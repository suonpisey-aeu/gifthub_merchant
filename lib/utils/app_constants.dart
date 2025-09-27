// =============================================================================
// File: utils/app_constants.dart
// =============================================================================
class AppConstants {
  // App Information
  static const String appName = 'GiftHub Cambodia';
  static const String appSubtitle = 'Merchant Portal';
  static const String appVersion = '1.0.0';
  
  // API Endpoints (for future implementation)
  static const String baseUrl = 'https://api.gifthub.com.kh';
  static const String loginEndpoint = '/auth/merchant/login';
  static const String vouchersEndpoint = '/merchant/vouchers';
  static const String transactionsEndpoint = '/merchant/transactions';
  static const String analyticsEndpoint = '/merchant/analytics';
  static const String profileEndpoint = '/merchant/profile';
  
  // Shared Preferences Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyMerchantId = 'merchant_id';
  static const String keyMerchantEmail = 'merchant_email';
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  
  // Default Values
  static const int defaultPageSize = 20;
  static const int connectionTimeout = 30; // seconds
  static const int receiveTimeout = 30; // seconds
  
  // Voucher Categories
  static const List<String> voucherCategories = [
    'Food & Beverage',
    'Retail & Shopping',
    'Entertainment',
    'Health & Beauty',
    'Travel & Tourism',
    'Services',
    'Education',
    'Sports & Fitness',
    'Technology',
    'Others',
  ];
  
  // Voucher Status
  static const String statusActive = 'active';
  static const String statusInactive = 'inactive';
  static const String statusExpired = 'expired';
  static const String statusRedeemed = 'redeemed';
  
  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxVoucherTitleLength = 100;
  static const int maxVoucherDescriptionLength = 500;
  static const double minVoucherPrice = 0.01;
  static const double maxVoucherPrice = 10000.00;
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 300);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
  
  // Error Messages
  static const String errorNetworkConnection = 'No internet connection. Please check your network and try again.';
  static const String errorServerConnection = 'Unable to connect to server. Please try again later.';
  static const String errorInvalidCredentials = 'Invalid email or password. Please try again.';
  static const String errorSessionExpired = 'Your session has expired. Please login again.';
  static const String errorUnknown = 'An unexpected error occurred. Please try again.';
  
  // Success Messages
  static const String successLogin = 'Login successful!';
  static const String successVoucherCreated = 'Voucher created successfully!';
  static const String successVoucherUpdated = 'Voucher updated successfully!';
  static const String successVoucherDeleted = 'Voucher deleted successfully!';
  static const String successVoucherRedeemed = 'Voucher redeemed successfully!';
  static const String successProfileUpdated = 'Profile updated successfully!';
  
  // Feature Flags (for future development)
  static const bool enablePushNotifications = true;
  static const bool enableOfflineMode = false;
  static const bool enableDarkTheme = false;
  static const bool enableAnalytics = true;
  static const bool enableQRScanner = true;
  static const bool enableExport = false;
  
  // Limits
  static const int maxVouchersPerBatch = 100;
  static const int maxTransactionsPerPage = 50;
  static const int maxImageSizeMB = 5;
  static const int maxQRCodeLength = 50;
  
  // Currency
  static const String currencySymbol = '\$';
  static const String currencyCode = 'USD';
  
  // Contact Information
  static const String supportEmail = 'support@gifthub.com.kh';
  static const String supportPhone = '+855 XX XXX XXX';
  static const String websiteUrl = 'https://gifthub.com.kh';
  
  // Social Media
  static const String facebookUrl = 'https://facebook.com/gifthubcambodia';
  static const String instagramUrl = 'https://instagram.com/gifthubcambodia';
  static const String linkedinUrl = 'https://linkedin.com/company/gifthubcambodia';
  
  // Legal
  static const String termsOfServiceUrl = 'https://gifthub.com.kh/terms';
  static const String privacyPolicyUrl = 'https://gifthub.com.kh/privacy';
  
  // App Store
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.gifthub.merchant';
  static const String appStoreUrl = 'https://apps.apple.com/app/gifthub-merchant/id123456789';
}