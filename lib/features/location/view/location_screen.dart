import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nulook_app/core/constant/constant_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/location/location_service.dart';
import '../../../core/location/location_stream.dart';
import '../cubit/location_cubit.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.785834, -122.406417),
    zoom: 10.0,
  );

  static const CameraPosition kLake = CameraPosition(
    bearing: 192,
    target: LatLng(37.785834, -122.406417),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  String _location = "Waiting for updates...";
  String geoLocation = "Waiting for updates...";

  static const LatLng _destination = LatLng(
    12.9716,
    77.5946,
  ); // Example: Bengaluru
  LatLng? _currentPosition;
  StreamSubscription<Position>? _positionStream;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  double? latitude;
  double? longitude;

  @override
  void initState() {
    LocationStream.locationStream.listen((data) {
      setState(() {
        _location = "Lat: ${data['latitude']}, Lng: ${data['longitude']}";
        debugPrint("_location: --->  $_location");
      });
    });
    _getLocation();
    _initLocation();
    super.initState();
  }

  Future<void> _getLocation() async {
    try {
      Position? position = await LocationService.getCurrentLocation();
      setState(() {
        geoLocation =
            "Latitude: ${position?.latitude}, Longitude: ${position?.longitude}";
        debugPrint("GeoLocation : - $geoLocation");
        latitude = position?.latitude;
        longitude = position?.longitude;
        CameraPosition(
          target: LatLng(position!.latitude, position.longitude),
          zoom: 10.0,
        );
        CameraPosition(
          bearing: 192,
          target: LatLng(position.latitude, position.longitude),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414,
        );
      });

      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // update every 10 meters
        ),
      ).listen((Position position) {
        print('${position.latitude}, ${position.longitude}');
      });
    } catch (e) {
      setState(() {
        _location = e.toString();
      });
    }
  }

  Future<void> _initLocation() async {
    await _checkPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _updateCurrentLocation(position);

    // Start listening for real-time updates
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen(_updateCurrentLocation);

    // Draw route from source to destination
    await _createRouteLegacy(position.latitude, position.longitude);
  }

  final List<Map<String, dynamic>> itemsSearch = [
    {
      "title": "Café Mocha",
      "subtitle": "Freshly brewed with chocolate",
      "rating": 4.5,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7VQJh7ka40x-igYnOoW8UZBFsQylSM_ttzA&s",
    },
    {
      "title": "Espresso Shot",
      "subtitle": "Strong and aromatic flavor",
      "rating": 4.2,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1T6PiFxZ2a8mhX145GtxmWr7T_o8LsTsC9w&s",
    },
    {
      "title": "Iced Latte",
      "subtitle": "Cold and refreshing",
      "rating": 4.8,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ7JeuBhJODHcuTH7QtkNq3S5PEdgCUJ07EQ&s",
    },
    {
      "title": "Café Mocha",
      "subtitle": "Freshly brewed with chocolate",
      "rating": 4.5,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7VQJh7ka40x-igYnOoW8UZBFsQylSM_ttzA&s",
    },
    {
      "title": "Espresso Shot",
      "subtitle": "Strong and aromatic flavor",
      "rating": 4.2,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1T6PiFxZ2a8mhX145GtxmWr7T_o8LsTsC9w&s",
    },
    {
      "title": "Iced Latte",
      "subtitle": "Cold and refreshing",
      "rating": 4.8,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ7JeuBhJODHcuTH7QtkNq3S5PEdgCUJ07EQ&s",
    },
  ];

  @override
  Widget build(BuildContext context) {
     final double destinationLat = 12.9716; // Example: Bengaluru
     final double destinationLng = 77.5946;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _currentPosition == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 17,
                    ),
                    markers: _markers,
                    polylines: _polylines,
                    zoomControlsEnabled: true,
                    // Enables on-screen zoom buttons (+/-)
                    zoomGesturesEnabled: true,
                    // Enables pinch and double-tap zoom
                    scrollGesturesEnabled: true,
                    // Enables moving the map
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) =>
                        _controller.complete(controller),
                  ),
            IgnorePointer(child: Container(color: Colors.transparent.withOpacity(0.0))),
      
            Positioned(
              right: 10,
              bottom: 120,
              child: InkWell(
                onTap: () => context.read<LocationCubit>().openGoogleMaps(destinationLat , destinationLng),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent, // background color
                    shape: BoxShape.circle, // 👈 makes it circular
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
      
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: itemsSearch.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return locationCardWidgetNew(context, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget locationCardWidgetNew(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Card(
        elevation: 5, // 👈 Shadow like Android CardView
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(right: 12),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              // 🔹 Image with curved corners
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: Image.network(
                    itemsSearch[index]["image"].toString(),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // 🔹 Text and Rating section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        itemsSearch[index]['title'].toString() ?? '',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        itemsSearch[index]['subtitle'],
                        maxLines: 1,
                        style: const TextStyle(fontSize: 14),
                      ),
                      // 🔹 Rating stars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            initialRating:
                                itemsSearch[index]['rating'] as double,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            itemSize: 17.0,
                            // 👈 star size
                            unratedColor: Colors.grey.shade300,
                            itemBuilder: (context, _) =>
                                const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                            updateOnDrag: false,
                            tapOnlyMode: false,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            itemsSearch[index]['rating'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            height: 25,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 0,
                                ),
                                fixedSize: Size(50, 20),
                              ),
                              onPressed: () {},
                              child: Text("Book"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // legacy approach — ensure Directions API enabled and billing on
  Future<void> _createRouteLegacy(double startLat, double startLng) async {
    final apiKey = ConstantData.googleMapsKey; // <- MUST be non-empty & valid
    final polylinePoints = PolylinePoints.legacy(apiKey);

    final result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(startLat, startLng),
        destination: PointLatLng(12.9998383, 77.6763015),
        mode: TravelMode.twoWheeler,
      ),
    );

    if (result.points.isNotEmpty) {
      final polylineCoordinates = result.points
          .map((p) => LatLng(p.latitude, p.longitude))
          .toList();

      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ),
        );
      });
    } else {
      debugPrint(
        'Legacy route not found. status/error: ${result.status} / ${result.errorMessage}',
      );
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

  void _updateCurrentLocation(Position position) {
    LatLng newPos = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = newPos;
      _markers
        ..clear()
        ..add(Marker(markerId: const MarkerId('source'), position: newPos))
        ..add(
          Marker(
            markerId: const MarkerId('destination'),
            position: _destination,
          ),
        );
    });
  }

  Future<void> _checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied');
    }
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }

  Future<void> _openGoogleMaps() async {
    final double destinationLat = 12.9716; // Example: Bengaluru
    final double destinationLng = 77.5946;
    final Uri googleMapUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$destinationLat,$destinationLng&travelmode=driving',
    );

    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open Google Maps';
    }
  }
}
