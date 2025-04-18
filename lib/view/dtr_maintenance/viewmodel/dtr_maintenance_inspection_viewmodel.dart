import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_inspection_sheet_entity.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class DtrMaintenanceInspectionViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  String jsonResponse;

  DtrInspectionSheetEntity? dtrInspectionSheetEntity = null;

  List<OptionList> groups = [];
  List<OptionList> get groupsList => groups;
  OptionList? selectedGroup;

  // Constructor to initialize the items
  DtrMaintenanceInspectionViewmodel({required this.context, required this.jsonResponse}) {
    dtrInspectionSheetEntity = DtrInspectionSheetEntity.fromJson(jsonDecode(jsonResponse));
    loadFilters();
  }

  void loadFilters() {
    List<OptionList> predefinedGroups = [
      OptionList(optionId: "HT_SIDE", optionName: "HT Side"),
      OptionList(optionId: "LT_SIDE", optionName: "LT Side"),
      OptionList(optionId: "OIL", optionName: "Oil"),
      OptionList(optionId: "EARTHING", optionName: "Earthing"),
      OptionList(optionId: "LT_NETWORK", optionName: "LT Network"),
      OptionList(optionId: "LA", optionName: "LA's"),
      OptionList(optionId: "DTR_LOADING", optionName: "DTR Loading"),
      OptionList(optionId: "TONG", optionName: "Tong Tester Readings"),
      OptionList(optionId: "GENERAL", optionName: "General"),
    ];
    groups = predefinedGroups;
    notifyListeners();
  }

  void selectGroup(OptionList group) {
    selectedGroup = group;
    notifyListeners();
  }

}
