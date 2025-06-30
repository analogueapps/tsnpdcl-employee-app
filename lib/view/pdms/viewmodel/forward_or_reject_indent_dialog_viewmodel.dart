import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';
import 'package:tsnpdcl_employee/view/pdms/model/option.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_request_indent_entity.dart';

class ForwardOrRejectIndentDialogViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final PoleRequestIndentEntity poleRequestIndentEntity;

  final bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  String? selectedCheckboxId;
  bool isSelected(String id) => selectedCheckboxId == id;

  List<SpinnerList> fys = [];
  String? fysSelect;

  // Constructor to initialize the items
  ForwardOrRejectIndentDialogViewModel(
      {required this.context, required this.poleRequestIndentEntity}) {
    getFinancialYear();
  }

  void selectCheckbox(String id) {
    if (selectedCheckboxId == id) {
      selectedCheckboxId = null; // Uncheck if the same checkbox is clicked
    } else {
      selectedCheckboxId = id;
    }
    notifyListeners(); // Notify the view about the change
  }

  void getFinancialYear() {
    int currentYear = DateTime.now().year;

    for (int i = 2020; i <= currentYear; i++) {
      String financialYear = '$i-${i + 1}';
      fys.add(
          SpinnerList(optionCode: financialYear, optionName: financialYear));
    }

    if (true) {
      fys = fys.reversed.toList();
    }

    notifyListeners();
  }

  void onListFysValueChange(String? value) {
    fysSelect = value;
    if (value != null) {
      getPurchaseOrderOfFyAndStores(value);
    }
    notifyListeners();
  }

  void getPurchaseOrderOfFyAndStores(String financialYear) {}
}
