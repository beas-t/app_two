import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'bladder.settings')
django.setup()

from django.contrib.auth.models import User
from doctor.models import DoctorProfile, AnalyticsData

def populate_analytics():
    # Ensure at least one doctor exists
    user, created = User.objects.get_or_create(username="doctor@example.com", email="doctor@example.com")
    if created:
        user.set_password("password123")
        user.save()
    
    profile, created = DoctorProfile.objects.get_or_create(
        user=user,
        defaults={
            'fullName': "Dr. John Doe",
            'licenseNumber': "LIC-12345",
            'specialty': "Urology"
        }
    )

    # Create or update analytics data
    analytics, created = AnalyticsData.objects.update_or_create(
        doctor=profile,
        defaults={
            'total_scans': 142,
            'scans_increase_pct': 12.0,
            'avg_volume': "320ml",
            'volume_decrease_pct': 5.0,
            'active_patients': 89,
            'patients_increase': 3,
            'retention_rate': 18.0,
            'retention_increase_pct': 2.0,
            'trend_monday': 310.0,
            'trend_tuesday': 340.0,
            'trend_wednesday': 320.0,
            'trend_thursday': 350.0,
            'trend_friday': 300.0,
            'trend_saturday': 280.0,
            'trend_sunday': 260.0,
            'scan_duration_seconds': 45.0,
            'image_quality_pct': 98.0,
            'report_gen_seconds': 1.2
        }
    )

    print(f"Analytics populated for {profile.fullName}")

if __name__ == "__main__":
    populate_analytics()
