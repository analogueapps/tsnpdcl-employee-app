import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';

class CreateGisIdViewModel extends ChangeNotifier {
  CreateGisIdViewModel({required this.context});
  final BuildContext context;

  static const bool isTrue = true;
  static const bool isFalse = false;
  static const int successResponseCode = 200;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  // Lists
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
    if (!_33kvline) { // Only allow changes if 33KV is not selected
      _selectedCircle = value ?? '000';
      _selectedSubStation = null;
      _selectedFeeder = null;
      getSubstations();
      print("_selectedCircle: $_selectedCircle");
      notifyListeners();
    }
  }

  String? _selectedSubStation;
  String? get selectedStation => _selectedSubStation;

  List<SpinnerList> _stations = [];
  List<SpinnerList> get stations => _stations;

  void onStationSelected(String? value) {
    _selectedSubStation = value;
    _selectedFeeder = null;
    if (_33kvline && value != null) {
      get33KVFeederOf132KVSSLines(value);
    } else if (_11kvline && value != null) {
      get11KVFeederOf132KVSSLines(value);
    }
    print("_selectedStation: $_selectedSubStation");
    notifyListeners();
  }

  Future<void> getSubstations() async {
    _stations.clear();
    _feeder.clear();
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "circleCode": selectedCircle,
    };

    final payload = {
      "path": "/load/load33kvssOfCircle",
      "apiVersion": "1.0",
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
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                _stations.addAll(listData);
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
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  String? _selectedFeeder;
  String? get selectedFeeder => _selectedFeeder;

  List<SpinnerList> _feeder = [];
  List<SpinnerList> get feeder => _feeder;

  void onListFeederSelected(String? value) {
    if (value != null && _feeder.any((item) => item.optionCode == value)) {
      _selectedFeeder = value;
      notifyListeners();
    }
  }

  Future<void> get11KVFeederOf132KVSSLines(String ss) async {
    _feeder.clear();
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ss": ss,
    };

    final payload = {
      "path": "/load/feeders",
      "apiVersion": "1.0",
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
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                _feeder.addAll(listData);
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
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> get132KVSSLines() async {
    _stations.clear();
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/load/132kvss",
      "apiVersion": "1.0",
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
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                _stations.addAll(listData);
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
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> get33KVFeederOf132KVSSLines(String ss) async {
    _feeder.clear();
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ss": ss,
    };

    final payload = {
      "path": "/load/load33kvfdrOf132KvSs",
      "apiVersion": "1.0",
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
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                _feeder.addAll(listData);
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
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  bool _33kvline = false;
  bool _11kvline = false;

  bool get is33KVLine1 => _33kvline;
  bool get is33KVLine2 => _11kvline;

  String? get selectedLineType {
    if (_33kvline) return '33KV';
    if (_11kvline) return '11KV';
    return null;
  }

  void toggle33KVLine1(bool? value) {
    if (value == true) {
      _33kvline = true;
      _11kvline = false;
      // Execute 33KV-specific APIs
      get132KVSSLines(); // Fetch 132KV substations
      if (_selectedSubStation != null) {
        get33KVFeederOf132KVSSLines(_selectedSubStation!); // Fetch 33KV feeders if substation is selected
      }
    } else {
      _33kvline = false;
    }
    notifyListeners();
  }

  void toggle33KVLine2(bool? value) {
    if (value == true) {
      _11kvline = true;
      _33kvline = false;
      // Optionally reset stations and feeders or call different APIs for 11KV
      _stations.clear();
      _feeder.clear();
      if (_selectedSubStation != null) {
        get11KVFeederOf132KVSSLines(_selectedSubStation!); // Fetch 11KV feeders if substation is selected
      }
    } else {
      _11kvline = false;
    }
    notifyListeners();
  }

  // Text controllers
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController workDescriptionController = TextEditingController();

  // Submit action
  void submit() {
    print('Submitting GIS ID Creation:');
    print('Circle: $_selectedCircle');
    print('Sub Station: $_selectedSubStation');
    print('Feeder: $_selectedFeeder');
    print('Selected Line Type: $selectedLineType');
    print('Land Mark: ${landMarkController.text}');
    print('Work Description: ${workDescriptionController.text}');
    print("voltage:  11 or 13");

    if(_selectedFeeder!=null||_selectedSubStation!=null||selectedLineType!=null||landMarkController.text.isNotEmpty||workDescriptionController.text.isNotEmpty){
      Future<void> createGisId(String ss) async {
        _feeder.clear();
        ProcessDialogHelper.showProcessDialog(
          context,
          message: "Loading...",
        );

        final requestData = {
          "authToken": SharedPreferenceHelper.getStringValue(
              LoginSdkPrefs.tokenPrefKey),
          "api": Apis.API_KEY,
          "ssCode": _selectedSubStation,
          " feederCode": _selectedFeeder,
          " work": workDescriptionController.text,
          " land": landMarkController.text,
          "voltage":""
        };

        final payload = {
          "path": "/createGisId",
          "apiVersion": "1.0",
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
              response.data = jsonDecode(response.data);
            }
            if (response.statusCode == successResponseCode) {
              if (response.data['tokenValid'] == isTrue) {
                if (response.data['success'] == isTrue) {
                  if (response.data['objectJson'] != null) {
                    final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                    final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                    _feeder.addAll(listData);
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
          showErrorDialog(context, "An error occurred. Please try again.");
          rethrow;
        }

        notifyListeners();
      }


    }
  }

  // Clean up
  @override
  void dispose() {
    landMarkController.dispose();
    workDescriptionController.dispose();
    super.dispose();
  }
}