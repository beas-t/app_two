from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenRefreshView
from .views import (
    SignUpView, LoginView, DoctorProfileView,
    PatientViewSet, ScanReportViewSet, AppointmentViewSet, AppInfoView,
    AnalyticsView, ImageVerificationView, BackupViewSet, BackupSettingsView,
    CacheManagementView, ScanGuidanceView, SupportMessageViewSet,
    AccessibilitySettingsView, DisplaySettingsView, EquipmentViewSet,
    VolumeEstimationView, DataExportViewSet, FeedbackViewSet, PasswordResetViewSet,
    HelpArticleViewSet, HomeDashboardView, NotificationViewSet, LogoutView,
    PrivacyPolicyViewSet, AccountDeletionView, RecommendationViewSet, ScanReportCreateView,
    UserSessionViewSet, SecurityStatusView, ChangePasswordView, SettingsSummaryView,
    TeamMemberViewSet, TeamInvitationViewSet, TrainingModuleViewSet
)

router = DefaultRouter()
router.register(r'patients', PatientViewSet, basename='patient')
router.register(r'reports', ScanReportViewSet, basename='report')
router.register(r'appointments', AppointmentViewSet, basename='appointment')
router.register(r'backups', BackupViewSet, basename='backup')
router.register(r'support-messages', SupportMessageViewSet, basename='support-message')
router.register(r'equipment', EquipmentViewSet, basename='equipment')
router.register(r'exports', DataExportViewSet, basename='export')
router.register(r'feedback', FeedbackViewSet, basename='feedback')
router.register(r'password-reset', PasswordResetViewSet, basename='password-reset')
router.register(r'help', HelpArticleViewSet, basename='help')
router.register(r'notifications', NotificationViewSet, basename='notification')
router.register(r'privacy-policy', PrivacyPolicyViewSet, basename='privacy-policy')
router.register(r'recommendations', RecommendationViewSet, basename='recommendations')
router.register(r'sessions', UserSessionViewSet, basename='session')
router.register(r'team-members', TeamMemberViewSet, basename='team-member')
router.register(r'invitations', TeamInvitationViewSet, basename='invitation')
router.register(r'training', TrainingModuleViewSet, basename='training')

urlpatterns = [
    path('signup/', SignUpView.as_view(), name='signup'),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('profile/', DoctorProfileView.as_view(), name='doctor-profile'),
    path('app-info/', AppInfoView.as_view(), name='app-info'),
    path('analytics/', AnalyticsView.as_view(), name='analytics'),
    path('verify-image/', ImageVerificationView.as_view(), name='verify-image'),
    path('scan-guidance/', ScanGuidanceView.as_view(), name='scan-guidance'),
    path('backup-settings/', BackupSettingsView.as_view(), name='backup-settings'),
    path('clear-cache/', CacheManagementView.as_view(), name='clear-cache'),
    path('accessibility-settings/', AccessibilitySettingsView.as_view(), name='accessibility-settings'),
    path('display-settings/', DisplaySettingsView.as_view(), name='display-settings'),
    path('estimate-volume/', VolumeEstimationView.as_view(), name='estimate-volume'),
    path('save-report/', ScanReportCreateView.as_view(), name='save-report'),
    path('home-dashboard/', HomeDashboardView.as_view(), name='home-dashboard'),
    path('delete-account/', AccountDeletionView.as_view(), name='delete-account'),
    path('security-status/', SecurityStatusView.as_view(), name='security-status'),
    path('change-password/', ChangePasswordView.as_view(), name='change-password'),
    path('settings-summary/', SettingsSummaryView.as_view(), name='settings-summary'),
    path('', include(router.urls)),
]
