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
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/new_sketch_prop_entity.dart';

class PoleTrackerSelectionViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  String? selectedCheckboxId;
  bool isSelected(String id) => selectedCheckboxId == id;

  String? selectedPurposeCheckboxId;
  bool isPurposeSelected(String id) => selectedPurposeCheckboxId == id;

  String? selectedProposalCheckboxId;
  bool isProposalSelected(String id) => selectedProposalCheckboxId == id;

  List<SpinnerList> listSubStationItem = [];
  String? listSubStationSelect;
  String? listSubStationSelectBottom;

  List<SpinnerList> listFeederItem = [];
  String? listFeederSelect;
  String? listFeederSelectBottom;

  NewSketchPropEntity? newSketchPropEntity;

  // Entry field
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController estimateController = TextEditingController();

  // duplicate predict
  bool duplicate = isTrue;

  // Constructor to initialize the items
  PoleTrackerSelectionViewModel({required this.context});

  void duplicateCheck(bool? value) {
    duplicate = value!;
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
    selectedProposalCheckboxId = null;
    newSketchPropEntity = null;
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
    listFeederItem.clear();
    listFeederSelect = null;
    listFeederSelectBottom = null;
    selectedProposalCheckboxId = null;
    newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    if (selectedPurposeCheckboxId == id) {
      selectedPurposeCheckboxId = null; // Uncheck if the same checkbox is clicked
    } else {
      selectedPurposeCheckboxId = id;
      if(id == "NFP") {
        listFeederItem.add(SpinnerList(optionCode: "NFP", optionName: "New Feeder Proposal"));
        listFeederSelect = "NFP";
        listFeederSelectBottom = listFeederSelect;
      } else {
        get33KVFeederOf132KVSSLines(listSubStationSelect!);
      }
    }
    notifyListeners(); // Notify the view about the change
  }

  void selectProposalCheckbox(String id) {
    newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    if (selectedProposalCheckboxId == id) {
      selectedProposalCheckboxId = null; // Uncheck if the same checkbox is clicked
    } else {
      if(id == "EP") {
        Navigation.instance.navigateTo(Routes.newProposalScreen, args: listSubStationSelect,onReturn: (result) {
          if(result != null) {
            Map<String, dynamic> jsonMap = json.decode(result);
            newSketchPropEntity = NewSketchPropEntity.fromJson(jsonMap);
            descriptionController.text = newSketchPropEntity!.proposalDesc ?? "";
            estimateController.text = newSketchPropEntity!.estimateNo ?? "";
            selectedProposalCheckboxId = id;
            notifyListeners();
          }
        });
      } else {
        selectedProposalCheckboxId = id;
      }
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

  void onListSubStationItemSelect(String? value) {
    listSubStationSelect = value;
    listSubStationSelectBottom = listSubStationSelect;
    listFeederItem.clear();
    listFeederSelect = null;
    listFeederSelectBottom = null;
    selectedPurposeCheckboxId = null;
    selectedProposalCheckboxId = null;
    newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
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

  void onListFeederItemSelect(String? value) {
    listFeederSelect = value;
    listFeederSelectBottom = listFeederSelect;
    selectedProposalCheckboxId = null;
    newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
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
                listFeederItem.add(SpinnerList(optionCode: "NFP", optionName: "New Feeder Proposal"));
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

  Future<void> onDigitizeClicked() async {
    if(selectedCheckboxId != null) {
      if (listSubStationSelect == null)  {
        showAlertDialog(context, "Please select the Substation");
        return;
      } else if (selectedPurposeCheckboxId == null)  {
        showAlertDialog(context, "Please select the purpose");
        return;
      } else if (listFeederSelect == null)  {
        showAlertDialog(context, "Please select the Feeder");
        return;
      } else if (selectedProposalCheckboxId == null)  {
        showAlertDialog(context, "Please select the Proposal Option");
        return;
      } else if (selectedProposalCheckboxId == "CNP" && descriptionController.text.length < 10)  {
        showAlertDialog(context, "Please enter the description of work for the New Proposal.");
        return;
      }

      if(selectedProposalCheckboxId == "CNP") {
        createNewProposal();
      } else if(selectedProposalCheckboxId == "EP") {

      } else if(selectedPurposeCheckboxId == "DEF") {

      }

    } else {
      showAlertDialog(context, "Please select the Line Voltage level");
    }
  }

  Future<void> createNewProposal() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Creating Proposal...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "v": selectedCheckboxId,
      "ssn": listSubStationSelect,
      "ssc": listSubStationItem.firstWhere((item) => item.optionCode == listSubStationSelect).optionName,
      "fc": listFeederSelect,
      "fn": listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName,
      "pt": selectedProposalCheckboxId == "CNP" ? "NFP" : "LEP",
      "pdc": descriptionController.text.trim(),
      "estno": estimateController.text.trim(),
    };

    final payload = {
      "path": "/createNewProposal",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.AUTH_URL, payload);
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

              ////////////////////////////////////////////
              ////////////////////////////////////////////
              ////////////////////////////////////////////
              /*need to work on this, after getting data*/
              ////////////////////////////////////////////
              ////////////////////////////////////////////
              ////////////////////////////////////////////

              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<NewSketchPropEntity> listData = jsonList.map((json) => NewSketchPropEntity.fromJson(json)).toList();
                if (listData.isNotEmpty) {
                  // var argument = {
                  //   'd': json.encode(listData[0]),
                  //   'p': true,
                  //   'ssc': listSubStationSelect,
                  //   'ssn': listSubStationItem.firstWhere((item) => item.optionCode == listSubStationSelect).optionName,
                  //   'fc': listFeederSelect,
                  //   'fn': listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName,
                  // };
                  // Navigation.instance.navigateTo(Routes.poleProposal11kvFeederMarkScreen, args: argument);
                } else {
                  showErrorDialog(context, "Unable to process your request!");
                }
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
