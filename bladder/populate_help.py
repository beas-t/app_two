import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'bladder.settings')
django.setup()

from doctor.models import HelpArticle

def populate():
    articles = [
        {
            'title': 'Getting Started with BladSense',
            'content': 'To get started with BladSense, first ensure your device is charged and connected via Bluetooth. Open the app and follow the on-screen instructions to create your account.',
            'category': 'Basics',
            'is_popular': True
        },
        {
            'title': 'How to Perform a Scan',
            'content': 'Applying ultrasound gel to the probe. Place the probe on the lower abdomen. Follow the real-time AI guidance for optimal bladder alignment.',
            'category': 'Scanning',
            'is_popular': True
        },
        {
            'title': 'Understanding Volume Measurements',
            'content': 'The AI calculates volume based on longitudinal and transverse planes. High volume triggers alert based on medical guidelines.',
            'category': 'Results',
            'is_popular': True
        },
        {
            'title': 'Interpreting AI Results',
            'content': 'AI results provide estimates and quality scores. Always consult with clinical judgment before taking action.',
            'category': 'Results',
            'is_popular': True
        },
        {
            'title': 'Patient Data Management',
            'content': 'All patient data is encrypted and HIPAA compliant. You can export data for offline review at any time.',
            'category': 'Data',
            'is_popular': True
        },
        {
            'title': 'Troubleshooting Connectivity',
            'content': 'If the probe fails to connect, restart the Bluetooth on your phone and ensure no other device is paired with the probe.',
            'category': 'Troubleshooting',
            'is_popular': False
        }
    ]

    for art in articles:
        HelpArticle.objects.get_or_create(
            title=art['title'],
            defaults={
                'content': art['content'],
                'category': art['category'],
                'is_popular': art['is_popular']
            }
        )
    print("Help articles populated successfully!")

if __name__ == '__main__':
    populate()
