import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/substation_model.dart';

class Breakdown11kvViewmodel extends ChangeNotifier {
  final TextEditingController substationsController = TextEditingController();

  /// **Substations Data**
  List<SubstationModel> _substations = [
    SubstationModel(name: "Substation A", rawData: "Raw data for Substation A"),
    SubstationModel(name: "Substation B", rawData: "Raw data for Substation B"),
    SubstationModel(name: "Substation C", rawData: "Raw data for Substation C"),
  ];
  String? selectedSubstation;

  /// **Feeders Data (Separate Model)**
  List<SubstationModel> _feeders = [
    SubstationModel(name: "Feeder 1", rawData: "Data for Feeder 1"),
    SubstationModel(name: "Feeder 2", rawData: "Data for Feeder 2"),
    SubstationModel(name: "Feeder 3", rawData: "Data for Feeder 3"),
  ];
  String? selectedFeeder;

  bool _isOption1Selected = false;
  bool _isOption2Selected = false;
  bool _isOption3Selected = false;
  DateTime? selectedDateTime;

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
}
