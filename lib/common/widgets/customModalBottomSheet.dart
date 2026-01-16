import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Core/Theme/colors.dart';
import '../../core/theme/theme_cubit.dart';
import 'circleButton.dart';

class CustomModalButtonSheet extends StatelessWidget {
  final Widget child;
  final bool? staticContent; // Renamed to isStaticContent for clarity
  const CustomModalButtonSheet({
    super.key,
    required this.child,
    this.staticContent = false,
  }); // Default to false

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Material(
      color: transparentColor, // Keep this transparent
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use min to wrap content, allowing sheet to determine height
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Dismiss button (moved outside the main container for visual separation)
          CircleButton(
            heightAndWidth: 50,
            backgroundColor: isDark ? Colors.grey.shade900  : AppColors.whiteColor,
            onTap: Navigator.of(context).pop,
            child: Icon(
              Icons.close,
              color: isDark ? AppColors.whiteColor : AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 20),
          // Spacing between button and sheet
          // Main content container with rounded corners and background color
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade900 : AppColors.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            // Conditionally apply height constraints or expand
            child: Column(
              children: [
                Container(
                  height: 4,
                  width: 40,
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.23),
                  ),
                ),
                staticContent == true
                    ? IntrinsicHeight(child: child)
                    : ConstrainedBox(
                        // Use ConstrainedBox for min/max height if needed
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.3, // Example min height
                          maxHeight: MediaQuery.of(context).size.height * 0.8, // Example max height
                        ),
                        child: child,
                      ),
                if (Platform.isIOS)
                  Container(
                    height: 0,
                    color: Theme.of(context).colorScheme.primary,
                  ), // Add spacing for iOS
              ],
            ),
          ),
        ],
      ),
    );
  }
}
