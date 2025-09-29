import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/merchant_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class MerchantRegisterScreen extends StatefulWidget {
  @override
  _MerchantRegisterScreenState createState() => _MerchantRegisterScreenState();
}

class _MerchantRegisterScreenState extends State<MerchantRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  String _selectedCategory = 'Food & Beverage';
  bool _acceptedTerms = false;
  
  final List<String> _categories = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      resizeToAvoidBottomInset: true, // ✅ Handle keyboard properly
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Merchant Registration',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 20), // ✅ Reduced top padding
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header - More compact
                Container(
                  padding: EdgeInsets.all(16), // ✅ Reduced padding
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.store,
                        size: 50, // ✅ Smaller icon
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(height: 8), // ✅ Reduced spacing
                      Text(
                        'Join GiftHub Cambodia',
                        style: TextStyle(
                          fontSize: 22, // ✅ Smaller font
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Start selling vouchers to thousands of customers',
                        style: TextStyle(
                          fontSize: 13, // ✅ Smaller font
                          color: AppTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20), // ✅ Reduced spacing
                
                // Business Information Section
                Text(
                  'Business Information',
                  style: TextStyle(
                    fontSize: 16, // ✅ Smaller font
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 12), // ✅ Reduced spacing
                
                CustomTextField(
                  controller: _businessNameController,
                  label: 'Business Name',
                  hint: 'Enter your business name',
                  prefixIcon: Icons.business,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your business name';
                    }
                    if (value!.length < 3) {
                      return 'Business name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12), // ✅ Reduced spacing
                
                // Category Dropdown
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Business Category',
                      prefixIcon: Icon(Icons.category),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // ✅ Reduced padding
                    ),
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
                SizedBox(height: 12),
                
                CustomTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: '+855 12 345 678',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your phone number';
                    }
                    if (value!.length < 8) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                
                CustomTextField(
                  controller: _addressController,
                  label: 'Business Address',
                  hint: 'Street, City, Province',
                  prefixIcon: Icons.location_on,
                  maxLines: 2,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your business address';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 20), // ✅ Reduced spacing
                
                // Account Information Section
                Text(
                  'Account Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                
                CustomTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  hint: 'your.email@example.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'At least 6 characters',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a password';
                    }
                    if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16), // ✅ Reduced spacing
                
                // Terms and Conditions - More compact
                Container(
                  padding: EdgeInsets.all(12), // ✅ Reduced padding
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _acceptedTerms ? AppTheme.primaryColor : Colors.grey[300]!,
                      width: _acceptedTerms ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _acceptedTerms,
                          onChanged: (bool? value) {
                            setState(() {
                              _acceptedTerms = value ?? false;
                            });
                          },
                          activeColor: AppTheme.primaryColor,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _acceptedTerms = !_acceptedTerms;
                            });
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 13, // ✅ Smaller font
                                color: AppTheme.textPrimary,
                              ),
                              children: [
                                TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20), // ✅ Reduced spacing
                
                // Register Button
                Consumer<MerchantProvider>(
                  builder: (context, merchantProvider, child) {
                    return CustomButton(
                      text: 'Create Account',
                      isLoading: merchantProvider.isLoading,
                      onPressed: () async {
                        // Dismiss keyboard
                        FocusScope.of(context).unfocus();
                        
                        if (!_acceptedTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please accept the Terms & Conditions'),
                              backgroundColor: AppTheme.errorColor,
                            ),
                          );
                          return;
                        }
                        
                        if (_formKey.currentState?.validate() ?? false) {
                          bool success = await merchantProvider.register(
                            businessName: _businessNameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            address: _addressController.text,
                            category: _selectedCategory,
                            password: _passwordController.text,
                          );
                          
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text('Registration successful!'),
                                  ],
                                ),
                                backgroundColor: AppTheme.secondaryColor,
                              ),
                            );
                            // Navigate to dashboard automatically
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registration failed. Please try again.'),
                                backgroundColor: AppTheme.errorColor,
                              ),
                            );
                          }
                        }
                      },
                      width: double.infinity,
                    );
                  },
                ),
                
                SizedBox(height: 12), // ✅ Reduced spacing
                
                // Already have account - More compact
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13, // ✅ Smaller font
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16), // ✅ Bottom padding for keyboard
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}