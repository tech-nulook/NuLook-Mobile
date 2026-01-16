import 'package:flutter/material.dart';

class EmptyPaymentView extends StatelessWidget {
  const EmptyPaymentView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          const Text(
            'No Payment History',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            'Your payment records will appear here',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}