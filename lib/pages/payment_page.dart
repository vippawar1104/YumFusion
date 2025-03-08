import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:foodapp/pages/delivery_progress_page.dart';

class UPILauncher {
  static Future<void> launchUPIApp({
    required String method,
    required String upiId,
    required double amount,
    required BuildContext context,
  }) async {
    try {
      String upiUrl = '';
      switch (method) {
        case 'gpay':
          upiUrl = 'upi://pay?pa=$upiId&pn=Merchant&am=$amount&cu=INR';
          break;
        case 'phonepe':
          upiUrl = 'phonepe://pay?pa=$upiId&pn=Merchant&am=$amount&cu=INR';
          break;
        case 'paytm':
          upiUrl = 'paytmmp://upi/pay?pa=$upiId&pn=Merchant&am=$amount&cu=INR';
          break;
      }

      final Uri uri = Uri.parse(upiUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showAppNotInstalledDialog(context, method);
      }
    } catch (e) {
      _showErrorDialog(context);
    }
  }

  static void _showAppNotInstalledDialog(BuildContext context, String method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('App Not Installed'),
        content: Text('$method app is not installed on your device.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Unable to launch payment app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final double totalAmount;
  const PaymentPage({super.key, required this.totalAmount});

  @override
  State createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedPaymentMethod = 'card';

  // Confirmation Dialogs
  Future _showCreditCardConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Card Number: $cardNumber'),
            Text('Expiry Date: $expiryDate'),
            Text('Card Holder: $cardHolderName'),
            Text('Total Amount: ₹${widget.totalAmount.toStringAsFixed(2)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToDeliveryProgress();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  // Navigation Method
  void _navigateToDeliveryProgress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DeliveryProgressPage()),
    );
  }

  // UPI Options Widget
  Widget _buildUpiOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'UPI Payment Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildPaymentOption(
                  'gpay',
                  'Google Pay',
                  'lib/images/google_pay.png',
                  Colors.blue.shade50,
                ),
                Divider(height: 1, color: Colors.grey.shade200),
                _buildPaymentOption(
                  'phonepe',
                  'PhonePe',
                  'lib/images/phonepe.png',
                  Colors.indigo.shade50,
                ),
                Divider(height: 1, color: Colors.grey.shade200),
                _buildPaymentOption(
                  'paytm',
                  'Paytm',
                  'lib/images/paytm.png',
                  Colors.blue.shade50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Payment Option Widget
  Widget _buildPaymentOption(
      String method, String name, String imagePath, Color selectedColor) {
    bool isSelected = selectedPaymentMethod == method;

    return Material(
      color: isSelected ? selectedColor : Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedPaymentMethod = method;
          });
          
          // Launch UPI App Directly
          UPILauncher.launchUPIApp(
            method: method,
            upiId: 'vipulpawar81077@oksbi',
            amount: widget.totalAmount,
            context: context,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.payment, size: 20),
                  );
                },
              ),
              const SizedBox(width: 16),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Credit Card Widget
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              cardBgColor: Colors.black,
              isSwipeGestureEnabled: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            ),

            // Credit Card Form
            Visibility(
              visible: selectedPaymentMethod == 'card',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CreditCardForm(
                  formKey: formKey,
                  obscureCvv: true,
                  obscureNumber: true,
                  cardNumber: cardNumber,
                  cvvCode: cvvCode,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  cardHolderName: cardHolderName,
                  expiryDate: expiryDate,
                  themeColor: Theme.of(context).primaryColor,
                  onCreditCardModelChange: _onCreditCardModelChange,
                ),
              ),
            ),

            // UPI Options
            _buildUpiOptions(),

            // Pay Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (selectedPaymentMethod == 'card') {
                    if (formKey.currentState != null &&
                        formKey.currentState!.validate()) {
                      _showCreditCardConfirmationDialog();
                    }
                  } else {
                    _navigateToDeliveryProgress();
                  }
                },
                child: Text(
                  'Pay ₹${widget.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
