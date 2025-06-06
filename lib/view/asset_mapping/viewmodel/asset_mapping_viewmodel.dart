import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/asset_mapping/model/asset_location.dart';

class AssetMappingViewModel extends ChangeNotifier {

  //Controller
  final TextEditingController _assetCodeController = TextEditingController();

  TextEditingController get assetCodeController => _assetCodeController;
  double MINIMUM_GPS_ACCURACY_REQUIRED = 15.0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  final List<String> assetTypeList = ['HT METER SERVICE', 'LT METER SERVICE'];
  String? assetSelectValue;

  // Fetch GPS location
  StreamSubscription<Position>? _positionStream;
  double? latitude;
  double? longitude;
  double? totalAccuracy;

  AssetMappingViewModel() {
    assetSelectValue = assetTypeList.first;
    fetchCurrentLocation();
  }

  Future<void> fetchCurrentLocation() async {
    _isLoading = true;
    notifyListeners();

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;
      totalAccuracy = position.accuracy;
      _isLoading = false;
      notifyListeners();
    });
  }

  //Validate asset mapping info
  bool validate(BuildContext context) {
    if (assetSelectValue == null) {
      showAlertDialog(context, "Please select asset type");
      return false;
    } else if (assetCodeController.text.isEmpty) {
      showAlertDialog(context, "Please enter ${assetSelectValue} code");
      return false;
    } else if (totalAccuracy == null) {
      showAlertDialog(context, "Please wait until your location is captured");
      return false;
    } else if (totalAccuracy!>= MINIMUM_GPS_ACCURACY_REQUIRED) {
      showAlertDialog(context,
          "Please wait until your location accuracy comes below ${MINIMUM_GPS_ACCURACY_REQUIRED} mtrs");
      return false;
    }
    return true;
  }

  void assetSelection(String newValue) {
    assetSelectValue = newValue;
    notifyListeners();
  }

  void postAssetInfo(BuildContext context) async {
    _isLoading = isTrue;

    print('Entered');
    print('Entering into request data');
    final requestData = {
      "token": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "assetType": assetSelectValue,
      "assetCode": assetCodeController.text,
      "lat": latitude,
      "lon": longitude,
    };
    final payload = requestData;

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL_ASSET_MAPPING)
        .postApiCall(context, Apis.ASSET_MAPPING_URL, payload);

    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Convert string to Map
        }

        if (response.statusCode == successResponseCode) {
          final data = response.data;

          if (data['sessionValid'] == true) {
            if (data['taskSuccess'] == true) {
              if (data['dataList'] != null && data['dataList'] is List) {
                final List<dynamic> jsonList = data['dataList'];
                if (data['message'] == "Done") {
                  showSuccessDialog(context, "${data['message']}", () {
                    Navigator.pop(context);
                  });
                }
              } else {
                showAlertDialog(context, "No Data Found");
              }
            } else {
              showAlertDialog(context, data['message'] ?? "Task Failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,
              response.data['message'] ?? "Unexpected server response");
        }
      }
    } catch (e) {
      print("Error: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
  }

}


// StreamSubscription<Position>? _positionStream;
// double? latitude;
// double? longitude;
// double? totalAccuracy;
// // Save Asset Information
// void saveAssetInfo(String assetType, String assetCode,BuildContext context) {
//   if (_currentPosition != null) {
//     _assetLocation = AssetLocation(
//       assetType: assetType,
//       assetCode: assetCode,
//       latitude: _currentPosition!.latitude,
//       longitude: _currentPosition!.longitude,
//       accuracy: _currentPosition!.accuracy,
//     );
//     _positionStream = Geolocator.getPositionStream(
//       locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
//     ).listen((Position position) {
//       latitude = position.latitude;
//       longitude = position.longitude;
//       totalAccuracy = position.accuracy;
//     });
//     notifyListeners();
//   }
//   postAssetInfo(context);
// }

// LocationPermission permission = await Geolocator.checkPermission();
// if (permission == LocationPermission.denied ||
// permission == LocationPermission.deniedForever) {
// permission = await Geolocator.requestPermission();
// }
//
// if (permission == LocationPermission.whileInUse ||
// permission == LocationPermission.always) {
// try {
// _currentPosition = await Geolocator.getCurrentPosition(
// desiredAccuracy: LocationAccuracy.best);
// _locationAccuracy = '${_currentPosition?.accuracy.toStringAsFixed(1)} mts';
// notifyListeners();
// } catch (e) {
// print('Error: $e');
// }
// }


// Position? get currentPosition => _currentPosition;

// String get locationAccuracy => _locationAccuracy;

// Position? _currentPosition;
// String _locationAccuracy = '';

// AssetLocation? get assetLocation => _assetLocation;
// AssetLocation? _assetLocation;
