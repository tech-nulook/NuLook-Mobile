import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _headerSection(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _PasswordField(
                        controller: _currentPasswordController,
                        label: 'Current Password',
                        icon: Icons.lock_outline,
                        isVisible: _showCurrent,
                        onToggle: () =>
                            setState(() => _showCurrent = !_showCurrent),
                      ),
                      const SizedBox(height: 18),
                      _PasswordField(
                        controller: _newPasswordController,
                        label: 'New Password',
                        icon: Icons.lock_reset,
                        isVisible: _showNew,
                        onToggle: () =>
                            setState(() => _showNew = !_showNew),
                      ),
                      const SizedBox(height: 18),
                      _PasswordField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        icon: Icons.verified_user_outlined,
                        isVisible: _showConfirm,
                        onToggle: () =>
                            setState(() => _showConfirm = !_showConfirm),
                      ),
                      const SizedBox(height: 30),
                      _changePasswordButton(context),
                      const SizedBox(height: 24),
                      _securityHint(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 36,
            child: Icon(
              Icons.lock_person,
              size: 40,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Change Password',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith( fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Keep your account secure',
            style: TextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _changePasswordButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.lock_reset),
        label: const Text(
          'Update Password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Call Cubit / API here
          }
        },
      ),
    );
  }

  Widget _securityHint(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.security, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Use a strong password with letters, numbers and special characters.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isVisible;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.isVisible,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}


