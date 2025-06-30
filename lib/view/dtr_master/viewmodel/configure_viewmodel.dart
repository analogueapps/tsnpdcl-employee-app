import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';

class MapDtrViewMobel extends ChangeNotifier {
  MapDtrViewMobel({required this.context});
  final BuildContext context;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  final formKey = GlobalKey<FormState>();
  final TextEditingController equipNoORStructCode = TextEditingController();

  String? _selectedFilter;
  String? get selectedFilter => _selectedFilter;

  //Distribution
  String? _selectedDistribution;
  String? get selectedDistribution => _selectedDistribution;
  final List<SubstationModel> _distributions = [];
  List<SubstationModel> get distributions => _distributions;

  void onListDistriSelected(String? value) {
    _selectedDistribution = value;
    notifyListeners();
  }

  Future<void> getDistributions() async {
    _distributions.clear();
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken":
            SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ??
                "",
        "api": Apis.API_KEY,
      };

      final payload = {
        "path": "/load/distributions",
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
        dataList = (jsonList)
            .map((json) =>
                SubstationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      _distributions.addAll(dataList);
      print("Successfully loaded ${_distributions.length} distributions");
    } catch (e, stackTrace) {
      print("Error fetching distributions: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load distributions: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Feeder wise
  //1. Circle
  // Circle logic
  String? _selectedCircle = '000';
  String? get selectedCircle => _selectedCircle;

  final List<Circle> _circle = [
    Circle("000", "SELECT"),
    Circle("401", "KHAMMAM"),
    Circle("402", "HANAMKONDA"),
    Circle("407", "WARANGAL"),
    Circle("403", "KARIMNAGAR"),
    Circle("405", "ADILABAD"),
    Circle("404", "NIZAMABAD"),
    Circle("406", "BHADRADRI KOTHAGUDEM"),
    Circle("408", "JANGAON"),
    Circle("409", "BHOOPALAPALLY"),
    Circle("410", "MAHABUBABAD"),
    Circle("411", "JAGITYAL"),
    Circle("412", "PEDDAPALLY"),
    Circle("413", "KAMAREDDY"),
    Circle("414", "NIRMAL"),
    Circle("415", "ASIFABAD"),
    Circle("416", "MANCHERIAL"),
  ];

  List<Circle> get circle => _circle;

  void onListCircleSelected(String? value) {
    _selectedCircle = value ?? '000';
    _selectedStation = null;
    _selectedFeeder = null;
    getSubstations();
    print("_selectedCircle: $_selectedCircle");
    notifyListeners();
  }

  // 2.station
  String? _selectedStation;
  String? get selectedStation => _selectedStation;

  final List<SubstationModel> _stations = [];
  List<SubstationModel> get stations => _stations;

  void onStationSelected(String? value) {
    _selectedStation = value;
    _selectedFeeder = null;
    getFeeders();
    print("_selectedStation: $_selectedStation");
    notifyListeners();
  }

  Future<void> getSubstations() async {
    _stations.clear();
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken":
            SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "circleCode": _selectedCircle
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
        String cleanedJson = jsonList.replaceAll(r'\"', '"').trim();

        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }

        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }

        dataList = (jsonDecode(cleanedJson) as List)
            .map((json) => SubstationModel.fromJson(json))
            .toList();
      } else if (jsonList is List) {
        dataList =
            jsonList.map((json) => SubstationModel.fromJson(json)).toList();
      }

      _stations.addAll(dataList);
      print("Successfully loaded ${_stations.length} stations");
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
  String? _selectedFeeder;
  String? get selectedFeeder => _selectedFeeder;

  List<SubstationModel> _feeder = [];
  List<SubstationModel> get feeder => _feeder;

  void onListFeederSelected(String? value) {
    if (value != null && _feeder.any((item) => item.optionCode == value)) {
      _selectedFeeder = value;
      notifyListeners();
    }
  }

  Future<void> getFeeders() async {
    if (_isLoading) return;

    _isLoading = true;
    _feeder.clear();
    _selectedFeeder = null;
    notifyListeners();

    try {
      final requestData = {
        "authToken":
            SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ??
                "",
        "api": Apis.API_KEY,
        "ss": _selectedStation ?? "",
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
        dataList = (jsonList)
            .map((json) =>
                SubstationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      _feeder = dataList.toSet().toList(); // Deduplicate based on optionCode
      print(
          "Feeder option codes: ${_feeder.map((f) => f.optionCode).toList()}");
      if (_feeder.isNotEmpty) {
        _selectedFeeder = _feeder.first.optionCode; // Default to first feeder
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
  //SUBMIT API CALLS

  List<FeederDisModel> _fDEntityList = [];
  List<FeederDisModel> get fDEntityList => _fDEntityList;

  Future<void> getStructFeederDis() async {
    if (_isLoading) return;

    _isLoading = true;
    _fDEntityList.clear();
    notifyListeners();

    final Map<String, dynamic> requestFData;

    try {
      if (_selectedFilter == "Feeder wise") {
        requestFData = {
          "authToken": SharedPreferenceHelper.getStringValue(
                  LoginSdkPrefs.tokenPrefKey) ??
              "",
          "api": Apis.API_KEY,
          "ss": _selectedStation ?? "",
          "fc": _selectedFeeder ?? "",
          "status": "",
          "ignoreSection": "true"
        };
      } else if (_selectedFilter == "Distribution wise") {
        requestFData = {
          "authToken": SharedPreferenceHelper.getStringValue(
                  LoginSdkPrefs.tokenPrefKey) ??
              "",
          "api": Apis.API_KEY,
          "dc": _selectedDistribution ?? "",
          "fc": "",
          "status": "",
          "ignoreSection": "true"
        };
      } else {
        throw Exception("Invalid filter selected: $_selectedFilter");
      }

      final payload = {
        "path": "/getStructuresOfFeederOrDistribution",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestFData),
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

      print("API Response: $responseData");

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

      final jsonList = responseData['message'];
      List<FeederDisModel> dataList = [];

      if (jsonList == null) {
        print("No feeder/distribution data received in message");
        _fDEntityList.clear();
      } else if (jsonList is String) {
        print("Raw message string: $jsonList");
        String cleanedJson = jsonList.trim();
        try {
          if (!cleanedJson.startsWith('[') || !cleanedJson.endsWith(']')) {
            throw FormatException(
                "Invalid JSON array format in message: $cleanedJson");
          }
          dataList = (jsonDecode(cleanedJson) as List<dynamic>)
              .map((json) =>
                  FeederDisModel.fromJson(json as Map<String, dynamic>))
              .toList();
          _fDEntityList = dataList;
        } catch (e) {
          print("Error decoding JSON string: $e");
          rethrow;
        }
      } else if (jsonList is List) {
        dataList = jsonList
            .map(
                (json) => FeederDisModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (jsonList is String) {
        // Parse the string only if it appears to be a valid JSON list
        final cleaned = jsonList.trim();
        if (cleaned.startsWith('[') && cleaned.endsWith(']')) {
          dataList = (jsonDecode(cleaned) as List)
              .map((json) => FeederDisModel.fromJson(json))
              .toList();
        } else {
          throw Exception("Unexpected message format: ${jsonList.runtimeType}");
        }
      } else {
        throw Exception("Unexpected message format: ${jsonList.runtimeType}");
      }

      print("Successfully loaded ${_fDEntityList.length} structure entities");
      print(
          "Navigating to MappedDtr with ${_fDEntityList.length} items: ${_fDEntityList.map((e) => e.toJson())}");
      // Navigator.pushNamed(context, Routes.mappedDtrScreen, arguments: _fDEntityList);
      Navigation.instance
          .navigateTo(Routes.mappedDtrScreen, args: _fDEntityList);
    } catch (e, stackTrace) {
      print("Error fetching feeder/distribution data: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load data: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
      print("Finished getStructFeederDis");
    }
  }

  // Equipment no/Structure code
  final List<FeederDisModel> _structureDataConfi = [];
  List<FeederDisModel> get structureData => _structureDataConfi;

  Future<void> getStructureData() async {
    _isLoading = true;
    _structureDataConfi.clear();
    notifyListeners();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ??
              "",
      "api": Apis.API_KEY,
      "structureCode": equipNoORStructCode.text,
    };

    final payload = {
      "path": "/getDtrsOfStructure",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("load structure response: $response");
      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(
                context, "Invalid response format. Please try again.");
            return;
          }
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == true) {
            if (responseData['success'] == true) {
              if (responseData['message'] != null) {
                try {
                  final jsonMessage = responseData['message'];
                  List<FeederDisModel> dataList = [];

                  if (jsonMessage is String) {
                    // Parse the JSON string within message
                    final structureJson = jsonDecode(jsonMessage);
                    dataList.add(FeederDisModel.fromJson(structureJson));
                  } else if (jsonMessage is Map<String, dynamic>) {
                    // If message is already a parsed object
                    dataList.add(FeederDisModel.fromJson(jsonMessage));
                  }

                  _structureDataConfi.addAll(dataList);
                  print(
                      "Structure data: ${_structureDataConfi.length} items loaded");
                  print(
                      "Structure details: ${_structureDataConfi.map((e) => e.toJson())}");
                  Navigation.instance.navigateTo(
                    Routes.dtrStructure,
                    args: _structureDataConfi,
                  );
                } catch (e, stackTrace) {
                  print("Error parsing message: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context,
                      "Failed to parse structure data. Please contact support.");
                }
              }
            } else {
              showAlertDialog(
                  context, responseData['message'] ?? "Operation failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showErrorDialog(
              context, "Request failed with status: ${response.statusCode}");
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  void setSelectedFilter(String title) {
    _selectedFilter = title;
    print("$_selectedFilter: filter selected");
    if (_selectedFilter == "Distribution wise") {
      getDistributions();
    }
    notifyListeners();
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      } else if (_selectedFilter == "Distribution wise" ||
          _selectedFilter == "Feeder wise") {
        getStructFeederDis();
      } else {
        getStructureData();
      }
    }
  }

  bool validateForm() {
    if (_selectedFilter == '' || _selectedFilter == null) {
      AlertUtils.showSnackBar(
          context, "Please select any one filter Circle", isTrue);
      print("Please select any one filter Circle");
      return false;
    }
    if (_selectedFilter == "Equipment/Structure search" &&
        equipNoORStructCode.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please Enter Your Equipment No/Structure Code", isTrue);
      return false;
    } else if (_selectedFilter == "Equipment/Structure search" &&
        equipNoORStructCode.text.length < 9) {
      AlertUtils.showSnackBar(
          context, "Please Enter Your Equipment No/Structure Code", isTrue);
      return false;
    } else if (_selectedFilter == "Distribution wise" &&
        selectedDistribution == null) {
      AlertUtils.showSnackBar(context, "Please select Distribution", isTrue);
      return false;
    } else if (_selectedFilter == "Feeder wise" && selectedCircle == null) {
      AlertUtils.showSnackBar(context, "Please select Circle", isTrue);
      return false;
    } else if ((_selectedFilter == "Feeder wise" && selectedCircle != null) &&
        selectedStation == null) {
      AlertUtils.showSnackBar(context, "Please select Station", isTrue);
      return false;
    } else if (((_selectedFilter == "Feeder wise" && selectedCircle != null) &&
            selectedStation != null) &&
        selectedFeeder == null) {
      AlertUtils.showSnackBar(context, "Please select Feeder", isTrue);
      return false;
    }
    return true;
  }
}
