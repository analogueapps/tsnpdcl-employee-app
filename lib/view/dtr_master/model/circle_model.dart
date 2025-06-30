import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Circle {
  final String circleId;
  final String circleName;
  final String circleCode;

  Circle(this.circleId, this.circleName, {this.circleCode = ''});

  String getCircleCode() {
    return circleCode ?? circleId;
  }

  String getCircleId() {
    return circleId ?? circleCode;
  }

  String getCircleName() {
    return circleName;
  }
}

class DtrItem {
  String? selectedMake;
  String? selectedDtrCapacity;
  final TextEditingController firstTimeChargedDate = TextEditingController();
  final TextEditingController serialNo = TextEditingController();
  String? selectedYearOfMfg;
  String? selectedPhase;
  String? selectedRatio;
  String? selectedTypeOfMeter;
  final TextEditingController sapDtr = TextEditingController();
}

class SubstationModel {
  final String optionCode;
  final String optionName;

  SubstationModel({
    required this.optionCode,
    required this.optionName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubstationModel &&
          runtimeType == other.runtimeType &&
          optionCode == other.optionCode;

  @override
  int get hashCode => optionCode.hashCode;

  factory SubstationModel.fromJson(Map<String, dynamic> json) {
    return SubstationModel(
      optionCode: json['optionCode'] as String? ?? '',
      optionName: json['optionName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'optionCode': optionCode,
        'optionName': optionName,
      };
}

// Helper functions (only if needed)
SubstationModel substationModelFromJson(String str) =>
    SubstationModel.fromJson(json.decode(str));

String substationModelToJson(SubstationModel data) =>
    json.encode(data.toJson());
