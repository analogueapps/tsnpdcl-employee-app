import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import '../../../dialogs/dialog_master.dart';
import '../../../utils/app_constants.dart';
import '../../line_clearance/model/spinner_list.dart';
import '../model/saidi_saifi_model.dart';

class SaidiSaifiCalculatorViewmodel extends ChangeNotifier {
  final sectionCode = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey);
  final circleCode = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.circleIdPrefKey);
  Map<String, dynamic>? _selectedMonthYear;
  String? _selectedSubstation;
  List<SpinnerList> listSubStationItem = [];
  List<Substation> _substations = [];
  List<InterruptionDetails> _interruptionDetails = [];
  bool _isLoading = false;

  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;
  String? get selectedSubstation => _selectedSubstation;
  List<Substation> get substations => _substations;
  List<InterruptionDetails> get interruptionDetails => _interruptionDetails;
  bool get isLoading => _isLoading;

  // Constants
  static const String baseUrl = Apis.INTERRUPTIONS_END_POINT_BASE_URL;
  static const int successResponseCode = 200;

  // Methods
  void setSelectedMonthYear(String month, int year, BuildContext context) async {
    _selectedMonthYear = {'month': month, 'year': year};
    notifyListeners();
    await get33kVSsOfCircle(context); // Pass month and year here
  }

  void setSelectedSubstation(String substation, BuildContext context) async {
    _selectedSubstation = substation;
    notifyListeners();
    await fetchInterruptionDetails(substation, context);
  }

  Future<void> get33kVSsOfCircle(BuildContext context) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "circleCode": circleCode,
      "sectionCode": sectionCode
    };

    final payload = {
      "path": "/load/load33kvssOfCircle",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                listSubStationItem = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                // Populate substations from listSubStationItem
                _substations = listSubStationItem.map((item) => Substation(
                  id: item.optionCode ?? '',
                  name: item.optionName ?? '',
                )).toList();
                notifyListeners(); // Notify after updating the lists
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
  }

  Future<void> fetchInterruptionDetails(String substationId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "substationId": substationId,
    };

    try {
      var response = await ApiProvider(baseUrl: baseUrl).postApiCall(
        context,
        '/getInterruptionDetails',
        payload,
      );

      if (response?.statusCode == successResponseCode) {
        if (response?.data['sessionValid'] == true && response?.data['taskSuccess'] == true) {
          var data = response?.data['dataList'];
          _interruptionDetails = (data is String ? jsonDecode(data) : data)
              .map<InterruptionDetails>((json) => InterruptionDetails.fromJson(json))
              .toList();
        } else {
          _showAlertDialog(context, response?.data['message'] ?? "Task failed");
          _interruptionDetails = [];
        }
      } else {
        _showAlertDialog(context, "Something went wrong");
        _interruptionDetails = [];
      }
    } catch (e) {
      _interruptionDetails = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
// import 'package:tsnpdcl_employee/network/api_provider.dart';
// import 'package:tsnpdcl_employee/network/api_urls.dart';
// import 'package:tsnpdcl_employee/preference/shared_preference.dart';
// import 'package:tsnpdcl_employee/utils/app_helper.dart';
// import '../../../dialogs/dialog_master.dart';
// import '../../../utils/app_constants.dart';
// import '../../line_clearance/model/spinner_list.dart';
// import '../model/saidi_saifi_model.dart';
//
// class SaidiSaifiCalculatorViewmodel extends ChangeNotifier {
//   final sectionCode = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey);
//   final circleCode = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.circleIdPrefKey);
//   Map<String, dynamic>? _selectedMonthYear;
//   String? _selectedSubstation;
//   List<SpinnerList> listSubStationItem = [];
//   List<Substation> _substations = [];
//   List<InterruptionDetails> _interruptionDetails = [];
//   bool _isLoading = false;
//
//   Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;
//   String? get selectedSubstation => _selectedSubstation;
//   List<Substation> get substations => _substations;
//   List<InterruptionDetails> get interruptionDetails => _interruptionDetails;
//   bool get isLoading => _isLoading;
//
//   // Constants
//   static const String baseUrl = Apis.INTERRUPTIONS_END_POINT_BASE_URL;
//   static const int successResponseCode = 200;
//
//   // Methods
//   void setSelectedMonthYear(String month, int year, BuildContext context) async {
//     _selectedMonthYear = {'month': month, 'year': year};
//     notifyListeners();
//     await get33kVSsOfCircle(context); // Pass month and year here
//   }
//
//   void setSelectedSubstation(String substation, BuildContext context) async {
//     _selectedSubstation = substation;
//     notifyListeners();
//     await fetchInterruptionDetails(substation, context);
//   }
//
//   Future<void> get33kVSsOfCircle(BuildContext context) async {
//     ProcessDialogHelper.showProcessDialog(
//       context,
//       message: "Loading...",
//     );
//
//     final requestData = {
//       "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
//       "api": Apis.API_KEY,
//       "circleCode": circleCode,
//       "sectionCode": sectionCode
//     };
//
//     final payload = {
//       "path": "/load/load33kvssOfCircle",
//       "apiVersion": "1.0",
//       "method": "POST",
//       "data": jsonEncode(requestData),
//     };
//
//     var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
//     if (context.mounted) {
//       ProcessDialogHelper.closeDialog(context);
//     }
//
//     try {
//       if (response != null) {
//         if (response.data is String) {
//           response.data = jsonDecode(response.data);
//         }
//         if (response.statusCode == successResponseCode) {
//           if (response.data['tokenValid'] == isTrue) {
//             if (response.data['success'] == isTrue) {
//               if (response.data['objectJson'] != null) {
//                 final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
//                 listSubStationItem = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
//                 // Populate substations from listSubStationItem
//                 _substations = listSubStationItem.map((item) => Substation(
//                   id: item.optionCode ?? '',
//                   name: item.optionName ?? '',
//                 )).toList();
//                 notifyListeners(); // Notify after updating the lists
//               }
//             } else {
//               showAlertDialog(context, response.data['message']);
//             }
//           } else {
//             showSessionExpiredDialog(context);
//           }
//         } else {
//           showAlertDialog(context, response.data['message']);
//         }
//       }
//     } catch (e) {
//       showErrorDialog(context, "An error occurred. Please try again.");
//       rethrow;
//     }
//   }
//
//   Future<void> fetchInterruptionDetails(String substationId, BuildContext context) async {
//     _isLoading = true;
//     notifyListeners();
//
//     final payload = {
//       "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
//       "appId": "in.tsnpdcl.npdclemployee",
//       "substationId": substationId,
//     };
//
//     try {
//       var response = await ApiProvider(baseUrl: baseUrl).postApiCall(
//         context,
//         '/getInterruptionDetails',
//         payload,
//       );
//
//       if (response?.statusCode == successResponseCode) {
//         if (response?.data['sessionValid'] == true && response?.data['taskSuccess'] == true) {
//           var data = response?.data['dataList'];
//           _interruptionDetails = (data is String ? jsonDecode(data) : data)
//               .map<InterruptionDetails>((json) => InterruptionDetails.fromJson(json))
//               .toList();
//         } else {
//           _showAlertDialog(context, response?.data['message'] ?? "Task failed");
//           _interruptionDetails = [];
//         }
//       } else {
//         _showAlertDialog(context, "Something went wrong");
//         _interruptionDetails = [];
//       }
//     } catch (e) {
//       _interruptionDetails = [];
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   void _showAlertDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Alert'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
