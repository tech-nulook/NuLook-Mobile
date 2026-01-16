import 'package:flutter/material.dart';
import 'package:nulook_app/features/settings/widget/status_chip.dart';

import '../model/payment_history_model.dart';


class PaymentHistoryCard extends StatelessWidget {
  final PaymentHistoryModel payment;

  const PaymentHistoryCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(payment.status);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: statusColor.withOpacity(.15),
              child: Icon(
                Icons.payment,
                color: statusColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    payment.date,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹ ${payment.amount.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                StatusChip(status: payment.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.success:
        return Colors.green;
      case PaymentStatus.failed:
        return Colors.red;
      case PaymentStatus.pending:
        return Colors.orange;
    }
  }
}