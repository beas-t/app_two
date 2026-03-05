import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'bladder.settings')
django.setup()

from doctor.models import AppInfo, Feature

def populate_app_info():
    if AppInfo.objects.exists():
        print("AppInfo already exists. Skipping.")
        return

    info = AppInfo.objects.create(
        app_name="BladSense AI",
        version="2.1.0",
        build_number="402",
        description="BladSense AI is a revolutionary medical imaging platform that uses artificial intelligence to analyze bladder ultrasound scans and provide accurate volume measurements in seconds.",
        footer_text="Made with ❤ by BladSense Team",
        copyright_text="© 2024 BladSense Inc. All rights reserved."
    )

    Feature.objects.create(
        app_info=info,
        title="HIPAA Compliant",
        description="Enterprise-grade security",
        icon_type="hipaa"
    )
    Feature.objects.create(
        app_info=info,
        title="FDA Cleared",
        description="Clinically validated technology",
        icon_type="fda"
    )
    Feature.objects.create(
        app_info=info,
        title="Team Collaboration",
        description="Multi-user support",
        icon_type="team"
    )

    print("AppInfo populated successfully.")

if __name__ == "__main__":
    populate_app_info()
