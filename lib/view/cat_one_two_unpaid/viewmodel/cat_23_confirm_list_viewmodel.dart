import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/cat_one_two_unpaid/model/cat_confirm_list_model.dart';

class Cat23ConfirmListViewmodel extends ChangeNotifier {
  Cat23ConfirmListViewmodel({required this.context, required this.args}) {
    print(" args: $args");
    _getCatEntities();
  }

  final BuildContext context;
  final Map<String, dynamic> args;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  final List<CatInspectionModel> _catList = [];
  List<CatInspectionModel> get catList => _catList;

  Future<void> _getCatEntities() async {
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "monthYear": args['monthYear'].toUpperCase(),
      "areCode": args['areaCode'] ?? ""
    };

    try {
      final response = await ApiProvider(baseUrl: Apis.CAT_23_INSPECTION_URL)
          .postApiCall(context, Apis.CAT_CONFIRM_LIST, payload);
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
                final List<CatInspectionModel> dataList = jsonList
                    .map((json) => CatInspectionModel.fromJson(json))
                    .toList();

                _catList.clear();
                _catList.addAll(dataList);
                notifyListeners();
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
      print("Exception in fetchAllAbstract: $e\n$stacktrace"); // Log error
      showErrorDialog(context, "An error occurred. Please try again.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
