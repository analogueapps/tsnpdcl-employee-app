import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/meeseva/model/csc_tsc_application_response.dart';

class FormLoaderViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final Map<String, dynamic> data;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  CscTscApplicationResponse? _cscTscApplicationResponse;
  CscTscApplicationResponse? get cscTscApplicationResponse => _cscTscApplicationResponse;

  FormLoaderViewmodel({required this.context, required this.data}) {
    loadApplications();
  }

  Future<void> loadApplications() async {
    _isLoading = true;
    _cscTscApplicationResponse = null;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "regNum": data['regNum'],
      "regId": data['regId'],
      "registrationId": data['regNum'],
    };

    final payload = {
      "path": "/getCscTscApplication",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = false;
    notifyListeners();
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
                final List<CscTscApplicationResponse> responseList = jsonList.map((
                    json) => CscTscApplicationResponse.fromJson(json)).toList();
                _cscTscApplicationResponse = responseList.first;
                notifyListeners();
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

  void remarkRejectClicked() {
    final TextEditingController remarksController = TextEditingController();
    bool isRejected = false;

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CupertinoAlertDialog(
              title: const Text(
                "Add Remarks/Reject Application",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Enter your remarks below",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: CupertinoTextField(
                      controller: remarksController,
                      maxLines: null,
                      placeholder: "Type your remarks...",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Also Reject application?",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'ProzaLibre',
                          ),
                        ),
                      ),
                      CupertinoSwitch(
                        value: isRejected,
                        onChanged: (value) {
                          setState(() => isRejected = value);
                        },
                      ),
                    ],
                  ),
                  if (isRejected)
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "You have selected an option to reject the application. This will move application to Non-feasible/Reject status.",
                        style: TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemRed,
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  isDestructiveAction: true,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontFamily: 'ProzaLibre'),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    // Handle submission
                    String remarks = remarksController.text;
                    //print("Submitted: $remarks | Rejected: $isRejected");

                    if(remarksController.text.isEmpty || remarksController.text.length < 10) {
                      showAlertDialog(context, "Please enter the remarks at least 10 characters");
                      return;
                    }

                    Navigator.pop(context);
                    updateRemarksOfMeeSevaApplication(remarksController.text, isRejected);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Color(0xFF076707),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> updateRemarksOfMeeSevaApplication(String remarks, bool reject) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Please wait...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "remarks": remarks,
      "regId": data['regId'],
      "registrationId": data['regNum'],
    };

    if(data['reject'] == true) {
      requestData['reject'] = true;
    }

    final payload = {
      "path": "/updateRemarksForMeesevaApplication",
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
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              showSuccessDialog(context, response.data['message'],(){});
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
