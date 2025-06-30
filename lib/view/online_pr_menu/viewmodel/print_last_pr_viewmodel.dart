import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class PrintLastPrViewModel extends ChangeNotifier {
  PrintLastPrViewModel({required this.context}) {
    checkAuth();
  }

  final BuildContext context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // void fetchLastPrData(BuildContext context) async {
  //
  //   _isLoading=true;
  //   _loadingMessage="Searching for last PR...";
  //   notifyListeners();
  //
  //   try{
  //
  //     final resonse = await _services.fetchLastPrData(
  //         token:'token',
  //         appId:'appId',
  //         deviceId:'deviceId',
  //         date:'date' // present date month and year -> dd/MM/yyyy
  //     );
  //
  //   } catch (e){
  //     CustomWidgets.snackBar(context, 'Exception Occurred while fetching the data');
  //   } finally{
  //     _isLoading=false;
  //     _loadingMessage="";
  //     notifyListeners();
  //   }
  //
  // }

  void checkDeviceAuth(context, String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const SizedBox(
              width: double.infinity,
              child: Text(
                "RC Authentication Fail",
                style: TextStyle(color: Colors.red),
              )),
          content: Text(msg),
          actions: [
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: "OK",
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> checkAuth() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "deviceId": await getDeviceId(),
    };
    var response = await ApiProvider(baseUrl: Apis.ONLINE_PR_END_POINT_BASE_URL)
        .postApiCall(context, Apis.ISSUE_DUPLICATE_URL, payload);

    try {
      print("load response: $response");
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isFalse) {
              if (response.data['message'] != null) {
                checkDeviceAuth(context, response.data['message']);
                print("checkDeviceAuth");
              }
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      throw Exception("Exception Occurred while Authenticating");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}
