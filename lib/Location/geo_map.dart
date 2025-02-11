import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationTrackingScreen extends StatefulWidget {
  const LocationTrackingScreen({super.key});


  @override
  State<LocationTrackingScreen> createState() => _LocationTrackingScreenState();
}


class _LocationTrackingScreenState extends State<LocationTrackingScreen> {
  Position? _currentPosition;
  Position? _startPosition;
  double _totalDistance = 0.0;
  bool _isTracking = false;
  GoogleMapController? _mapController;
  Marker? _currentMarker;
  List<LatLng> _polylineCoordinates = [];
  Polyline? _polyline;


  // Request location permission
  Future<void> _requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
  }

  // Start location tracking with polyline
  void _startTracking() async {
    await _requestPermission();
    _startPosition = await Geolocator.getCurrentPosition();
    _polylineCoordinates.clear();
    setState(() {
      _isTracking = true;
      _totalDistance = 0.0;
      _polyline = null;
    });

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = position;
        _currentMarker = Marker(
          markerId: const MarkerId("current_location"),
          position: LatLng(position.latitude, position.longitude),
        );

        // Add new location to polyline
        _polylineCoordinates.add(LatLng(position.latitude, position.longitude));
        _polyline = Polyline(
          polylineId: const PolylineId("tracking_line"),
          color: Colors.red,
          width: 5,
          points: _polylineCoordinates,
        );

        if (_startPosition != null) {
          _totalDistance += Geolocator.distanceBetween(
            _startPosition!.latitude,
            _startPosition!.longitude,
            position.latitude,
            position.longitude,
          );
        }
        _startPosition = position;

        if (_mapController != null) {
          _mapController!.animateCamera(
            CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
          );
        }
      });
    });
  }

  // Stop tracking and show summary
  void _stopTracking() {
    if (_currentPosition != null && _startPosition != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Tracking Summary"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Start : ${_polylineCoordinates.first}"),
              Text("Last : ${_polylineCoordinates.last}"),
              Text("Distance Traveled: ${_totalDistance.toStringAsFixed(2)} meters"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }

    setState(() {
      _isTracking = false;
      _currentMarker = null;
      _polyline = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Location"),
            buildLiveButton()
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(20.5937, 78.9629),
            zoom: 10,
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          markers: _currentMarker != null ? {_currentMarker!} : {},
          myLocationEnabled: true,
          polylines: _polyline != null ? {_polyline!} : {},
        ),
      ),
    );
  }

  ElevatedButton buildLiveButton() {
    return ElevatedButton(
      onPressed: _isTracking ? _stopTracking : _startTracking,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isTracking ? Colors.red : Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
      child: Text(
        _isTracking ? "Stop Tracking" : "Start Tracking",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
