<<<<<<< HEAD
# gift-hub
=======
// =============================================================================
// File: main.dart
// =============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/merchant_login_screen.dart';
import 'screens/merchant/merchant_dashboard_screen.dart';
import 'providers/merchant_provider.dart';
import 'providers/voucher_provider.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(GiftHubMerchantApp());
}

class GiftHubMerchantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MerchantProvider()),
        ChangeNotifierProvider(create: (_) => VoucherProvider()),
      ],
      child: MaterialApp(
        title: 'GiftHub Cambodia - Merchant',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
        routes: {
          '/login': (context) => MerchantLoginScreen(),
          '/dashboard': (context) => MerchantDashboardScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MerchantProvider>(
      builder: (context, merchantProvider, child) {
        if (merchantProvider.merchant == null) {
          return MerchantLoginScreen();
        } else {
          return MerchantDashboardScreen();
        }
      },
    );
  }
}

// =============================================================================
// File: pubspec.yaml
// =============================================================================
name: gifthub_merchant
description: GiftHub Cambodia - Merchant Portal App

publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=2.17.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.0.5
  
  # UI Components
  cupertino_icons: ^1.0.2
  
  # Network & HTTP
  http: ^0.13.5
  
  # Image Handling
  cached_network_image: ^3.2.3
  
  # Local Storage
  shared_preferences: ^2.0.17
  
  # Date/Time formatting
  intl: ^0.17.0
  
  # Charts (for analytics)
  fl_chart: ^0.60.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
    
  fonts:
    - family: Roboto
      fonts:
        - asset: fonts/Roboto-Regular.ttf
        - asset: fonts/Roboto-Medium.ttf
          weight: 500
        - asset: fonts/Roboto-Bold.ttf
          weight: 700

// =============================================================================
// File: README.md
// =============================================================================
# GiftHub Cambodia - Merchant Portal

A Flutter mobile application for merchants to manage their vouchers, track sales, and process redemptions in the GiftHub Cambodia platform.

## Features

- **Merchant Authentication**: Secure login for merchants
- **Dashboard**: Overview of key metrics and quick actions
- **Voucher Management**: Create, edit, and manage voucher templates
- **QR Code Scanner**: Scan and validate customer vouchers
- **Transaction History**: View detailed transaction records
- **Analytics**: Performance insights and sales analytics
- **Profile Management**: Merchant profile and settings

## Project Structure

```
lib/
├── main.dart                           # App entry point
├── models/                             # Data models
│   ├── merchant_model.dart
│   └── voucher_model.dart
├── providers/                          # State management (Provider)
│   ├── merchant_provider.dart
│   └── voucher_provider.dart
├── screens/                            # UI screens
│   ├── auth/
│   │   └── merchant_login_screen.dart
│   └── merchant/
│       ├── merchant_dashboard_screen.dart
│       ├── voucher_management_screen.dart
│       ├── transactions_screen.dart
│       ├── analytics_screen.dart
│       ├── profile_screen.dart
│       └── qr_scanner_screen.dart
├── widgets/                            # Reusable UI components
│   ├── custom_button.dart
│   ├── custom_text_field.dart
│   ├── stat_card.dart
│   └── voucher_card.dart
└── utils/                              # Utilities and themes
    └── app_theme.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (>=2.17.0)
- Dart SDK
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repository-url>
   cd gifthub_merchant
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```
>>>>>>> 58fd195 (chore: push all files)
