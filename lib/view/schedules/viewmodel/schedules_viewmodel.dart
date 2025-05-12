import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/view/schedules/models/ss_and_line_count_model.dart';
import 'package:tsnpdcl_employee/view/schedules/models/ss_data_model.dart';
import 'package:tsnpdcl_employee/view/schedules/view/schedule_line_dialog.dart';
import 'package:tsnpdcl_employee/view/schedules/view/schedule_ss_dialog.dart';

class ScheduleViewModel extends ChangeNotifier {
  ScheduleViewModel({required this.context}) {
    final now = DateTime.now();
    _selectedMonthYear = {
      'month': _getMonthName(now.month),
      'year': now.year,
    };
    fetchScheduledData(context, _selectedMonthYear);
  }
  final BuildContext context;
  Map<String, dynamic>? _selectedMonthYear;

  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;

  String _getMonthName(int month) {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month - 1];
  }

  String getMonthNumeric(Map<String, dynamic>? selectedMonthYear) {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    int monthIndex = monthNames.indexOf(selectedMonthYear?['month']);
    return (monthIndex + 1).toString().padLeft(2, '0'); // Converts index to month number with leading zero
  }

  void setSelectedMonthYear(String month, int year, BuildContext context) {
    _selectedMonthYear = {
      'month': month,
      'year': year,
    };
    fetchScheduledData(context, _selectedMonthYear);
    print("selectedMonthYear: $selectedMonthYear");
    notifyListeners();
  }

  bool _isLoading = false;
  List<DataModel> _fetchedData = [];

  bool get isLoading => _isLoading;

  List<DataModel> get fetchedData => _fetchedData;

  DateTime? selectedDate;

  String getWeekday(String dateString) {
    final parts = dateString.split('/');
    final date = DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
    const weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return weekdays[date.weekday - 1];
  }

  //
  String selectedSS = ''; // Currently selected value
  final List<SsDataModel> ssOptions = [];


List<String> _allDays=[];
List<String> get allDays=>_allDays;
  Future<void> fetchScheduledData(
      BuildContext context, Map<String, dynamic>? dateMonth) async {
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "monthYear": dateMonth != null
    ? '${getMonthNumeric(dateMonth)}${dateMonth['year']}'
        : DateFormat('MM/yyyy').format(DateTime.now())
    };
    try {
      var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL)
          .postApiCall(context, Apis.SCHEDULES_URL, payload);

      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          responseData = jsonDecode(responseData);
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['sessionValid'] == isTrue) {
            if (responseData['taskSuccess'] == isTrue) {
              if (response.data['data'] != null) {
                Map<String, dynamic> jsonMap;
                if (response.data['data'] is String) {
                  jsonMap = jsonDecode(response.data['data']);
                } else if (response.data['data'] is Map<String, dynamic>) {
                  jsonMap = response.data['data'];
                } else {
                  jsonMap = {};
                }
                final List<DataModel> dataList = jsonMap.entries
                    .map((entry) => DataModel.fromJson(entry))
                    .toList();
                _fetchedData = dataList;
                print('${_fetchedData[0].date}');
                _allDays = _fetchedData.map((data) {
                  return data.date.split('/')[0];
                }).toList();
                notifyListeners();
              }
            } else if (responseData['message'] != null) {
              showErrorDialog(context, responseData['message']);
            } else {
              showAlertDialog(
                  context, responseData['message'] ?? "Request failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(
              context,
              responseData['message'] ??
                  "Request failed with status ${response.statusCode}");
        }
      } else {
        showAlertDialog(context, "No response received from server");
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  showChooseOptionPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            // onWillPop: () async {
            //   return viewModel.isLocationGranted;
            // },
            onWillPop: null,
            child:AlertDialog(
          title: Text('Choose Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  // ssInfo(context, "substation");
                  // Navigator.pop(context); // Close current dialog
                  showScheduleSSMaintenceDialog(context, _selectedMonthYear);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.subStation,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text('SUBSTATION MAINTENANCE'),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  showScheduleLineMaintencePopUp(context,_selectedMonthYear);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.poloTracker,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text('LINE MAINTENANCE'),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.clear,
                        size: 30,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text('CANCEL'),
                    ],
                  ),
                ),
              ),
            ],
          ),
            ));
      },
    );
  }
}
