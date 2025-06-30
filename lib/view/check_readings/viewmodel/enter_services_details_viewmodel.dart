import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'dart:convert';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';
import 'package:tsnpdcl_employee/view/check_readings/model/service_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';

class EnterServicesDetailsViewmodel extends ChangeNotifier {
  EnterServicesDetailsViewmodel({required this.context, required this.bs_udc});

  final BuildContext context;
  final bool bs_udc;

  final formKey = GlobalKey<FormState>();
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
    final index =
        _circle.indexWhere((circle) => circle.circleId == _selectedCircle);
    print("Selected Circle: $_selectedCircle, Position: $index");
    getEroList(index.toString());
    notifyListeners();
    notifyListeners();
  }

  List<EroModel> _getEro = [];
  String? _selectedEro;

  List<EroModel> get eroList => _getEro;

  String? get selectedEro => _selectedEro;

  Future<void> getEroList(String selectedCircleId) async {
    ProcessDialogHelper.showProcessDialog(context, message: "Loading...");

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "app": "in.tsnpdcl.npdclemployee",
      "cid": selectedCircleId,
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.CHECK_ROOT_URL)
          .postApiCall(context, Apis.GET_EROS, payload);

      if (context.mounted) ProcessDialogHelper.closeDialog(context);

      if (response != null) {
        dynamic responseData =
            response.data is String ? jsonDecode(response.data) : response.data;

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
            responseData['msg'] ??
                "Failed to load EROs (Status: ${response.statusCode})",
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
      print("_selectedEro: $_selectedEro");
      notifyListeners();
    } else {
      print('Warning: Selected ERO ($value) not found in list');
    }
  }

  //Find service
  Future<void> submitForm(
      String circleId, String ero, String sc, String usc) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      } else {
        confirmServiceData(circleId, ero, sc, usc);
        print("in else block");
      }
    }
  }

  bool validateForm() {
    if (_selectedCircle == "" || _selectedCircle == null) {
      AlertUtils.showSnackBar(context, "Please select Circle", isTrue);
      return false;
    } else if (_selectedEro == "" || _selectedEro == null) {
      AlertUtils.showSnackBar(context, "Please select ERO", isTrue);
      return false;
    } else if (scNoController.text == "" && uscNoController.text == "") {
      AlertUtils.showSnackBar(context, "Please enter SCNO or USCNO ", isTrue);
      return false;
    } else if (uscNoController.text != "" && uscNoController.text.length < 8) {
      AlertUtils.showSnackBar(context, "USCNO should be 8 characters", isTrue);
      return false;
    } else if (uscNoController.text != "" && uscNoController.text.length > 8) {
      AlertUtils.showSnackBar(context, "USCNO should be 8 characters", isTrue);
      return false;
    }
    return true;
  }

  List<ServiceDetailsModel> _confirmService = [];

  List<ServiceDetailsModel> get confirmService => _confirmService;

  Future<void> confirmServiceData(
      String circleId, String ero, String sc, String usc) async {
    ProcessDialogHelper.showProcessDialog(context, message: "Loading...");

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "app": "in.tsnpdcl.npdclemployee",
      "cid": usc.isEmpty ? circleId : "-",
      "ero": usc.isEmpty ? ero : "-",
      "sc": sc.isEmpty ? usc : sc,
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.CHECK_ROOT_URL)
          .postApiCall(context, Apis.VALIDATE_SERVICE, payload);

      if (context.mounted) ProcessDialogHelper.closeDialog(context);

      if (response != null) {
        dynamic responseData =
            response.data is String ? jsonDecode(response.data) : response.data;

        if (responseData is List && responseData.isNotEmpty) {
          responseData = responseData.first;
        }

        if (response.statusCode == successResponseCode &&
            responseData['login'] == true &&
            responseData['success'] == true) {
          if (responseData['objectList'] is List) {
            _confirmService = (responseData['objectList'] as List)
                .map((item) => ServiceDetailsModel.fromJson(item))
                .toList();

            if (_confirmService.isNotEmpty) {
              showConsumerDialog(_confirmService.first);
            }

            notifyListeners();
          }
        } else {
          showAlertDialog(
            context,
            responseData['msg'] ??
                "Failed to load EROs (Status: ${response.statusCode})",
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
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(width: 25), // Space between label and value
          Expanded(
            flex: 3, // Adjust flex for the value
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
              softWrap: true,
              overflow: TextOverflow.visible, // Ensures wrapping
            ),
          ),
        ],
      ),
    );
  }

  void showConsumerDialog(ServiceDetailsModel objectList) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Confirm Services Details",
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow("Consumer Name:", objectList.name),
                        _buildInfoRow("Service No:", objectList.scno),
                        _buildInfoRow("USCNO:", objectList.uscno),
                        _buildInfoRow("Circle Code:", objectList.circle),
                        _buildInfoRow("ERO Code:", objectList.erono),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(color: CupertinoColors.destructiveRed),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                if (bs_udc == true) {
                  Navigator.of(context).pop();
                  String webUrl =
                      "${Apis.CHECK_BS_UDC_WED_URL}bsUdcEntryForm.jsp?scno=${_confirmService.first.uscno}&ero=${selectedEro!}&emp_id=${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.userIdPrefKey)}&sectionId=${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionIdKey)}";
                  Navigation.instance.navigateTo(Routes.webViewScreen, args: {
                    "title": "BS/UDC Inspection",
                    "url": webUrl,
                  });
                } else {
                  Navigator.of(context).pop();
                  String webUrl =
                      "${Apis.CHECK_BS_UDC_WED_URL}checkReadingEntryForm.jsp?scno=${_confirmService.first.uscno}&ero=${selectedEro!}&emp_id=${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.userIdPrefKey)}&sectionId=${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionIdKey)}";
                  Navigation.instance.navigateTo(Routes.webViewScreen, args: {
                    "title": "Check Reading",
                    "url": webUrl,
                  });
                }
              },
              child: const Text(
                "CONFIRM",
                style: TextStyle(color: CupertinoColors.activeGreen),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    scNoController.dispose();
    uscNoController.dispose();
  }
}
