
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Private constructor
  SharedPreferencesHelper._internal();

  // Singleton instance
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._internal();

  // Getter to access instance
  static SharedPreferencesHelper get instance => _instance;

  SharedPreferences? _prefs;

  /// Ensure SharedPreferences initialized before use
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // ----------------------
  // Save Methods
  // ----------------------

  Future<bool> setString(String key, String value) async {
    await init();
    return _prefs!.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    await init();
    return _prefs!.setBool(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    await init();
    return _prefs!.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    await init();
    return _prefs!.setDouble(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    await init();
    return _prefs!.setStringList(key, value);
  }

  // Save any object
   Future<void> saveObject(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(value);
    await prefs.setString(key, jsonString);
  }

  // Get any object
  Future<dynamic> getObject(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  // ----------------------
  // Get Methods
  //-----------------------

  String? getString(String key) => _prefs?.getString(key);

  bool? getBool(String key) => _prefs?.getBool(key);

  int? getInt(String key) => _prefs?.getInt(key);

  double? getDouble(String key) => _prefs?.getDouble(key);

  List<String>? getStringList(String key) => _prefs?.getStringList(key);

  // -----------------------
  // Remove & Clear
  // -----------------------

  Future<bool> remove(String key) async {
    await init();
    return _prefs!.remove(key);
  }

  Future<bool> clear() async {
    await init();
    return _prefs!.clear();
  }
}