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
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/dateMoth.dart';

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
  List<SubstationModel> _distributions = [];
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
        "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? "",
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
            .map((json) => SubstationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (jsonList is List) {
        dataList = (jsonList as List<dynamic>)
            .map((json) => SubstationModel.fromJson(json as Map<String, dynamic>))
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
    _selectedFeeder=null;
    getSubstations();
    print("_selectedCircle: $_selectedCircle");
    notifyListeners();
  }
  // 2.station
  String? _selectedStation;
  String? get selectedStation => _selectedStation;

  List<SubstationModel> _stations = [];
  List<SubstationModel> get stations => _stations;

  void onStationSelected(String? value) {
    _selectedStation = value;
    _selectedFeeder=null;
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
        "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
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
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    _feeder.clear();
    _selectedFeeder = null; // Reset selected feeder when reloading
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? "",
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

      // Process feeder data
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
            .map((json) => SubstationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (jsonList is List) {
        dataList = (jsonList as List<dynamic>)
            .map((json) => SubstationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      // Remove duplicates based on optionCode
      _feeder = dataList.toSet().toList(); // Assumes SubstationModel has proper equality
      if (_feeder.isNotEmpty && _selectedFeeder == null) {
        _selectedFeeder = _feeder.first.optionCode; // Set default selection
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

  List<FeederDisModel> _FDEntityList = [];
  List<FeederDisModel> get FDEntityList => _FDEntityList;

  Future<void> getStructFeederDis() async {
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    _feeder.clear();
    notifyListeners();

    final Map<String, dynamic> requestFData; // Declare as final

    try {
      if (_selectedFilter == "Feeder wise") {
        requestFData = {
          "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? "",
          "api": Apis.API_KEY,
          "ss": _selectedStation ?? "",
          "fc": _selectedFeeder ?? "",
          "status": "",
          "ignoreSection": "true"
        };
      } else if (_selectedFilter == "Distribution wise") {
        requestFData = {
          "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? "",
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

      // Process response data
      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      print("API Response: $responseData"); // Debug log

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

      // Process feeder/distribution data
      final jsonList = responseData['objectJson'];
      List<FeederDisModel> dataList = [];

      if (jsonList == null) {
        print("No feeder/distribution data received in objectJson");
        _FDEntityList.clear(); // Clear list if no data
      } else if (jsonList is String) {
        String cleanedJson = jsonList.replaceAll(r'\"', '"').trim();
        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }
        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }
        dataList = (jsonDecode(cleanedJson) as List<dynamic>)
            .map((json) => FeederDisModel.fromJson(json as Map<String, dynamic>))
            .toList();
        _FDEntityList.addAll(dataList);
      } else if (jsonList is List) {
        dataList = (jsonList as List<dynamic>)
            .map((json) => FeederDisModel.fromJson(json as Map<String, dynamic>))
            .toList();
        _FDEntityList.addAll(dataList);
      }

      print("Successfully loaded ${_FDEntityList.length} feeder/distribution entities");

    } catch (e, stackTrace) {
      print("Error fetching feeder/distribution data: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load data: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void setSelectedFilter(String title) {
    _selectedFilter = title;
    print("$_selectedFilter: filter selected");
    if(_selectedFilter=="Distribution wise"){
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
      }else if(_selectedFilter=="Distribution wise"||_selectedFilter=="Feeder wise"){
        getStructFeederDis();
      }else{
        null;
      }
    }
  }
    bool validateForm() {
      if (_selectedFilter==''||_selectedFilter==null) {
        AlertUtils.showSnackBar(context, "Please select any one filter Circle", isTrue);
        print("Please select any one filter Circle");
        return false;
      }
      if (_selectedFilter=="Equipment/Structure search" && equipNoORStructCode.text.isEmpty ) {
        AlertUtils.showSnackBar(
            context, "Please Enter Your Equipment No/Structure Code",
            isTrue);
        return false;
      } else if (_selectedFilter=="Equipment/Structure search" && equipNoORStructCode.text.length<9 ) {
        AlertUtils.showSnackBar(
            context, "Please Enter Your Equipment No/Structure Code",
            isTrue);
        return false;
      }
      else if (_selectedFilter=="Distribution wise" && selectedDistribution==null) {
        AlertUtils.showSnackBar(
            context, "Please select Distribution",
            isTrue);
        return false;
      }else if (_selectedFilter=="Feeder wise" && selectedCircle==null) {
        AlertUtils.showSnackBar(
            context, "Please select Circle",
            isTrue);
        return false;
      }else if ((_selectedFilter=="Feeder wise" &&selectedCircle!=null) && selectedStation==null) {
        AlertUtils.showSnackBar(
            context, "Please select Station",
            isTrue);
        return false;
      }else if (((_selectedFilter=="Feeder wise"&&selectedCircle!=null)&&selectedStation!=null) && selectedFeeder==null) {
        AlertUtils.showSnackBar(
            context, "Please select Feeder",
            isTrue);
        return false;
      }
      return true;
    }
}
