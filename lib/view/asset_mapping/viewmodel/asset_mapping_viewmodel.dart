import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/view/asset_mapping/model/asset_location.dart';

class AssetMappingViewModel extends ChangeNotifier {
  bool _isLoading = false;
  Position? _currentPosition;
  String _locationAccuracy = '';
  AssetLocation? _assetLocation;

  // Getters for state
  bool get isLoading => _isLoading;
  Position? get currentPosition => _currentPosition;
  String get locationAccuracy => _locationAccuracy;
  AssetLocation? get assetLocation => _assetLocation;

  final List<String> assetTypeList = ['HT METER SERVICE', 'LT METER SERVICE'];
  String? assetSelectValue;

  AssetMappingViewModel() {
    assetSelectValue = assetTypeList.first;
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

  // Save Asset Information
  void saveAssetInfo(String assetType, String assetCode) {
    if (_currentPosition != null) {
      _assetLocation = AssetLocation(
        assetType: assetType,
        assetCode: assetCode,
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
        accuracy: _currentPosition!.accuracy,
      );
      notifyListeners();
      print('Asset Info Saved: $_assetLocation');
    }
  }

  void assetSelection(String newValue) {
    assetSelectValue = newValue;
    notifyListeners();
  }
}
