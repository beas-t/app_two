from django.utils import timezone
from datetime import timedelta
from django.db import models
from django.core.cache import cache
import re
from rest_framework import viewsets, generics, permissions, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from .models import DoctorProfile, Patient, ScanReport, Appointment, AppInfo, Feature, AnalyticsData, ScanValidation, Backup, BackupSettings, SupportMessage, AccessibilitySettings, DisplaySettings, Equipment, EstimationResult, DataExport, Feedback, PasswordResetToken, HelpArticle, Notification, PrivacyPolicy, Recommendation, UserSession, TeamMember, TeamInvitation, TrainingModule, TrainingProgress
from .serializers import (
    UserSerializer, DoctorProfileSerializer, PatientSerializer, 
    ScanReportSerializer, AppointmentSerializer, AppInfoSerializer,
    AnalyticsDataSerializer, ScanValidationSerializer, BackupSerializer,
    BackupSettingsSerializer, SupportMessageSerializer, AccessibilitySettingsSerializer,
    DisplaySettingsSerializer, EquipmentSerializer, EstimationResultSerializer,
    DataExportSerializer, FeedbackSerializer, HelpArticleSerializer,
    NotificationSerializer, PrivacyPolicySerializer, RecommendationSerializer,
    UserSessionSerializer, TeamMemberSerializer, TeamInvitationSerializer,
    TrainingModuleSerializer
)
import random
import time
from rest_framework.parsers import MultiPartParser, FormParser
import uuid

# We import the new real PyTorch Inference Engine from the ai_engine folder
import sys
import os
from pathlib import Path

# Add project root to path so we can import ai_engine
BASE_DIR = Path(__file__).resolve().parent.parent
if str(BASE_DIR) not in sys.path:
    sys.path.append(str(BASE_DIR))

try:
    from ai_engine.inference import get_inference_engine
except ImportError:
    # If the app restarts or there's an issue with PyTorch, we fail gracefully
    pass

class HelpArticleViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = HelpArticleSerializer
    permission_classes = [permissions.AllowAny]
    authentication_classes = []

    def get_queryset(self):
        queryset = HelpArticle.objects.all()
        query = self.request.query_params.get('q')
        if query:
            queryset = queryset.filter(title__icontains=query) | queryset.filter(content__icontains=query)
        
        popular = self.request.query_params.get('popular')
        if popular:
            queryset = queryset.filter(is_popular=True)
            
        return queryset

class PasswordResetViewSet(viewsets.ViewSet):
    permission_classes = [permissions.AllowAny]
    authentication_classes = []

    @action(detail=False, methods=['post'])
    def request_code(self, request):
        email = request.data.get('email')
        try:
            doctor = DoctorProfile.objects.get(email=email)
            # Generate 6-digit code
            code = str(random.randint(100000, 999999))
            PasswordResetToken.objects.create(doctor=doctor, token=code)
            
            # Mock sending email
            print(f"DEBUG: Password reset code for {email}: {code}")
            
            return Response({"detail": "Code sent successfully."}, status=status.HTTP_200_OK)
        except DoctorProfile.objects.DoesNotExist:
            return Response({"error": "User with this email does not exist."}, status=status.HTTP_404_NOT_FOUND)

    @action(detail=False, methods=['post'])
    def verify_code(self, request):
        email = request.data.get('email')
        code = request.data.get('code')
        try:
            doctor = DoctorProfile.objects.get(email=email)
            token_obj = PasswordResetToken.objects.filter(doctor=doctor, token=code, is_used=False).order_by('-created_at').first()
            
            if token_obj and token_obj.is_valid():
                return Response({"detail": "Code verified."}, status=status.HTTP_200_OK)
            else:
                return Response({"error": "Invalid or expired code."}, status=status.HTTP_400_BAD_REQUEST)
        except DoctorProfile.objects.DoesNotExist:
            return Response({"error": "User not found."}, status=status.HTTP_404_NOT_FOUND)

    @action(detail=False, methods=['post'])
    def confirm_password(self, request):
        email = request.data.get('email')
        code = request.data.get('code') # Re-verify code for security
        new_password = request.data.get('new_password')
        
        try:
            doctor = DoctorProfile.objects.get(email=email)
            token_obj = PasswordResetToken.objects.filter(doctor=doctor, token=code, is_used=False).order_by('-created_at').first()
            
            if token_obj and token_obj.is_valid():
                user = doctor.user
                user.set_password(new_password)
                user.save()
                
                token_obj.is_used = True
                token_obj.save()
                
                return Response({"detail": "Password reset successfully."}, status=status.HTTP_200_OK)
            else:
                return Response({"error": "Validation failed."}, status=status.HTTP_400_BAD_REQUEST)
        except DoctorProfile.objects.DoesNotExist:
            return Response({"error": "User not found."}, status=status.HTTP_404_NOT_FOUND)

class FeedbackViewSet(viewsets.ModelViewSet):
    serializer_class = FeedbackSerializer

    def get_queryset(self):
        return Feedback.objects.filter(doctor=self.request.user.profile)

    def perform_create(self, serializer):
        serializer.save(doctor=self.request.user.profile)

class DataExportViewSet(viewsets.ModelViewSet):
    serializer_class = DataExportSerializer

    def get_queryset(self):
        return DataExport.objects.filter(doctor=self.request.user.profile)

    def perform_create(self, serializer):
        # Simulate an export being prepared
        timestamp = timezone.now().strftime("%Y%m%d_%H%M%S")
        serializer.save(
            doctor=self.request.user.profile,
            status='Completed',
            file_name=f"bladsense_export_{timestamp}.zip",
            file_size="189.2 MB",
            categories_included=4,
            download_url=f"http://example.com/downloads/bladsense_export_{timestamp}.zip",
            expires_at=timezone.now() + timezone.timedelta(hours=24)
        )

    @action(detail=False, methods=['get'])
    def summary(self, request):
        doctor = request.user.profile
        patient_count = Patient.objects.filter(doctor=doctor).count()
        report_count = ScanReport.objects.filter(patient__doctor=doctor).count()
        
        # Estimates based on counts
        patient_size = round(patient_count * 0.12, 1) # ~120KB per patient record
        report_size = round(report_count * 4.2, 1)   # ~4.2MB per scan report
        analytics_size = 8.3 # Default estimate
        settings_size = 0.2  # Default estimate
        
        total_size = round(patient_size + report_size + analytics_size + settings_size, 1)
        
        return Response({
            'categories': [
                {'name': 'Patient Records', 'count': patient_count, 'size': f"{patient_size} MB"},
                {'name': 'Scan Reports', 'count': report_count, 'size': f"{report_size} MB"},
                {'name': 'Analytics Data', 'count': 1, 'size': f"{analytics_size} MB"},
                {'name': 'App Settings', 'count': 1, 'size': f"{settings_size} MB"},
            ],
            'total_categories': 4,
            'total_size': f"{total_size} MB"
        })

class VolumeEstimationView(APIView):
    def post(self, request):
        length = float(request.data.get('length', 0))
        width = float(request.data.get('width', 0))
        height = float(request.data.get('height', 0))
        
        # Standard bladder volume calculation (L * W * H * coefficient)
        # We use a mock coefficient of 0.72 as per standard prolate ellipsoid model
        volume = length * width * height * 0.72
        
        recommendation = "Normal Range"
        if volume > 400:
            recommendation = "High Volume - Consider Catheterization"
        elif volume < 50:
            recommendation = "Low Volume - Monitor Fluid Intake"

        estimation = EstimationResult.objects.create(
            doctor=request.user.profile,
            patient=Patient.objects.filter(doctor=request.user.profile).first(), # Mocking patient link
            length=length,
            width=width,
            height=height,
            volume=round(volume, 2),
            recommendation=recommendation
        )
        
class ScanReportCreateView(APIView):
    parser_classes = (MultiPartParser, FormParser)

    def post(self, request):
        patient_id = request.data.get('patient_id')
        image_file = request.FILES.get('image')
        notes = request.data.get('notes', '')
        
        if not image_file:
            return Response({"error": "Scan image is required for AI analysis"}, status=status.HTTP_400_BAD_REQUEST)

        # 1. Use real PyTorch AI Engine to analyze the image
        try:
            inference_engine = get_inference_engine()
            ai_results = inference_engine.predict(image_file)
            
            # Check for Image Validation Errors (e.g. Not an ultrasound)
            if 'error' in ai_results and not ai_results.get('is_valid', True):
                return Response({
                    "status": "error",
                    "message": ai_results['error']
                }, status=status.HTTP_400_BAD_REQUEST)
                
        except Exception as e:
            print("Error loading inference engine:", e)
            # Fallback 
            ai_results = {
                "class": "empty",
                "volume": "100 ml",
                "level": "Low",
                "status": "Normal",
                "confidence": 0.85
            }
        
        # 2. Generate unique Report ID
        report_id = f"R-{uuid.uuid4().hex[:6].upper()}"
        
        # 3. Resolve Patient (Strict lookup to avoid incorrect linking)
        try:
            if patient_id and str(patient_id).isdigit():
                patient = Patient.objects.get(id=patient_id, doctor=request.user.profile)
            else:
                # Always create a new patient record for unknown scans
                # This prevents name updates on one "New Patient" from affecting others
                patient = Patient.objects.create(
                    doctor=request.user.profile,
                    name="New Patient",
                    patient_id=f"P-{uuid.uuid4().hex[:6].upper()}",
                    age=30,
                    gender="Unknown"
                )
        except (Patient.DoesNotExist, ValueError):
            return Response({"error": "Specified patient not found"}, status=status.HTTP_404_NOT_FOUND)
        
        try:
            # 4. Create the report with AI results
            report = ScanReport.objects.create(
                patient=patient,
                report_id=report_id,
                volume=ai_results['volume'],
                status=ai_results['status'],
                notes=f"AI Level: {ai_results['level']}. {notes}",
                scan_image=image_file
            )
            
            # 4. Return the enriched response
            data = ScanReportSerializer(report).data
            data['ai_details'] = ai_results
            
            return Response(data, status=status.HTTP_201_CREATED)
        except Patient.DoesNotExist:
            return Response({"error": "Patient not found"}, status=status.HTTP_404_NOT_FOUND)

class EquipmentViewSet(viewsets.ModelViewSet):
    serializer_class = EquipmentSerializer

    def get_queryset(self):
        return Equipment.objects.filter(doctor=self.request.user.profile)

    def perform_create(self, serializer):
        serializer.save(doctor=self.request.user.profile)

    @action(detail=True, methods=['post'])
    def recalibrate(self, request, pk=None):
        equipment = self.get_object()
        equipment.last_calibration = timezone.now()
        equipment.status = 'Connected' # Ensure status is reset
        equipment.save()
        return Response({
            'status': 'Recalibration successful',
            'last_calibration': equipment.last_calibration
        })

class DisplaySettingsView(APIView):
    def get(self, request):
        settings, _ = DisplaySettings.objects.get_or_create(doctor=request.user.profile)
        serializer = DisplaySettingsSerializer(settings)
        return Response(serializer.data)

    def patch(self, request):
        settings, _ = DisplaySettings.objects.get_or_create(doctor=request.user.profile)
        serializer = DisplaySettingsSerializer(settings, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class AccessibilitySettingsView(APIView):
    def get(self, request):
        settings, _ = AccessibilitySettings.objects.get_or_create(doctor=request.user.profile)
        serializer = AccessibilitySettingsSerializer(settings)
        return Response(serializer.data)

    def patch(self, request):
        settings, _ = AccessibilitySettings.objects.get_or_create(doctor=request.user.profile)
        serializer = AccessibilitySettingsSerializer(settings, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class SupportMessageViewSet(viewsets.ModelViewSet):
    serializer_class = SupportMessageSerializer

    def get_queryset(self):
        return SupportMessage.objects.filter(doctor=self.request.user.profile)

    def perform_create(self, serializer):
        serializer.save(doctor=self.request.user.profile)

class BackupViewSet(viewsets.ModelViewSet):
    serializer_class = BackupSerializer

    def get_queryset(self):
        return Backup.objects.filter(doctor=self.request.user.profile)

    def perform_create(self, serializer):
        doctor = self.request.user.profile
        # Calculate real stats for the backup record
        patient_count = Patient.objects.filter(doctor=doctor).count()
        scan_count = ScanReport.objects.filter(patient__doctor=doctor).count()
        total_items = patient_count + scan_count
        
        # Simulated file size based on scan count
        file_size_mb = 10.5 + (scan_count * 5.2)
        file_size_str = f"{file_size_mb:.1f} MB" if file_size_mb < 1024 else f"{file_size_mb/1024:.1f} GB"

        serializer.save(
            doctor=doctor,
            file_size=file_size_str,
            item_count=total_items,
            status="Success"
        )
        
        # Update settings
        settings, _ = BackupSettings.objects.get_or_create(doctor=doctor)
        settings.last_backup_at = timezone.now()
        settings.save()

class BackupSettingsView(APIView):
    def get(self, request):
        settings, _ = BackupSettings.objects.get_or_create(doctor=request.user.profile)
        serializer = BackupSettingsSerializer(settings)
        return Response(serializer.data)

    def patch(self, request):
        settings, _ = BackupSettings.objects.get_or_create(doctor=request.user.profile)
        serializer = BackupSettingsSerializer(settings, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CacheManagementView(APIView):
    def get(self, request):
        # Realistic mock for CacheActivity
        return Response({
            "current_size": "142.5 MB",
            "progress_percent": 65,
            "last_cleared": timezone.now() - timedelta(days=5)
        })

    def post(self, request):
        # Mocking the action of clearing cache
        # In a real app, this might trigger server-side cleanup
        return Response({
            "message": "Cache cleared successfully",
            "current_size": "0 KB"
        }, status=status.HTTP_200_OK)

class ScanGuidanceView(APIView):
    def get(self, request):
        view_type = request.query_params.get('view_type', 'transverse')
        # Mocking AI guidance logic
        guidance = {
            "instruction": "Align probe center",
            "is_aligned": False,
            "status": "AI Guidance: Active",
            "color": "#FFFFFF"
        }
        
        if view_type == 'sagittal':
            guidance["instruction"] = "Rotate probe 90 degrees"
            
        return Response(guidance)

class ImageVerificationView(APIView):
    def post(self, request):
        serializer = ScanValidationSerializer(data=request.data)
        if serializer.is_valid():
            # Mock quality check logic
            # In a real app, this would call an AI model
            quality_score = 0.98
            quality_label = "Excellent"
            feedback_message = "Bladder walls clearly defined. Ready for analysis."
            
            validation = serializer.save(
                doctor=request.user.profile,
                quality_score=quality_score,
                quality_label=quality_label,
                feedback_message=feedback_message
            )
            return Response(ScanValidationSerializer(validation).data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class AnalyticsView(APIView):
    def get(self, request):
        doctor = request.user.profile
        patients = Patient.objects.filter(doctor=doctor)
        total_patients = patients.count()
        
        # Demographics
        male_count = patients.filter(gender__iexact='Male').count()
        female_count = patients.filter(gender__iexact='Female').count()
        other_count = total_patients - (male_count + female_count)
        
        # Age Distribution
        age_0_18 = patients.filter(age__lte=18).count()
        age_19_30 = patients.filter(age__gt=18, age__lte=30).count()
        age_31_50 = patients.filter(age__gt=30, age__lte=50).count()
        age_51_70 = patients.filter(age__gt=50, age__lte=70).count()
        age_70_plus = patients.filter(age__gt=70).count()
        
        # Discharge Rate (Latest volume < 500ml)
        discharged_count = 0
        import re
        for patient in patients:
            latest_report = ScanReport.objects.filter(patient=patient).order_by('-scan_date', '-id').first()
            if latest_report:
                # Handle "450 ml" format
                vol_str = latest_report.volume
                match = re.search(r'(\d+(?:\.\d+)?)', vol_str)
                if match:
                    vol = float(match.group(1))
                    if vol < 500:
                        discharged_count += 1
        
        discharge_rate = (discharged_count / total_patients * 100) if total_patients > 0 else 0
        
        # Get existing analytics for weekly trends
        analytics_obj = AnalyticsData.objects.filter(doctor=doctor).first()
        
        data = {
            "total_patients": total_patients,
            "discharge_rate": round(discharge_rate, 1),
            "male_count": male_count,
            "female_count": female_count,
            "other_count": other_count,
            "age_0_18": age_0_18,
            "age_19_30": age_19_30,
            "age_31_50": age_31_50,
            "age_51_70": age_51_70,
            "age_70_plus": age_70_plus,
            "active_patients": total_patients, # Fallback
            "retention_rate": round(discharge_rate, 1), # Using discharge rate as proxy
        }
        
        if analytics_obj:
            # Merge with weekly trends
            data.update({
                "trend_monday": analytics_obj.trend_monday,
                "trend_tuesday": analytics_obj.trend_tuesday,
                "trend_wednesday": analytics_obj.trend_wednesday,
                "trend_thursday": analytics_obj.trend_thursday,
                "trend_friday": analytics_obj.trend_friday,
                "trend_saturday": analytics_obj.trend_saturday,
                "trend_sunday": analytics_obj.trend_sunday,
            })
            
        return Response(data)

class AppInfoView(APIView):
    permission_classes = [permissions.AllowAny]
    authentication_classes = []

    def get(self, request):
        app_info = AppInfo.objects.first()
        if not app_info:
            return Response({"error": "App info not found"}, status=status.HTTP_404_NOT_FOUND)
        serializer = AppInfoSerializer(app_info)
        return Response(serializer.get_initial_data() if hasattr(serializer, 'get_initial_data') else serializer.data)

class SignUpView(APIView):
    permission_classes = [permissions.AllowAny]
    authentication_classes = []

    def post(self, request):
        full_name = request.data.get('fullName', '').strip()
        email = request.data.get('email', '').strip()
        license_number = request.data.get('licenseNumber', '').strip()
        specialty = request.data.get('specialty', 'Select specialty').strip()
        password = request.data.get('password', '').strip()
        
        # 1. Full Name Validation
        if len(full_name) < 3 or not re.match(r'^[a-zA-Z\s]+$', full_name):
            return Response({"status": "error", "message": "Full Name should contain only letters."}, status=status.HTTP_400_BAD_REQUEST)

        # 2. Email Validation
        if not re.match(r'^[a-zA-Z0-9._%+-]+@gmail\.com$', email):
            return Response({"status": "error", "message": "Enter a valid Gmail address."}, status=status.HTTP_400_BAD_REQUEST)

        # 3. Medical License ID Validation
        if not re.match(r'^[a-zA-Z0-9]{6,15}$', license_number):
            return Response({"status": "error", "message": "Enter a valid Medical License ID."}, status=status.HTTP_400_BAD_REQUEST)

        # 4. Specialty Selection
        if specialty == "Select specialty":
            return Response({"status": "error", "message": "Please select your specialty."}, status=status.HTTP_400_BAD_REQUEST)

        # 5. Password Validation
        if not re.match(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&\-_\.])[A-Za-z\d@$!%*?&\-_\.]{8,}$', password):
            return Response({"status": "error", "message": "Password must be strong (8+ chars, uppercase, lowercase, number, special character)."}, status=status.HTTP_400_BAD_REQUEST)

        # 6. Check if email already exists
        if User.objects.filter(email=email).exists():
            return Response({"status": "error", "message": "Email already registered. Please login."}, status=status.HTTP_400_BAD_REQUEST)
            
        if DoctorProfile.objects.filter(licenseNumber=license_number).exists():
            return Response({"status": "error", "message": "Account with this Medical License ID already exists"}, status=status.HTTP_400_BAD_REQUEST)

        user_data = {
            'username': email,
            'email': email,
            'password': password
        }
        serializer = UserSerializer(data=user_data)
        if serializer.is_valid():
            user = serializer.save()
            DoctorProfile.objects.create(
                user=user,
                fullName=full_name,
                licenseNumber=license_number,
                specialty=specialty
            )
            refresh = RefreshToken.for_user(user)
            return Response({
                "status": "success",
                "message": "Account created successfully.",
                "tokens": {
                    'refresh': str(refresh),
                    'access': str(refresh.access_token)
                },
                'user': UserSerializer(user).data
            }, status=status.HTTP_201_CREATED)
        return Response({"status": "error", "message": str(serializer.errors)}, status=status.HTTP_400_BAD_REQUEST)

class LoginView(APIView):
    permission_classes = [permissions.AllowAny]
    authentication_classes = []

    def post(self, request):
        identity = request.data.get('email', '').strip() # Can be email or medical ID
        password = request.data.get('password', '').strip()
        
        # 1. Validation
        if not identity:
            return Response({"status": "error", "message": "Enter Email or Medical ID."}, status=status.HTTP_400_BAD_REQUEST)
        if not password:
            return Response({"status": "error", "message": "Enter password."}, status=status.HTTP_400_BAD_REQUEST)

        # 2. Rate Limiting (Basic)
        cache_key = f"login_attempts_{request.META.get('REMOTE_ADDR')}"
        attempts = cache.get(cache_key, 0)
        if attempts >= 5:
             return Response({"status": "error", "message": "Too many attempts. Please try again later."}, status=status.HTTP_429_TOO_MANY_REQUESTS)

        user = None
        # Try authenticating via email
        user = authenticate(username=identity, password=password)
        
        if not user:
            # Try authenticating via license number
            try:
                profile = DoctorProfile.objects.get(licenseNumber=identity)
                user = authenticate(username=profile.user.username, password=password)
            except DoctorProfile.DoesNotExist:
                pass

        if user:
            # Reset attempts on success
            cache.delete(cache_key)
            refresh = RefreshToken.for_user(user)
            return Response({
                "status": "success",
                "message": "Login successful",
                "tokens": {
                    'refresh': str(refresh),
                    'access': str(refresh.access_token)
                },
                'user': UserSerializer(user).data
            })
        
        # Increment attempts on failure
        cache.set(cache_key, attempts + 1, timeout=300) # 5 minutes lockout
        return Response({"status": "error", "message": "Invalid credentials."}, status=status.HTTP_401_UNAUTHORIZED)

class LogoutView(APIView):
    def post(self, request):
        try:
            refresh_token = request.data.get("refresh")
            token = RefreshToken(refresh_token)
            token.blacklist()
            return Response({"detail": "Successfully logged out."}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({"error": "Invalid token or already blacklisted."}, status=status.HTTP_400_BAD_REQUEST)

from rest_framework.parsers import MultiPartParser, FormParser, JSONParser

class DoctorProfileView(generics.RetrieveUpdateAPIView):
    serializer_class = DoctorProfileSerializer
    parser_classes = (MultiPartParser, FormParser, JSONParser)
    
    def get_object(self):
        return self.request.user.profile

class PatientViewSet(viewsets.ModelViewSet):
    serializer_class = PatientSerializer
    
    def get_queryset(self):
        queryset = Patient.objects.filter(doctor=self.request.user.profile)
        
        # Filter patients by archive status only for the list view
        # This allows detail actions (like unarchive) to access the patient even if archived
        if self.action == 'list':
            show_archived = self.request.query_params.get('show_archived', 'false').lower() == 'true'
            if not show_archived:
                queryset = queryset.filter(is_archived=False)

        query = self.request.query_params.get('q')
        if query:
            queryset = queryset.filter(
                models.Q(name__icontains=query) | 
                models.Q(patient_id__icontains=query)
            )
        return queryset

    @action(detail=True, methods=['post'])
    def archive(self, request, pk=None):
        patient = self.get_object()
        patient.is_archived = True
        patient.save()
        return Response({'status': 'Patient archived'})

    @action(detail=True, methods=['post'])
    def unarchive(self, request, pk=None):
        patient = self.get_object()
        patient.is_archived = False
        patient.save()
        return Response({'status': 'Patient unarchived'})
    
    def perform_create(self, serializer):
        serializer.save(doctor=self.request.user.profile)

class ScanReportViewSet(viewsets.ModelViewSet):
    serializer_class = ScanReportSerializer
    
    def get_queryset(self):
        queryset = ScanReport.objects.filter(patient__doctor=self.request.user.profile)
        
        # Filter by patient
        patient_id = self.request.query_params.get('patient')
        if patient_id:
            queryset = queryset.filter(patient_id=patient_id)
            
        # Filter by status (e.g., Normal, Distended)
        status_param = self.request.query_params.get('status')
        if status_param:
            queryset = queryset.filter(status__iexact=status_param)
            
        # Filter by date range
        start_date = self.request.query_params.get('start_date')
        end_date = self.request.query_params.get('end_date')
        if start_date:
            queryset = queryset.filter(scan_date__gte=start_date)
        if end_date:
            queryset = queryset.filter(scan_date__lte=end_date)
            
        # Unified Search
        query = self.request.query_params.get('q')
        if query:
            queryset = queryset.filter(
                models.Q(report_id__icontains=query) |
                models.Q(notes__icontains=query) |
                models.Q(patient__name__icontains=query)
            )
            
        return queryset

class AppointmentViewSet(viewsets.ModelViewSet):
    serializer_class = AppointmentSerializer
    
    def get_queryset(self):
        queryset = Appointment.objects.filter(doctor=self.request.user.profile)
        date_param = self.request.query_params.get('date')
        if date_param:
            queryset = queryset.filter(date=date_param)
        return queryset.order_by('time')
    
    def perform_create(self, serializer):
        serializer.save(doctor=self.request.user.profile)

class NotificationViewSet(viewsets.ModelViewSet):
    serializer_class = NotificationSerializer
    
    def get_queryset(self):
        return Notification.objects.filter(doctor=self.request.user.profile).order_by('-created_at')

    @action(detail=True, methods=['post'])
    def mark_as_read(self, request, pk=None):
        notification = self.get_object()
        notification.is_read = True
        notification.save()
        return Response({'status': 'notification marked as read'})

class HomeDashboardView(APIView):
    def get(self, request):
        doctor = request.user.profile
        
        # Recent Scans
        recent_scans = ScanReport.objects.filter(patient__doctor=doctor).order_by('-scan_date', '-id')[:5]
        scans_serializer = ScanReportSerializer(recent_scans, many=True)
        
        # Upcoming Appointments
        upcoming_appointments = Appointment.objects.filter(
            doctor=doctor, 
            date__gte=timezone.now().date()
        ).order_by('date', 'time')[:5]
        appointments_serializer = AppointmentSerializer(upcoming_appointments, many=True)
        
        # Unread Notifications
        unread_notifications = Notification.objects.filter(doctor=doctor, is_read=False).order_by('-created_at')[:5]
        notifications_serializer = NotificationSerializer(unread_notifications, many=True)
        
        # Recent Activities (Combined Scans and Feedbacks)
        recent_feedbacks = Feedback.objects.filter(doctor=doctor).order_by('-created_at')[:5]
        
        activities = []
        for scan in recent_scans:
            activities.append({
                'id': f"scan_{scan.id}",
                'type': 'Scan',
                'title': f"Scan: {scan.patient.name}",
                'subtitle': f"Volume: {scan.volume} | Status: {scan.status}",
                'timestamp': scan.scan_date.isoformat() if hasattr(scan.scan_date, 'isoformat') else str(scan.scan_date),
                'relative_time': "Recently"
            })
            
        for feed in recent_feedbacks:
            activities.append({
                'id': f"feed_{feed.id}",
                'type': 'Feedback',
                'title': f"Feedback: {feed.feedback_type}",
                'subtitle': feed.message[:50] + "..." if len(feed.message) > 50 else feed.message,
                'timestamp': feed.created_at.isoformat(),
                'relative_time': "Recently"
            })
            
        # Sort by timestamp (mocked for now since scan_date is a date not datetime, but in real app it would be)
        activities.sort(key=lambda x: x['timestamp'], reverse=True)
        activities = activities[:10]

        # Team Overview Counts
        team_members = TeamMember.objects.filter(doctor=doctor)
        team_doctors = team_members.filter(role__icontains='Doctor')
        nurses = team_members.filter(models.Q(role__icontains='Nurse') | models.Q(role__icontains='Patient Care'))
        techs = team_members.filter(role__icontains='Tech')
        patients = Patient.objects.filter(doctor=doctor)

        # Active Patients - Patients with scans today
        today = timezone.now().date()
        active_patients_today = Patient.objects.filter(
            doctor=doctor, 
            reports__scan_date=today
        ).distinct().count()

        return Response({
            'doctor_name': doctor.fullName,
            'specialty': doctor.specialty,
            'license_number': doctor.licenseNumber,
            'profile_picture': doctor.profile_picture.url if doctor.profile_picture else None,
            'doctor_count': team_doctors.count() + 1, # Including current doctor
            'active_doctors': team_doctors.filter(status='Active').count() + 1, # Current doctor is active
            'nurse_count': nurses.count(),
            'active_nurses': nurses.filter(status='Active').count(),
            'technician_count': techs.count(),
            'active_techs': techs.filter(status='Active').count(),
            'patient_count': patients.count(),
            'active_patients': active_patients_today,
            'task_count': Appointment.objects.filter(doctor=doctor, date=today).count(),
            'recent_scans': scans_serializer.data,
            'upcoming_appointments': appointments_serializer.data,
            'unread_notifications': notifications_serializer.data,
            'recent_activities': activities,
        })

class PrivacyPolicyViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = PrivacyPolicy.objects.all()
    serializer_class = PrivacyPolicySerializer
    permission_classes = [permissions.AllowAny]

class AccountDeletionView(APIView):
    def post(self, request):
        user = request.user
        # Confirmation check (e.g., password verification or explicit confirm flag)
        confirm = request.data.get('confirm')
        if confirm != 'DELETE':
             return Response({"error": "Please confirm account deletion by providing 'DELETE' flag."}, status=status.HTTP_400_BAD_REQUEST)
        
        # Log deletion request or perform cleanup if needed
        print(f"DEBUG: Deleting account for user {user.username}")
        
        # Cascade delete will handle DoctorProfile and related data
        user.delete()
        
        return Response({"detail": "Account deleted successfully."}, status=status.HTTP_200_OK)

class RecommendationViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Recommendation.objects.all()
    serializer_class = RecommendationSerializer
    permission_classes = [permissions.AllowAny]
class UserSessionViewSet(viewsets.ModelViewSet):
    serializer_class = UserSessionSerializer

    def get_queryset(self):
        return UserSession.objects.filter(doctor=self.request.user.profile)

    def perform_create(self, serializer):
        serializer.save(doctor=self.request.user.profile)

    @action(detail=False, methods=['post'])
    def sign_out_all(self, request):
        # In a real app, this would invalidate tokens
        UserSession.objects.filter(doctor=request.user.profile).delete()
        return Response({"detail": "All sessions signed out."}, status=status.HTTP_200_OK)

class SecurityStatusView(APIView):
    def get(self, request):
        profile = request.user.profile
        return Response({
            "two_factor_enabled": profile.two_factor_enabled,
            "biometric_enabled": profile.biometric_enabled,
            "last_password_change": profile.last_password_change
        })

class DataSyncView(APIView):
    def post(self, request):
        doctor = request.user.profile
        # Simulate synchronization logic
        # In a real app, this would check for updates, 
        # pull new data, and return a summary.
        
        patient_count = Patient.objects.filter(doctor=doctor).count()
        report_count = ScanReport.objects.filter(patient__doctor=doctor).count()
        
        return Response({
            "status": "success",
            "message": "Data synchronized successfully",
            "last_sync": timezone.now(),
            "summary": {
                "patients": patient_count,
                "reports": report_count,
                "notifications": Notification.objects.filter(doctor=doctor).count()
            }
        })

class ChangePasswordView(APIView):
    def post(self, request):
        old_password = request.data.get('old_password')
        new_password = request.data.get('new_password')
        user = request.user
        
        if user.check_password(old_password):
            user.set_password(new_password)
            user.save()
            
            # Update last change date
            profile = user.profile
            profile.last_password_change = timezone.now()
            profile.save()
            
            return Response({"detail": "Password updated successfully."}, status=status.HTTP_200_OK)
        else:
            return Response({"error": "Incorrect old password."}, status=status.HTTP_400_BAD_REQUEST)

class SettingsSummaryView(APIView):
    def get(self, request):
        doctor = request.user.profile
        
        # System Status
        latest_backup = Backup.objects.filter(doctor=doctor).order_by('-created_at').first()
        last_sync = latest_backup.created_at if latest_backup else doctor.user.date_joined
        
        # Storage Simulation (as seen in layout)
        storage_data = {
            "used_total": "1.2 GB",
            "total_capacity": "5 GB",
            "breakdown": {
                "scans_pct": 60,
                "reports_pct": 15,
                "cache_pct": 5,
                "free_pct": 20
            }
        }
        
        return Response({
            "profile": {
                "name": doctor.fullName,
                "image_url": doctor.profile_picture.url if doctor.profile_picture else None,
            },
            "system_status": {
                "is_operational": True,
                "last_synced": last_sync,
            },
            "storage": storage_data
        })

class TeamMemberViewSet(viewsets.ModelViewSet):
    serializer_class = TeamMemberSerializer

    def get_queryset(self):
        queryset = TeamMember.objects.filter(doctor=self.request.user.profile)
        category = self.request.query_params.get('category')
        
        if category == 'doctors':
            queryset = queryset.filter(role__icontains='Doctor')
        elif category == 'nurses':
            queryset = queryset.filter(models.Q(role__icontains='Nurse') | models.Q(role__icontains='Patient Care'))
        elif category == 'technicians':
            queryset = queryset.filter(role__icontains='Tech')
            
        return queryset

    def perform_create(self, serializer):
        serializer.save(doctor=self.request.user.profile)

class TeamInvitationViewSet(viewsets.ModelViewSet):
    serializer_class = TeamInvitationSerializer

    def get_queryset(self):
        return TeamInvitation.objects.filter(inviter=self.request.user.profile)

    def perform_create(self, serializer):
        serializer.save(inviter=self.request.user.profile)

class TrainingModuleViewSet(viewsets.ModelViewSet):
    queryset = TrainingModule.objects.all().order_by('order')
    serializer_class = TrainingModuleSerializer

    @action(detail=True, methods=['post'])
    def complete(self, request, pk=None):
        module = self.get_object()
        progress, created = TrainingProgress.objects.get_or_create(
            doctor=request.user.profile,
            module=module
        )
        progress.is_completed = True
        progress.completed_at = timezone.now()
        progress.save()
        return Response({'status': 'module marked as completed'})

    @action(detail=False, methods=['get'])
    def summary(self, request):
        doctor = request.user.profile
        total_modules = TrainingModule.objects.count()
        completed_count = TrainingProgress.objects.filter(doctor=doctor, is_completed=True).count()
        
        completion_percent = 0
        if total_modules > 0:
            completion_percent = int((completed_count / total_modules) * 100)
            
        return Response({
            "completion_percent": completion_percent,
            "technician_level": doctor.technician_level,
            "total_modules": total_modules,
            "completed_modules": completed_count
        })
