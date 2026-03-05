import os
import django
from django.utils import timezone
from datetime import timedelta

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'bladder.settings')
django.setup()

from django.contrib.auth.models import User
from doctor.models import DoctorProfile, Backup, BackupSettings

def populate_backup_data():
    # Ensure doctor exists
    user = User.objects.filter(username="doctor@example.com").first()
    if not user:
        user = User.objects.create_user(username="doctor@example.com", password="password123")
    
    doctor, _ = DoctorProfile.objects.get_or_create(
        user=user,
        defaults={'fullName': "Dr. John Doe", 'licenseNumber': "LIC-12345", 'specialty': "Urology"}
    )

    # Initial Settings
    BackupSettings.objects.get_or_create(
        doctor=doctor,
        defaults={
            'auto_backup': True,
            'include_images': True,
            'wifi_only': True,
            'last_backup_at': timezone.now()
        }
    )

    # Sample Backup History matching activity_backup.xml
    history_data = [
        {"days_ago": 0, "size": "1.2 GB", "items": 248},
        {"days_ago": 1, "size": "1.2 GB", "items": 240},
        {"days_ago": 2, "size": "1.1 GB", "items": 235},
    ]

    for h in history_data:
        backup_time = timezone.now() - timedelta(days=h["days_ago"])
        # Set to 3:00 AM as per UI
        backup_time = backup_time.replace(hour=3, minute=0, second=0, microsecond=0)
        
        Backup.objects.get_or_create(
            doctor=doctor,
            created_at=backup_time,
            defaults={
                "file_size": h["size"],
                "item_count": h["items"],
                "status": "Success"
            }
        )

    print("Sample backup data populated successfully.")

if __name__ == "__main__":
    populate_backup_data()
