import 'package:flutter/foundation.dart';
import '../models/merchant_model.dart';

class MerchantProvider with ChangeNotifier {
  Merchant? _merchant;
  bool _isLoading = false;

  Merchant? get merchant => _merchant;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      _merchant = Merchant(
        id: '1',
        businessName: 'Sample Business',
        email: email,
        phone: '+855 12 345 678',
        address: 'Phnom Penh, Cambodia',
        category: 'Restaurant',
        isActive: true,
        commissionRate: 8.5,
        createdAt: DateTime.now(),
      );
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _merchant = null;
    notifyListeners();
  }
}