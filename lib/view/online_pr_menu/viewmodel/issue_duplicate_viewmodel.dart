import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';


class IssueDuplicateReceiptViewModel extends ChangeNotifier{
  IssueDuplicateReceiptViewModel( {required this.context}){
    init();
  }

  void init(){
    checkAuth();
  }

  final BuildContext context;

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  final TextEditingController uscnoController=TextEditingController();
  final TextEditingController scnoController=TextEditingController();
  final TextEditingController receiptNoController=TextEditingController();

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


// void fetchDuplicateReceipt(BuildContext context) async {
  //
  //   if(uscnoController.text.isEmpty && scnoController.text.isEmpty && receiptNoController.text.isEmpty){
  //     CustomWidgets.snackBar(context,"Enter scno Or uscno Or prno");
  //   }
  //
  //   _isLoading=true;
  //   notifyListeners();
  //
  //   try{
  //     final fetchedData= await _services.fetchDuplicateReceipt(
  //       token:'token',
  //       appId:'appId',
  //       uscno:'uscno',
  //       scno:'scno',
  //       prno:'prno',
  //       deviceId:'deviceId',
  //       fetchFlag:'fetchFlag',
  //     );
  //
  //     final decodedData=jsonDecode(fetchedData.data);
  //
  //     if(decodedData['sessionValid']==true){
  //       if(decodedData['taskSuccess'] == true ||decodedData['taskSuccess'] == false){
  //         CustomWidgets.snackBar(context, '${decodedData['message']}');
  //       }
  //     }
  //
  //   } catch(e){
  //     CustomWidgets.snackBar(context, "Error occurred while fetching the data");
  //   }finally{
  //     _isLoading=false;
  //     notifyListeners();
  //   }
  // }

}