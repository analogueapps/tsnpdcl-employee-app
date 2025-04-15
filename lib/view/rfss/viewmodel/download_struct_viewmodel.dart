import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';

class DownloadStructureViewModel extends ChangeNotifier {
  final BuildContext context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SpinnerList> list33kVSsOfCircleItem = [];
  String? list33kVSsOfCircleSelect;

  DownloadStructureViewModel({required this.context}) {
    get33kVSsOfCircle();
  }

  Future<void> get33kVSsOfCircle() async {
    if (_isLoading) return; // Prevent multiple calls
    _isLoading = true;
    notifyListeners();

    // Show dialog safely
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ProcessDialogHelper.showProcessDialog(
          context,
          message: "Loading...",
        );
      }
    });

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? '',
        "api": Apis.API_KEY,
      };

      final payload = {
        "path": "/load/load33kvssOfCircle",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      // Close dialog safely
      if (context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ProcessDialogHelper.closeDialog(context);
        });
      }

      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == true) {
            if (response.data['success'] == true) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                list33kVSsOfCircleItem.clear(); // Clear existing data
                list33kVSsOfCircleItem.addAll(listData);
              } else {
                if (context.mounted) {
                  showAlertDialog(context, response.data['message'] ?? 'No data available');
                }
              }
            } else {
              if (context.mounted) {
                showAlertDialog(context, response.data['message'] ?? 'Operation failed');
              }
            }
          } else {
            if (context.mounted) {
              showSessionExpiredDialog(context);
            }
          }
        } else {
          if (context.mounted) {
            showAlertDialog(context, response.data['message'] ?? 'Request failed with status: ${response.statusCode}');
          }
        }
      } else {
        if (context.mounted) {
          showErrorDialog(context, 'No response from server');
        }
      }
    } catch (e) {
      if (context.mounted) {
        showErrorDialog(context, 'An error occurred: $e');
      }
    } finally {
      _isLoading = false;
      if (context.mounted) {
        notifyListeners();
      }
    }
  }

  void onList33kVSsOfCircleValueChange(String? value) {
    list33kVSsOfCircleSelect = value;
    notifyListeners();
  }
}