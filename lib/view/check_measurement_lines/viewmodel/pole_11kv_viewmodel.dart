import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';

class Pole11kvViewmodel extends ChangeNotifier {
  Pole11kvViewmodel({required this.context, required this.args}){
    getCurrentLocation();
    getPolesOnFeeder();
  }

  // Current View Context
  final BuildContext context;
  final Map<String, dynamic> args;

  String? latitude="";
  String? longitude="";

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final TextEditingController poleNumber= TextEditingController();

  bool _followSwitch = true;

  bool get followSwitch => _followSwitch;

  set followMe(bool value) {
    _followSwitch = value;
    notifyListeners();
  }

  String locationAccuracy="";

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AlertUtils.showSnackBar(context, "Location permission denied", isTrue);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        AlertUtils.showSnackBar(
            context, "Location permissions are permanently denied", isTrue);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude.toString();
      longitude = position.longitude.toString();

      print("Geo Current location: $latitude , $longitude");

      notifyListeners();
    } catch (e) {
      print("Error fetching location: $e");
      AlertUtils.showSnackBar(context, "Error fetching location", isTrue);
    }
  }


  String? _selectedPole;
  String? get selectedPole => _selectedPole;
  void setSelectedPole(String title) {
    _selectedPole = title;
    print("$_selectedPole: filter selected");
    notifyListeners();
  }

  //Tapping from previous pole
  String? _selectedPreviousPole;
  String? get selectedPreviousPole => _selectedPreviousPole;
  void setSelectedPreviousPole(String title) {
    _selectedPreviousPole = title;
    print("$_selectedPreviousPole: Previous pole selected");
    notifyListeners();
  }

  //Pole type
  List<String> selectedPoleTypes = [];

  void toggleSelectedPoleType(String value) {
    if (selectedPoleTypes.contains(value)) {
      selectedPoleTypes.remove(value);
    } else {
      if (selectedPoleTypes.length < 2) {
        selectedPoleTypes.add(value);
      }
    }
    notifyListeners();
  }

  List<String> poleHeightData=["8.0 Mtr. Pole", "11 Mtr. Pole","13 Mtr(Tower)","19 Mtr(Tower)","9.1 Mtr. Pole","10 Mtrs(Tower)","16 Mtr(Tower)" ];
  String? _selectedPoleHeight;
  String? get selectedPoleHeight => _selectedPoleHeight;
  void setSelectedPoleHeight(String title) {
    _selectedPoleHeight = title;
    print("$_selectedPoleHeight: Previous pole selected");
    notifyListeners();
  }

  List<PoleFeederEntity> poleFeederList = [];
  String? poleFeederSelected;

  void onListPoleFeederChange(String? value) {
    poleFeederSelected = value;
    if (value != null) {
      print("feeder data: $poleFeederSelected");
    }
    notifyListeners();
  }

  Future<void> getPolesOnFeeder() async {
    poleFeederList.clear();
    poleFeederSelected = null;
    notifyListeners();

    _isLoading = isTrue;

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ssc": args["ssc"],
      "fc":args["fc"],
    };

    final payload = {
      "path": "/getPolesOnFeeder",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(
        context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = isFalse;

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
                final List<PoleFeederEntity> listData = jsonList.map((json) =>
                    PoleFeederEntity.fromJson(json)).toList();
                poleFeederList.addAll(listData);
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
      rethrow;
    }

    notifyListeners();
  }



}