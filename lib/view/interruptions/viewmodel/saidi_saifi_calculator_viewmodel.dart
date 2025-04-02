import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/general_substation_model.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/substation_model.dart';

class SaidiSaifiCalculatorViewmodel extends ChangeNotifier {
  List<GeneralSubstationModel> substations = [
    GeneralSubstationModel(name: "Substation A", rawData: "Substation A"),
    GeneralSubstationModel(name: "Substation B", rawData: "Substation B"),
    GeneralSubstationModel(name: "Substation C", rawData: "Substation C"),
  ];

  String? selectedSubstation;

  void setSelectedSubstation(String? newValue) {
    selectedSubstation = newValue;
    notifyListeners();
  }
}