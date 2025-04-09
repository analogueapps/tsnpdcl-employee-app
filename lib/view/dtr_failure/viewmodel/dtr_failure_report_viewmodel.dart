import 'package:flutter/material.dart';

class ReportDTRFailureViewModel extends ChangeNotifier {
  // Dropdown selections
  String? _selectedLocation;
  String? _failedEquipmentCode;
  String? _selectedStructureCode;

  // Lists
  final List<String> locationList = ["NAKKALAGUTTA"];
  final List<String> failedEquipmentList = ["200049446"];
  final List<String> failedStructureCodeList = [
    '12234-NAKKALAGUTTA-NKG-SS-0071',
    '12235-NAKKALAGUTTA-NKG-SS-0072',
    '12236-NAKKALAGUTTA-NKG-SS-0073',
    '12237-NAKKALAGUTTA-NKG-SS-0074',
    '12238-NAKKALAGUTTA-NKG-SS-0075',
    '12239-NAKKALAGUTTA-NKG-SS-0076',
    '12240-NAKKALAGUTTA-NKG-SS-0077',
    '12241-NAKKALAGUTTA-NKG-SS-0078',
    '12242-NAKKALAGUTTA-NKG-SS-0079',
    '12243-NAKKALAGUTTA-NKG-SS-0080',
  ];

  // Text controllers
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // Failure reason checkboxes
  bool highRatingHG = false;
  bool highRatingLT = false;
  bool ventPipeBurst = false;
  bool gasketDamaged = false;
  bool earthWireCut = false;
  bool looseLinesInTheEarth = false;
  bool phaseTouching = false;
  bool phTouching = false;
  bool dueToLightning = false;
  bool heavyWind = false;
  bool dtrInstalled = false;
  bool improperHG = false;
  bool improperLT = false;
  bool tankCrack = false;
  bool moistureEntry = false;
  bool flashover = false;
  bool improperEarthing = false;
  bool overload = false;
  bool hgFuse = false;
  bool faultDueToAGL = false;
  bool oilGushing = false;
  bool lowOilLevel = false;
  bool tankBurst = false;
  bool agingOfDTR = false;
  bool theftOfOil = false;
  bool floodsFallenOil = false;
  bool floodsSubmerged = false;
  bool other = false;

  // Estimate required checkboxes
  bool estimateRequiredYes = false;
  bool estimateRequiredNo = false;

  // Getters
  String? get selectedLocation => _selectedLocation;
  String? get failedEquipmentCode => _failedEquipmentCode;
  String? get selectedStructureCode => _selectedStructureCode;

  // Setters
  void setSelectedLocation(String? value) {
    _selectedLocation = value;
    notifyListeners();
  }

  void setFailedEquipmentCode(String? value) {
    _failedEquipmentCode = value;
    notifyListeners();
  }

  void setSelectedStructureCode(String? value) {
    _selectedStructureCode = value;
    notifyListeners();
  }

  void setFailureDate(String date) {
    dateController.text = date;
    notifyListeners();
  }

  void setFailureTime(String time) {
    timeController.text = time;
    notifyListeners();
  }

  void toggleCheckbox(String field, bool value) {
    switch (field) {
      case 'highRatingHG':
        highRatingHG = value;
        break;
      case 'highRatingLT':
        highRatingLT = value;
        break;
      case 'ventPipeBurst':
        ventPipeBurst = value;
        break;
      case 'gasketDamaged':
        gasketDamaged = value;
        break;
      case 'earthWireCut':
        earthWireCut = value;
        break;
      case 'looseLinesInTheEarth':
        looseLinesInTheEarth = value;
        break;
      case 'phaseTouching':
        phaseTouching = value;
        break;
      case 'phTouching':
        phTouching = value;
        break;
      case 'dueToLightning':
        dueToLightning = value;
        break;
      case 'heavyWind':
        heavyWind = value;
        break;
      case 'dtrInstalled':
        dtrInstalled = value;
        break;
      case 'improperHG':
        improperHG = value;
        break;
      case 'improperLT':
        improperLT = value;
        break;
      case 'tankCrack':
        tankCrack = value;
        break;
      case 'moistureEntry':
        moistureEntry = value;
        break;
      case 'flashover':
        flashover = value;
        break;
      case 'improperEarthing':
        improperEarthing = value;
        break;
      case 'overload':
        overload = value;
        break;
      case 'hgFuse':
        hgFuse = value;
        break;
      case 'faultDueToAGL':
        faultDueToAGL = value;
        break;
      case 'oilGushing':
        oilGushing = value;
        break;
      case 'lowOilLevel':
        lowOilLevel = value;
        break;
      case 'tankBurst':
        tankBurst = value;
        break;
      case 'agingOfDTR':
        agingOfDTR = value;
        break;
      case 'theftOfOil':
        theftOfOil = value;
        break;
      case 'floodsFallenOil':
        floodsFallenOil = value;
        break;
      case 'floodsSubmerged':
        floodsSubmerged = value;
        break;
      case 'other':
        other = value;
        break;
      case 'estimateRequiredYes':
        estimateRequiredYes = value;
        estimateRequiredNo = !value; // Mutually exclusive
        break;
      case 'estimateRequiredNo':
        estimateRequiredNo = value;
        estimateRequiredYes = !value; // Mutually exclusive
        break;
    }
    notifyListeners();
  }

  void save() {
    // Implement save logic here (e.g., API call)
    print('Saving DTR Failure Report:');
    print('Location: $_selectedLocation');
    print('Equipment Code: $_failedEquipmentCode');
    print('Structure Code: $_selectedStructureCode');
    print('Date: ${dateController.text}');
    print('Time: ${timeController.text}');
    // Add other fields as needed
  }
}