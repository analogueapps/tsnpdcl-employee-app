import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/exceptionals/model/exceptional_service.dart';

class ExceptionalsViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  final LatLng _currentLocation = const LatLng(17.387140, 78.491684); // Default to Hyderabad, Telangana, India
  CameraPosition? _initialCameraPosition;

  LatLng get currentLocation => _currentLocation;
  CameraPosition? get initialCameraPosition => _initialCameraPosition;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  //LatLng? markerPosition;
  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;
  List<ExceptionalService> exceptionalServices = [];

  GoogleMapController? _mapController;

  late Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
  late ClusterManager clusterManager;

  set mapController(GoogleMapController controller) {
    _mapController = controller;
  }

  ExceptionalsViewmodel({required this.context}) {
    _initializeCameraPosition();
    _initializeLoading();
    _initializeClusterManager();
    getExceptionals();
  }

  // Initialize Cluster Manager
  void _initializeClusterManager() {

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

  Future<void> getExceptionals() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/getExceptionals",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = false;
    notifyListeners();
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(
                    response.data['objectJson']);
                final List<ExceptionalService> list = jsonList.map((
                    json) => ExceptionalService.fromJson(json)).toList();
                exceptionalServices = list;
                for (var location in exceptionalServices) {
                  // _addMarker(
                  //   LatLng(double.parse(location.lat!), double.parse(location.lng!)),
                  //   location.address,
                  // );
                  String latString = location.lat.toString().replaceAll(RegExp(r'[^0-9.-]'), '');
                  String lngString = location.lng.toString().replaceAll(RegExp(r'[^0-9.-]'), '');

                  double lat = double.tryParse(latString) ?? 0.0;
                  double lng = double.tryParse(lngString) ?? 0.0;

                  if (lat != 0.0 && lng != 0.0) {
                    _addMarker(LatLng(lat, lng), location.address);
                  }
                  //placeList.add(PlaceModel(name: location.address, latLng: LatLng(lat, lng), type: Intege, id: id))
                }
                notifyListeners();
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  void _addMarker(LatLng position, String? title) {
    _markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: title),
      ),
    );
    notifyListeners();
  }

}
