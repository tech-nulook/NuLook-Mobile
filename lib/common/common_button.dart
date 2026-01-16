import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool isLoading;
  final Color loaderColor;

  const CommonButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = Colors.redAccent,
    this.height = 50,
    this.borderRadius = 30,
    this.textStyle,
    this.isLoading = false,
    this.loaderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          // Disable button while loading
          onPressed: isLoading ? null : onPressed,
          child: isLoading
                  ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: loaderColor,
                    ),
                  )
                  : Text(
                    title,
                    style:textStyle ??
                        const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
        ),
      ),
    );
  }
}
