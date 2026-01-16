import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
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
                  _aboutCard(context),
                  const SizedBox(height: 10),
                  _infoSection(context),
                  const SizedBox(height: 10),
                  _appInfoSection(context),
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
        //     Colors.teal,
        //     Colors.tealAccent.shade400,
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
          const CircleAvatar(
            radius: 40,
            child: Icon(
              Icons.info_outline,
              size: 44,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'About Our Company',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Learn more about who we are and what we do',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _aboutCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Who We Are',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'We are a customer-focused platform dedicated to delivering '
                  'high-quality digital experiences. Our goal is to simplify '
                  'everyday tasks and bring value through innovation, trust, '
                  'and technology.',
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Purpose',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _infoItem(
          icon: Icons.flag,
          color: Colors.blue,
          title: 'Our Mission',
          description:
          'To deliver reliable and innovative solutions that improve lives.',
        ),
        _infoItem(
          icon: Icons.visibility,
          color: Colors.orange,
          title: 'Our Vision',
          description:
          'To be a trusted global platform known for simplicity and excellence.',
        ),
        _infoItem(
          icon: Icons.favorite,
          color: Colors.red,
          title: 'Our Values',
          description:
          'Integrity, transparency, customer satisfaction, and innovation.',
        ),
      ],
    );
  }

  Widget _infoItem({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _appInfoSection(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _appInfoRow(
              icon: Icons.apps,
              label: 'App Version',
              value: '1.0.0',
            ),
            const Divider(),
            _appInfoRow(
              icon: Icons.email_outlined,
              label: 'Support Email',
              value: 'support@example.com',
            ),
            const Divider(),
            _appInfoRow(
              icon: Icons.language,
              label: 'Website',
              value: 'www.example.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _appInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}