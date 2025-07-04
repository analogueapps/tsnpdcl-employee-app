import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/verify_wrong_category/model/areaWiseAbstract_model.dart';

class RmdServiceInspectionViewmodel extends ChangeNotifier {
  RmdServiceInspectionViewmodel({required this.context}) {
    loadAreaWiseAbstract();
  }
  final BuildContext context;
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;
  final List<FetchAllAbstract> _rmdServiceData = [];

  bool get isLoading => _isLoading;
  List<FetchAllAbstract> get rmdServiceData => _rmdServiceData;

  Future<void> loadAreaWiseAbstract() async {
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
    };

    try {
      final response = await ApiProvider(baseUrl: Apis.RMD_EXCEEDED_INSPECTION_URL)
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

                final List<FetchAllAbstract> dataList = jsonList
                    .map((json) => FetchAllAbstract.fromJson(json))
                    .toList();

                _rmdServiceData.clear();
                _rmdServiceData.addAll(dataList);
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
          showAlertDialog(
              context,
              response.data['message'] ??
                  'Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e, stacktrace) {
      print("Exception in loadAreaWiseAbstract: $e\n$stacktrace"); // Log error
      showErrorDialog(context, "An error occurred. Please try again.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, dynamic>? selectedMonthYear;
  void setSelectedMonthYear(String month, int year, BuildContext context) {
    selectedMonthYear = {
      'month': month,
      'year': year,
    };
    if (selectedMonthYear != null) {
      Navigation.instance
          .navigateTo(Routes.monthRmdExceedService, args: selectedMonthYear);
    }
    print("selectedMonthYear universal: $selectedMonthYear");
    notifyListeners();
  }
}
