import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';

class DownloadFeederViewmodel extends ChangeNotifier {
  DownloadFeederViewmodel({required this.context}) {
    getCurrentLocation();
    getSubstations();
  }

  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  bool isLocationGranted = false;
  String? _latitude;
  String? _longitude;

  final formKey = GlobalKey<FormState>();

  String? _selectedSubStation;
  String? get selectedSubStation => _selectedSubStation;

  List<SubstationModel> _subStation = [];

  List<SubstationModel> get station => _subStation;
  void onListSubStationSelected(String? value) {
    _selectedSubStation = value;
    _chooseFeeder=null;
    getFeeders();
    notifyListeners();
  }
  Future<void> getSubstations() async {
    _subStation.clear();
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
      };

      final payload = {
        "path": "/load/load33kvssOfCircle",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      // Process response data
      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      // Validate response
      if (response.statusCode != successResponseCode) {
        throw Exception(responseData['message'] ??
            "Request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "Operation failed");
      }

      // Process station data
      if (responseData['objectJson'] == null) {
        throw Exception("No station data received");
      }

      final jsonList = responseData['objectJson'];
      List<SubstationModel> dataList = [];

      if (jsonList is String) {
        // Clean and parse JSON string
        String cleanedJson = jsonList
            .replaceAll(r'\"', '"')
            .trim();

        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }

        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }

        dataList = (jsonDecode(cleanedJson) as List)
            .map((json) => SubstationModel.fromJson(json))
            .toList();
      }
      else if (jsonList is List) {
        dataList = jsonList
            .map((json) => SubstationModel.fromJson(json))
            .toList();
      }

      _subStation.addAll(dataList);
      print("Successfully loaded ${_subStation.length} stations");
    } catch (e, stackTrace) {
      print("Error fetching stations: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load stations: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


//3.feeder
  String? _chooseFeeder;
  String? get chooseFeeder => _chooseFeeder;

  List<SubstationModel> _feeder = [];
  List<SubstationModel> get feeder => _feeder;

  void onListFeederSelected(String? value) {
    if (value != null && _feeder.any((item) => item.optionCode == value)) {
      _chooseFeeder = value;
      notifyListeners();
    }
  }

  Future<void> getFeeders() async {
    if (_isLoading) return;

    _isLoading = true;
    _feeder.clear();
    _chooseFeeder = null;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey) ?? "",
        "api": Apis.API_KEY,
        "ss": _selectedSubStation ?? "",
      };

      final payload = {
        "path": "/load/feeders",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (response.statusCode != successResponseCode) {
        throw Exception(responseData['message'] ??
            "Request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "Operation failed");
      }

      if (responseData['objectJson'] == null) {
        throw Exception("No feeder data received");
      }

      final jsonList = responseData['objectJson'];
      List<SubstationModel> dataList = [];

      if (jsonList is String) {
        String cleanedJson = jsonList.replaceAll(r'\"', '"').trim();
        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }
        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }
        dataList = (jsonDecode(cleanedJson) as List<dynamic>)
            .map((json) =>
            SubstationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (jsonList is List) {
        dataList = (jsonList as List<dynamic>)
            .map((json) =>
            SubstationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      _feeder = dataList.toSet().toList(); // Deduplicate based on optionCode
      print(
          "Feeder option codes: ${_feeder.map((f) => f.optionCode).toList()}");
      if (_feeder.isNotEmpty) {
        _chooseFeeder = _feeder.first.optionCode; // Default to first feeder
      }
      print("Successfully loaded ${_feeder.length} feeders");
    } catch (e, stackTrace) {
      print("Error fetching feeders: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load feeders: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (position != null) {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
        isLocationGranted = true;
        print("Geo Last known location: $_latitude , $_longitude");
      } else {
        // If no last known location, fetch current location
        Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        _latitude = currentPosition.latitude.toString();
        _longitude = currentPosition.longitude.toString();
        print("Geo Current location: $_latitude , $_longitude");
      }
    } catch (e) {
      print("Error fetching location: $e");
      AlertUtils.showSnackBar(context, "Error fetching location", isTrue);
    }
    notifyListeners(); // Notify listeners that the location has been updated
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      }
    }
  }
  bool validateForm() {
    if (_selectedSubStation==''||_selectedSubStation==null) {
      AlertUtils.showSnackBar(context, "Please select 33/11 KV SS", isTrue);
      print("Please select any one filter option");
      return false;
    }
    if (_chooseFeeder==" " && _chooseFeeder==null ) { //not displaying error msg
      AlertUtils.showSnackBar(
          context, "Please choose Feeder",
          isTrue);
      return false;
    }
    return true;
  }

}
