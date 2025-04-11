import 'dart:io';

import 'package:flutter/cupertino.dart';

class DtrCardData {
  TextEditingController serialNo = TextEditingController();
  TextEditingController firstTimeChargedDate = TextEditingController();
  TextEditingController sapDtr = TextEditingController();
  String? selectedMake;
  String? selectedDtrCapacity;
  String? selectedYearOfMfg;
  String? selectedPhase;
  String? selectedRatio;
  String? selectedTypeOfMeter;
  File? capturedImage;

  DtrCardData();

  void dispose() {
    serialNo.dispose();
    firstTimeChargedDate.dispose();
    sapDtr.dispose();
  }
}