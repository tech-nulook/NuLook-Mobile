import 'package:flutter/material.dart';

class AppTheme {
  // 🌞 Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.black54,
      background: Color(0xFFF6F6F6),
      surface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black),
      toolbarTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
      elevation: 2,
    ),
    cardColor: Colors.white,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w300,
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w300,
      ),
      labelLarge: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w300,
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.black,
      textColor: Colors.black,
      style: ListTileStyle.list,
    ),

  );

  // 🌚 Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF000000),
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.grey,
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    cardColor: const Color(0xFF1E1E1E),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w300,
      ),

      titleLarge: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w300,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w300,
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
      style: ListTileStyle.list,
    ),

  );
}
