import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/merchant_login_screen.dart';
import 'screens/auth/merchant_register_screen.dart';
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
          '/register': (context) => MerchantRegisterScreen(),
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