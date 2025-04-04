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

class MapDtrViewMobel extends ChangeNotifier {
  MapDtrViewMobel({required this.context});
  final BuildContext context;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;
  
  final formKey = GlobalKey<FormState>();
  final TextEditingController equipNoORStructCode = TextEditingController();

  String? _selectedFilter;
  String? get selectedFilter => _selectedFilter;

  String? _selectedDistribution;
  String? get selectedDistribution => _selectedDistribution;

  // List<Circle> _circles = [];
  List _distributions = ["RTC", "Nakkalagutta", "Ramnagar"];
  List get distributions => _distributions;

  void onListDistriSelected(String? value) {
    _selectedDistribution = value;
    notifyListeners();
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
    print("_selectedCircle: $_selectedCircle");
    notifyListeners();
  }
  // 2.station
  String? _selectedStation;
  String? get selectedStation => _selectedStation;

  List _station = ["KHA", "ANGALp", "ADILA"];

  List get station => _station;
  void onListStationSelected(String? value) {
    _selectedStation = value;
    notifyListeners();
  }

//3.feeder
  String? _selectedFeeder;
  String? get selectedFeeder => _selectedFeeder;

  List _feeder = ["RTC", "Nakkalagutta", "Ramnagar"];
  List get feeder => _feeder;

  void onListFeederSelected(String? value) {
    _selectedFeeder = value;
    notifyListeners();
  }

  void setSelectedFilter(String title) {
    _selectedFilter = title;
    print("$_selectedFilter: filter selected");
    notifyListeners();
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
      } else if (_selectedFilter=="Distribution wise" && selectedDistribution==null) {
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

  // Future<void> getSubStation() async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   final requestData = {
  //     "authToken": SharedPreferenceHelper.getStringValue(
  //         LoginSdkPrefs.tokenPrefKey),
  //     "api": Apis.API_KEY,
  //     "circleCode":"",
  //   };
  //
  //   final payload = {
  //     "path": "/load/load33kvssOfCircle",
  //     "apiVersion": "1.0",
  //     "method": "POST",
  //     "data": jsonEncode(requestData), //"data": "{\"authToken\":\"{{TOKEN}}\",\"api\":\"{{API_KEY}}\", \"empId\":\"70000000\"}"
  //   };
  //
  //
  //   try {
  //     var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(
  //         context, Apis.NPDCL_EMP_URL, payload);
  //
  //     _isLoading = false;
  //     notifyListeners();
  //
  //     print("Meter response: $response");
  //     if (response != null) {
  //       var responseData = response.data;
  //       // Ensure response.data is properly parsed
  //       if (responseData is String) {
  //         try {
  //           responseData = jsonDecode(responseData);
  //         } catch (e) {
  //           print("Error decoding response data: $e");
  //           showErrorDialog(
  //               context, "Invalid response format. Please try again.");
  //           return;
  //         }
  //       }
  //
  //       // Check status code
  //       if (response.statusCode == successResponseCode) {
  //         if (responseData['tokenValid'] == isTrue) {
  //           if (responseData['success'] == isTrue) {
  //              if (responseData['objectJson'] != null) {
  //       try {
  //         final jsonList = responseData['objectJson'];
  //         List<MisMatchedModel> dataList = [];
  //
  //         if (jsonList is String) {
  //           // Clean the string JSON format by replacing escaped quotes
  //           String cleanedJsonString = jsonList.replaceAll(r'\"', '"').trim();
  //
  //           // Ensure it ends with a correct JSON format (either array or object)
  //           if (cleanedJsonString.endsWith(',')) {
  //             cleanedJsonString = cleanedJsonString.substring(0, cleanedJsonString.length - 1);
  //           }
  //
  //           if (!cleanedJsonString.startsWith('[')) {
  //             cleanedJsonString = '[$cleanedJsonString]';
  //           }
  //
  //                   // Parse the cleaned JSON string
  //                   final parsedList = jsonDecode(cleanedJsonString) as List;
  //                   dataList = parsedList.map((json) => MeterStockEntity.fromJson(json)).toList();
  //                 } else if (jsonList is List) {
  //                   dataList = jsonList.map((json) => MeterStockEntity.fromJson(json)).toList();
  //                 }
  //
  //                 _meterStockEntityList.addAll(dataList);
  //                 print("Meters data: ${_meterStockEntityList.length} items loaded");
  //                 notifyListeners();
  //               } catch (e, stackTrace) {
  //                 print("Error parsing objectJson: $e");
  //                 print("Stack trace: $stackTrace");
  //                 showErrorDialog(context, "Failed to parse meter data. Please contact support.");
  //               }
  //             }            }
  //         } else {
  //           showAlertDialog(context, responseData['message']);
  //         }
  //       } else {
  //         showSessionExpiredDialog(context);
  //       }
  //     }
  //   } catch (e) {
  //     print("Exception caught: $e");
  //     showErrorDialog(context, "An error occurred. Please try again.");
  //   }
  // }

}
