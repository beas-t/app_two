from rest_framework import serializers
from django.contrib.auth.models import User
from .models import DoctorProfile, Patient, ScanReport, Appointment, AppInfo, Feature, AnalyticsData, ScanValidation, Backup, BackupSettings, SupportMessage, AccessibilitySettings, DisplaySettings, Equipment, EstimationResult, DataExport, Feedback, PasswordResetToken, HelpArticle, Notification, PrivacyPolicy, Recommendation, UserSession, TeamMember, TeamInvitation, TrainingModule, TrainingProgress

class DoctorProfileSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(source='user.email')
    username = serializers.CharField(source='user.username', read_only=True)
    stats = serializers.SerializerMethodField()
    
    class Meta:
        model = DoctorProfile
        fields = [
            'id', 'username', 'email', 'fullName', 'licenseNumber', 'specialty', 
            'profile_picture', 'phone', 'location', 'years_of_experience', 'status',
            'technician_level', 'two_factor_enabled', 'biometric_enabled', 'last_password_change', 'stats'
        ]

    def get_stats(self, obj):
        try:
            analytics = obj.analytics
            return {
                "total_scans": analytics.total_scans,
                "accuracy_pct": int(analytics.image_quality_pct) if analytics.image_quality_pct else 98,
                "active_patients": analytics.active_patients
            }
        except:
            return {
                "total_scans": 0,
                "accuracy_pct": 0,
                "active_patients": 0
            }

    def update(self, instance, validated_data):
        user_data = validated_data.pop('user', {})
        email = user_data.get('email')
        
        if email:
            instance.user.email = email
            instance.user.username = email
            instance.user.save()
            
        return super().update(instance, validated_data)

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    profile = DoctorProfileSerializer(read_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password', 'profile']

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data.get('email', ''),
            password=validated_data['password']
        )
        return user

class PatientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Patient
        fields = '__all__'
        read_only_fields = ['doctor']

class ScanReportSerializer(serializers.ModelSerializer):
    patient = PatientSerializer(read_only=True)
    patient_name = serializers.ReadOnlyField(source='patient.name')
    
    class Meta:
        model = ScanReport
        fields = '__all__'

class AppointmentSerializer(serializers.ModelSerializer):
    doctor_name = serializers.ReadOnlyField(source='doctor.fullName')
    patient_name = serializers.ReadOnlyField(source='patient.name')

    class Meta:
        model = Appointment
        fields = ['id', 'doctor', 'patient', 'date', 'time', 'status', 'appointment_type', 'location', 'duration_minutes', 'reason', 'doctor_name', 'patient_name']
        read_only_fields = ['doctor']

class FeatureSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feature
        fields = ['id', 'title', 'description', 'icon_type']

class AppInfoSerializer(serializers.ModelSerializer):
    features = FeatureSerializer(many=True, read_only=True)

    class Meta:
        model = AppInfo
        fields = ['id', 'app_name', 'version', 'build_number', 'description', 'footer_text', 'copyright_text', 'features']

class AnalyticsDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = AnalyticsData
        fields = '__all__'

class ScanValidationSerializer(serializers.ModelSerializer):
    class Meta:
        model = ScanValidation
        fields = ['id', 'image', 'view_type', 'quality_score', 'quality_label', 'feedback_message', 'created_at']
        read_only_fields = ['quality_score', 'quality_label', 'feedback_message', 'created_at']

class BackupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Backup
        fields = '__all__'

class BackupSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = BackupSettings
        fields = '__all__'

class SupportMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = SupportMessage
        fields = ['id', 'subject', 'message', 'created_at', 'is_resolved']
        read_only_fields = ['is_resolved', 'created_at']

class AccessibilitySettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = AccessibilitySettings
        fields = ['voice_guidance', 'screen_reader_optimized', 'high_contrast', 'button_size']

class DisplaySettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = DisplaySettings
        fields = ['theme', 'volume_units', 'language']

class EquipmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Equipment
        fields = '__all__'
        read_only_fields = ['doctor']

class EstimationResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = EstimationResult
        fields = '__all__'
        read_only_fields = ['doctor', 'volume', 'recommendation']

class DataExportSerializer(serializers.ModelSerializer):
    class Meta:
        model = DataExport
        fields = '__all__'
        read_only_fields = ['doctor', 'status', 'file_name', 'file_size', 'download_url', 'expires_at']

class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'
        read_only_fields = ['doctor']

class HelpArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = HelpArticle
        fields = '__all__'

class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = ['id', 'title', 'message', 'is_read', 'created_at']

class PrivacyPolicySerializer(serializers.ModelSerializer):
    class Meta:
        model = PrivacyPolicy
        fields = ['content', 'last_updated', 'version']

class RecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recommendation
        fields = ['id', 'title', 'content', 'category', 'icon_name', 'created_at']

class UserSessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserSession
        fields = '__all__'
        read_only_fields = ['doctor', 'last_active']

class TeamMemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = TeamMember
        fields = '__all__'
        read_only_fields = ['doctor', 'created_at']

class TeamInvitationSerializer(serializers.ModelSerializer):
    class Meta:
        model = TeamInvitation
        fields = '__all__'
        read_only_fields = ['inviter', 'status', 'created_at']

class TrainingModuleSerializer(serializers.ModelSerializer):
    is_completed = serializers.SerializerMethodField()

    class Meta:
        model = TrainingModule
        fields = ['id', 'title', 'subtitle', 'description', 'video_url', 'takeaways', 'order', 'duration_minutes', 'is_completed']

    def get_is_completed(self, obj):
        request = self.context.get('request')
        if request and request.user.is_authenticated:
            try:
                progress = TrainingProgress.objects.get(doctor=request.user.profile, module=obj)
                return progress.is_completed
            except TrainingProgress.DoesNotExist:
                return False
        return False
