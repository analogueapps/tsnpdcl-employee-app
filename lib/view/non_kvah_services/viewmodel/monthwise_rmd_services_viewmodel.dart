import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/verify_wrong_category/model/areaWiseAbstract_model.dart';

class MonthWiseRmdServicesViewmodel extends ChangeNotifier {
  MonthWiseRmdServicesViewmodel({required this.context, required this.args}) {
    print(" args: $args");
    _loadAbstractBasedOnMonthYear(args);
  }

  final BuildContext context;
  final Map<String, dynamic> args;

  final DateTime now = DateTime.now();

  Map<String, dynamic>? _selectedMonthYear;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;

  final List<FetchAllAbstract> _inspectService = [];
  List<FetchAllAbstract> get inspectService => _inspectService;

  void setSelectedMonthYear(String month, int year, BuildContext context) {
    _selectedMonthYear = {
      'month': month,
      'year': year,
    };
    _loadAbstractBasedOnMonthYear(_selectedMonthYear);
    print("selectedMonthYear: $selectedMonthYear");
    notifyListeners();
  }

  Future<void> _loadAbstractBasedOnMonthYear(
      Map<String, dynamic>? dateMonth,
      ) async {
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "monthYear": dateMonth != null
          ? '${dateMonth['month'].toUpperCase()}${dateMonth['year']}'
          : DateFormat('MMMyyyy').format(DateTime.now()),
    };

    try {
      final response = await ApiProvider(baseUrl: Apis.NON_KVAH_INSPECTION_BASE_URL)
          .postApiCall(context, Apis.RMD_GET_ABSTRACT, payload);
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

                _inspectService.clear();
                _inspectService.addAll(dataList);
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
      print("Exception in fetchAllAbstract: $e\n$stacktrace"); // Log error
      showErrorDialog(context, "An error occurred. Please try again.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
