import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class View33kvBreakdownViewmodel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<dynamic> _breakdownList = [];
  List<dynamic> get breakdownList => _breakdownList;

  View33kvBreakdownViewmodel({required BuildContext context}) {
    getBreakDowns(context);
  }

  Future<void> getBreakDowns(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "voltage": "33KV"
    };

    try {
      var response = await ApiProvider(
          baseUrl: Apis.INTERRUPTIONS_END_POINT_BASE_URL)
          .postApiCall(context, Apis.GET_BREAKDOWNS_OF_SECTION, payload);

      if (response != null && response.statusCode == successResponseCode) {
        if (response.data['sessionValid'] == true &&
            response.data['taskSuccess'] == true) {
          var data = response.data['dataList'];
          _breakdownList = data is String ? jsonDecode(data) : data;
        } else {
          showAlertDialog(context, response.data['message'] ?? "Task failed");
        }
      } else {
        showAlertDialog(context, "Something went wrong");
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}