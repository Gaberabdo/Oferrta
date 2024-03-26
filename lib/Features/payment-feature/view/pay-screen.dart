import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';

class CartTotal extends StatelessWidget {
  final List<PaymentItem> _paymentItems = []; // List to hold payment items

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadGPayConfiguration(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Google Pay button
                GooglePayButton(
                  paymentItems: _paymentItems,
                  width: 200,
                  height: 50,
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: (data) {
                    print(data);
                    // Handle payment result here
                  },
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  paymentConfiguration: PaymentConfiguration.fromJsonString(snapshot.data!),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<String> _loadGPayConfiguration() async {
    return await rootBundle.loadString('assets/gpay.json');
  }
}
