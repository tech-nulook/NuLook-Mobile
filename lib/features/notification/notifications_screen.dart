import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/theme_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            _topActions(),
            const Divider(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      NotificationTile(
                        isUnread: index % 2 == 0,
                        message:
                        index % 2 == 0
                            ? "You have an appointment at Manea The Salon at 8:00am today"
                            : "Your password is successfully changed",
                        time: index % 2 == 0 ? "Just now" : "2 hours ago",
                      ),
                      // Divider(
                      //   color: isDark ? Colors.white24 : Colors.black26,
                      // ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 🔹 Header
  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Text(
            "Notifications",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// 🔹 Top Actions
  Widget _topActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Text(
            "Mark all as read",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const Spacer(),
          const Text(
            "Do not disturb",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: false,
            onChanged: (_) {},
            activeColor: Colors.red,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.white24,
          ),
        ],
      ),
    );
  }
}


class NotificationTile extends StatelessWidget {
  final bool isUnread;
  final String message;
  final String time;
  final String? actionText;

  const NotificationTile({
    super.key,
    this.isUnread = false,
    required this.message,
    required this.time,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Dot indicator
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isUnread ? Colors.red : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),

          /// Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: message,
                    style:  TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    children: actionText != null
                        ? [
                      TextSpan(
                        text: actionText!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]
                        : [],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style:  TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}