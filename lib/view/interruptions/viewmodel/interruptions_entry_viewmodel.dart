import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/general_substation_model.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/substation_model.dart';

class InterruptionsEntryViewmodel extends ChangeNotifier {
  final TextEditingController substationsController = TextEditingController();

  String? selectedOption = "Feeder"; // Default to "Feeder"
  String? selectedSupplyPosition = "Restored"; // Default to "Restored"
  String? selectedLV; // For LV dropdown selection

  // Substations Data
  List<GeneralSubstationModel> _substations = [
    GeneralSubstationModel(name: "Circle A", rawData: "Raw data for Substation A"),
    GeneralSubstationModel(name: "Circle B", rawData: "Raw data for Substation B"),
    GeneralSubstationModel(name: "Circle C", rawData: "Raw data for Substation C"),
  ];
  String? selectedSubstation;

  // Feeders Data
  List<GeneralSubstationModel> _feeders = [
    GeneralSubstationModel(name: "Substation 1", rawData: "Data for Feeder 1"),
    GeneralSubstationModel(name: "Substation 2", rawData: "Data for Feeder 2"),
    GeneralSubstationModel(name: "Substation 3", rawData: "Data for Feeder 3"),
  ];
  String? selectedFeeder;

  // Interruption Types (New)
  List<String> _interruptionTypes = [
    "Type 1",
    "Type 2",
    "Type 3",
  ];
  String? selectedInterruptionType;

  DateTime? fromDateTime;
  DateTime? toDateTime;

  // Getters
  List<GeneralSubstationModel> get substations => _substations;
  List<GeneralSubstationModel> get feeders => _feeders;
  List<String> get interruptionTypes => _interruptionTypes;

  // Setters
  void setSelectedSubstation(String? substation) {
    selectedSubstation = substation;
    notifyListeners();
  }

  void setSelectedFeeder(String? feeder) {
    selectedFeeder = feeder;
    notifyListeners();
  }

  void setSelectedLV(String? lv) {
    selectedLV = lv;
    notifyListeners();
  }

  void setSelectedInterruptionType(String? type) {
    selectedInterruptionType = type;
    notifyListeners();
  }

  void toggleOption(String value) {
    selectedOption = value;
    notifyListeners();
  }

  void setSupplyPosition(String? position) {
    selectedSupplyPosition = position;
    notifyListeners();
  }

  // DateTime Pickers
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

  Future<void> selectToDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: toDateTime ?? (fromDateTime ?? DateTime.now()),
      firstDate: fromDateTime ?? DateTime(2000),
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

  String getDuration() {
    if (fromDateTime == null || toDateTime == null) return "HH:MM";
    final difference = toDateTime!.difference(fromDateTime!);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }

  // Cleanup
  @override
  void dispose() {
    substationsController.dispose();
    super.dispose();
  }
}