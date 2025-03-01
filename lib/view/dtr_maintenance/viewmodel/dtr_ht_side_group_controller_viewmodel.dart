import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/option_spinner.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/new_sketch_prop_entity.dart';

enum AbSwitch { available, notAvailable }
enum AbSwitchType { vertical, horizontal }
enum AbSwitchStatus { good, damage }

class DtrHtSideGroupControllerViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  // AB SWITCH
  AbSwitch? abSwitch = AbSwitch.available;
  AbSwitchType? abSwitchType;
  AbSwitchStatus? abSwitchStatus;
  // damaged spinner
  String? spinnerAbSwitchContactsDamagedValue;
  OptionSpinner? spinnerAbSwitchContactsDamaged;
  String? spinnerAbSwitchPigTailDamagedValue;
  OptionSpinner? spinnerAbSwitchPigTailDamaged;
  String? spinnerAbSwitchNylonBushesDamagedValue;
  OptionSpinner? spinnerAbSwitchNylonBushesDamaged;

  // 11 KV HG FUSE SET
  AbSwitch? kv11HgFuseSet = AbSwitch.available;
  AbSwitchStatus? hgFuseStatus;
  // damaged spinner
  String? spinner11HgFsHornsToReplacedValue;
  OptionSpinner? spinner11HgFsHornsToReplaced;
  String? spinner11HgFsGapNotCorrectValue;
  OptionSpinner? spinner11HgFsGapNotCorrect;
  String? spinner11HgFsPostTypeInsulatorsDamagedValue;
  OptionSpinner? spinner11HgFsPostTypeInsulatorsDamaged;

  // HT BUSHES
  AbSwitchStatus? htBushStatus;
  String? spinnerHtBushDamagedQtyValue;
  OptionSpinner? spinnerHtBushDamagedQty;

  // HT BUSH RODS
  AbSwitchStatus? htBushRodsStatus;
  String? spinnerHtBushRodsDamagedQtyValue;
  OptionSpinner? spinnerHtBushRodsDamagedQty;

  // Constructor to initialize the items
  DtrHtSideGroupControllerViewmodel({required this.context}) {
    spinnerAbSwitchContactsDamaged = getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinnerAbSwitchPigTailDamaged = getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinnerAbSwitchNylonBushesDamaged = getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinner11HgFsHornsToReplaced = getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinner11HgFsGapNotCorrect = getYesNoSpinner();
    spinner11HgFsPostTypeInsulatorsDamaged = getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinnerHtBushDamagedQty = getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinnerHtBushRodsDamagedQty = getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
  }

  OptionSpinner getYesNoSpinner() {
    List<OptionList> optionList = [];
    optionList.add(OptionList(optionId:"Yes", optionName: "Yes"));
    optionList.add(OptionList(optionId:"No", optionName: "No"));
    return OptionSpinner(optionList);
  }

  OptionSpinner getNumberSpinnerAdapter({required bool includeZero, required int maxValue}) {
    //List<OptionList> optionList = [OptionList(optionId:"-1", optionName:"SELECT")];
    List<OptionList> optionList = [];

    for (int i = includeZero ? 0 : 1; i <= maxValue; i++) {
      optionList.add(OptionList(optionId: i.toString(), optionName: i.toString()));
    }

    return OptionSpinner(optionList);
  }

  void selectAbSwitch(AbSwitch? value) {
    if (value == null) return;
    abSwitch = value;
    notifyListeners();
  }

  void selectAbSwitchType(AbSwitchType? value) {
    if (value == null) return;
    abSwitchType = value;
    notifyListeners();
  }

  void selectAbSwitchStatus(AbSwitchStatus? value) {
    if (value == null) return;
    abSwitchStatus = value;
    notifyListeners();
  }

  void selectKv11HgFuseSet(AbSwitch? value) {
    if (value == null) return;
    kv11HgFuseSet = value;
    notifyListeners();
  }

  void spinnerAbSwitchContactsDamagedValueSelected(String? value) {
    spinnerAbSwitchContactsDamagedValue = value;
    notifyListeners();
  }

  void spinnerAbSwitchPigTailDamagedValueSelected(String? value) {
    spinnerAbSwitchPigTailDamagedValue = value;
    notifyListeners();
  }

  void spinnerAbSwitchNylonBushesDamagedValueSelected(String? value) {
    spinnerAbSwitchNylonBushesDamagedValue = value;
    notifyListeners();
  }

  void selectHgFuseStatus(AbSwitchStatus? value) {
    if (value == null) return;
    hgFuseStatus = value;
    notifyListeners();
  }

  void spinner11HgFsHornsToReplacedValueSelected(String? value) {
    spinner11HgFsHornsToReplacedValue = value;
    notifyListeners();
  }

  void spinner11HgFsGapNotCorrectValueSelected(String? value) {
    spinner11HgFsGapNotCorrectValue = value;
    notifyListeners();
  }

  void spinner11HgFsPostTypeInsulatorsDamagedValueSelected(String? value) {
    spinner11HgFsPostTypeInsulatorsDamagedValue = value;
    notifyListeners();
  }

  void selectHtBushStatus(AbSwitchStatus? value) {
    if (value == null) return;
    htBushStatus = value;
    notifyListeners();
  }

  void spinnerHtBushDamagedQtyValueSelected(String? value) {
    spinnerHtBushDamagedQtyValue = value;
    notifyListeners();
  }

  void selectHtBushRodsStatus(AbSwitchStatus? value) {
    if (value == null) return;
    htBushRodsStatus = value;
    notifyListeners();
  }

  void spinnerHtBushRodsDamagedQtyValueSelected(String? value) {
    spinnerHtBushRodsDamagedQtyValue = value;
    notifyListeners();
  }
}
