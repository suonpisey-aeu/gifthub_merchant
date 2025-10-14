import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/voucher_model.dart';
import '../../providers/voucher_provider.dart';
import '../../providers/merchant_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class CreateVoucherScreen extends StatefulWidget {
  const CreateVoucherScreen({super.key});

  @override
  _CreateVoucherScreenState createState() => _CreateVoucherScreenState();
}

class _CreateVoucherScreenState extends State<CreateVoucherScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _originalPriceController = TextEditingController();
  final _discountedPriceController = TextEditingController();
  final _validityDaysController = TextEditingController(text: '30');
  final _maxRedemptionsController = TextEditingController(text: '100');
  final _imageUrlController = TextEditingController();
  final _termController = TextEditingController();
  
  // State
  String _selectedCategory = 'Food & Beverage';
  final List<String> _terms = [];
  bool _isLoading = false;
  
  final List<String> _categories = [
    'Food & Beverage',
    'Shopping',
    'Entertainment',
    'Health & Beauty',
    'Travel',
    'Services',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _originalPriceController.dispose();
    _discountedPriceController.dispose();
    _validityDaysController.dispose();
    _maxRedemptionsController.dispose();
    _imageUrlController.dispose();
    _termController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Voucher'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Voucher Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Fill in the details for your new voucher',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Title
                    CustomTextField(
                      controller: _titleController,
                      label: 'Voucher Title',
                      hint: 'e.g., Coffee & Pastry Combo',
                      prefixIcon: Icons.local_offer,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Description
                    CustomTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      hint: 'Describe what customers get...',
                      prefixIcon: Icons.description,
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    
                    // Pricing Section
                    Text(
                      'Pricing',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _originalPriceController,
                            label: 'Original',
                            hint: '0.00',
                            prefixIcon: Icons.attach_money,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Invalid';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            controller: _discountedPriceController,
                            label: 'Sale Price',
                            hint: '0.00',
                            prefixIcon: Icons.discount,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              final price = double.tryParse(value);
                              final originalPrice = double.tryParse(_originalPriceController.text);
                              if (price == null) {
                                return 'Invalid';
                              }
                              if (originalPrice != null && price >= originalPrice) {
                                return 'Too high';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    // Discount Percentage Display
                    if (_originalPriceController.text.isNotEmpty && 
                        _discountedPriceController.text.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: _buildDiscountBadge(),
                      ),
                    
                    SizedBox(height: 24),
                    
                    // Category
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down),
                          items: _categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Availability Section
                    Text(
                      'Availability',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _validityDaysController,
                            label: 'Days Valid',
                            hint: '30',
                            prefixIcon: Icons.calendar_today,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Invalid';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            controller: _maxRedemptionsController,
                            label: 'Max Uses',
                            hint: '100',
                            prefixIcon: Icons.people,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Invalid';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Image Upload
                    Text(
                      'Voucher Image',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!, width: 2, style: BorderStyle.solid),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                size: 40,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tap to upload image',
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'or paste image URL below',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 12),
                    
                    CustomTextField(
                      controller: _imageUrlController,
                      label: 'Image URL',
                      hint: 'https://...',
                      prefixIcon: Icons.link,
                      keyboardType: TextInputType.url,
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Terms & Conditions
                    Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _termController,
                            decoration: InputDecoration(
                              hintText: 'Add a term or condition',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: _addTerm,
                          ),
                        ),
                      ],
                    ),
                    
                    if (_terms.isNotEmpty) ...[
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          children: _terms.asMap().entries.map((entry) {
                            int index = entry.key;
                            String term = entry.value;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, size: 16, color: AppTheme.secondaryColor),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(term, style: TextStyle(fontSize: 14)),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close, size: 18),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    onPressed: () {
                                      setState(() {
                                        _terms.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                    
                    SizedBox(height: 32),
                    
                    // Action Buttons
                    Column(
                      children: [
                        CustomButton(
                          text: 'Create Voucher',
                          icon: Icons.check_circle,
                          onPressed: _createVoucher,
                          width: double.infinity,
                        ),
                        SizedBox(height: 12),
                        CustomButton(
                          text: 'Preview',
                          icon: Icons.visibility,
                          isOutlined: true,
                          onPressed: _previewVoucher,
                          width: double.infinity,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDiscountBadge() {
    final original = double.tryParse(_originalPriceController.text);
    final discounted = double.tryParse(_discountedPriceController.text);
    
    if (original != null && discounted != null && original > discounted) {
      final percentage = ((original - discounted) / original * 100).toInt();
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.secondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.secondaryColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_offer, size: 16, color: AppTheme.secondaryColor),
            SizedBox(width: 6),
            Text(
              '$percentage% OFF',
              style: TextStyle(
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  void _addTerm() {
    if (_termController.text.trim().isNotEmpty) {
      setState(() {
        _terms.add(_termController.text.trim());
        _termController.clear();
      });
    }
  }

  void _pickImage() {
    // Placeholder for image picker functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Image picker will be implemented with image_picker package'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _previewVoucher() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Preview'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_titleController.text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(_descriptionController.text),
                SizedBox(height: 12),
                Text('Original: \$${_originalPriceController.text}', style: TextStyle(decoration: TextDecoration.lineThrough)),
                Text('Sale: \$${_discountedPriceController.text}', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('Category: $_selectedCategory'),
                Text('Valid for: ${_validityDaysController.text} days'),
                Text('Max redemptions: ${_maxRedemptionsController.text}'),
                if (_terms.isNotEmpty) ...[
                  SizedBox(height: 12),
                  Text('Terms:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ..._terms.map((term) => Text('• $term')),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _createVoucher() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final merchant = Provider.of<MerchantProvider>(context, listen: false).merchant;
        final voucherProvider = Provider.of<VoucherProvider>(context, listen: false);

        final validityDays = int.parse(_validityDaysController.text);
        
        final voucher = VoucherTemplate(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          merchantId: merchant?.id ?? '1',
          title: _titleController.text,
          description: _descriptionController.text,
          originalPrice: double.parse(_originalPriceController.text),
          discountedPrice: double.parse(_discountedPriceController.text),
          category: _selectedCategory,
          validFrom: DateTime.now(),
          validUntil: DateTime.now().add(Duration(days: validityDays)),
          maxRedemptions: int.parse(_maxRedemptionsController.text),
          currentRedemptions: 0,
          status: VoucherStatus.active,
          imageUrl: _imageUrlController.text.isEmpty 
              ? 'https://images.unsplash.com/photo-1513542789411-b6a5d4f31634' 
              : _imageUrlController.text,
          terms: _terms,
        );

        await voucherProvider.createVoucher(voucher);

        setState(() {
          _isLoading = false;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Voucher created successfully!'),
              ],
            ),
            backgroundColor: AppTheme.secondaryColor,
          ),
        );

        // Navigate back
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating voucher: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }
}