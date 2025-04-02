import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/general_substation_model.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/substation_model.dart';

class Breakdown11kvViewmodel extends ChangeNotifier {
  final TextEditingController substationsController = TextEditingController();

  /// **Substations Data**
  List<GeneralSubstationModel> _substations = [
    GeneralSubstationModel(name: "Substation A", rawData: "Raw data for Substation A"),
    GeneralSubstationModel(name: "Substation B", rawData: "Raw data for Substation B"),
    GeneralSubstationModel(name: "Substation C", rawData: "Raw data for Substation C"),
  ];
  String? selectedSubstation;

  /// **Feeders Data (Separate Model)**
  List<GeneralSubstationModel> _feeders = [
    GeneralSubstationModel(name: "Feeder 1", rawData: "Data for Feeder 1"),
    GeneralSubstationModel(name: "Feeder 2", rawData: "Data for Feeder 2"),
    GeneralSubstationModel(name: "Feeder 3", rawData: "Data for Feeder 3"),
  ];
  String? selectedFeeder;

  // Single variable to track the selected supply option
  String? selectedSupplyOption; // Possible values: "Not Arranged", "Arranged", "Partially Provided", or null

  DateTime? selectedDateTime;

  List<GeneralSubstationModel> get substations => _substations;
  List<GeneralSubstationModel> get feeders => _feeders;

  void setSelectedSubstation(String? substation) {
    selectedSubstation = substation;
    notifyListeners();
  }

  void setSelectedFeeder(String? feeder) {
    selectedFeeder = feeder;
    notifyListeners();
  }

  /// **DateTime Picker**
  Future<void> selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    selectedDateTime = DateTime(
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

  /// **Alternative Supply Arrangement (Single Selection)**
  void setSupplyOption(String? option) {
    selectedSupplyOption = option; // Set the selected option, or null to deselect
    notifyListeners();
  }
}