import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_inspection_sheet_entity.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/ht_side_group_model.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/option_spinner.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class DtrHtMaintenanceEntryViewmodel extends ChangeNotifier {
  String data;

  final bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  DtrInspectionSheetEntity? dtrInspectionSheetEntity;

  // AB SWITCH
  AbSwitch? abSwitch;
  bool isAbSwitchDisabled = false;
  AbSwitchType? abSwitchType;
  bool isAbSwitchTypeDisabled = false;
  Status? abSwitchStatus;
  bool isAbSwitchStatusDisabled = false;

  // damaged spinner
  String? spinnerAbSwitchContactsDamagedValue;
  OptionSpinner? spinnerAbSwitchContactsDamaged;
  String? spinnerAbSwitchPigTailDamagedValue;
  OptionSpinner? spinnerAbSwitchPigTailDamaged;
  String? spinnerAbSwitchNylonBushesDamagedValue;
  OptionSpinner? spinnerAbSwitchNylonBushesDamaged;

  // 11 KV HG FUSE SET
  AbSwitch? kv11HgFuseSet = AbSwitch.Available;
  bool isKv11HgFuseSetDisabled = false;

  Status? hgFuseStatus;
  bool isHgFuseStatusDisabled = false;

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

  //LT Bushes

  //lt bushes status
  Status? ltBushStatus;
  bool isLtBushStatusDisabled = false;

  void selectLtBushStatus(Status? value) {
    if (value == null) return;
    ltBushStatus = value;
    notifyListeners();
  }

  //lt bushes rods
  Status? ltBushRodStatus;
  bool isLtBushRodStatusDisabled = false;

  void selectLtRodBushStatus(Status? value) {
    if (value == null) return;
    ltBushRodStatus = value;
    notifyListeners();
  }

  //lt-bi metalic clamps
  AbSwitch? ltBiMetalicClamps;
  bool isLtBiMetalicClampsDisabled = false;

  void selectLtBiMetalicClamps(AbSwitch? value) {
    if (value == null) return;
    ltBiMetalicClamps = value;
    notifyListeners();
  }

  //clamps status
  Status? clampsStatus;
  bool isClampsStatusDisabled = false;

  void selectClampsStatus(Status? value) {
    if (value == null) return;
    clampsStatus = value;
    notifyListeners();
  }

  //Lt breaker
  AbSwitch? ltBreaker;
  bool isLtBreakerDisabled = false;

  void selectLtBreaker(AbSwitch? value) {
    if (value == null) return;
    ltBreaker = value;
    notifyListeners();
  }

  //lt breaker status
  Status? ltBreakerStatus;
  bool isLtBreakerStatusDisabled = false;

  void selectLtBreakerStatus(Status? value) {
    if (value == null) return;
    ltBreakerStatus = value;
    notifyListeners();
  }

  //lt fuse set
  AbSwitch? ltFuseSet;
  bool isLtFuseSetDisabled = false;

  void selectLtFuseSet(AbSwitch? value) {
    if (value == null) return;
    ltFuseSet = value;
    notifyListeners();
  }

  //lt fuse set status
  Status? ltFuseSetStatus;
  bool isLtFuseSetStatusDisabled = false;

  void selectLtFuseSetStatus(Status? value) {
    if (value == null) return;
    ltFuseSetStatus = value;
    notifyListeners();
  }

  //lt fuse wire
  FuseWire? ltFuseWire;
  bool isLtFuseWireDisabled = false;

  void selectLtFuseWireStatus(FuseWire? value) {
    if (value == null) return;
    ltFuseWire = value;
    notifyListeners();
  }

  //Copper fuse wire status
  WireStatus? cfwStatus;
  bool isCfwStatusDisabled = false;

  void selectCfwStatus(WireStatus? value) {
    if (value == null) return;
    cfwStatus = value;
    notifyListeners();
  }

  //LT PVC Cable
  AbSwitch? ltPvcCable;
  bool isLtPvcCableDisabled = false;

  void selectLtPvcCable(AbSwitch? value) {
    if (value == null) return;
    ltPvcCable = value;
    notifyListeners();
  }

  //Lt pvc cable status
  Status? ltPvcCableStatus;
  bool isLtPvcCableStatusDisabled = false;

  void selectLtPvcCableStatus(Status? value) {
    if (value == null) return;
    ltPvcCableStatus = value;
    notifyListeners();
  }

  //OIL
  OilLevel? oilLevelValue;
  bool isOilLevelDisabled = false;

  void selectOilLevelStatus(OilLevel? value) {
    if (value == null) return;
    oilLevelValue = value;
    notifyListeners();
  }

  //Oil Leakage
  OilLeak? oilLeakValue;
  bool isOilLeakDisabled = false;

  void selectOilLeakStatus(OilLeak? value) {
    if (value == null) return;
    oilLeakValue = value;
    notifyListeners();
  }

  Gaskets? gasketsValue;
  bool isGasketsDisabled = false;

  void selectGasketsStatus(Gaskets? value) {
    if (value == null) return;
    gasketsValue = value;
    notifyListeners();
  }

  Gaskets? diaphragm;
  bool isDiaphragmDisabled = false;

  void selectDiaphragm(Gaskets? value) {
    if (value == null) return;
    diaphragm = value;
    notifyListeners();
  }

  Status? diaphragmStatus;
  bool isDiaphragmStatusDisabled = false;

  void selectDiaphragmStatus(Status? value) {
    if (value == null) return;
    diaphragmStatus = value;
    notifyListeners();
  }

  //Earthing
  //Earth Pits
  EarthPits? earthPits;
  bool isEarthPitsDisabled = false;

  void selectEarthPitsStatus(EarthPits? value) {
    if (value == null) return;
    earthPits = value;
    notifyListeners();
  }

  //Earth PIpe Status
  Gaskets? earthPipeStatus;
  bool isEarthPipeStatusDisabled = false;

  void selectEarthPipeStatusStatus(Gaskets? value) {
    if (value == null) return;
    earthPipeStatus = value;
    notifyListeners();
  }

  //Earthing
  Gaskets? earthing;
  bool isEarthingDisabled = false;

  void selectEarthingStatus(Gaskets? value) {
    if (value == null) return;
    earthing = value;
    notifyListeners();
  }

  //Double earthing
  AbSwitch? doubleEarthing;
  bool isDoubleEarthingDisabled = false;

  void selectDoubleEarthingStatus(AbSwitch? value) {
    if (value == null) return;
    doubleEarthing = value;
    notifyListeners();
  }

  //earth Pipes
  EarthPipes? earthPips;
  bool isEarthPipsDisabled = false;

  void selectEarthPipsStatus(EarthPipes? value) {
    if (value == null) return;
    earthPips = value;
    notifyListeners();
  }

  //LT- Network
  //Loose Lines on DTR
  NoLooseLine? looseLinesONDtr;
  bool isLooseLinesONDtrDisabled = false;

  void selectLooseLinesONDtrStatus(NoLooseLine? value) {
    if (value == null) return;
    looseLinesONDtr = value;
    notifyListeners();
  }

  //Line Tree Cutting
  LTLineTreeCutting? linesTreeCutting;
  bool isLinesTreeCuttingDisabled = false;

  void selectLinesTreeCuttingStatus(LTLineTreeCutting? value) {
    if (value == null) return;
    linesTreeCutting = value;
    notifyListeners();
  }

  //Line other rectifications
  Gaskets? lineOtherRect;
  bool isLineOtherRectDisabled = false;

  void selectLineOtherRectStatus(Gaskets? value) {
    if (value == null) return;
    lineOtherRect = value;
    notifyListeners();
  }

  //LA

  //Lighting Arrestors
  AbSwitch? lightingArrestors;
  bool isLightingArrestorsDisabled = false;

  void selectLightingArrestorsStatus(AbSwitch? value) {
    if (value == null) return;
    lightingArrestors = value;
    notifyListeners();
  }

  //Lighting Arrestor Status
  Gaskets? lightingArrStatus;
  bool isLightingArrStatusDisabled = false;

  void selectLightingArrStatus(Gaskets? value) {
    if (value == null) return;
    lightingArrStatus = value;
    notifyListeners();
  }

  //DTR Loading
  DTROverLoaded? dtrOverLoaded;
  bool isDtrOverLoadedDisabled = false;

  void selectDtrOverLoadedStatus(DTROverLoaded? value) {
    if (value == null) return;
    dtrOverLoaded = value;
    notifyListeners();
  }

  //Toong Tester
  TextEditingController rPhase = TextEditingController();
  TextEditingController yPhase = TextEditingController();
  TextEditingController bPhase = TextEditingController();
  TextEditingController neutral = TextEditingController();

  // Constructor to initialize the items
  DtrHtMaintenanceEntryViewmodel(this.data) {
    dtrInspectionSheetEntity =
        DtrInspectionSheetEntity.fromJson(jsonDecode(data));
    spinnerAbSwitchContactsDamaged =
        getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinnerAbSwitchPigTailDamaged =
        getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinnerAbSwitchNylonBushesDamaged =
        getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinner11HgFsHornsToReplaced =
        getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinner11HgFsGapNotCorrect = getYesNoSpinner();
    spinner11HgFsPostTypeInsulatorsDamaged =
        getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinnerHtBushDamagedQty =
        getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    spinnerHtBushRodsDamagedQty =
        getNumberSpinnerAdapter(includeZero: true, maxValue: 3);
    setData();
  }
  void setData() {
    print("Setting Data");
    abSwitch = dtrInspectionSheetEntity!.abSwitchAvailable == "Y"
        ? AbSwitch.Available
        : AbSwitch.NotAvailable;
    isAbSwitchDisabled = true;
    abSwitchType = dtrInspectionSheetEntity?.abSwitchType == "VERTICAL"
        ? AbSwitchType.Vertical
        : AbSwitchType.Horizontal;
    isAbSwitchTypeDisabled = true;
    abSwitchStatus = dtrInspectionSheetEntity?.abSwitchStatus == "GOOD"
        ? Status.Good
        : Status.Damaged;
    isAbSwitchStatusDisabled = true;
    kv11HgFuseSet = dtrInspectionSheetEntity?.hG11KvFuseSetAvailable == "Y"
        ? AbSwitch.Available
        : AbSwitch.NotAvailable;
    isKv11HgFuseSetDisabled = true;
    hgFuseStatus = dtrInspectionSheetEntity?.hG11KvFuseSetAvailable == "Y"
        ? Status.Good
        : Status.Damaged;
    isHgFuseStatusDisabled = true;
    //LT SIDE:
    ltBushStatus = dtrInspectionSheetEntity?.ltBushesDamageCount == 0
        ? Status.Good
        : Status.Damaged;
    isLtBushStatusDisabled = true;
    ltBushRodStatus = dtrInspectionSheetEntity?.ltBushRodsDamCount == 0
        ? Status.Good
        : Status.Damaged;
    isLtBushRodStatusDisabled = true;
    ltBiMetalicClamps =
        dtrInspectionSheetEntity?.ltBiMetalClampsAvailable == "Y"
            ? AbSwitch.Available
            : AbSwitch.NotAvailable;
    isLtBiMetalicClampsDisabled = true;
    clampsStatus = dtrInspectionSheetEntity?.ltBiMetalClampsDamCount == 0
        ? Status.Good
        : Status.Damaged;
    isClampsStatusDisabled = true;
    ltBreaker = dtrInspectionSheetEntity?.ltBreaker == "y"
        ? AbSwitch.Available
        : AbSwitch.NotAvailable;
    isLtBreakerDisabled = true;
    ltBreakerStatus = dtrInspectionSheetEntity?.ltBreakerStatus == "GOOD"
        ? Status.Good
        : Status.Damaged;
    isLtBreakerStatusDisabled = true;
    ltFuseSet = dtrInspectionSheetEntity?.ltFuseSetAvailable == "Y"
        ? AbSwitch.Available
        : AbSwitch.NotAvailable;
    isLtFuseSetDisabled = true;
    ltFuseSetStatus = dtrInspectionSheetEntity?.ltFuseSetStatus == "GOOD"
        ? Status.Good
        : Status.Damaged;
    isLtFuseSetStatusDisabled = true;
    ltFuseWire = dtrInspectionSheetEntity?.ltFuseWire == "COPPER_OK"
        ? FuseWire.Copper
        : FuseWire.Aluminium;
    isLtFuseWireDisabled = true;
    // cfwStatus=dtrInspectionSheetEntity?.ltFuseWire.contains("OK")?WireStatus.OK: WireStatus.NotOK;
    // isCfwStatusDisabled=true;
    ltPvcCable = dtrInspectionSheetEntity?.ltPvcCable == "Y"
        ? AbSwitch.Available
        : AbSwitch.NotAvailable;
    isLtPvcCableDisabled = true;
    ltPvcCableStatus = dtrInspectionSheetEntity?.ltPvcCableStatus == "GOOD"
        ? Status.Good
        : Status.Damaged;
    isLtPvcCableStatusDisabled = true;
    ltFuseSetStatus = dtrInspectionSheetEntity?.ltFuseSetStatus == "GOOD"
        ? Status.Good
        : Status.Damaged;
    isLtFuseSetStatusDisabled = true;

    //OIl
    oilLevelValue = dtrInspectionSheetEntity?.oilShortageInLiters == 0
        ? OilLevel.Ok
        : OilLevel.Shortage;
    isOilLevelDisabled = true;

    //Earthing
    earthPits = dtrInspectionSheetEntity?.earthPits == 2
        ? EarthPits.two
        : dtrInspectionSheetEntity?.earthPits == 1
            ? EarthPits.one
            : dtrInspectionSheetEntity?.earthPits == 3
                ? EarthPits.three
                : null;
    isEarthPitsDisabled = true;
    earthPips = dtrInspectionSheetEntity!.earthPipes.contains("GI")
        ? EarthPipes.GIPipes
        : dtrInspectionSheetEntity!.earthPipes.contains("CI")
            ? EarthPipes.CIPipes
            : null;
    isEarthPipsDisabled = true;
    doubleEarthing = dtrInspectionSheetEntity?.doubleEarthing == "Y"
        ? AbSwitch.Available
        : dtrInspectionSheetEntity?.doubleEarthing == "N"
            ? AbSwitch.NotAvailable
            : null;
    isDoubleEarthingDisabled = true;

    //LT Network
    looseLinesONDtr = dtrInspectionSheetEntity?.noOfLooseLinesOnDtr == 0
        ? NoLooseLine.NoLooseLines
        : dtrInspectionSheetEntity?.noOfLooseLinesOnDtr != "0"
            ? NoLooseLine.LooseLines
            : null;
    isLooseLinesONDtrDisabled = true;
    linesTreeCutting = dtrInspectionSheetEntity?.treeCuttingRequired == 0
        ? LTLineTreeCutting.NotRequired
        : dtrInspectionSheetEntity?.treeCuttingRequired != 0
            ? LTLineTreeCutting.Required
            : null;
    isLinesTreeCuttingDisabled = true;

    doubleEarthing = dtrInspectionSheetEntity?.doubleEarthing == "Y"
        ? AbSwitch.Available
        : dtrInspectionSheetEntity?.doubleEarthing == "N"
            ? AbSwitch.NotAvailable
            : null;
    isLineOtherRectDisabled = true;

    //LA
    lightingArrestors = dtrInspectionSheetEntity?.lightningArrestors == "Good"
        ? AbSwitch.Available
        : dtrInspectionSheetEntity?.lightningArrestors == "BAD"
            ? AbSwitch.NotAvailable
            : null;
    isLightingArrestorsDisabled = true;

    //DTR loading
    dtrOverLoaded = dtrInspectionSheetEntity?.dtrAglLoadHp == 0.0
        ? DTROverLoaded.NotOverLoaded
        : dtrInspectionSheetEntity?.dtrAglLoadHp != 0.0
            ? DTROverLoaded.OverLoaded
            : null;
    isDtrOverLoadedDisabled = true;

    notifyListeners();
  }

  OptionSpinner getYesNoSpinner() {
    List<OptionList> optionList = [];
    optionList.add(OptionList(optionId: "Yes", optionName: "Yes"));
    optionList.add(OptionList(optionId: "No", optionName: "No"));
    return OptionSpinner(optionList);
  }

  OptionSpinner getNumberSpinnerAdapter(
      {required bool includeZero, required int maxValue}) {
    //List<OptionList> optionList = [OptionList(optionId:"-1", optionName:"SELECT")];
    List<OptionList> optionList = [];

    for (int i = includeZero ? 0 : 1; i <= maxValue; i++) {
      optionList
          .add(OptionList(optionId: i.toString(), optionName: i.toString()));
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

  bool methodToCallOnSubmitDtrHtSideGroupControllerScreen(
      BuildContext context, bool promptError) {
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
        showAlertDialog(
            context, "Please select AB Switch Contacts Damaged Quantity");
      }
      return false;
    } else if (abSwitch == AbSwitch.Available &&
        abSwitchStatus == Status.Damaged &&
        spinnerAbSwitchPigTailDamagedValue == null) {
      if (promptError) {
        showAlertDialog(context,
            "Please select AB Switch Copper Strips/Copper Pig tail damaged Quantity");
      }
      return false;
    } else if (abSwitch == AbSwitch.Available &&
        abSwitchStatus == Status.Damaged &&
        spinnerAbSwitchNylonBushesDamagedValue == null) {
      if (promptError) {
        showAlertDialog(
            context, "Please select AB Switch Nylon bushes damaged Quantity");
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
        showAlertDialog(
            context, "Please select HG fuse Horns to be replaced qty");
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
        showAlertDialog(
            context, "Please select HG fuse post type insulators damaged qty");
      }
      return false;
    } else if (htBushStatus == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HT bushes status");
      }
      return false;
    } else if (htBushStatus == Status.Damaged &&
        spinnerHtBushDamagedQtyValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HT bushes damaged quantity");
      }
      return false;
    } else if (htBushRodsStatus == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HT bushes rods status");
      }
      return false;
    } else if (htBushRodsStatus == Status.Damaged &&
        spinnerHtBushRodsDamagedQtyValue == null) {
      if (promptError) {
        showAlertDialog(context, "Please select HT bush rods damaged quantity");
      }
      return false;
    }
    return true;
  }

  void getData() {
    HtSideGroupModel htSideGroupModel = HtSideGroupModel(
      abSwitchAvailable: abSwitch == AbSwitch.Available
          ? true
          : false, // Boolean value from UI
      contactsDamagedQty: 0,
      brassStripsDamagedQty: 0,
      nylonBushDamagedQty: 0,
      hgFuseSet11KvAvailable: kv11HgFuseSet == AbSwitch.Available
          ? true
          : false, // Boolean value from UI
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
        htSideGroupModel.contactsDamagedQty =
            int.tryParse(spinnerAbSwitchContactsDamagedValue!) ?? 0;
        htSideGroupModel.brassStripsDamagedQty =
            int.tryParse(spinnerAbSwitchPigTailDamagedValue!) ?? 0;
        htSideGroupModel.nylonBushDamagedQty =
            int.tryParse(spinnerAbSwitchNylonBushesDamagedValue!) ?? 0;
      }
    }

    if (kv11HgFuseSet == AbSwitch.Available) {
      htSideGroupModel.hgFuseSet11KvAvailable = true;
      htSideGroupModel.hgFuseStatus = abSwitchStatus;

      if (hgFuseStatus == Status.Damaged) {
        htSideGroupModel.hornsToBeReplacedQty =
            int.tryParse(spinner11HgFsHornsToReplacedValue!) ?? 0;
        htSideGroupModel.postTypeInsulatorsDamagedQty =
            int.tryParse(spinner11HgFsPostTypeInsulatorsDamagedValue!) ?? 0;
        htSideGroupModel.gapIsNotCorrect =
            spinner11HgFsGapNotCorrectValue!.toLowerCase() == 'yes';
      }
    } else {
      htSideGroupModel.hgFuseSet11KvAvailable = false;
    }

    htSideGroupModel.htBushesStatus = htBushStatus;
    if (htBushStatus == Status.Damaged) {
      htSideGroupModel.htBushDamagedQty =
          int.tryParse(spinnerHtBushDamagedQtyValue!) ?? 0;
    }

    htSideGroupModel.htBushRodsStatus = htBushRodsStatus;
    if (htBushRodsStatus == Status.Damaged) {
      htSideGroupModel.htBushRodsDamagedQty =
          int.tryParse(spinnerHtBushRodsDamagedQtyValue!) ?? 0;
    }

    //return htSideGroupModel;
    print(htSideGroupModel.toString());
  }

  Map<String, bool Function()> get maintenanceCheckMap => {
        "HT_SIDE": htIsMaintenanceRequired,
        // "LT_SIDE": ltIsMaintenanceRequired,
        // "OIL": oilMaintenanceRequired,
        // "EARTHING":earthMaintenanceRequired,
        // "LT_NETWORK": ltnMaintenanceRequired,
        // "LA": laMaintenanceRequired,
        // "DTR_LOADING": dtrMaintenanceRequired,
        // "TONG": () => false,
      };

  bool htIsMaintenanceRequired() {
    return abSwitch != null &&
        abSwitchType != null &&
        abSwitchStatus != null &&
        kv11HgFuseSet != null &&
        hgFuseStatus != null;
  }

// bool ltIsMaintenanceRequired(){
//   return dtrInspectionSheetEntity?.ltBushesDamageCount>0 || dtrInspectionSheetEntity?.ltBushRodsDamCount>0 || dtrInspectionSheetEntity?.ltBiMetalClampsDamCount>0 ||
//       (dtrInspectionSheetEntity?.ltBreakerStatus!="DAMAGED") || (dtrInspectionSheetEntity?.ltFuseSetStatus!="DAMAGED")
//       || dtrInspectionSheetEntity?.ltFuseWire!="COPPER_OK"|| (dtrInspectionSheetEntity?.ltPvcCableStatus!="DAMAGED");
//
//
// }
//
// bool oilMaintenanceRequired(){
//   return  dtrInspectionSheetEntity?.oilShortageInLiters>0 || (dtrInspectionSheetEntity?.gasketsDamaged!="DAMAGED") || (dtrInspectionSheetEntity?.diaphragmStatus!="DAMAGED");
// }
//
// bool earthMaintenanceRequired(){
//   return  dtrInspectionSheetEntity?.earthPipesStatus!=null&&dtrInspectionSheetEntity?.earthPipesStatus.toLowerCase() == "damaged" ||
//       dtrInspectionSheetEntity?.earthing!=null && dtrInspectionSheetEntity?.earthing.toLowerCase() == "damaged";
// }
//
// bool ltnMaintenanceRequired(){
//   return dtrInspectionSheetEntity?.noOfLooseLinesOnDtr>0 || dtrInspectionSheetEntity?.treeCuttingRequired>0 || (dtrInspectionSheetEntity?.otherObservationsByLm.toLowerCase() == "y");
// }
//
// bool laMaintenanceRequired(){
//   return dtrInspectionSheetEntity?.lightningArrestors!=null&&dtrInspectionSheetEntity?.lightningArrestors.toLowerCase() == "damaged";
// }
// bool dtrMaintenanceRequired(){
//   return (dtrInspectionSheetEntity?.dtrAglLoadHp>0.0 || dtrInspectionSheetEntity?.domesticNonDomLoad >0.0 || dtrInspectionSheetEntity?.industrialLoadInHp>0.0 || dtrInspectionSheetEntity?.waterWorksLoadInHp>0.0 || dtrInspectionSheetEntity?.otherLoadInKw>0.0);
// }
}
