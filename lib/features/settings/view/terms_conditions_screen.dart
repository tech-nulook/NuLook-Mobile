import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerSection(context),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _termsSection(
                    icon: Icons.info_outline,
                    title: 'Introduction',
                    content:
                    'By accessing or using this application, you agree to be '
                        'bound by these Terms & Conditions. Please read them '
                        'carefully before using our services.',
                  ),
                  _termsSection(
                    icon: Icons.person_outline,
                    title: 'User Responsibilities',
                    content:
                    'You agree to use the app responsibly and provide accurate '
                        'information. Any misuse of the application may result in '
                        'account suspension or termination.',
                  ),
                  _termsSection(
                    icon: Icons.lock_outline,
                    title: 'Account Security',
                    content:
                    'You are responsible for maintaining the confidentiality '
                        'of your account credentials and for all activities that '
                        'occur under your account.',
                  ),
                  _termsSection(
                    icon: Icons.payment,
                    title: 'Payments & Services',
                    content:
                    'All payments made through the app are subject to our '
                        'pricing and refund policies. We reserve the right to '
                        'modify services or pricing at any time.',
                  ),
                  _termsSection(
                    icon: Icons.gavel,
                    title: 'Limitation of Liability',
                    content:
                    'We shall not be liable for any indirect, incidental, or '
                        'consequential damages arising from the use of this app.',
                  ),
                  _termsSection(
                    icon: Icons.update,
                    title: 'Changes to Terms',
                    content:
                    'We may update these Terms & Conditions periodically. '
                        'Continued use of the app after changes implies acceptance '
                        'of the updated terms.',
                  ),
                  const SizedBox(height: 24),
                  _footerNote(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _headerSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     Colors.deepOrange,
        //     Colors.orangeAccent,
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
        children: const [
          CircleAvatar(
            radius: 40,
            child: Icon(
              Icons.description_outlined,
              size: 44,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'Terms & Conditions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please read carefully before using the app',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
  Widget _termsSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.deepOrange.withOpacity(.15),
              child: Icon(icon, color: Colors.deepOrange),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
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

  Widget _footerNote(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 12),
        Text(
          'If you have any questions regarding these Terms & Conditions, '
              'please contact us.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 6),
        const Text(
          'support@example.com',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ],
    );
  }

}
