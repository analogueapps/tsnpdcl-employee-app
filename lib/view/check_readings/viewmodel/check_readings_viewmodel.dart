import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class CheckReadingViewModel extends ChangeNotifier{
  CheckReadingViewModel({required this.context, required this.bsudcScreen}){
    final now = DateTime.now();
    _selectedMonthYear = {
      'month': _getMonthName(now.month),
      'year': now.year,
    };
    fetchCheckedReading(_selectedMonthYear, bsudcScreen);
  }
  final BuildContext context;
  final String bsudcScreen;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<String, dynamic>? _selectedMonthYear;

  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;

  void setSelectedMonthYear(String month, int year, BuildContext context) {
    _selectedMonthYear = {
      'month': month,
      'year': year,
    };
    fetchCheckedReading(_selectedMonthYear, bsudcScreen);
    print("selectedMonthYear: $selectedMonthYear");
    notifyListeners();
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

  List<dynamic> _failureReports = [];
  List<dynamic> get failureReports => _failureReports;

  Future<void> fetchCheckedReading(  Map<String, dynamic>? dateMonth, String flagBsUdc ) async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      'my': dateMonth != null
          ? '${dateMonth['month']}${dateMonth['year']}'
          : DateFormat('MMMyyyy').format(DateTime.now()),
      'bsudc': flagBsUdc == "" ? "No" : "Yes",
    };

    final payload = {
      "path": "/getCheckReadings",
      "apiVersion": "1.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          responseData = jsonDecode(responseData);
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isTrue) {
            if (responseData['success'] == isTrue) {
            if (responseData['message'] !="" ) {
              showErrorDialog(context, responseData['message']);
              if (responseData['objectJson'] != null) {
                List<dynamic> reportsJson = responseData['objectJson'] is String
                    ? jsonDecode(responseData['objectJson']) as List<dynamic>
                    : responseData['objectJson'] as List<dynamic>;
                print("data recevied: $reportsJson");

                // _failureReports = reportsJson.map((reportJson) {
                //   return FailureReportModel.fromJson(reportJson);
                // }).toList();
                notifyListeners();
              } else {
                _failureReports = []; // Clear list if no data
                notifyListeners();
              }
            }
            } else {
              showAlertDialog(context, responseData['message'] ?? "Request failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, responseData['message'] ?? "Request failed with status ${response.statusCode}");
        }
      } else {
        showAlertDialog(context, "No response received from server");
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred: ${e.toString()}");
    }
  }

  // showConsumerDialog(objectList[0]);
  // void showConsumerDialog(ObjectList objectList) {
  //   showCupertinoDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CupertinoAlertDialog(
  //         title: Text(
  //           "Confirm Services Details",
  //         ),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               SizedBox(
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 8.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       _buildInfoRow("Consumer Name:", objectList.name!),
  //                       _buildInfoRow("Service No:", objectList.scno!),
  //                       _buildInfoRow("Circle Code:", objectList.circle!),
  //                       _buildInfoRow("ERO Code:", objectList.erono!),
  //                       _buildInfoRow("USCNO:", objectList.uscno!),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           CupertinoDialogAction(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //             child: const Text(
  //               'CANCEL',
  //               style: TextStyle(color: CupertinoColors.destructiveRed),
  //             ),
  //           ),
  //           CupertinoDialogAction(
  //             onPressed: () {
  //               // Navigator.of(context).pop(); // Close the dialog
  //               // addServiceToServer(objectList);
  //             },
  //             child: const Text(
  //               "CONFIRM",
  //               style: TextStyle(color: CupertinoColors.activeGreen),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the top
        children: [
          Expanded(
            flex: 2, // Adjust flex for the label
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 25), // Space between label and value
          Expanded(
            flex: 3, // Adjust flex for the value
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
              softWrap: true,
              overflow: TextOverflow.visible, // Ensures wrapping
            ),
          ),
        ],
      ),
    );
  }


}