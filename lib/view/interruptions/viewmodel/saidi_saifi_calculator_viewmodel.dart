import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/substation_model.dart';

class SaidiSaifiCalculatorViewmodel extends ChangeNotifier {
  List<SubstationModel> substations = [
    SubstationModel(name: "Substation A", rawData: "Substation A"),
    SubstationModel(name: "Substation B", rawData: "Substation B"),
    SubstationModel(name: "Substation C", rawData: "Substation C"),
  ];

  String? selectedSubstation;

  void setSelectedSubstation(String? newValue) {
    selectedSubstation = newValue;
    notifyListeners();
  }
}
