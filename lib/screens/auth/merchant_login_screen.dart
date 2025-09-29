import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/merchant_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'merchant_register_screen.dart';

class MerchantLoginScreen extends StatefulWidget {
  @override
  _MerchantLoginScreenState createState() => _MerchantLoginScreenState();
}

class _MerchantLoginScreenState extends State<MerchantLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get screen height to ensure proper fitting
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;
    
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                         MediaQuery.of(context).padding.top - 
                         MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  SizedBox(height: isSmallScreen ? 20 : 40), 
                  
                  // Logo and Title Section
                  Container(
                    padding: EdgeInsets.all(16), 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.store,
                      size: isSmallScreen ? 50 : 55, 
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Gift Box',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 26 : 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4), 
                  Text(
                    'Merchant App',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 30 : 40), 
                  
                  // Login Form 
                  Container(
                    padding: EdgeInsets.all(20), 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 22, 
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20), 
                          
                          CustomTextField(
                            controller: _emailController,
                            label: 'Email',
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
                            obscureText: true,
                            prefixIcon: Icons.lock_outline,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter your password';
                              }
                              if (value!.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16), 
                          
                          Consumer<MerchantProvider>(
                            builder: (context, merchantProvider, child) {
                              return CustomButton(
                                text: 'Sign In',
                                isLoading: merchantProvider.isLoading,
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    bool success = await merchantProvider.login(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                    
                                    if (!success) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Login failed. Please try again.'),
                                          backgroundColor: AppTheme.errorColor,
                                        ),
                                      );
                                    }
                                  }
                                },
                              );
                            },
                          ),
                          
                          SizedBox(height: 8), 
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Forgot password functionality coming soon!')),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20), 
                  
                  // Register Section 
                  Container(
                    padding: EdgeInsets.all(16), 
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Need to grow your business? Join us today!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14, 
                            
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10), 
                        CustomButton(
                          text: 'Register Your Business',
                          icon: Icons.business,
                          isOutlined: true,
                          color: Colors.white,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MerchantRegisterScreen(),
                              ),
                            );
                          },
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 16), 
                  Text(
                    'Need help? Contact support',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13, 
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 30), 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}