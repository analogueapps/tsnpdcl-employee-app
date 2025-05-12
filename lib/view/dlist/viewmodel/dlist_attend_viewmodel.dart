import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dlist/model/range_dlist.dart';
import 'package:url_launcher/url_launcher.dart';

class DlistAttendViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String data;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  DlistEntityRealmList? dlistEntityRealmList;

  String? selectedCheckboxId;
  bool isSelected(String id) => selectedCheckboxId == id;

  final TextEditingController remarks = TextEditingController();

  final TextEditingController finalReadingKwh = TextEditingController();
  final TextEditingController finalReadingKvah = TextEditingController();
  final TextEditingController disconnectionDate = TextEditingController();
  DateTime? _selectedDate;

  final TextEditingController fullAmount = TextEditingController();
  final TextEditingController prNumber = TextEditingController();
  final TextEditingController prDate = TextEditingController();
  final TextEditingController nbsDate = TextEditingController();
  DateTime? _selectedPrDate;
  DateTime? _selectedNbsDate;

  // Constructor to initialize the items
  DlistAttendViewmodel({required this.context, required this.data}) {
    dlistEntityRealmList = DlistEntityRealmList.fromJson(jsonDecode(data));
  }

  Future<void> driveIconClicked() async {
    final Uri googleMapsUri = Uri.parse('google.navigation:q=${parseLatLngFromString(dlistEntityRealmList!.latLong).latitude},${parseLatLngFromString(dlistEntityRealmList!.latLong).longitude}');

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(
        googleMapsUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      AlertUtils.showSnackBar(context, "Could not launch Google Maps", isTrue);
      throw Exception('Could not launch Google Maps');
    }
  }

  void selectCheckbox(String id) {
    if (selectedCheckboxId == id) {
      selectedCheckboxId = null; // Uncheck if the same checkbox is clicked
    } else {
      selectedCheckboxId = id;
    }
    clearFormData();
    notifyListeners(); // Notify the view about the change
  }

  void clearFormData() {
    finalReadingKwh.clear();
    finalReadingKvah.clear();
    disconnectionDate.clear();
    fullAmount.clear();
    prNumber.clear();
    prDate.clear();
    nbsDate.clear();

    _selectedDate = null;
    _selectedPrDate = null;
    _selectedNbsDate = null;
  }

  Future<void> disconnectionDateClicked() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _selectedDate ?? now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      _selectedDate = picked;
      disconnectionDate.text = DateFormat('dd MM yyyy').format(picked);
      notifyListeners();
    }
  }

  Future<void> prDateClicked() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _selectedPrDate ?? now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      _selectedPrDate = picked;
      prDate.text = DateFormat('dd MM yyyy').format(picked);
      notifyListeners();
    }
  }

  Future<void> nbsDateClicked() async{
    final DateTime now = DateTime.now();
    final DateTime initialDate = _selectedNbsDate ?? now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 2)),
    );

    if (picked != null) {
      _selectedNbsDate = picked;
      nbsDate.text = DateFormat('dd/MM/yyyy').format(picked);
      notifyListeners();
    }
  }

  void submitButtonClicked() {
    if (selectedCheckboxId == null) {
      showAlertDialog(context, "Please select any option\nDisconnected\nOR\nAmount Paid\nOR\nUDC");
    } else if (selectedCheckboxId == "Now Disconnected" && finalReadingKwh.text.isEmpty) {
      showAlertDialog(context, "Please enter the final reading KWH.");
    } else if (selectedCheckboxId == "Now Disconnected" && disconnectionDate.text.isEmpty) {
      showAlertDialog(context, "Please enter the disconnection date.");
    } else if (selectedCheckboxId == "Full Amount Paid" && fullAmount.text.isEmpty) {
      showAlertDialog(context, "Please enter amount paid");
    } else if (selectedCheckboxId == "Full Amount Paid" && prNumber.text.isEmpty) {
      showAlertDialog(context, "Please enter PR No");
    } else if (selectedCheckboxId == "Full Amount Paid" && prDate.text.isEmpty) {
      showAlertDialog(context, "Please enter PR date");
    } else if (selectedCheckboxId == "Part Amount Paid" && nbsDate.text.isEmpty) {
      showAlertDialog(context, "Please enter next installment promised date");
    } else if (selectedCheckboxId == "Part Amount Paid" && fullAmount.text.isEmpty) {
      showAlertDialog(context, "Please enter amount paid");
    } else if (selectedCheckboxId == "Part Amount Paid" && prNumber.text.isEmpty) {
      showAlertDialog(context, "Please enter PR No");
    } else if (selectedCheckboxId == "Part Amount Paid" && prDate.text.isEmpty) {
      showAlertDialog(context, "Please enter PR date");
    } else {
      updateDlistService();
    }

  }

  Future<void> updateDlistService() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Authenticating please wait...",
    );
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "uscno": dlistEntityRealmList!.dluan,
      "erocode": dlistEntityRealmList!.erocode,
      "remarks": remarks.text.trim(),
      "my": dlistEntityRealmList!.dlmonyr,
      "installmentDate": nbsDate.text,
      "dlisttype": selectedCheckboxId == "Full Amount Paid"
          ? "Paid"
          : selectedCheckboxId == "Part Amount Paid"
          ? "Part Paid"
          : selectedCheckboxId == "Court case"
          ? "Courtcase"
          : selectedCheckboxId == "Already UDC"
          ? "Already UDC"
          : selectedCheckboxId == "Now Disconnected"
          ? "Now Disconnected"
          : selectedCheckboxId == "Proposed for BS"
          ? "Proposed for BS"
          : "UNDER Correspondance"
    };

    if(selectedCheckboxId == "Now Disconnected") {
      requestData['frkwh'] = finalReadingKwh.text;
      requestData['frkvah'] = finalReadingKvah.text;
      requestData['discdate'] = disconnectionDate.text;
    }

    if(selectedCheckboxId == "Full Amount Paid" || selectedCheckboxId == "Part Amount Paid") {
      requestData['pr'] = prNumber.text;
      requestData['prdate'] = prDate.text;
      requestData['pramt'] = fullAmount.text;
    }

    final payload = {
      "path": "/updateDlistService",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              showAlertDialog(context, response.data['message']);
              Navigation.instance.navigateToReplacement(Routes.universalDashboardScreen);
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

    notifyListeners();
  }
}


