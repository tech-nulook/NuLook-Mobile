import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeInitial> {
  ThemeCubit() : super(ThemeInitial(themeMode: ThemeMode.dark)) {
    _loadTheme();
  }

  void toggleTheme() {
    final newTheme = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    emit(ThemeInitial(themeMode: newTheme));
    _saveTheme(newTheme);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    // Default = DARK
    final isDark = prefs.getBool('isDarkMode') ?? true;

    emit(ThemeInitial(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    ));
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', mode == ThemeMode.dark);
  }
}
