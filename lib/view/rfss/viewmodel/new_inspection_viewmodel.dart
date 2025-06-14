import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_structure_index_model.dart';

class NewInspectionViewmodel extends ChangeNotifier{
  NewInspectionViewmodel({ required this.context}){
    getDtrMasterIndex();
  }

 final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<DtrStructureIndexModel> _dtrStructureIndexList = [];
  List<DtrStructureIndexModel> get dtrStructureIndexList => _dtrStructureIndexList;

  Future<void> getDtrMasterIndex() async {
    _dtrStructureIndexList.clear();
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee"
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_DTR_MASTER_INDEX_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
          if (response.data['taskSuccess'] == isTrue) {
            if (response.data['dataList'] != null) {
              List<dynamic> jsonList;

              if (response.data['dataList'] is String) {
                jsonList = jsonDecode(response.data['dataList']);
              } else if (response.data['dataList'] is List) {
                jsonList = response.data['dataList'];
              } else {
                jsonList =
                [];
              }
              final List<DtrStructureIndexModel> dataList = jsonList.map((json) => DtrStructureIndexModel.fromJson(json)).toList();
              _dtrStructureIndexList.addAll(dataList);
              notifyListeners();
            }
          }else {
            showAlertDialog(context,response.data['message']);
          }
          } else {
            showSessionExpiredDialog(context);
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
  }

  Future<void> openDtrDefectSheet(String structCode, String distCode) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "structureCode":structCode,
      "distributionCode":distCode
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.OPEN_DTR_DEFECT_SHEET, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['message'] != null) {
                showSuccessDialog(context, response.data['message'], (){
                  Navigator.pop(context);
                });
              }
            }else {
              showAlertDialog(context,response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
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
  }


}