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
import 'package:tsnpdcl_employee/view/category_pending_allotment/model/category_change_request_model.dart';
class CategoryChangeRequestsViewmodel extends ChangeNotifier {
   CategoryChangeRequestsViewmodel({required this.context, required this.data}){
     getCatChangeRequests(data['status']);
   }

   final BuildContext context;
   final Map<String, dynamic> data;

   bool _isLoading = isFalse;
   bool get isLoading => _isLoading;

   final List<CategoryChangeRequestModel> _openList = [];
   List<CategoryChangeRequestModel> get openList => _openList;

   Future<bool> getCatChangeRequests( String status) async {
     _openList.clear();
     _isLoading = isTrue;
     notifyListeners();

     final payload = {
       "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
       "appId": "in.tsnpdcl.npdclemployee",
       "status":status
     };
     var response = await ApiProvider(baseUrl: Apis.CAT_CHANGE_ENDPOINT_URL)
         .postApiCall(context, Apis.CAT_CHANGE_REQUESTS_OF_SECTION, payload);

     try {
       if (response != null) {
         if (response.data is String) {
           response.data = jsonDecode(response.data);
         }
         if (response.statusCode == successResponseCode) {
           if (response.data['sessionValid'] == isTrue) {
             if (response.data['taskSuccess'] == isTrue) {
               final dataList = response.data['dataList'];
               if (dataList is List && dataList.isEmpty) {
                 await showSuccessDialog(
                   context,
                   response.data['message'],
                       () {
                     Navigator.pop(context);
                   },
                 );
               } else if (response.data['dataList'] != null) {
                 List<dynamic> jsonList;
                 if (response.data['dataList'] is String) {
                   jsonList = jsonDecode(response.data['dataList']);
                 } else if (response.data['dataList'] is List) {
                   jsonList = response.data['dataList'];
                 } else {
                   jsonList = [];
                 }
                 final List<CategoryChangeRequestModel> dataList = jsonList.map((json) => CategoryChangeRequestModel.fromJson(json)).toList();
                 _openList.addAll(dataList);
                 print("Fetched complaints: ${dataList.length}");
                 notifyListeners();
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
       showAlertDialog(context, e.toString());
       throw Exception("Exception Occurred while Authenticating");
     }finally{
       _isLoading=false;
       notifyListeners();
     }
     return false;
   }

}
