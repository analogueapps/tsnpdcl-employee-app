import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/consumer_details/model/dlist_form_response.dart';

class DlFormViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String dListForm;

  DlistFormResponse? dlistFormResponse;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final formKey = GlobalKey<FormState>();
  final TextEditingController scNoController = TextEditingController();
  final TextEditingController uscNoController = TextEditingController();
  final TextEditingController scNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountDueController = TextEditingController();
  final TextEditingController billAmountController = TextEditingController();
  final TextEditingController billDateController = TextEditingController();
  final TextEditingController discDateController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  DlFormViewModel({required this.context, required this.dListForm}) {
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    final Map<String, dynamic> jsonMap = jsonDecode(dListForm);
    dlistFormResponse = DlistFormResponse.fromJson(jsonMap);
    scNoController.text = dlistFormResponse!.scno!;
    uscNoController.text = dlistFormResponse!.uscno!;
    scNameController.text = dlistFormResponse!.consumerName!;
    categoryController.text = dlistFormResponse!.category!;
    addressController.text = dlistFormResponse!.address!;
    amountDueController.text = dlistFormResponse!.amountDue!;
    billAmountController.text = dlistFormResponse!.billAmount!;
    billDateController.text = dlistFormResponse!.billDate!;
    discDateController.text = dlistFormResponse!.discDate!;
    dueDateController.text = dlistFormResponse!.dueDate!;
    notifyListeners();
    print("st is: ${dlistFormResponse!.db} ");
  }

  Future<void> saveDlist()async{

    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "uscno": uscNoController.text.trim(),
      "amountDue": amountDueController.text.trim(),
      "billAmount": billAmountController.text.trim(),
      "address": addressController.text.trim(),
      "scno": scNoController.text.trim(),
      "discDate": discDateController.text.trim(),
      "dueDate": dueDateController.text.trim(),
      "billDate": billAmountController.text.trim(),
      "category": categoryController.text.trim(),
      "consumerName": scNameController.text.trim(),
      "st":dlistFormResponse!.db //ltService?"LT":"HT"
    };

    final payload = {
      "path": "/saveDlist",
      "apiVersion": "1.1",
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
          if (response.data['tokenValid'] == true) {
            if (response.data['success'] == true) {
              if (response.data['message'] != "") {
                showSuccessDialog(context, response.data['message'], () {
                  Navigator.pop(context);
                });
              }
              } else {
              showAlertDialog(context, "${response.data['message']}Please try again later.");
              }
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response?.data['message']);
        }
    }catch(e){
      throw Exception("Exception Occurred while Authenticating");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

}
