import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/model/online_collection_model.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class OnlineCollectionViewModel extends ChangeNotifier{

  OnlineCollectionViewModel({required this.context} ){
    checkAuth();
  }

  final BuildContext context;
  BillDetails? _billDetails;
  bool _isLoading=false;
  String? _includeRcAmount="NO";
  String? _includeAcdAmount="NO";
  double? _totalAmount;

  final TextEditingController uscnoController=TextEditingController();
  final TextEditingController scnoController=TextEditingController();
  final TextEditingController amountController=TextEditingController();

  BillDetails? get billDetails => _billDetails;
  bool get isLoading => _isLoading;
  String? get includeRcAmount => _includeRcAmount;
  String? get includeAcdAmount => _includeAcdAmount;
  double? get totalAmount => _totalAmount;


  void setIncludeRcAmount(String? value) {
    _includeRcAmount = value;
  }

  void setIncludeAcdAmount(String? value) {
    _includeAcdAmount = value;
  }



  Future<bool> checkAuth() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "deviceId":await getDeviceId(),
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
    }catch(e){
      throw Exception("Exception Occurred while Authenticating");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
    return false;
  }


  void checkDeviceAuth(context, String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const SizedBox( width: double.infinity,child:const Text("RC Authentication Fail", style: TextStyle(color: Colors.red),)),
          content: Text(msg),
          actions: [
            SizedBox( width: double.infinity,
              child:PrimaryButton(text: "OK", onPressed: () {
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

}