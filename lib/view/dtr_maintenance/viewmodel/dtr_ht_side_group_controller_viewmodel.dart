
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/ht_side_group_model.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/option_spinner.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class DtrHtSideGroupControllerViewmodel extends ChangeNotifier {

  final bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  // AB SWITCH
  AbSwitch? abSwitch = AbSwitch.Available;
  AbSwitchType? abSwitchType;
  Status? abSwitchStatus;
  // damaged spinner
  String? spinnerAbSwitchContactsDamagedValue;
  OptionSpinner? spinnerAbSwitchContactsDamaged;
  String? spinnerAbSwitchPigTailDamagedValue;
  OptionSpinner? spinnerAbSwitchPigTailDamaged;
  String? spinnerAbSwitchNylonBushesDamagedValue;
  OptionSpinner? spinnerAbSwitchNylonBushesDamaged;

  // 11 KV HG FUSE SET
  AbSwitch? kv11HgFuseSet = AbSwitch.Available;
  Status? hgFuseStatus;
  // damaged spinner
  String? spinner11HgFsHornsToReplacedValue;
  OptionSpinner? spinner11HgFsHornsToReplaced;
  String? spinner11HgFsGapNotCorrectValue;
  OptionSpinner? spinner11HgFsGapNotCorrect;
  String? spinner11HgFsPostTypeInsulatorsDamagedValue;
  OptionSpinner? spinner11HgFsPostTypeInsulatorsDamaged;

  // HT BUSHES
  Status? htBushStatus;
  String? spinnerHtBushDamagedQtyValue;
  OptionSpinner? spinnerHtBushDamagedQty;

  // HT BUSH RODS
  Status? htBushRodsStatus;
  String? spinnerHtBushRodsDamagedQtyValue;
  OptionSpinner? spinnerHtBushRodsDamagedQty;

  // Constructor to initialize the items
  DtrHtSideGroupControllerViewmodel() {
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

  void selectAbSwitchStatus(Status? value) {
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

  void selectHgFuseStatus(Status? value) {
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

  void selectHtBushStatus(Status? value) {
    if (value == null) return;
    htBushStatus = value;
    notifyListeners();
  }

  void spinnerHtBushDamagedQtyValueSelected(String? value) {
    spinnerHtBushDamagedQtyValue = value;
    notifyListeners();
  }

  void selectHtBushRodsStatus(Status? value) {
    if (value == null) return;
    htBushRodsStatus = value;
    notifyListeners();
  }

  void spinnerHtBushRodsDamagedQtyValueSelected(String? value) {
    spinnerHtBushRodsDamagedQtyValue = value;
    notifyListeners();
  }

  bool methodToCallOnSubmitDtrHtSideGroupControllerScreen(BuildContext context, bool promptError) {
    if (abSwitch == null) {
      if (promptError) {
        showAlertDialog(context, "Please select AB Switch available or not");
      }
      return false;
    } else if (abSwitch == AbSwitch.Available && abSwitchType == null) {
      if (promptError) {
        showAlertDialog(context, "Please select AB Switch type");
      }
      return false;
    } else if (abSwitch == AbSwitch.Available && abSwitchStatus == null) {
      if (promptError) {
        showAlertDialog(context, "Please select AB Switch status");
      }
      return false;
    } else if (abSwitch == AbSwitch.Available &&
        abSwitchStatus == Status.Damaged &&
        spinnerAbSwitchContactsDamagedValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select AB Switch Contacts Damaged Quantity");
      }
      return false;
    } else if (abSwitch == AbSwitch.Available &&
        abSwitchStatus == Status.Damaged &&
        spinnerAbSwitchPigTailDamagedValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select AB Switch Copper Strips/Copper Pig tail damaged Quantity");
      }
      return false;
    } else if (abSwitch == AbSwitch.Available &&
        abSwitchStatus == Status.Damaged &&
        spinnerAbSwitchNylonBushesDamagedValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select AB Switch Nylon bushes damaged Quantity");
      }
      return false;
    } else if (kv11HgFuseSet == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HG fuse set available or not");
      }
      return false;
    } else if (kv11HgFuseSet == AbSwitch.Available && hgFuseStatus == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HG fuse set status");
      }
      return false;
    } else if (kv11HgFuseSet == AbSwitch.Available &&
        hgFuseStatus == Status.Damaged &&
        spinner11HgFsHornsToReplacedValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HG fuse Horns to be replaced qty");
      }
      return false;
    } else if (kv11HgFuseSet == AbSwitch.Available &&
        hgFuseStatus == Status.Damaged &&
        spinner11HgFsGapNotCorrectValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HG fuse Gap is correct or not");
      }
      return false;
    } else if (kv11HgFuseSet == AbSwitch.Available &&
        hgFuseStatus == Status.Damaged &&
        spinner11HgFsPostTypeInsulatorsDamagedValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HG fuse post type insulators damaged qty");
      }
      return false;
    } else if (htBushStatus == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HT bushes status");
      }
      return false;
    } else if (htBushStatus == Status.Damaged && spinnerHtBushDamagedQtyValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HT bushes damaged quantity");
      }
      return false;
    } else if (htBushRodsStatus == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HT bushes rods status");
      }
      return false;
    } else if (htBushRodsStatus == Status.Damaged && spinnerHtBushRodsDamagedQtyValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HT bush rods damaged quantity");
      }
      return false;
    }
    return true;
  }

  void getData() {
    HtSideGroupModel htSideGroupModel = HtSideGroupModel(
      abSwitchAvailable: abSwitch == AbSwitch.Available ? true : false, // Boolean value from UI
      contactsDamagedQty: 0,
      brassStripsDamagedQty: 0,
      nylonBushDamagedQty: 0,
      hgFuseSet11KvAvailable: kv11HgFuseSet == AbSwitch.Available ? true : false, // Boolean value from UI
      hornsToBeReplacedQty: 0,
      gapIsNotCorrect: false,
      postTypeInsulatorsDamagedQty: 0,
      htBushDamagedQty: 0,
      htBushRodsDamagedQty: 0,
    );

    if (abSwitch == AbSwitch.Available) {
      htSideGroupModel.abSwitchType = abSwitchType;
      htSideGroupModel.abSwitchStatus = abSwitchStatus;

      if (abSwitchStatus == Status.Damaged) {
        htSideGroupModel.contactsDamagedQty = int.tryParse(spinnerAbSwitchContactsDamagedValue!) ?? 0;
        htSideGroupModel.brassStripsDamagedQty = int.tryParse(spinnerAbSwitchPigTailDamagedValue!) ?? 0;
        htSideGroupModel.nylonBushDamagedQty = int.tryParse(spinnerAbSwitchNylonBushesDamagedValue!) ?? 0;
      }
    }

    if (kv11HgFuseSet == AbSwitch.Available) {
      htSideGroupModel.hgFuseSet11KvAvailable = true;
      htSideGroupModel.hgFuseStatus = abSwitchStatus;

      if (hgFuseStatus == Status.Damaged) {
        htSideGroupModel.hornsToBeReplacedQty = int.tryParse(spinner11HgFsHornsToReplacedValue!) ?? 0;
        htSideGroupModel.postTypeInsulatorsDamagedQty = int.tryParse(spinner11HgFsPostTypeInsulatorsDamagedValue!) ?? 0;
        htSideGroupModel.gapIsNotCorrect = spinner11HgFsGapNotCorrectValue!.toLowerCase() == 'yes';
      }
    } else {
      htSideGroupModel.hgFuseSet11KvAvailable = false;
    }

    htSideGroupModel.htBushesStatus = htBushStatus;
    if (htBushStatus == Status.Damaged) {
      htSideGroupModel.htBushDamagedQty = int.tryParse(spinnerHtBushDamagedQtyValue!) ?? 0;
    }

    htSideGroupModel.htBushRodsStatus = htBushRodsStatus;
    if (htBushRodsStatus == Status.Damaged) {
      htSideGroupModel.htBushRodsDamagedQty = int.tryParse(spinnerHtBushRodsDamagedQtyValue!) ?? 0;
    }

    //return htSideGroupModel;
    print(htSideGroupModel.toString());
  }
}
