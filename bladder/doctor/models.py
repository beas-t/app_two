from django.db import models
from django.contrib.auth.models import User

class DoctorProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    fullName = models.CharField(max_length=255)
    licenseNumber = models.CharField(max_length=100, unique=True)
    specialty = models.CharField(max_length=100)
    profile_picture = models.ImageField(upload_to='profile_pics/', null=True, blank=True)
    phone = models.CharField(max_length=20, null=True, blank=True)
    location = models.CharField(max_length=255, default='Building A, Floor 3')
    years_of_experience = models.IntegerField(default=0)
    status = models.CharField(max_length=50, default='Active') # Active, Away
    technician_level = models.CharField(max_length=50, default='Level 1')
    
    # Security Features
    two_factor_enabled = models.BooleanField(default=True)
    biometric_enabled = models.BooleanField(default=False)
    last_password_change = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.fullName

class Patient(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='patients')
    name = models.CharField(max_length=255)
    patient_id = models.CharField(max_length=50, unique=True)
    age = models.IntegerField()
    gender = models.CharField(max_length=20)
    phone = models.CharField(max_length=20, null=True, blank=True)
    is_archived = models.BooleanField(default=False)
    condition = models.TextField(null=True, blank=True) # Medical history / patient details

    def __str__(self):
        return f"{self.name} ({self.patient_id})"

class ScanReport(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='reports')
    report_id = models.CharField(max_length=50, unique=True)
    scan_date = models.DateField(auto_now_add=True)
    volume = models.CharField(max_length=50) # e.g., "450 ml"
    status = models.CharField(max_length=50) # e.g., "Normal", "Distended"
    scan_image = models.ImageField(upload_to='scans/', null=True, blank=True)
    drawing_image = models.ImageField(upload_to='drawings/', null=True, blank=True)
    notes = models.TextField(null=True, blank=True)

    def __str__(self):
        return f"Report {self.report_id} for {self.patient.name}"

class Appointment(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='appointments')
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='appointments', null=True, blank=True)
    date = models.DateField()
    time = models.TimeField()
    status = models.CharField(max_length=50, default='Scheduled') # Scheduled, Completed, Cancelled
    appointment_type = models.CharField(max_length=100, default="Initial Scan")
    location = models.CharField(max_length=100, default="Room 302")
    duration_minutes = models.IntegerField(default=30)
    reason = models.TextField(null=True, blank=True)

    def __str__(self):
        return f"Appointment on {self.date} at {self.time}"

class AppInfo(models.Model):
    app_name = models.CharField(max_length=100, default="BladSense AI")
    version = models.CharField(max_length=50, default="2.1.0")
    build_number = models.CharField(max_length=50, default="402")
    description = models.TextField()
    footer_text = models.CharField(max_length=255, default="Made with ❤ by BladSense Team")
    copyright_text = models.CharField(max_length=255, default="© 2024 BladSense Inc. All rights reserved.")

    def __str__(self):
        return f"{self.app_name} v{self.version}"

class Feature(models.Model):
    app_info = models.ForeignKey(AppInfo, on_delete=models.CASCADE, related_name='features')
    title = models.CharField(max_length=100)
    description = models.CharField(max_length=255)
    icon_type = models.CharField(max_length=50) # 'hipaa', 'fda', 'team', etc.

    def __str__(self):
        return self.title

class AnalyticsData(models.Model):
    doctor = models.OneToOneField(DoctorProfile, on_delete=models.CASCADE, related_name='analytics')
    total_scans = models.IntegerField(default=0)
    scans_increase_pct = models.FloatField(default=0.0)
    avg_volume = models.CharField(max_length=50, default="0ml")
    volume_decrease_pct = models.FloatField(default=0.0)
    active_patients = models.IntegerField(default=0)
    patients_increase = models.IntegerField(default=0)
    retention_rate = models.FloatField(default=0.0)
    retention_increase_pct = models.FloatField(default=0.0)
    
    # Weekly Trends (Daily averages)
    trend_monday = models.FloatField(default=0.0)
    trend_tuesday = models.FloatField(default=0.0)
    trend_wednesday = models.FloatField(default=0.0)
    trend_thursday = models.FloatField(default=0.0)
    trend_friday = models.FloatField(default=0.0)
    trend_saturday = models.FloatField(default=0.0)
    trend_sunday = models.FloatField(default=0.0)

    # Efficiency Metrics
    scan_duration_seconds = models.FloatField(default=0.0)
    image_quality_pct = models.FloatField(default=0.0)
    report_gen_seconds = models.FloatField(default=0.0)

    def __str__(self):
        return f"Analytics for {self.doctor.fullName}"

class ScanValidation(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='temp_scans/')
    view_type = models.CharField(max_length=50, default="transverse") # transverse, sagittal
    quality_score = models.FloatField(default=0.0) # 0.0 to 1.0
    quality_label = models.CharField(max_length=50) # Excellent, Good, Poor
    feedback_message = models.TextField()
    is_processed = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Validation {self.id} - {self.quality_label}"

class Backup(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='backups')
    created_at = models.DateTimeField(auto_now_add=True)
    file_size = models.CharField(max_length=50) # e.g., "1.2 GB"
    item_count = models.IntegerField() # Number of scans/records
    backup_file = models.FileField(upload_to='backups/', null=True, blank=True)
    status = models.CharField(max_length=50, default='Success') # Success, In Progress, Failed

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"Backup {self.created_at} for {self.doctor.fullName}"

class BackupSettings(models.Model):
    doctor = models.OneToOneField(DoctorProfile, on_delete=models.CASCADE, related_name='backup_settings')
    auto_backup = models.BooleanField(default=True)
    include_images = models.BooleanField(default=True)
    wifi_only = models.BooleanField(default=True)
    last_backup_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Backup Settings for {self.doctor.fullName}"

class SupportMessage(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='support_messages')
    subject = models.CharField(max_length=255)
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    is_resolved = models.BooleanField(default=False)

    def __str__(self):
        return f"Support Message from {self.doctor.fullName} - {self.subject}"

class AccessibilitySettings(models.Model):
    doctor = models.OneToOneField(DoctorProfile, on_delete=models.CASCADE, related_name='accessibility_settings')
    voice_guidance = models.BooleanField(default=False)
    screen_reader_optimized = models.BooleanField(default=False)
    high_contrast = models.BooleanField(default=False)
    button_size = models.CharField(max_length=20, default='Medium') # Small, Medium, Large

    def __str__(self):
        return f"Accessibility Settings for {self.doctor.fullName}"

class DisplaySettings(models.Model):
    doctor = models.OneToOneField(DoctorProfile, on_delete=models.CASCADE, related_name='display_settings')
    theme = models.CharField(max_length=20, default='Light') # Light, Dark, Auto
    volume_units = models.CharField(max_length=50, default='Milliliters (ml)')
    language = models.CharField(max_length=50, default='English')

    def __str__(self):
        return f"Display Settings for {self.doctor.fullName}"

class Equipment(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='equipments')
    name = models.CharField(max_length=100, default='Probe C5-2')
    serial_number = models.CharField(max_length=100, unique=True)
    status = models.CharField(max_length=20, default='Connected') # Connected, Disconnected, Maintenance
    battery_level = models.IntegerField(default=100)
    temperature = models.IntegerField(default=35)
    signal_strength = models.CharField(max_length=20, default='5GHz')
    last_calibration = models.DateTimeField(null=True, blank=True)
    next_service_due = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"{self.name} ({self.serial_number})"

class EstimationResult(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='estimations')
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='estimations', null=True, blank=True)
    length = models.FloatField()
    width = models.FloatField()
    height = models.FloatField()
    volume = models.FloatField()
    recommendation = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Estimation {self.volume}ml for {self.doctor.fullName}"

class DataExport(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='exports')
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=20, default='Pending') # Pending, Completed, Failed
    file_name = models.CharField(max_length=255, null=True, blank=True)
    file_size = models.CharField(max_length=50, null=True, blank=True) # e.g., "189.2 MB"
    categories_included = models.IntegerField(default=4)
    download_url = models.URLField(null=True, blank=True)
    expires_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Export {self.id} for {self.doctor.fullName} ({self.status})"

class Feedback(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='feedbacks')
    feedback_type = models.CharField(max_length=50, default='General') # Bug Report, Feature Request, etc.
    message = models.TextField()
    email = models.EmailField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Feedback ({self.feedback_type}) from {self.doctor.fullName}"

class PasswordResetToken(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE)
    token = models.CharField(max_length=6)
    created_at = models.DateTimeField(auto_now_add=True)
    is_used = models.BooleanField(default=False)

    def is_valid(self):
        # Valid for 15 minutes
        return not self.is_used and (timezone.now() < self.created_at + timezone.timedelta(minutes=15))

    def __str__(self):
        return f"Token for {self.doctor.fullName} ({self.token})"

class HelpArticle(models.Model):
    title = models.CharField(max_length=255)
    content = models.TextField()
    category = models.CharField(max_length=100, default='General')
    is_popular = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

class Notification(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='notifications')
    title = models.CharField(max_length=255)
    message = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Notification for {self.doctor.fullName} - {self.title}"

class PrivacyPolicy(models.Model):
    content = models.TextField()
    last_updated = models.DateField(auto_now=True)
    version = models.CharField(max_length=20, default="1.0.0")

    def __str__(self):
        return f"Privacy Policy v{self.version} ({self.last_updated})"

class Recommendation(models.Model):
    title = models.CharField(max_length=255)
    content = models.TextField()
    category = models.CharField(max_length=100, default='General')
    icon_name = models.CharField(max_length=50, blank=True, null=True) # Reference to Android drawable name
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

class UserSession(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='sessions')
    device_name = models.CharField(max_length=255) # e.g., "iPhone 14 Pro"
    location = models.CharField(max_length=255) # e.g., "San Francisco, CA"
    last_active = models.DateTimeField(auto_now=True)
    is_current = models.BooleanField(default=False)
    
    def __str__(self):
        return f"{self.device_name} for {self.doctor.fullName}"

class TeamMember(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='team_members')
    fullName = models.CharField(max_length=255)
    staff_id = models.CharField(max_length=50, unique=True)
    role = models.CharField(max_length=100) # e.g., "Ultrasound Tech", "Nurse", "Patient Care"
    status = models.CharField(max_length=50, default='Active') # Active, Inactive
    years_of_experience = models.IntegerField(default=0)
    total_scans = models.IntegerField(default=0)
    accuracy_pct = models.IntegerField(default=0) # 0-100
    total_patients = models.IntegerField(default=0)
    email = models.EmailField()
    phone = models.CharField(max_length=20)
    location = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.fullName} ({self.staff_id})"

class TeamInvitation(models.Model):
    inviter = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='sent_invitations')
    email = models.EmailField()
    fullName = models.CharField(max_length=255)
    role = models.CharField(max_length=100) # e.g., "Doctor (Full Access)"
    licenseNumber = models.CharField(max_length=100)
    specialty = models.CharField(max_length=100)
    status = models.CharField(max_length=20, default='Pending') # Pending, Accepted, Expired
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Invite to {self.email} from {self.inviter.fullName}"

class TrainingModule(models.Model):
    title = models.CharField(max_length=255)
    subtitle = models.CharField(max_length=255, null=True, blank=True) # e.g., "Probe handling & physics"
    description = models.TextField()
    video_url = models.URLField(null=True, blank=True)
    takeaways = models.JSONField(default=list) # List of strings
    duration_minutes = models.IntegerField(default=15)
    order = models.IntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

class TrainingProgress(models.Model):
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='training_progress')
    module = models.ForeignKey(TrainingModule, on_delete=models.CASCADE, related_name='user_progress')
    is_completed = models.BooleanField(default=False)
    completed_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        unique_together = ('doctor', 'module')

    def __str__(self):
        status = "Completed" if self.is_completed else "In Progress"
        return f"{self.doctor.fullName} - {self.module.title} ({status})"
