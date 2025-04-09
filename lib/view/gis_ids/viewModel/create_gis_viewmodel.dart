import 'package:flutter/material.dart';

class CreateGisIdViewModel extends ChangeNotifier {
  // Lists
  final List<String> circleList = ["KHAMMAM", "HANMAKONDA"];
  final List<String> subStationList = ["substation1", "substation2"];
  final List<String> feederList = ["feeder1", "feeder2"];

  // Selected values
  String? _selectedCircle;
  String? _selectedSubStation;
  String? _selectedFeeder;

  // Checkbox states
  bool is33KVLine1 = false; // First 33KV checkbox
  bool is33KVLine2 = false; // Second 33KV checkbox (assuming duplicate in original was unintentional)

  // Text controllers
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController workDescriptionController = TextEditingController();

  // Getters
  String? get selectedCircle => _selectedCircle;
  String? get selectedSubStation => _selectedSubStation;
  String? get selectedFeeder => _selectedFeeder;

  // Setters
  void setSelectedCircle(String? value) {
    _selectedCircle = value;
    notifyListeners();
  }

  void setSelectedSubStation(String? value) {
    _selectedSubStation = value;
    notifyListeners();
  }

  void setSelectedFeeder(String? value) {
    _selectedFeeder = value;
    notifyListeners();
  }

  void toggle33KVLine1(bool? value) {
    is33KVLine1 = value ?? false;
    notifyListeners();
  }

  void toggle33KVLine2(bool? value) {
    is33KVLine2 = value ?? false;
    notifyListeners();
  }

  // Submit action
  void submit() {
    // Implement submit logic here (e.g., API call)
    print('Submitting GIS ID Creation:');
    print('Circle: $_selectedCircle');
    print('Sub Station: $_selectedSubStation');
    print('Feeder: $_selectedFeeder');
    print('33KV Line 1: $is33KVLine1');
    print('33KV Line 2: $is33KVLine2');
    print('Land Mark: ${landMarkController.text}');
    print('Work Description: ${workDescriptionController.text}');
  }

  // Clean up
  @override
  void dispose() {
    landMarkController.dispose();
    workDescriptionController.dispose();
    super.dispose();
  }
}