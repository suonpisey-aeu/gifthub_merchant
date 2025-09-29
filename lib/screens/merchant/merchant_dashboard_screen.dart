import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/merchant_provider.dart';
import '../../providers/voucher_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/voucher_card.dart';
import 'voucher_management_screen.dart';
import 'transactions_screen.dart';
import 'analytics_screen.dart';
import 'profile_screen.dart';
import 'qr_scanner_screen.dart';

class MerchantDashboardScreen extends StatefulWidget {
  @override
  _MerchantDashboardScreenState createState() => _MerchantDashboardScreenState();
}

class _MerchantDashboardScreenState extends State<MerchantDashboardScreen> {
  int _currentIndex = 0;
  Map<String, dynamic> _stats = {};

  @override
  void initState() {
    super.initState();
    _loadDashboardStats();
  }

  void _loadDashboardStats() async {
    final stats = await Provider.of<VoucherProvider>(context, listen: false).getDashboardStats();
    setState(() {
      _stats = stats;
    });
  }

  void _navigateBack() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final merchant = Provider.of<MerchantProvider>(context).merchant;
    
    if (_currentIndex != 0) {
      return _getScreenForIndex(_currentIndex);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRScannerScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              // Show notifications
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadDashboardStats();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12), // ✅ Reduced from 16
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section - More compact
              Container(
                padding: EdgeInsets.all(16), // ✅ Reduced from 20
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: TextStyle(color: Colors.white70, fontSize: 14), // ✅ Reduced font
                    ),
                    Text(
                      merchant?.businessName ?? 'Business',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20, // ✅ Reduced from 24
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12), // ✅ Reduced from 16
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white70, size: 14), // ✅ Smaller icon
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            merchant?.address ?? 'Cambodia',
                            style: TextStyle(color: Colors.white70, fontSize: 13), // ✅ Smaller font
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16), // ✅ Reduced from 24
              
              // Quick Stats
              Text(
                'Overview',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 18, // ✅ Smaller font
                ),
              ),
              SizedBox(height: 12), // ✅ Reduced from 16
              
              // Stats Grid - More compact
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12, // ✅ Reduced from 16
                crossAxisSpacing: 12, // ✅ Reduced from 16
                childAspectRatio: 1.6, // ✅ Adjusted ratio for better fit
                children: [
                  StatCard(
                    title: 'Total Vouchers',
                    value: _stats['totalVouchers']?.toString() ?? '0',
                    icon: Icons.local_offer,
                    color: AppTheme.primaryColor,
                  ),
                  StatCard(
                    title: 'Active Vouchers',
                    value: _stats['activeVouchers']?.toString() ?? '0',
                    icon: Icons.check_circle,
                    color: AppTheme.secondaryColor,
                  ),
                  StatCard(
                    title: 'Today\'s Sales',
                    value: '\$${_stats['todaySales']?.toStringAsFixed(2) ?? '0.00'}',
                    icon: Icons.attach_money,
                    color: AppTheme.accentColor,
                  ),
                  StatCard(
                    title: 'Total Sales',
                    value: '\$${_stats['totalSales']?.toStringAsFixed(2) ?? '0.00'}',
                    icon: Icons.trending_up,
                    color: Colors.purple,
                  ),
                ],
              ),
              
              SizedBox(height: 20), // ✅ Reduced from 32
              
              // Quick Actions
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      'Create Voucher',
                      Icons.add,
                      AppTheme.primaryColor,
                      () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 12), // ✅ Reduced from 16
                  Expanded(
                    child: _buildQuickActionCard(
                      'Scan QR',
                      Icons.qr_code_scanner,
                      AppTheme.secondaryColor,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QRScannerScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20), // ✅ Reduced from 32
              
              // Recent Vouchers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Vouchers',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Text('View All'),
                  ),
                ],
              ),
              SizedBox(height: 12), // ✅ Reduced from 16
              
              Consumer<VoucherProvider>(
                builder: (context, voucherProvider, child) {
                  final recentVouchers = voucherProvider.vouchers.take(2).toList();
                  
                  if (recentVouchers.isEmpty) {
                    return Container(
                      padding: EdgeInsets.all(32), // ✅ Reduced from 40
                      child: Column(
                        children: [
                          Icon(
                            Icons.local_offer_outlined,
                            size: 56, // ✅ Reduced from 64
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 12), // ✅ Reduced from 16
                          Text(
                            'No vouchers yet',
                            style: TextStyle(
                              fontSize: 16, // ✅ Reduced from 18
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 6), // ✅ Reduced from 8
                          Text(
                            'Create your first voucher to get started',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13, // ✅ Smaller font
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return Column(
                    children: recentVouchers.map((voucher) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12), // ✅ Reduced from 16
                        child: VoucherCard(
                          voucher: voucher,
                          onTap: () {
                            // Navigate to voucher details
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              
              SizedBox(height: 16), // ✅ Bottom padding for safer scroll
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Vouchers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 1:
        return VoucherManagementScreen(onBack: _navigateBack);
      case 2:
        return TransactionsScreen(onBack: _navigateBack);
      case 3:
        return AnalyticsScreen(onBack: _navigateBack);
      case 4:
        return ProfileScreen(onBack: _navigateBack);
      default:
        return Container();
    }
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16), // ✅ Reduced from 20
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10), // ✅ Reduced from 12
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 22, // ✅ Reduced from 24
              ),
            ),
            SizedBox(height: 10), // ✅ Reduced from 12
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13, // ✅ Reduced from 14
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}