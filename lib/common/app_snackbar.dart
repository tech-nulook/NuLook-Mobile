

import 'package:flutter/material.dart';

class AppSnackBar {
  AppSnackBar._(); // 👈 private constructor (no instantiation)

  // 🔹 Show success snackbar
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Colors.green.shade600,
      icon: Icons.check_circle_outline,
    );
  }

  // 🔹 Show error snackbar
  static void showError(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Colors.redAccent,
      icon: Icons.error_outline,
    );
  }

  // 🔹 Show info snackbar
  static void showInfo(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Colors.blueAccent,
      icon: Icons.info_outline,
    );
  }

  // 🔹 Internal helper
  static void _showSnackBar(BuildContext context, String message, {
        required Color backgroundColor,
        required IconData icon,
      }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}