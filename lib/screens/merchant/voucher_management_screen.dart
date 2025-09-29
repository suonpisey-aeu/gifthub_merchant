import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/voucher_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/voucher_card.dart';
import '../../widgets/custom_button.dart';

class VoucherManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const VoucherManagementScreen({Key? key, this.onBack}) : super(key: key);

  @override
  _VoucherManagementScreenState createState() => _VoucherManagementScreenState();
}

class _VoucherManagementScreenState extends State<VoucherManagementScreen> {
  String _selectedFilter = 'all';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onBack ?? () => Navigator.of(context).pop(),
        ),
        title: Text('Voucher Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All', 'all'),
                SizedBox(width: 8),
                _buildFilterChip('Active', 'active'),
                SizedBox(width: 8),
                _buildFilterChip('Inactive', 'inactive'),
                SizedBox(width: 8),
                _buildFilterChip('Expired', 'expired'),
              ],
            ),
          ),
          
          // Vouchers List
          Expanded(
            child: Consumer<VoucherProvider>(
              builder: (context, voucherProvider, child) {
                final filteredVouchers = _getFilteredVouchers(voucherProvider);
                
                if (filteredVouchers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No vouchers found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Create your voucher to get started',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        SizedBox(height: 24),
                        CustomButton(
                          text: 'Create Voucher',
                          icon: Icons.add,
                          onPressed: _createNewVoucher,
                        ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: filteredVouchers.length,
                  itemBuilder: (context, index) {
                    final voucher = filteredVouchers[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: VoucherCard(
                        voucher: voucher,
                        onTap: () => _editVoucher(voucher.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewVoucher,
        backgroundColor: AppTheme.primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      selectedColor: AppTheme.primaryColor.withOpacity(0.2),
      checkmarkColor: AppTheme.primaryColor,
    );
  }

  List _getFilteredVouchers(VoucherProvider provider) {
    switch (_selectedFilter) {
      case 'active':
        return provider.vouchers.where((v) => v.status.toString() == 'VoucherStatus.active').toList();
      case 'inactive':
        return provider.vouchers.where((v) => v.status.toString() == 'VoucherStatus.inactive').toList();
      case 'expired':
        return provider.vouchers.where((v) => v.status.toString() == 'VoucherStatus.expired').toList();
      default:
        return provider.vouchers;
    }
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filter Options',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('All Vouchers'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'all';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Active'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'active';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Inactive'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'inactive';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Expired'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'expired';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _createNewVoucher() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Create voucher functionality coming soon!')),
    );
  }

  void _editVoucher(String voucherId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit voucher functionality coming soon!')),
    );
  }
}
