

class Validators {
  /// Validates Indian phone numbers (10 digits, starting with 6–9)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }

    final RegExp phoneRegExp = RegExp(r'^[6-9]\d{9}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }

    return null;
  }

  /// Validates email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email address';
    }

    // Simple and effective regex for standard emails
    final RegExp emailRegExp =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  /// Validates password
  /// Minimum 8 chars, at least 1 uppercase, 1 lowercase, 1 number, 1 special char
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }

    final RegExp passwordRegExp =
    RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be 8+ chars with upper, lower, number, and special char';
    }

    return null;
  }

  /// Validates name (letters and spaces only)
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }

    return null;
  }
}