
import 'package:flutter/material.dart';
import 'package:nulook_app/features/payments/view/razorpay_payment.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int selectedIndex = 0;

  final List<_PaymentMethod> paymentMethods = [
    _PaymentMethod(
      title: "Credit / Debit Card",
      subtitle: "Visa, MasterCard, Rupay",
      icon: Icons.credit_card,
    ),
    _PaymentMethod(
      title: "UPI",
      subtitle: "Google Pay, PhonePe, Paytm",
      icon: Icons.account_balance_wallet_outlined,
    ),
    _PaymentMethod(
      title: "Net Banking",
      subtitle: "All major banks supported",
      icon: Icons.account_balance,
    ),
    _PaymentMethod(
      title: "Cash on Delivery",
      subtitle: "Pay when you receive",
      icon: Icons.payments_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Method"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            paymentHeaderSection(context),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose your payment method",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentMethods.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final method = paymentMethods[index];
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedIndex = index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary.withOpacity(0.08)
                                : theme.cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : Colors.grey.shade300,
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundColor:
                                theme.colorScheme.primary.withOpacity(0.15),
                                child: Icon(
                                  method.icon,
                                  color: theme.colorScheme.primary,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      method.title,
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      method.subtitle,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),

                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: theme.colorScheme.primary,
                                  size: 26,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                       // Continue payment
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return RazorpayPayment();
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.lock_outline),
                      label: const Text(
                        "Continue",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentHeaderSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     Theme.of(context).colorScheme.primary,
        //     Theme.of(context).colorScheme.primary.withOpacity(0.75),
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
         // ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
            child: Icon(
              Icons.payment_outlined,
              size: 46,
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),

          const Text(
            'Choose a secure and convenient way to pay',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

}

/// Model class
class _PaymentMethod {
  final String title;
  final String subtitle;
  final IconData icon;

  _PaymentMethod({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}