import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/view/asset_mapping/model/asset_location.dart';

class MeasureDistanceViewmodel extends ChangeNotifier {
  bool _isLoading = false;
  Position? _currentPosition;
  String _locationAccuracy = '';
  AssetLocation? _assetLocation;

  // Coordinates for Point A and Point B
  double? pointALat;
  double? pointALon;
  double? pointBLat;
  double? pointBLon;

  // Distance and accuracy values
  double? distanceInMeters;
  String? accuracy;

  // Getters for state
  bool get isLoading => _isLoading;
  Position? get currentPosition => _currentPosition;
  String get locationAccuracy => _locationAccuracy;
  AssetLocation? get assetLocation => _assetLocation;

  MeasureDistanceViewmodel() {
    fetchCurrentLocation();
  }

  // Fetch GPS location
  Future<void> fetchCurrentLocation() async {
    _isLoading = true;
    notifyListeners();

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        _currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        _locationAccuracy = '${_currentPosition?.accuracy.toStringAsFixed(1)} mts';
      } catch (e) {
        print('Error: $e');
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  // Capture Point A Coordinates
  void capturePointA() {
    if (_currentPosition != null) {
      pointALat = _currentPosition!.latitude;
      pointALon = _currentPosition!.longitude;
      accuracy = '${_currentPosition!.accuracy.toStringAsFixed(1)} mts';
      notifyListeners();
      print('Point A Captured: ($pointALat, $pointALon)');
    }
  }

  // Capture Point B Coordinates and Calculate Distance
  void capturePointB() {
    if (_currentPosition != null) {
      pointBLat = _currentPosition!.latitude;
      pointBLon = _currentPosition!.longitude;
      accuracy = '${_currentPosition!.accuracy.toStringAsFixed(1)} mts';

      if (pointALat != null && pointALon != null) {
        // Calculate distance between Point A and Point B
        distanceInMeters = Geolocator.distanceBetween(
          pointALat!,
          pointALon!,
          pointBLat!,
          pointBLon!,
        );
        print('Distance between Point A and Point B: ${distanceInMeters?.toStringAsFixed(2)} meters');
      }

      notifyListeners();
    }
  }

  // Reset all captured data
  void reset() {
    pointALat = null;
    pointALon = null;
    pointBLat = null;
    pointBLon = null;
    distanceInMeters = null;
    notifyListeners();
    print('All data has been reset.');
  }
}
