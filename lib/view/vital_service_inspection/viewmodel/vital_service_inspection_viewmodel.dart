import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class VitalServiceInspectionViewmodel extends ChangeNotifier {
  VitalServiceInspectionViewmodel({required this.context}) {
    _getVitalServices();
  }

  final BuildContext context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> _getVitalServices() async {
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "status":null,
    };

    try {
      final response = await ApiProvider(baseUrl: Apis.VITAL_SERVICE_URL)
          .postApiCall(context, Apis.VITAL_SERVICE_OF_SELECTION, payload);
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }

        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['dataList'].isNotEmpty) {
                List<dynamic> jsonList;

                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];
                }
                //////<- Should work if response is not [] ->//////
              } else {
                showEmptyFolderDialog(context, response.data['message'], () {
                  Navigator.pop(context);
                });
              }
            } else {
              showErrorDialog(
                  context, response.data['message'] ?? 'Operation failed');
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(
              context,
              response.data['message'] ??
                  'Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e, stacktrace) {
      print("Exception in fetchAllAbstract: $e\n$stacktrace");
      showErrorDialog(context, "An error occurred. Please try again.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  //{"token":"D1B2D5CDE6170E68E2EED539E273E302","appId":"in.tsnpdcl.npdclemployee","status":null}
}