import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/view/dlist/model/dfilter.dart';
import 'package:tsnpdcl_employee/view/dlist/model/range_dlist.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class DlistFilterViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  Map<String, dynamic> data;
  //String jsonResponse;

  List<DlistEntityRealmList> _dlistEntityRealmList = [];
  List<DlistEntityRealmList> get dlistEntityRealmList => _dlistEntityRealmList;

  List<OptionList> _filteredOptionList = [];
  List<OptionList> get filteredOptionList => _filteredOptionList;

  final TextEditingController fromAmountController = TextEditingController();
  final TextEditingController toAmountController = TextEditingController();

  bool isLiveChecked = false;
  bool isUdcChecked = false;
  bool isBillStopChecked = false;

  // Constructor to initialize the items
  DlistFilterViewmodel({required this.context, required this.data}) {
    fromAmountController.text = "0";
    toAmountController.text = "999999999";
    loadFilters();
  }

  void loadFilters() {
    // Parse the JSON response and update the filters list
    _dlistEntityRealmList = (jsonDecode(data['data']) as List)
        .map((e) => DlistEntityRealmList.fromJson(e))
        .toList();

    for (var a in _dlistEntityRealmList) {
      // before check already added or not
      if (_filteredOptionList.any((element) => element.optionId == a.ctareacd)) {
        continue;
      }
      _filteredOptionList.add(
        OptionList(
          optionId: a.ctareacd,
          optionName: a.areaname,
        ),
      );
      AlertUtils.printValue('DlistFilterViewmodel','${a.areaname}   code: ${a.ctareacd}');
    }

    if (data['filter'] != null && data['filter'].toString().trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(data['filter']);
        if (decoded is Map<String, dynamic>) {
          final dFilter = DFilter.fromJson(decoded);
          fromAmountController.text = dFilter.amountFrom?.toString() ?? '';
          toAmountController.text = dFilter.amountTo?.toString() ?? '';
          isLiveChecked = dFilter.liveSelected;
          isUdcChecked = dFilter.udcSelected;
          isBillStopChecked = dFilter.bsSelected;
        }
      } catch (e) {
        debugPrint("Failed to parse filter: $e");
      }
    }

    notifyListeners();
  }

  void itemClicked(OptionList item) {
    if (fromAmountController.text.isEmpty) {
      showAlertDialog(context, "Please specify DList amount range (From amount)");
      return;
    } else if (toAmountController.text.isEmpty) {
      showAlertDialog(context, "Please specify DList amount range (To amount)");
      return;
    } else if (double.tryParse(fromAmountController.text)! > double.tryParse(toAmountController.text)!) {
      showAlertDialog(context, "From amount can not be greater than To amount");
      return;
    } else if (!isLiveChecked && !isUdcChecked && !isBillStopChecked) {
      showAlertDialog(context, "Please select at least one service type (LIVE/UDC/BILL STOP)");
      return;
    } else {
      final dFilter = DFilter(
        distributionCode: item.optionId!,
        liveSelected: isLiveChecked,
        udcSelected: isUdcChecked,
        bsSelected: isBillStopChecked,
        distributionName: item.optionName!,
        amountFrom: double.parse(fromAmountController.text),
        amountTo: double.parse(toAmountController.text),
      );

      final jsonString = jsonEncode(dFilter);
      Navigator.pop(context, jsonString);
    }
  }
}
