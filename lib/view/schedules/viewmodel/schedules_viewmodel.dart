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

  String _getMonthNumeric(Map<String, dynamic> selectedMonthYear) {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    int monthIndex = monthNames.indexOf(selectedMonthYear['month']);
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
    ? '${_getMonthNumeric(dateMonth)}${dateMonth['year']}'
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

  //Line Maintence
  // void showScheduleLineMaintencePopUp(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             titlePadding: EdgeInsets.zero,
  //             title: ClipRRect(
  //               borderRadius: const BorderRadius.only(
  //                 topRight: Radius.circular(20),
  //                 topLeft: Radius.circular(20),
  //               ),
  //               child: Container(
  //                 color: CommonColors.colorPrimary,
  //                 child: const Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 20.0),
  //                   child: Center(
  //                       child: Text(
  //                     'SCHEDULE 11KV LINE MAINTENANCE',
  //                     style: TextStyle(color: Colors.white, fontSize: 12),
  //                   )),
  //                 ),
  //               ),
  //             ),
  //             content: SizedBox(
  //               width: double.maxFinite,
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Expanded(
  //                           flex: 2,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 10.0, horizontal: 10.0),
  //                             child: Text(
  //                               'Select SS',
  //                               style: TextStyle(fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(
  //                           width: 1,
  //                           height: 30,
  //                           color: Colors.grey.shade400,
  //                         ),
  //                         Expanded(
  //                           flex: 2,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 10.0, horizontal: 10.0),
  //                             child: DropdownButton<String>(
  //                               value: selectedSS,
  //                               isExpanded: true,
  //                               underline: SizedBox(),
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.black,
  //                               ),
  //                               items: ssOptions.map((value) {
  //                                 return DropdownMenuItem<String>(
  //                                   value: value.ssName,
  //                                   child: Text(value.ssName!),
  //                                 );
  //                               }).toList(),
  //                               onChanged: (newValue) {
  //                                 // Add any additional logic here
  //                               },
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey.shade400,
  //                       thickness: 1,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Expanded(
  //                           flex: 2,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 10.0, horizontal: 10.0),
  //                             child: Text(
  //                               'SS Code',
  //                               style: TextStyle(fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(
  //                           width: 1,
  //                           height: 30,
  //                           color: Colors.grey.shade400,
  //                         ),
  //                         Expanded(
  //                           flex: 2,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 10.0, horizontal: 10.0),
  //                             child: Text(
  //                               '0003-33KV SS-NAKKALAGUTTA',
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.red),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey.shade400,
  //                       thickness: 1,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Expanded(
  //                           flex: 2,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 10.0, horizontal: 10.0),
  //                             child: Text(
  //                               'SS Name',
  //                               style: TextStyle(fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(
  //                           width: 1,
  //                           height: 30,
  //                           color: Colors.grey.shade400,
  //                         ),
  //                         Expanded(
  //                           flex: 2,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 10.0, horizontal: 10.0),
  //                             child: Text(
  //                               'NAKKALAGUTTA',
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.red),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey.shade400,
  //                       thickness: 1,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Expanded(
  //                           flex: 2,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 10.0, horizontal: 10.0),
  //                             child: Text(
  //                               'Section',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(
  //                           width: 1,
  //                           height: 30,
  //                           color: Colors.grey.shade400,
  //                         ),
  //                         Expanded(
  //                           flex: 2,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 10.0, horizontal: 10.0),
  //                             child: Text(
  //                               'NAKKALAGUTTA',
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.red),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey.shade400,
  //                       thickness: 1,
  //                     ),
  //                     SizedBox(
  //                       height: 11,
  //                     ),
  //                     Text(
  //                       'CHOOSE 11KV FEEDERS',
  //                       style: TextStyle(color: Colors.red),
  //                     ),
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: isFalse, onChanged: (bool? newValue) {}),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text('CIRCLE OFFICE'),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey,
  //                       thickness: 1,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: isFalse, onChanged: (bool? newValue) {}),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text('DIVISION OFFICE'),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey,
  //                       thickness: 1,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: isFalse, onChanged: (bool? newValue) {}),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text('VINAYAKA NAGAR'),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey,
  //                       thickness: 1,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: isFalse, onChanged: (bool? newValue) {}),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text('GOKULNAGAR'),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey,
  //                       thickness: 1,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: isFalse, onChanged: (bool? newValue) {}),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text('POLICEHEADQUARTER'),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey,
  //                       thickness: 1,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: isFalse, onChanged: (bool? newValue) {}),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text('BHAVANI NAGARII'),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey,
  //                       thickness: 1,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: isFalse, onChanged: (bool? newValue) {}),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text('NAKKALAGUTTA'),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.grey,
  //                       thickness: 1,
  //                     ),
  //                     SizedBox(
  //                       height: 11,
  //                     ),
  //                     Text(
  //                       'Select Schedule Date',
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                     ),
  //                     SizedBox(
  //                       height: 21,
  //                     ),
  //                     Row(
  //                       children: [
  //                         InkWell(
  //                           onTap: () async {
  //                             final DateTime today = DateTime.now();
  //                             final DateTime maxDate = today.add(const Duration(
  //                                 days: 30)); // 30 days from today
  //
  //                             final DateTime? picked = await showDatePicker(
  //                               context: context,
  //                               initialDate: DateTime.now(),
  //                               firstDate: today,
  //                               lastDate: maxDate,
  //                             );
  //
  //                             if (picked != null && picked != selectedDate) {
  //                               setState(() {
  //                                 selectedDate = picked;
  //                               });
  //                             }
  //                           },
  //                           child: Row(
  //                             children: [
  //                               const Icon(Icons.calendar_month_outlined),
  //                               const SizedBox(
  //                                 width: doubleTen,
  //                               ),
  //                               Text(
  //                                 selectedDate != null
  //                                     ? DateFormat('dd/MM/yyyy')
  //                                         .format(selectedDate!)
  //                                     : "CHOOSE DATE",
  //                                 style: const TextStyle(
  //                                   color: CommonColors.colorPrimary,
  //                                   fontSize: normalSize,
  //                                   fontWeight: FontWeight.w700,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 21,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: ElevatedButton(
  //                               style: ElevatedButton.styleFrom(
  //                                 backgroundColor: Colors.grey[100],
  //                                 foregroundColor: Colors.black,
  //                               ),
  //                               onPressed: () {
  //                                 Navigator.pop(context);
  //                                 Navigator.pop(context);
  //                               },
  //                               child: Text('CANCEL')),
  //                         ),
  //                         SizedBox(
  //                           width: 5,
  //                         ),
  //                         Expanded(
  //                           child: ElevatedButton(
  //                               style: ElevatedButton.styleFrom(
  //                                 backgroundColor: Colors.green,
  //                                 foregroundColor: Colors.black,
  //                               ),
  //                               onPressed: () {},
  //                               child: Text('OK')),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         });
  //       });
  // }

}
