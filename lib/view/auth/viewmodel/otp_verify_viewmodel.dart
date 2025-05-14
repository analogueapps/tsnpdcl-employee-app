import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';

class OtpVerifyViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final Map<String, dynamic> data;

  // Controllers for Employee login
  final TextEditingController empPhoneController = TextEditingController();
  String? otp;
  bool resendOtp = isFalse;
  int secondsRemaining = millisecondsThirty;
  Timer? timer;

  // State variables
  bool isChecked = false; // For the checkbox
  bool isLoading = false; // For showing progress indicator

  // Form Keys
  final employeeFormKey = GlobalKey<FormState>(); // For Employee

  // App version
  String appVersion = 'Unknown';

  OtpVerifyViewmodel({required this.context, required this.data}) {
    _initPackageInfo();
    empPhoneController.text = data['phone'];
    notifyListeners();
    //startTimer();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: numOne);
    timer = Timer.periodic(oneSecond, (timer) {
      if (secondsRemaining == numZero) {
        timer.cancel();
        resendOtp = isTrue;
      } else {
        secondsRemaining--;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
    if(otp!.isNotEmpty && otp!.length == numSix) {

      ProcessDialogHelper.showProcessDialog(
        context,
        message: "Please wait....",
      );
      notifyListeners();

      final requestData = {
        "phone": empPhoneController.text.trim(),
        "otp": otp,
        "api": Apis.API_KEY,
        "did": await getDeviceId(),
      };

      final payload = {
        "path": "/verifyOTP",
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
                showSuccessDialog(context, "Password changed successfully", () {
                  Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);
                });
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
      //handleEmpValidationErrors();
      showAlertDialog(context,"Please enter a valid OTP");
    }
  }

  void handleEmpValidationErrors() {
    // if (empIdController.text.isEmpty && empPassController.text.isEmpty) {
    //   showAlertDialog(context,"Please enter valid employee ID and password");
    // } else if (empIdController.text.length < 5) {
    //   showAlertDialog(context,"Please enter a valid employee ID");
    // } else if (empPassController.text.isEmpty) {
    //   showAlertDialog(context,"Password cannot be left blank");
    // } else if(empConPassController.text.isEmpty) {
    //   showAlertDialog(context,"Confirm Password cannot be left blank");
    // } else if(empConPassController.text != empPassController.text) {
    //   showAlertDialog(context,"Password does not match");
    // } else {
    //   showAlertDialog(context,"Check all fields");
    // }
  }
}
