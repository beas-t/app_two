import os
import django
from datetime import date, time

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'bladder.settings')
django.setup()

from django.contrib.auth.models import User
from doctor.models import DoctorProfile, Patient, Appointment

def populate_appointments():
    # Ensure doctor exists
    user = User.objects.filter(username="doctor@example.com").first()
    if not user:
        user = User.objects.create_user(username="doctor@example.com", password="password123")
    
    doctor, _ = DoctorProfile.objects.get_or_create(
        user=user,
        defaults={'fullName': "Dr. John Doe", 'licenseNumber': "LIC-12345", 'specialty': "Urology"}
    )

    # Sample Patients
    patients_data = [
        {"name": "James Wilson", "patient_id": "P-001", "age": 45, "gender": "Male"},
        {"name": "Sarah Connor", "patient_id": "P-002", "age": 32, "gender": "Female"},
        {"name": "Robert Smith", "patient_id": "P-003", "age": 58, "gender": "Male"},
    ]

    patients = []
    for p_data in patients_data:
        p, _ = Patient.objects.get_or_create(
            doctor=doctor,
            patient_id=p_data["patient_id"],
            defaults=p_data
        )
        patients.append(p)

    # Sample Appointments matching the UI (activity_appointment.xml)
    appointments_data = [
        {
            "patient": patients[0],
            "date": date(2024, 10, 23),
            "time": time(9, 0),
            "appointment_type": "Follow-up Scan",
            "duration_minutes": 30,
            "location": "Room 302"
        },
        {
            "patient": patients[1],
            "date": date(2024, 10, 23),
            "time": time(10, 30),
            "appointment_type": "Initial Assessment",
            "duration_minutes": 45,
            "location": "Room 302"
        },
        {
            "patient": patients[2],
            "date": date(2024, 10, 23),
            "time": time(14, 0),
            "appointment_type": "Routine Check",
            "duration_minutes": 15,
            "location": "Room 302"
        },
    ]

    for a_data in appointments_data:
        Appointment.objects.get_or_create(
            doctor=doctor,
            patient=a_data["patient"],
            date=a_data["date"],
            time=a_data["time"],
            defaults={
                "appointment_type": a_data["appointment_type"],
                "duration_minutes": a_data["duration_minutes"],
                "location": a_data["location"],
                "status": "Scheduled"
            }
        )

    print("Sample appointments populated successfully.")

if __name__ == "__main__":
    populate_appointments()
