class PaymentHistoryModel {
  final String id;
  final String title;
  final String date;
  final double amount;
  final PaymentStatus status;

  PaymentHistoryModel({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
  });
}

enum PaymentStatus { success, failed, pending }