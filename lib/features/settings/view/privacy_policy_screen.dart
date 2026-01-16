import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
                  _policySection(
                    icon: Icons.info_outline,
                    title: 'Introduction',
                    content:
                    'We value your privacy and are committed to protecting '
                        'your personal information. This Privacy Policy explains '
                        'how we collect, use, and safeguard your data.',
                  ),
                  _policySection(
                    icon: Icons.data_usage,
                    title: 'Information We Collect',
                    content:
                    'We may collect personal information such as your name, '
                        'email address, phone number, and usage data to improve '
                        'our services.',
                  ),
                  _policySection(
                    icon: Icons.security,
                    title: 'How We Use Your Information',
                    content:
                    'Your data is used to provide and improve our services, '
                        'process transactions, send notification, and ensure '
                        'account security.',
                  ),
                  _policySection(
                    icon: Icons.lock_outline,
                    title: 'Data Protection',
                    content:
                    'We implement industry-standard security measures to '
                        'protect your information from unauthorized access or '
                        'disclosure.',
                  ),
                  _policySection(
                    icon: Icons.share_outlined,
                    title: 'Information Sharing',
                    content:
                    'We do not sell or share your personal data with third '
                        'parties except when required by law or to provide our '
                        'services.',
                  ),
                  _policySection(
                    icon: Icons.update,
                    title: 'Policy Updates',
                    content:
                    'We may update this Privacy Policy from time to time. '
                        'Any changes will be reflected within the app.',
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
        //     Colors.indigo,
        //     Colors.indigoAccent,
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
              Icons.privacy_tip_outlined,
              size: 44,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your privacy matters to us',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _policySection({
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
              backgroundColor: Colors.indigo.withOpacity(.15),
              child: Icon(icon, color: Colors.indigo),
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
          'If you have any questions regarding this Privacy Policy, '
              'please contact our support team.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 6),
        const Text(
          'support@example.com',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
      ],
    );
  }




}