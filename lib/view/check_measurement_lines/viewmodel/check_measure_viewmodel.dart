
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/new_sketch_prop_entity.dart';

class CheckMeasureViewModel extends ChangeNotifier {
  CheckMeasureViewModel({required this.context});
  // Current View Context
  final BuildContext context;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController estimateController = TextEditingController();

  String? selectedCheckboxId;
  bool isSelected(String id) => selectedCheckboxId == id;

  String? selectedPurposeCheckboxId;
  bool isPurposeSelected(String id) => selectedPurposeCheckboxId == id;

  List<SpinnerList> listSubStationItem = [];
  String? listSubStationSelect;
  String? listSubStationSelectBottom;


  List<SpinnerList> listFeederItem = [];
  String? listFeederSelect;
  String? listFeederSelectBottom;

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
                // listFeederItem.add(SpinnerList(optionCode: "NFP", optionName: "New Feeder Proposal"));
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


  void onListSubStationItemSelect(String? value) {
    listSubStationSelect = value;
    listSubStationSelectBottom = listSubStationSelect;

      if(selectedCheckboxId == "33KV Line"){
        get33KVFeederOf132KVSSLines(listSubStationSelect!);
      } else if(selectedCheckboxId == "11 KV Line") {
        getFeeders(listSubStationSelect!);
      }
    listFeederItem.clear();
    listFeederSelect = null;
    listFeederSelectBottom = null;
    selectedPurposeCheckboxId = null;
    // selectedProposalCheckboxId = null;
    // newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    notifyListeners();
  }

  void selectCheckbox(String id) {
    listSubStationItem.clear();
    listSubStationSelect = null;
    listSubStationSelectBottom = null;
    listFeederItem.clear();
    listFeederSelect = null;
    listFeederSelectBottom = null;
    selectedPurposeCheckboxId = null;
    // selectedProposalCheckboxId = null;
    // newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    notifyListeners();
    if (selectedCheckboxId == id) {
      selectedCheckboxId = null; // Uncheck if the same checkbox is clicked
    } else {
      selectedCheckboxId = id;
      if(id == "33KV Line"){
        get132KVSSLines();
      } else if(id == "11 KV Line") {
        get33kVSsOfCircle();
      }
    }
    notifyListeners(); // Notify the view about the change
  }

  void selectPurposeCheckbox(String id) {
    if (listSubStationSelect == null) {
      showAlertDialog(context, "Please select the Substation first.!");
      return;
    }
    // listFeederItem.clear();
    // listFeederSelect = null;
    // listFeederSelectBottom = null;

    // selectedProposalCheckboxId = null;
    // newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    if (selectedPurposeCheckboxId == id) {
      selectedPurposeCheckboxId = null;
    } else {
      selectedPurposeCheckboxId = id;
      if(selectedPurposeCheckboxId=="ECMD"){
        Navigation.instance.navigateTo(Routes.docketScreen, args: listSubStationSelect);
      }

    }
    print("selectedCheckboxId: $selectedPurposeCheckboxId");
    notifyListeners(); // Notify the view about the change
  }


  void onListFeederItemSelect(String? value) {
    listFeederSelect = value;
    listFeederSelectBottom = listFeederSelect;
    // selectedProposalCheckboxId = null;
    // newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    notifyListeners();
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
                listSubStationItem.addAll(listData);
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

  Future<void> get33kVSsOfCircle() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
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
                listSubStationItem.addAll(listData);
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

  //PROCEED
// void proceed(){
//   if (!validateForm2()) {
//     return false;
//   }
//   else{
//     print("in else block");
//     await makeCall(tickId, agentMobile, userMobile);
//     return true;
//   }
// }

  // bool validateForm2() {
  //   if (registeredNumber.text == "" || registeredNumber.text.isEmpty) {
  //     AlertUtils.showSnackBar(context, "Please enter your mobile number", isTrue);
  //     return  false;
  //   }else if(registeredNumber.text.length<10){
  //     AlertUtils.showSnackBar(context, "Please enter valid mobile number", isTrue);
  //     return  false;
  //   }
  //   return true;
  // }

  void proceed(){
    if(selectedPurposeCheckboxId=="NCMD"){
      createNewCheckMeasureSession();
    }else{
      print("check box is existing");
    }
  }
  Future<bool> createNewCheckMeasureSession( ) async {
    _isLoading = isTrue;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "estno":estimateController.text.trim(),
      "fc":listFeederSelect,
      "fn":listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName,
      "v":selectedCheckboxId,
      "pt":selectedPurposeCheckboxId=="NCMD"?"NFP":"LEP",
      "pdc":descriptionController.text.trim(),
      "ssn":listSubStationSelect,
      "ssc":listSubStationItem.firstWhere((item) => item.optionCode == listSubStationSelect).optionName,
    };
    final payload = {
      "path": "/createCheckMeasureSession",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };
    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['message']!=null) {
                showSuccessDialog(context, response.data['message'], (){
                  Navigator.pop(context);
                });
                resetDialogValues();
              }
            }else{
              showErrorDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    }catch(e){
      throw Exception("Exception Occurred while Authenticating");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
    return false;
  }






  void resetDialogValues() {
    selectedCheckboxId = "";
    estimateController.text = "";
    listFeederSelect = "";
    selectedPurposeCheckboxId="";
    descriptionController.text="";
    listSubStationItem.clear();
    listFeederItem.clear();
    notifyListeners();
  }
}