import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';

class AddInductionPointViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  String? selectedCheckboxId;
  bool isSelected(String id) => selectedCheckboxId == id;

  List<SpinnerList> list132kVssItem = [];
  String? list132kVssSelect;

  List<SpinnerList> list33KvFeederOf132kVssItem = [];
  String? list33KvFeederOf132kVssSelect;

  List<SpinnerList> listCircleItem = [];
  String? listCircleSelect;

  List<SpinnerList> list33kVSsOfCircleItem = [];
  String? list33kVSsOfCircleSelect;

  List<SpinnerList> listFeederItem = [];
  String? listFeederSelect;

  List<SpinnerList> listInterferenceItem = [];
  String? listInterferenceSelect;

  List<SpinnerList> listDistributionItem = [];
  String? listDistributionSelect;

  // Constructor to initialize the items
  AddInductionPointViewModel({required this.context});

  void selectCheckbox(String id) {
    clearAllList();
    notifyListeners();
    if(id == "33KV LINE"){
      get132KVSSLines();
    } else if(id == "11KV LINE" || id == "LT LINE") {
      addCircleList();
    }
    if (selectedCheckboxId == id) {
      selectedCheckboxId = null; // Uncheck if the same checkbox is clicked
    } else {
      selectedCheckboxId = id;
    }
    notifyListeners(); // Notify the view about the change
  }

  Future<void> get132KVSSLines() async {
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
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                list132kVssItem.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
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

  void onList132kVssValueChange(String? value) {
    list132kVssSelect = value;
    if(value != null) {
      clearList33KvFeederOf132kVssItem();
      get33KVFeederOf132KVSSLines(value);
    }
    notifyListeners();
  }

  Future<void> get33KVFeederOf132KVSSLines(String ss) async {
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
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                list33KvFeederOf132kVssItem.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
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

  void onList33KvFeederOf132kVssValueChange(String? value) {
    list33KvFeederOf132kVssSelect = value;
    notifyListeners();
  }

  void addCircleList() {
    listCircleItem.addAll([
      SpinnerList(optionCode:"401",optionName: "KHAMMAM"),
      SpinnerList(optionCode:"402",optionName: "HANAMKONDA"),
      SpinnerList(optionCode:"407",optionName: "WARANGAL"),
      SpinnerList(optionCode:"403",optionName: "KARIMNAGAR"),
      SpinnerList(optionCode:"405",optionName: "ADILABAD"),
      SpinnerList(optionCode:"404",optionName: "NIZAMABAD"),
      SpinnerList(optionCode:"406",optionName: "BHADRADRI KOTHAGUDEM"),
      SpinnerList(optionCode:"408",optionName: "JANGAON"),
      SpinnerList(optionCode:"409",optionName: "BHOOPALAPALLY"),
      SpinnerList(optionCode:"410",optionName: "MAHABUBABAD"),
      SpinnerList(optionCode:"411",optionName: "JAGITYAL"),
      SpinnerList(optionCode:"412",optionName: "PEDDAPALLY"),
      SpinnerList(optionCode:"413",optionName: "KAMAREDDY"),
      SpinnerList(optionCode:"414",optionName: "NIRMAL"),
      SpinnerList(optionCode:"415",optionName: "ASIFABAD"),
      SpinnerList(optionCode:"416",optionName: "MANCHERIAL"),
    ]);
    notifyListeners();
  }

  void onListCircleValueChange(String? value) {
    listCircleSelect = value;
    if(value != null) {
      clearList33kVSsOfCircleItem();
      clearListFeederItem();
      clearListInterferenceItem();
      clearListDistributionItem();
      get33kVSsOfCircle(value);
    }
    notifyListeners();
  }

  Future<void> get33kVSsOfCircle(String circleCode) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "circleCode": circleCode,
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
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                list33kVSsOfCircleItem.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
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

  void onList33kVSsOfCircleValueChange(String? value) {
    list33kVSsOfCircleSelect = value;
    if(value != null) {
      clearListFeederItem();
      clearListInterferenceItem();
      clearListDistributionItem();
      getFeeders(value);
    }
    notifyListeners();
  }

  Future<void> getFeeders(String ss) async {
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
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                listFeederItem.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
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

  void onListFeederValueChange(String? value) {
    listFeederSelect = value;
    if(value != null) {
      clearListInterferenceItem();
      clearListDistributionItem();
      getInterferenceType();
    }
    notifyListeners();
  }

  void getInterferenceType() {
    listInterferenceItem.addAll([
      SpinnerList(optionCode:"CROSSING",optionName: "CROSSING"),
      SpinnerList(optionCode:"DOUBLE FEEDING",optionName: "DOUBLE FEEDING"),
      if(isSelected("LT LINE"))
        SpinnerList(optionCode:"HT/LT",optionName: "HT/LT")
    ]);
    notifyListeners();
  }

  void onListInterferenceValueChange(String? value) {
    listInterferenceSelect = value;
    if(value != null && isSelected("LT LINE")) {
      clearListDistributionItem();
      getDistributions();
    }
    notifyListeners();
  }

  Future<void> getDistributions() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "feederCode": listFeederSelect,
      "ebsstructure": true,
    };

    final payload = {
      "path": "/load/distributions",
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
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                listDistributionItem.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
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

  void onListDistributionValueChange(String? value) {
    listDistributionSelect = value;
    notifyListeners();
  }

  void clearAllList() {
    clearList132kVssItem();
    clearList33KvFeederOf132kVssItem();
    clearListCircleItem();
    clearList33kVSsOfCircleItem();
    clearListFeederItem();
    clearListInterferenceItem();
    clearListDistributionItem();
  }

  void clearList132kVssItem() {
    // clearList132kVssItem
    list132kVssItem.clear();
    list132kVssSelect = null;
  }

  void clearList33KvFeederOf132kVssItem() {
    // clearList33KvFeederOf132kVssItem
    list33KvFeederOf132kVssItem.clear();
    list33KvFeederOf132kVssSelect = null;
  }


  void clearListCircleItem() {
    // clearListCircleItem
    listCircleItem.clear();
    listCircleSelect = null;
  }

  void clearList33kVSsOfCircleItem() {
    // clearList33kVSsOfCircleItem
    list33kVSsOfCircleItem.clear();
    list33kVSsOfCircleSelect = null;
  }


  void clearListFeederItem() {
    // clearListFeederItem
    listFeederItem.clear();
    listFeederSelect = null;
  }

  void clearListInterferenceItem() {
    // clearListInterferenceItem
    listInterferenceItem.clear();
    listInterferenceSelect = null;
  }

  void clearListDistributionItem() {
    // clearListDistributionItem
    listDistributionItem.clear();
    listDistributionSelect = null;
  }

  Future<void> onSaveClicked(Map<String, dynamic> args) async {
    if(selectedCheckboxId != null) {

      final requestData = {
        "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "appId": 'in.tsnpdcl.npdclemployee',
        "deviceId": await getDeviceId(),
        "ssCode": args['ssCode'],
        "fdrCode": args['fdrCode'],
      };

      if(selectedCheckboxId == "NO INDUCTION SOURCE"){
        requestData['type'] = "NONE";
      } else if(selectedCheckboxId == "EHT LINE"){
        requestData['type'] = "EHT";
      } else if(selectedCheckboxId == "33KV LINE"){
        requestData['type'] = "33KV";

        if (list132kVssSelect == null) {
          showAlertDialog(context, "Please select EHT Substation");
          return;
        } else if (list33KvFeederOf132kVssSelect == null) {
          showAlertDialog(context, "Please select 33KV Feeder");
          return;
        }

        requestData['ehtSSCode'] = list132kVssSelect;
        requestData['indSSName'] = list132kVssItem.firstWhere((item) => item.optionCode == list132kVssSelect).optionName;
        requestData['indFdrCode'] = list33KvFeederOf132kVssSelect;
        requestData['indFdrName'] = list33KvFeederOf132kVssItem.firstWhere((item) => item.optionCode == list33KvFeederOf132kVssSelect).optionName;

      } else if(selectedCheckboxId == "11KV LINE") {
        requestData['type'] = "11KV";

        if (listCircleSelect == null)  {
          showAlertDialog(context, "Please select Circle");
          return;
        } else if (list33kVSsOfCircleSelect == null)  {
          showAlertDialog(context, "Please select 33/11KV Substation");
          return;
        } else if (listFeederSelect == null) {
          showAlertDialog(context, "Please select 11KV Feeder");
          return;
        } else if (listInterferenceSelect == null) {
          showAlertDialog(context, "Please select Interference Type");
          return;
        }

        requestData['indSS33KvCode'] = list33kVSsOfCircleSelect;
        requestData['indSSName'] = list33kVSsOfCircleItem.firstWhere((item) => item.optionCode == list33kVSsOfCircleSelect).optionName;
        requestData['indFdrCode'] = listFeederSelect;
        requestData['indFdrName'] = listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName;
        requestData['interferenceType'] = listInterferenceSelect;

      } else if(selectedCheckboxId == "LT LINE") {
        requestData['type'] = "LT";

        if (listCircleSelect == null)  {
          showAlertDialog(context, "Please select Circle");
          return;
        } else if (list33kVSsOfCircleSelect == null)  {
          showAlertDialog(context, "Please select 33/11KV Substation");
          return;
        } else if (listFeederSelect == null) {
          showAlertDialog(context, "Please select 11KV Feeder");
          return;
        } else if (listInterferenceSelect == null) {
          showAlertDialog(context, "Please select Interference Type");
          return;
        } else if (listDistributionSelect == null) {
          showAlertDialog(context, "Please select DTR structure code");
          return;
        }

        requestData['indSS33KvCode'] = list33kVSsOfCircleSelect;
        requestData['indSSName'] = list33kVSsOfCircleItem.firstWhere((item) => item.optionCode == list33kVSsOfCircleSelect).optionName;
        requestData['indFdrCode'] = listFeederSelect;
        requestData['indFdrName'] = listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName;
        requestData['interferenceType'] = listInterferenceSelect;
        requestData['indDtrStructCode'] = listDistributionSelect;
      }

      ProcessDialogHelper.showProcessDialog(
        context,
        message: "Please wait...",
      );

      var response = await ApiProvider(baseUrl: Apis.LC_END_POINT_BASE_URL).postApiCall(context, Apis.ADD_INDUCTION_POINT_URL, requestData);
      if (context.mounted) {
        ProcessDialogHelper.closeDialog(context);
      }

      try {
        if (response != null) {
          if (response.data is String) {
            response.data = jsonDecode(response.data); // Parse string to JSON
          }
          if (response.statusCode == successResponseCode) {
            if(response.data['tokenValid'] == isTrue) {
              if (response.data['success'] == isTrue) {
                await showSuccessDialog(context, response.data['success'], () {
                  Navigation.instance.pushBack();
                  },
                );
              } else {
                showAlertDialog(context,response.data['message']);
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

    } else {
      showAlertDialog(context, "Please choose induction source");
    }
  }

}


// if(list132kVssSelect == null) {
// showAlertDialog(context, "Please select EHT Substation");
// }
// if(list33KvFeederOf132kVssSelect == null) {
// showAlertDialog(context, "Please select 33KV Feeder");
// }
// if(listCircleSelect == null) {
// showAlertDialog(context, "Please select Circle");
// }
// if(list33kVSsOfCircleSelect == null) {
// showAlertDialog(context, "Please select 33/11KV Substation");
// }
// if(listFeederSelect == null) {
// showAlertDialog(context, "Please select 11KV Feeder");
// }
// if(listInterferenceSelect == null) {
// showAlertDialog(context, "Please select Interference Type");
// }
// if(listDistributionSelect == null) {
// showAlertDialog(context, "Please select Interference Type");
// }
