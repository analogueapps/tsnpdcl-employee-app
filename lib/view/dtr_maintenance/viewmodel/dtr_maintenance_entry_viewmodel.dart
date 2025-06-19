
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_inspection_sheet_entity.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class DtrMaintenanceEntryViewmodel extends ChangeNotifier {

   final BuildContext context;
   String jsonResponse;

   DtrInspectionSheetEntity? dtrInspectionSheetEntity = null;

   List<OptionList> groups = [];
   List<OptionList> get groupsList => groups;

   OptionList? selectedGroup;

   // Constructor to initialize the items
   DtrMaintenanceEntryViewmodel({required this.context, required this.jsonResponse}) {
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
     ];
     groups = predefinedGroups;

     selectedGroup = predefinedGroups.firstWhere(
           (group) => group.optionId == "HT_SIDE",
       orElse: () => predefinedGroups.first,
     );
     notifyListeners();
   }

   void selectGroup(OptionList group) {
     selectedGroup = group;
     print("SelectedGroup : ${group.optionId}");
     notifyListeners();
   }


}
