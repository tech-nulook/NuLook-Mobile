

import 'package:flutter/material.dart';
import 'package:nulook_app/features/settings/model/payment_history_model.dart';
import 'package:nulook_app/features/settings/widget/empty_payment_view.dart';
import 'package:nulook_app/features/settings/widget/payment_history_card.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final payments = _dummyPayments; // Replace with Bloc data

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _summarySection(context),
          const SizedBox(height: 8),
          Expanded(
            child: payments.isEmpty
                ? const EmptyPaymentView()
                : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: payments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return PaymentHistoryCard(
                  payment: payments[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final _dummyPayments = [
  PaymentHistoryModel(
    id: '1',
    title: 'Salon Booking',
    date: '12 Dec 2025 • 10:30 AM',
    amount: 899,
    status: PaymentStatus.success,
  ),
  PaymentHistoryModel(
    id: '2',
    title: 'Membership Plan',
    date: '10 Dec 2025 • 02:15 PM',
    amount: 1200,
    status: PaymentStatus.failed,
  ),
  PaymentHistoryModel(
    id: '3',
    title: 'Hair Spa',
    date: '08 Dec 2025 • 06:45 PM',
    amount: 650,
    status: PaymentStatus.pending,
  ),
];


Widget _summarySection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        _SummaryCard(
          title: 'Total Paid',
          value: '₹ 12,450',
          icon: Icons.account_balance_wallet,
          color: Colors.green,
        ),
        const SizedBox(width: 12),
        _SummaryCard(
          title: 'Failed',
          value: '₹ 1,200',
          icon: Icons.error_outline,
          color: Colors.red,
        ),
      ],
    ),
  );
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(.15),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}