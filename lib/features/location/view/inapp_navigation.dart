
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../core/constant/constant_data.dart';

class InAppNavigation extends StatefulWidget {
  const InAppNavigation({Key? key}) : super(key: key);

  @override
  State<InAppNavigation> createState() => _InAppNavigationState();
}

class _InAppNavigationState extends State<InAppNavigation> {
  late GoogleMapController _mapController;
  final LatLng _origin = const LatLng(12.9716, 77.5946); // Example: Bengaluru
  final LatLng _destination = const LatLng(12.2958, 76.6394); // Mysuru
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _getDirections();
  }

  Future<void> _getDirections() async {
    const apiKey = ConstantData.googleMapsKey;
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${12.9716},${77.5946}&destination=${12.2958},${76.6394}&key=$apiKey');

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    if (data['routes'].isNotEmpty) {
      final points = data['routes'][0]['overview_polyline']['points'];
      final decodedPoints = _decodePolyline(points);

      setState(() {
        _polylines.add(Polyline(
          polylineId: const PolylineId('route'),
          points: decodedPoints,
          color: Colors.blue,
          width: 5,
        ));
      });
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('In-App Google Maps Navigation')),
      body: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: CameraPosition(
          target: _origin,
          zoom: 7,
        ),
        markers: {
          Marker(markerId: const MarkerId('origin'), position: _origin),
          Marker(markerId: const MarkerId('destination'), position: _destination),
        },
        polylines: _polylines,
      ),
    );
  }
}