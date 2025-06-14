import 'dart:convert';

import 'package:tsnpdcl_employee/view/pole_tracker/model/digital_feeder_entity.dart';

class OffLineFeeder {
  String feederCode;
  String feederName;
  String ssCode;
  String ssName;
  String voltageLevel;
  int insertDate;
  List<DigitalFeederEntity> poleList;

  OffLineFeeder({
    required this.feederCode,
    required this.feederName,
    required this.ssCode,
    required this.ssName,
    required this.voltageLevel,
    required this.insertDate,
    required this.poleList,
  });

  factory OffLineFeeder.fromJson(Map<String, dynamic> json) {
    return OffLineFeeder(
      feederCode: json['feederCode'] ?? '',
      feederName: json['feederName'] ?? '',
      ssCode: json['ssCode'] ?? '',
      ssName: json['ssName'] ?? '',
      voltageLevel: json['voltageLevel'] ?? '',
      insertDate: json['insertDate'] ?? 0,
      poleList: (jsonDecode(json['poleListJson']) as List)
          .map((e) => DigitalFeederEntity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feederCode': feederCode,
      'feederName': feederName,
      'ssCode': ssCode,
      'ssName': ssName,
      'voltageLevel': voltageLevel,
      'insertDate': insertDate,
      'poleListJson': jsonEncode(poleList.map((e) => e.toJson()).toList()),
      // 'digitalFeederEntityList':
      // digitalFeederEntityList.map((e) => e.toJson()).toList(),
      // 'digitalFeederOfflineEntities':
      // digitalFeederOfflineEntities.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'OffLineFeeder(feederCode: $feederCode, feederName: $feederName, ssCode: $ssCode, ssName: $ssName, voltageLevel: $voltageLevel, insertDate: $insertDate, poleList: $poleList)';
  }

}
