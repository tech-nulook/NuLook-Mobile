import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/theme_cubit.dart';

class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final bool showDot;
  final bool isDecoration;
  final bool themeMode;
  final VoidCallback? onTap;

  const GlassIconButton({
    super.key,
    required this.icon,
    this.showDot = false,
    required this.isDecoration,
    this.themeMode = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isDecoration ? 48 : 25,
        height: isDecoration ? 48 : 25,
         decoration: isDecoration ? BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.withOpacity(0.08),
              Colors.grey.withOpacity(0.02),
            ],
          ),
          border: Border.all(
            color: Colors.grey.withOpacity(0.99),
            width: 1,
          ),
        ) : null,
        child: Stack(
          children: [
            /// Icon
            Center(
              child: Icon(
                icon,
                size: 30,
                color: themeMode ? isDark ? Colors.white : Colors.black : Colors.white,
              ),
            ),

            /// Red notification dot
            if (showDot)
              Positioned(
                top: 10,
                right: 12,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}