import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/voucher_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/stat_card.dart';

class AnalyticsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const AnalyticsScreen({Key? key, this.onBack}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedPeriod = 'week';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onBack ?? () => Navigator.of(context).pop(),
        ),
        title: Text('Analytics'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'week', child: Text('This Week')),
              PopupMenuItem(value: 'month', child: Text('This Month')),
              PopupMenuItem(value: 'year', child: Text('This Year')),
            ],
            child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_getPeriodLabel()),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Consumer<VoucherProvider>(
        builder: (context, voucherProvider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Key Metrics
                Text(
                  'Key Metrics',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 16),
                
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    StatCard(
                      title: 'Revenue',
                      value: '\$${_calculateRevenue(voucherProvider)}',
                      icon: Icons.attach_money,
                      color: AppTheme.primaryColor,
                    ),
                    StatCard(
                      title: 'Redemptions',
                      value: '${_calculateRedemptions(voucherProvider)}',
                      icon: Icons.redeem,
                      color: AppTheme.secondaryColor,
                    ),
                    StatCard(
                      title: 'Conversion Rate',
                      value: '${_calculateConversionRate(voucherProvider)}%',
                      icon: Icons.trending_up,
                      color: AppTheme.accentColor,
                    ),
                    StatCard(
                      title: 'Avg. Order Value',
                      value: '\$${_calculateAverageOrderValue(voucherProvider)}',
                      icon: Icons.shopping_cart,
                      color: Colors.purple,
                    ),
                  ],
                ),
                
                SizedBox(height: 32),
                
                // Performance Chart Placeholder
                Text(
                  'Performance Overview',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 16),
                
                Container(
                  height: 200,
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bar_chart,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Chart Visualization',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Coming Soon',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 32),
                
                // Top Performing Vouchers
                Text(
                  'Top Performing Vouchers',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 16),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: voucherProvider.vouchers.length,
                  itemBuilder: (context, index) {
                    final voucher = voucherProvider.vouchers[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(voucher.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          voucher.title,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${voucher.currentRedemptions} redemptions',
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\$${(voucher.discountedPrice * voucher.currentRedemptions).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            Text(
                              '${((voucher.currentRedemptions / voucher.maxRedemptions) * 100).toInt()}% sold',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getPeriodLabel() {
    switch (_selectedPeriod) {
      case 'week':
        return 'This Week';
      case 'month':
        return 'This Month';
      case 'year':
        return 'This Year';
      default:
        return 'This Week';
    }
  }

  String _calculateRevenue(VoucherProvider provider) {
    final total = provider.transactions.fold<double>(0.0, (sum, t) => sum + t.amount);
    return total.toStringAsFixed(2);
  }

  String _calculateRedemptions(VoucherProvider provider) {
    return provider.transactions.length.toString();
  }

  String _calculateConversionRate(VoucherProvider provider) {
    final totalVouchers = provider.vouchers.fold<int>(0, (sum, v) => sum + v.maxRedemptions);
    final totalRedemptions = provider.vouchers.fold<int>(0, (sum, v) => sum + v.currentRedemptions);
    
    if (totalVouchers == 0) return '0';
    
    final rate = (totalRedemptions / totalVouchers) * 100;
    return rate.toStringAsFixed(1);
  }

  String _calculateAverageOrderValue(VoucherProvider provider) {
    if (provider.transactions.isEmpty) return '0.00';
    
    final total = provider.transactions.fold<double>(0.0, (sum, t) => sum + t.amount);
    final average = total / provider.transactions.length;
    return average.toStringAsFixed(2);
  }
}
