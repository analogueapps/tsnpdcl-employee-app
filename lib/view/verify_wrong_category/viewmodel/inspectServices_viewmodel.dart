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

class InspectServicesViewmodel extends ChangeNotifier {
  InspectServicesViewmodel( {required this.context, required this.args}) {
    print(" args: $args");
    _loadAbstractBasedOnMonthYear(args);
  }

  final BuildContext context;
  final Map<String, dynamic> args;

  final DateTime now = DateTime.now();

  Map<String, dynamic>? _selectedMonthYear;


  bool _isLoading=false;
  bool get isLoading=>_isLoading;



  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;

  List<FetchAllAbstract> _inspectService=[];
  List<FetchAllAbstract> get inspectService=>_inspectService;


  void setSelectedMonthYear(String month, int year, BuildContext context) {
    _selectedMonthYear = {
      'month': month,
      'year': year,
    };
    _loadAbstractBasedOnMonthYear(_selectedMonthYear);
    print("selectedMonthYear: $selectedMonthYear");
    notifyListeners();
  }

  // String _getMonthName(int month) {
  //   const monthNames = [
  //     'Jan',
  //     'Feb',
  //     'Mar',
  //     'Apr',
  //     'May',
  //     'Jun',
  //     'Jul',
  //     'Aug',
  //     'Sep',
  //     'Oct',
  //     'Nov',
  //     'Dec'
  //   ];
  //   return monthNames[month - 1];
  // }

  Future<void> _loadAbstractBasedOnMonthYear(Map<String, dynamic>? dateMonth,) async {
    _isLoading=true;
    notifyListeners();


    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "monthYear":dateMonth != null
          ? '${dateMonth['month']}${dateMonth['year']}'
          : DateFormat('MMMyyyy').format(DateTime.now()),
    };

    try{
      final response = await ApiProvider(baseUrl: Apis.VERIFY_WRONG_CONFIRM_URL)
          .postApiCall(context, Apis.GET_VERIFY_ABSTRACT, payload);
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
          showAlertDialog(context, response.data['message'] ??
              'Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e, stacktrace) {
      print("Exception in fetchAllAbstract: $e\n$stacktrace"); // Log error
      showErrorDialog(context, "An error occurred. Please try again.");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
}

//Future<Response> loadAbstractBasedOnMonthYear({
//     String? token,
//     String? appId,
//     String? monthYear
//   }) async {
//     return await _dio.post(
//       '${AppConstants.serverIp}${AppConstants.baseUrl}/getAbstract',
//       data: {
//         'token':token,
//         'appId':appId,
//         'monthYear':monthYear
//       }
//     );
//   }
//
//