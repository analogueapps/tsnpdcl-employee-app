import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/ccc/model/ccc_dashboard_model.dart';


class CccDashboardViewmodel extends ChangeNotifier {
  CccDashboardViewmodel({required this.context}){
    getAbstract();
  }

  final BuildContext context;

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  final List<CccResponse> _itemsCount = [];
  List<CccResponse> get itemsCount => _itemsCount;

  Future<bool> getAbstract() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
    };
    var response = await ApiProvider(baseUrl: Apis.CCC_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_ABSTRACT, payload);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['dataList'] != null) {
                List<dynamic> jsonList;
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];
                }
                final List<CccResponse> dataList = jsonList.map((json) => CccResponse.fromJson(json)).toList();
                _itemsCount.addAll(dataList);
                print("data added in _itemsCount");
                notifyListeners();
                // if (response.data['message'] != null) {
                //   showSuccessDialog(context, response.data['message'], () {
                //     Navigator.pop(context);
                //   });
                // }
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

}