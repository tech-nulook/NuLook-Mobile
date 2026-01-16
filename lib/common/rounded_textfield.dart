import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color? fillColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? iconColor;
  final Color? focusedBorderColor;
  final Function(String?)? validator;

  const RoundedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.textColor,
    this.hintColor,
    this.iconColor,
    this.focusedBorderColor,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.always,
        // inputFormatters: [
        //   LengthLimitingTextInputFormatter(10),
        //   FilteringTextInputFormatter.digitsOnly,
        // ],
      style: TextStyle(color: textColor ?? Colors.white , fontSize: 15),
      validator: (value) => validator != null ? validator!(value) : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor ?? Colors.white70),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: iconColor ?? Colors.white70) : null,
        filled: true,
        fillColor: fillColor ?? Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: focusedBorderColor ?? theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: focusedBorderColor ?? theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.5,
          ),
        ),
        errorStyle: TextStyle(
          fontSize: 14,
          color: theme.colorScheme.error,
        ),
      ),
    );
  }
}