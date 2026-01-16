import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  // Singleton instance
  static final NetworkConnectivity _instance = NetworkConnectivity._internal();
  factory NetworkConnectivity() => _instance;

  NetworkConnectivity._internal();

  final Connectivity _connectivity = Connectivity();

  /// Checks whether the device has an active internet connection.
  Future<bool> isConnected() async {
    // First check for network availability (WiFi, Mobile, etc.)
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Then verify actual internet access (not just network)
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}