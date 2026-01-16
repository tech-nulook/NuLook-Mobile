

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationStream {
  static const EventChannel _eventChannel =
  EventChannel('samples.flutter.dev/locationStream');

  static Future<void> requestPermission() async {
    await Permission.location.request();
  }

  static Stream<Map<String, double>> get locationStream {
    return _eventChannel.receiveBroadcastStream().map((event) {
      final Map<dynamic, dynamic> data = event;
      return {
        'latitude': data['latitude'] as double,
        'longitude': data['longitude'] as double,
      };
    });
  }
}