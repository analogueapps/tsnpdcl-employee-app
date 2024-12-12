import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchConsumerViewmodel extends ChangeNotifier {
  final LatLng _currentLocation = const LatLng(17.387140, 78.491684); // Default to Hyderabad, Telangana, India
  CameraPosition? _initialCameraPosition;

  LatLng get currentLocation => _currentLocation;
  CameraPosition? get initialCameraPosition => _initialCameraPosition;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  GoogleMapController? _mapController;
  set mapController(GoogleMapController controller) {
    _mapController = controller;
  }

  SearchConsumerViewmodel() {
    _initializeCameraPosition();
    _initializeLoading();
  }

  // Initialize Camera Position
  void _initializeCameraPosition() {
    _initialCameraPosition = CameraPosition(
      target: _currentLocation,
      zoom: 14.0, // Default zoom level
    );
    notifyListeners();
  }

  // Method to simulate loading
  void _initializeLoading() {
    Future.delayed(const Duration(seconds: 1), () {
      _isLoading = false;
      notifyListeners(); // Notify listeners about the state change
    });
  }

}
