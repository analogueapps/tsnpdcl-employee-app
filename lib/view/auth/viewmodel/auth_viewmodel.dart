import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';

class AuthViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  // Controllers for Employee login
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController empPassController = TextEditingController();

  // Controllers for Corporate Login
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPassController = TextEditingController();

  // State variables
  bool isChecked = false; // For the checkbox
  bool isLoading = false; // For showing progress indicator

  // Form Keys
  final employeeFormKey = GlobalKey<FormState>(); // For Employee
  final corporateFormKey = GlobalKey<FormState>(); // For Corporate

  // App version
  String appVersion = 'Unknown';

  AuthViewmodel({required this.context,}) {
    _initPackageInfo();
  }

  // Package Info method
  Future<void> _initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //_appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
    appVersion = packageInfo.version;
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }

  // API call simulation
  Future<void> authenticateEmployee() async {
    if (employeeFormKey.currentState!.validate()) {
      employeeFormKey.currentState!.save();
      notifyListeners();

      ProcessDialogHelper.showProcessDialog(
        context,
        message: "Authenticating please wait...",
      );

      final requestData = {
        "eid": empIdController.text.trim(),
        "did": await getDeviceId(),
        "p": empPassController.text.trim(),
        "api": Apis.API_KEY,
      };

      final payload = {
        "path": "/loginEmp",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.AUTH_URL, payload);
      if (context.mounted) {
        ProcessDialogHelper.closeDialog(context);
      }
      print('shitt1: $response');

      try {
        if (response != null) {
          if (response.data is String) {
            response.data = jsonDecode(response.data); // Parse string to JSON
          }
          if (response.statusCode == successResponseCode) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
                await SharedPreferenceHelper.setStringValue(LoginSdkPrefs.tokenPrefKey, user[0].tokenHolder!);
                await SharedPreferenceHelper.setIntValue(LoginSdkPrefs.tokenTimePrefKey, DateTime.now().millisecondsSinceEpoch);
                await SharedPreferenceHelper.setStringValue(LoginSdkPrefs.userIdPrefKey, empIdController.text.trim());
                await SharedPreferenceHelper.setStringValue(LoginSdkPrefs.npdclUserPrefKey, jsonEncode(user));
                await SharedPreferenceHelper.setLoginStatus(isTrue);
                /// * swetha
                await SharedPreferenceHelper.setStringValue(LoginSdkPrefs.sectionCodePrefKey, user[0].sectionCode ?? '',);
                await SharedPreferenceHelper.setStringValue(LoginSdkPrefs.circleIdPrefKey, user[0].secMasterEntity!.circleId ?? '',);


                Navigation.instance.pushAndRemoveUntil(Routes.universalDashboardScreen);
              }
            } else {
              showAlertDialog(context,response.data['message']);
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
      handleEmpValidationErrors();
    }
  }

  void handleEmpValidationErrors() {
    if (empIdController.text.isEmpty && empPassController.text.isEmpty) {
      showAlertDialog(context,"Please enter valid employee ID and password");
    } else if (empIdController.text.length < 5) {
      showAlertDialog(context,"Please enter a valid employee ID");
    } else if (empPassController.text.isEmpty) {
      showAlertDialog(context,"Password cannot be left blank");
    } else {
      showAlertDialog(context,"Check all fields");
    }
  }


  // API call simulation
  Future<void> authenticateUser() async {
    if (corporateFormKey.currentState!.validate()) {
      corporateFormKey.currentState!.save();
      notifyListeners();

      ProcessDialogHelper.showProcessDialog(
        context,
        message: "Authenticating please wait...",
      );

      final requestData = {
        "eid": userNameController.text.trim(),
        "did": await getDeviceId(),
        "p": userPassController.text.trim(),
        "api": Apis.API_KEY,
      };

      final payload = {
        "path": "/loginCorp",
        "apiVersion": "1.0",
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
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
                await SharedPreferenceHelper.setStringValue(LoginSdkPrefs.tokenPrefKey, user[0].tokenHolder!);
                await SharedPreferenceHelper.setIntValue(LoginSdkPrefs.tokenTimePrefKey, DateTime.now().millisecondsSinceEpoch);
                await SharedPreferenceHelper.setStringValue(LoginSdkPrefs.userIdPrefKey, empIdController.text.trim());
                await SharedPreferenceHelper.setStringValue(LoginSdkPrefs.npdclUserPrefKey, jsonEncode(user));
                await SharedPreferenceHelper.setLoginStatus(isTrue);

                Navigation.instance.pushAndRemoveUntil(Routes.universalDashboardScreen);
              }
            } else {
              showAlertDialog(context,response.data['message']);
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
      handleCorporateValidationErrors();
    }
  }

  void handleCorporateValidationErrors() {
    if (userNameController.text.isEmpty && userPassController.text.isEmpty) {
      showAlertDialog(context,"Please enter valid user name and password");
    } else if (userNameController.text.length < 2) {
      showAlertDialog(context,"Please enter a valid user name");
    } else if (userPassController.text.isEmpty) {
      showAlertDialog(context,"Password cannot be left blank");
    } else {
      showAlertDialog(context,"Check all fields");
    }
  }
}
