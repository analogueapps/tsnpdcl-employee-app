import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/ccc/model/open_model.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';


class CccOricbViewmodel extends ChangeNotifier {
  CccOricbViewmodel({required this.context, required this.status}) {
    getCCCTicket(status);
  }

  final BuildContext context;
  final String status;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<CccOpenModel> _openList = [];
  List<CccOpenModel> get openList => _openList;

  Future<bool> getCCCTicket(String status) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "fromDate":"2024-12-01",
      "toDate":DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "status":status
    };
    var response = await ApiProvider(baseUrl: Apis.CCC_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_CCC_TICKETS, payload);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
                if(response.data['message']!=null&&response.data['dataList']==[]) {
                  showSuccessDialog(context, response.data['message'], () {
                    Navigator.pop(context);
                  },);
                }else if (response.data['dataList'] != null) {
                  final dataList = response.data['dataList'];
                  if (dataList is List && dataList.isNotEmpty) {
                    List<CccOpenModel> fetchedList = dataList
                        .map((item) =>
                        CccOpenModel.fromJson(item['cccComplaint']))
                        .toList();

                    _openList.addAll(fetchedList);

                    print("Fetched complaints: ${fetchedList.length}");
                  }
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

  // void responseMsg(context, String msg) async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title:  const SizedBox( width: double.infinity,child:const Text("Empty Folder", style: TextStyle(color:  CommonColors.colorPrimary),)),
  //         content: Text(msg),
  //         actions: [
  //           SizedBox( width: double.infinity,
  //             child:PrimaryButton(text: "OK", onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

}