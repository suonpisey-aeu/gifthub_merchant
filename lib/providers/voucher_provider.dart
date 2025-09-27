import 'package:flutter/foundation.dart';
import '../models/voucher_model.dart';

class VoucherProvider with ChangeNotifier {
  List<VoucherTemplate> _vouchers = [];
  List<VoucherTransaction> _transactions = [];
  bool _isLoading = false;

  List<VoucherTemplate> get vouchers => _vouchers;
  List<VoucherTransaction> get transactions => _transactions;
  bool get isLoading => _isLoading;

  VoucherProvider() {
    _loadSampleData();
  }

  void _loadSampleData() {
    _vouchers = [
      VoucherTemplate(
        id: '1',
        merchantId: '1',
        title: 'Coffee & Pastry Combo',
        description: 'Get any coffee with a pastry of your choice',
        originalPrice: 12.00,
        discountedPrice: 9.00,
        category: 'Food & Beverage',
        validFrom: DateTime.now(),
        validUntil: DateTime.now().add(Duration(days: 30)),
        maxRedemptions: 100,
        currentRedemptions: 23,
        status: VoucherStatus.active,
        imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',
        terms: ['Valid for dine-in only', 'Cannot be combined with other offers'],
      ),
      VoucherTemplate(
        id: '2',
        merchantId: '1',
        title: 'Lunch Set Menu',
        description: 'Complete lunch set with main course, soup, and drink',
        originalPrice: 18.00,
        discountedPrice: 14.00,
        category: 'Food & Beverage',
        validFrom: DateTime.now(),
        validUntil: DateTime.now().add(Duration(days: 15)),
        maxRedemptions: 50,
        currentRedemptions: 31,
        status: VoucherStatus.active,
        imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
        terms: ['Valid Monday to Friday', 'Available 11AM - 3PM only'],
      ),
    ];

    _transactions = [
      VoucherTransaction(
        id: '1',
        voucherId: '1',
        consumerName: 'Sok Pisey',
        consumerEmail: 'pisey@example.com',
        redeemedAt: DateTime.now().subtract(Duration(hours: 2)),
        amount: 9.00,
        qrCode: 'GH123456789',
      ),
      VoucherTransaction(
        id: '2',
        voucherId: '2',
        consumerName: 'Chea Dara',
        consumerEmail: 'dara@example.com',
        redeemedAt: DateTime.now().subtract(Duration(hours: 5)),
        amount: 14.00,
        qrCode: 'GH987654321',
      ),
    ];
  }

  Future<void> createVoucher(VoucherTemplate voucher) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    _vouchers.add(voucher);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateVoucher(VoucherTemplate voucher) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    int index = _vouchers.indexWhere((v) => v.id == voucher.id);
    if (index != -1) {
      _vouchers[index] = voucher;
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteVoucher(String voucherId) async {
    _vouchers.removeWhere((v) => v.id == voucherId);
    notifyListeners();
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    await Future.delayed(Duration(milliseconds: 500));
    
    return {
      'totalVouchers': _vouchers.length,
      'activeVouchers': _vouchers.where((v) => v.status == VoucherStatus.active).length,
      'totalSales': _transactions.fold<double>(0.0, (sum, t) => sum + t.amount), // Fixed type
      'todaySales': _transactions
          .where((t) => t.redeemedAt.day == DateTime.now().day)
          .fold<double>(0.0, (sum, t) => sum + t.amount), // Fixed type
      'totalRedemptions': _transactions.length,
    };
  }
}