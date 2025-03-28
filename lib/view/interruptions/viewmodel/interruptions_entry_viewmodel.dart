import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/substation_model.dart';

class InterruptionsEntryViewmodel extends ChangeNotifier {
  final TextEditingController substationsController = TextEditingController();

  String? selectedOption = "Feeder"; // Default to "Feeder"
  String? _selectedInterruptionLevel; // "Feeder", "LV", or "ISF"
  String? _selectedSupplyPosition = "Restored"; // Default to "Restored"
  String? selectedLV; // New field for LV dropdown selection

  // Getters
  String? get selectedInterruptionLevel => _selectedInterruptionLevel;
  String? get selectedSupplyPosition => _selectedSupplyPosition;

  // Toggle the selected radio button
  void toggleOption(String value) {
    selectedOption = value;
    notifyListeners();
  }

  /// **Substations Data**
  List<SubstationModel> _substations = [
    SubstationModel(name: "Circle A", rawData: "Raw data for Substation A"),
    SubstationModel(name: "Circle B", rawData: "Raw data for Substation B"),
    SubstationModel(name: "Circle C", rawData: "Raw data for Substation C"),
  ];
  String? selectedSubstation;

  /// **Feeders Data (Separate Model)**
  List<SubstationModel> _feeders = [
    SubstationModel(name: "Substation 1", rawData: "Data for Feeder 1"),
    SubstationModel(name: "Substation 2", rawData: "Data for Feeder 2"),
    SubstationModel(name: "Substation 3", rawData: "Data for Feeder 3"),
  ];
  String? selectedFeeder;

  bool _isOption1Selected = false;
  bool _isOption2Selected = false;
  bool _isOption3Selected = false;

  // CHANGED: Two separate date-times for From and To
  DateTime? fromDateTime;
  DateTime? toDateTime;

  List<SubstationModel> get substations => _substations;
  List<SubstationModel> get feeders => _feeders;

  bool get isOption1Selected => _isOption1Selected;
  bool get isOption2Selected => _isOption2Selected;
  bool get isOption3Selected => _isOption3Selected;

  void setSelectedSubstation(String? substation) {
    selectedSubstation = substation;
    notifyListeners();
  }

  void setSelectedFeeder(String? feeder) {
    selectedFeeder = feeder;
    notifyListeners();
  }

  /// New method for LV dropdown
  void setSelectedLV(String? lv) {
    selectedLV = lv;
    notifyListeners();
  }

  /// **DateTime Picker - From**
  Future<void> selectFromDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: fromDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: fromDateTime != null
          ? TimeOfDay(hour: fromDateTime!.hour, minute: fromDateTime!.minute)
          : TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    fromDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    notifyListeners();
  }

  /// **DateTime Picker - To**
  Future<void> selectToDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: toDateTime ?? (fromDateTime ?? DateTime.now()),
      firstDate: fromDateTime ?? DateTime(2000), // Don't allow To date before From date
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: toDateTime != null
          ? TimeOfDay(hour: toDateTime!.hour, minute: toDateTime!.minute)
          : TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    toDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    notifyListeners();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat("dd-MM-yyyy hh:mm a").format(dateTime);
  }

  /// **Alternative Supply Arrangement (Checkboxes)**
  void toggleOption1(bool value) {
    _isOption1Selected = value;
    notifyListeners();
  }

  void toggleOption2(bool value) {
    _isOption2Selected = value;
    notifyListeners();
  }

  void toggleOption3(bool value) {
    _isOption3Selected = value;
    notifyListeners();
  }

  // Methods for radio selections
  void setInterruptionLevel(String? level) {
    _selectedInterruptionLevel = level;
    notifyListeners();
  }

  void setSupplyPosition(String? position) {
    _selectedSupplyPosition = position;
    notifyListeners();
  }

  // Validation method
  bool validateSelections() {
    return _selectedInterruptionLevel != null && _selectedSupplyPosition != null;
  }
}