import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'dart:convert';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';

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


  List<EroModel> _getEro = [];
  String? _selectedEro;

  List<EroModel> get eroList => _getEro;
  String? get selectedEro => _selectedEro;


  Future<void> getEroList( String selectedCircleId) async {
    ProcessDialogHelper.showProcessDialog(context, message: "Loading...");

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "app": "in.tsnpdcl.npdclemployee",
      "cid": selectedCircleId,
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.CHECK_ROOT_URL)
          .postApiCall(context, Apis.GET_EROS, payload);

      if (context.mounted) ProcessDialogHelper.closeDialog(context);

      if (response != null) {
        dynamic responseData = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        // Fix: handle List as root
        if (responseData is List && responseData.isNotEmpty) {
          responseData = responseData.first;
        }

        if (response.statusCode == successResponseCode &&
            responseData['login'] == true &&
            responseData['success'] == true) {
          if (responseData['objectList'] is List) {
            _getEro = (responseData['objectList'] as List)
                .map((item) => EroModel.fromJson(item))
                .toList();

            if (_getEro.isNotEmpty) {
              _selectedEro = _getEro.first.optionId;
            }

            notifyListeners();
          }
        } else {
          showAlertDialog(
            context,
            responseData['msg'] ?? "Failed to load EROs (Status: ${response.statusCode})",
          );
        }
      }
    } catch (e) {
      print("ERO API Exception: $e");
      if (context.mounted) {
        showAlertDialog(context, "Failed to load EROs: ${e.toString()}");
      }
    }
  }

  void onSelectedERO(String? value) {
    if (value != null && _getEro.any((ero) => ero.optionId == value)) {
      _selectedEro = value;
      notifyListeners();
    } else {
      print('Warning: Selected ERO ($value) not found in list');
    }
  }



  void dispose() {
    scNoController.dispose();
    uscNoController.dispose();
  }
}
