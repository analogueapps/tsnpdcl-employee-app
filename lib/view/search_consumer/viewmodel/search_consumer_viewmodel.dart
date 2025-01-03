import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/search_consumer/model/consumer_master_response.dart';

class SearchConsumerViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  final LatLng _currentLocation = const LatLng(17.387140, 78.491684); // Default to Hyderabad, Telangana, India
  CameraPosition? _initialCameraPosition;

  LatLng get currentLocation => _currentLocation;
  CameraPosition? get initialCameraPosition => _initialCameraPosition;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  LatLng? markerPosition;
  ConsumerMasterResponse? consumerLocation;

  GoogleMapController? _mapController;
  set mapController(GoogleMapController controller) {
    _mapController = controller;
  }

  SearchConsumerViewmodel({required this.context}) {
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

  Future<void> searchConsumer(String serviceNumber) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "usc": serviceNumber,
    };

    final payload = {
      "path": "/getLatLngOfUsc",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

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
                final List<ConsumerMasterResponse> consumer = jsonList.map((
                    json) => ConsumerMasterResponse.fromJson(json)).toList();
                consumerLocation = consumer[0];
                markerPosition = LatLng(
                  double.parse(consumerLocation!.latitude!.substring(
                      0, consumerLocation!.latitude!.length - 1)),
                  double.parse(consumerLocation!.longitude!.substring(
                      0, consumerLocation!.longitude!.length - 1)),
                );
                _mapController!.animateCamera(
                  CameraUpdate.newLatLng(markerPosition!),
                );
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

}
