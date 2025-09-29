// =============================================================================
// File: screens/merchant/qr_scanner_screen.dart (UPDATED FOR FLUTTER 3.x)
// =============================================================================
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_button.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final _qrCodeController = TextEditingController();
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Scanner Area
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryColor, width: 2),
                ),
                child: _isScanning
                    ? _buildScanningView()
                    : _buildPlaceholderView(),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Manual Input Section
            Text(
              'Or enter QR code manually',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            
            SizedBox(height: 16),
            
            TextField(
              controller: _qrCodeController,
              decoration: InputDecoration(
                labelText: 'QR Code',
                hintText: 'Enter voucher QR code',
                prefixIcon: Icon(Icons.qr_code),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Action Buttons
            CustomButton(
              text: _isScanning ? 'Stop Scanning' : 'Start Camera',
              icon: _isScanning ? Icons.stop : Icons.camera_alt,
              onPressed: _toggleScanning,
              width: double.infinity,
            ),
            
            SizedBox(height: 12),
            
            CustomButton(
              text: 'Validate Code',
              icon: Icons.check_circle,
              onPressed: _validateQRCode,
              width: double.infinity,
              isOutlined: true,
            ),
            
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildScanningView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Corner indicators
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppTheme.primaryColor, width: 3),
                      left: BorderSide(color: AppTheme.primaryColor, width: 3),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppTheme.primaryColor, width: 3),
                      right: BorderSide(color: AppTheme.primaryColor, width: 3),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.primaryColor, width: 3),
                      left: BorderSide(color: AppTheme.primaryColor, width: 3),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.primaryColor, width: 3),
                      right: BorderSide(color: AppTheme.primaryColor, width: 3),
                    ),
                  ),
                ),
              ),
              // Scanning line animation
              Center(
                child: Container(
                  width: 180,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.5),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Point camera at QR code',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Scanning for voucher codes...',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.qr_code_scanner,
          size: 80,
          color: Colors.grey[400],
        ),
        SizedBox(height: 20),
        Text(
          'QR Code Scanner',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Tap "Start Camera" to scan voucher QR codes',
          style: TextStyle(
            color: Colors.grey[500],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _toggleScanning() {
    setState(() {
      _isScanning = !_isScanning;
    });
    
    if (_isScanning) {
      // Simulate scanning process
      _simulateScanning();
    }
  }

  void _simulateScanning() {
    // Simulate a QR code detection after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      if (_isScanning) {
        _onQRCodeDetected('GH123456789');
      }
    });
  }

  void _onQRCodeDetected(String qrCode) {
    setState(() {
      _isScanning = false;
      _qrCodeController.text = qrCode;
    });
    
    _validateQRCode();
  }

  void _validateQRCode() {
    final qrCode = _qrCodeController.text.trim();
    
    if (qrCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter or scan a QR code'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }
    
    // Simulate validation
    _showValidationDialog(qrCode);
  }

  void _showValidationDialog(String qrCode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AppTheme.secondaryColor),
            SizedBox(width: 8),
            Text('Voucher Found'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('QR Code: $qrCode'),
            SizedBox(height: 8),
            Text('Voucher: Coffee & Pastry Combo'),
            Text('Amount: \$9.00'),
            Text('Customer: Sok Pisey'),
            SizedBox(height: 16),
            Text(
              'Confirm redemption?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processRedemption(qrCode);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor, // Updated from 'primary'
            ),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _processRedemption(String qrCode) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Voucher redeemed successfully!'),
          ],
        ),
        backgroundColor: AppTheme.secondaryColor,
        duration: Duration(seconds: 3),
      ),
    );
    
    // Clear the input
    _qrCodeController.clear();
    
    // Navigate back to dashboard after a delay
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _qrCodeController.dispose();
    super.dispose();
  }
}