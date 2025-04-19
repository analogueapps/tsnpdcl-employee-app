import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'dart:convert';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/feeder_model.dart';

class EnterServicesDetailsViewmodel extends ChangeNotifier {
  EnterServicesDetailsViewmodel({required this.context});
  final BuildContext context;

  final TextEditingController scNoController = TextEditingController();
  final TextEditingController uscNoController = TextEditingController();

  String? _selectedCircle = '000';
  String? get selectedCircle => _selectedCircle;

  final List<Circle> _circle = [
    Circle("000", "SELECT"),
    Circle("401", "KHAMMAM"),
    Circle("402", "HANAMKONDA"),
    Circle("407", "WARANGAL"),
    Circle("403", "KARIMNAGAR"),
    Circle("405", "ADILABAD"),
    Circle("404", "NIZAMABAD"),
    Circle("406", "BHADRADRI KOTHAGUDEM"),
    Circle("408", "JANGAON"),
    Circle("409", "BHOOPALAPALLY"),
    Circle("410", "MAHABUBABAD"),
    Circle("411", "JAGITYAL"),
    Circle("412", "PEDDAPALLY"),
    Circle("413", "KAMAREDDY"),
    Circle("414", "NIRMAL"),
    Circle("415", "ASIFABAD"),
    Circle("416", "MANCHERIAL"),
  ];

  List<Circle> get circle => _circle;

  void onListCircleSelected(String? value) {
    _selectedCircle = value ?? '000';
     final index = _circle.indexWhere((circle) => circle.circleId == _selectedCircle);
    print("Selected Circle: $_selectedCircle, Position: $index");
    getEroList(index.toString());
    notifyListeners();
    notifyListeners();
  }


  List<FeederModel> _getEro = [];
  String? selectedEro;
  List<FeederModel> get eroList => _getEro;


  Future<void> getEroList(String selectedCircleId) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "app": "in.tsnpdcl.npdclemployee",
      "cid": "$selectedCircleId",
    };

      var response = await ApiProvider(baseUrl: Apis.CHECK_ROOT_URL)
          .postApiCall(context, Apis.GET_EROS, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        // Handle response parsing
        dynamic responseData;
        if (response.data is String) {
          responseData = jsonDecode(response.data);
        } else {
          responseData = response.data;
        }

        if (response.statusCode == successResponseCode &&
            responseData['login'] == true &&
            responseData['success'] == true) {
          List<dynamic> jsonList = [];
          if (responseData['objectList'] is String) {
            jsonList = jsonDecode(responseData['objectList']);
          } else if (responseData['objectList'] is List) {
            jsonList = responseData['objectList'];
          }

          _getEro = jsonList.map((json) => FeederModel.fromJson(json)).toList();
            notifyListeners();
          notifyListeners();
        } else {
          showAlertDialog(
              context,
              responseData['message'] ?? "API returned status ${response.statusCode}"
          );
        }
      }
    } catch (e) {
      print("Feeder API Exception: $e");
    }
  }


  void onSelectedERO(String? value) {
    selectedEro = value;
    print("selected ERO is $selectedEro");
  }

  // Future<void> validateService() async {
  //   const String apiUrl = "api/validateService";
  //   final Map<String, String> requestBody = {
  //     "token": "",
  //     "cid": selectedCircle ?? "",
  //     "app": "",
  //     "ero": selectedEro ?? "",
  //     "sc": scNoController.text.isNotEmpty ? scNoController.text : uscNoController.text,
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(requestBody),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Handle successful response
  //       print("Service validated successfully: ${response.body}");
  //     } else {
  //       // Handle error response
  //       print("Failed to validate service: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     // Handle network or other errors
  //     print("Error validating service: $e");
  //   }
  // }

  void dispose() {
    scNoController.dispose();
    uscNoController.dispose();
  }
}
