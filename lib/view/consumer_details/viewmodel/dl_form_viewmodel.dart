import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/consumer_details/model/dlist_form_response.dart';

class DlFormViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String dListForm;

  DlistFormResponse? dlistFormResponse;

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
  }
}
