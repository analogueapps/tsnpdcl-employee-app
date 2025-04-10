import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class AccountScreenViewmodel with ChangeNotifier {
  final BuildContext context;
  bool _isLoading = false;
  Map<String, dynamic>? _accountData;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get accountData => _accountData;

  AccountScreenViewmodel(this.context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAccount();
    });
  }

  Future<void> loadAccount() async {
    _isLoading = true;
    notifyListeners();

    try {
      final payload = {
        "authToken": await SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? '',
        "api": Apis.API_KEY,
      };

      final requestData = {
        "path": "/load/account",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(payload),
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, requestData)
          .timeout(const Duration(seconds: 30));

      if (response == null) {
        showAlertDialog(context, "No response received from server");
        return;
      }

      // Parse response data if it's a string
      if (response.data is String) {
        response.data = jsonDecode(response.data);
      }

      if (response.statusCode == successResponseCode) {
        if (response.data['tokenValid'] == true) {
          if (response.data['success'] == true) {
            // Parse the objectJson which contains the actual employee data
            if (response.data['objectJson'] is String) {
              _accountData = jsonDecode(response.data['objectJson'])[0];
            } else if (response.data['objectJson'] is List) {
              _accountData = response.data['objectJson'][0];
            } else {
              _accountData = response.data;
            }
          } else {
            showAlertDialog(context, response.data['message'] ?? "Failed to load account");
          }
        } else {
          _showSessionExpiredDialog(context);
        }
      } else {
        showAlertDialog(context, response.data['message'] ?? "Request failed");
      }
    } catch (e) {
      showAlertDialog(context, "An error occurred: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void _showSessionExpiredDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Session Expired"),
          content: const Text("Your session has expired. Please log in again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
