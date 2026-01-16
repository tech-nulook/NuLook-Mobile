import 'package:flutter/material.dart';

import '../model/payment_history_model.dart';

class StatusChip extends StatelessWidget {
  final PaymentStatus status;

  const StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      PaymentStatus.success => Colors.green,
      PaymentStatus.failed => Colors.red,
      PaymentStatus.pending => Colors.orange,
    };

    final text = switch (status) {
      PaymentStatus.success => 'SUCCESS',
      PaymentStatus.failed => 'FAILED',
      PaymentStatus.pending => 'PENDING',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}