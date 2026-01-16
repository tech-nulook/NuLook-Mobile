
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  // Step 1: Private constructor
  SecureStorageHelper._internal();

  // Step 2: Single static instance
  static final SecureStorageHelper _instance = SecureStorageHelper._internal();

  // Step 3: Public getter to access the singleton instance
  static SecureStorageHelper get instance => _instance;

  // Step 4: Create the storage instance (lazy initialization)
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Step 5: Define common methods

  /// Write data
  Future<void> writeData(String key, dynamic value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  /// Read data
  Future<dynamic> readData(String key) async {
    return await _secureStorage.read(key: key);
  }

  /// Delete single key
  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }

  /// Delete all secure data
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  /// Check if a key exists
  Future<bool> containsKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }
}