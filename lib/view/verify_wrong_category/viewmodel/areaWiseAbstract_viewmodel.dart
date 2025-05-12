import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/verify_wrong_category/model/areaWiseAbstract_model.dart';

class AreaWiseAbstractViewModel extends ChangeNotifier{

  AreaWiseAbstractViewModel({required this.context}){
    fetchAllAbstract();
  }
  final BuildContext context;
  TextEditingController searchController=TextEditingController();
  bool _isLoading=false;
  List<FetchAllAbstract> _verifyWrongData=[];

  bool get isLoading=>_isLoading;
  List<FetchAllAbstract> get verifyWrongData=>_verifyWrongData;

  Future<void> fetchAllAbstract() async {
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
    };

    try {
      final response = await ApiProvider(baseUrl: Apis.VERIFY_WRONG_CONFIRM_URL)
          .postApiCall(context, Apis.GET_ALL_ABSTRACT, payload);

      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
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

                final List<FetchAllAbstract> dataList =
                jsonList.map((json) => FetchAllAbstract.fromJson(json)).toList();

                _verifyWrongData.clear();
                _verifyWrongData.addAll(dataList);
                notifyListeners();
              }
            } else {
              showErrorDialog(
                  context, response.data['message'] ?? 'Operation failed');
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message'] ??
              'Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e, stacktrace) {
      print("Exception in fetchAllAbstract: $e\n$stacktrace"); // Log error
      showErrorDialog(context, "An error occurred. Please try again.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}