import 'package:tsnpdcl_employee/view/pole_tracker/model/digital_feeder_entity.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/digital_feeder_offline_entity.dart';

class OffLineFeeder {
  String feederCode;
  String feederName;
  String ssCode;
  String ssName;
  String voltageLevel;
  int insertDate;
  List<DigitalFeederEntity> digitalFeederEntityList;
  List<DigitalFeederOfflineEntity> digitalFeederOfflineEntities;

  OffLineFeeder({
    required this.feederCode,
    required this.feederName,
    required this.ssCode,
    required this.ssName,
    required this.voltageLevel,
    required this.insertDate,
    this.digitalFeederEntityList = const [],
    this.digitalFeederOfflineEntities = const [],
  });

  factory OffLineFeeder.fromJson(Map<String, dynamic> json) {
    return OffLineFeeder(
      feederCode: json['feederCode'] ?? '',
      feederName: json['feederName'] ?? '',
      ssCode: json['ssCode'] ?? '',
      ssName: json['ssName'] ?? '',
      voltageLevel: json['voltageLevel'] ?? '',
      insertDate: json['insertDate'] ?? 0,
      digitalFeederEntityList: (json['digitalFeederEntityList'] as List?)
          ?.map((e) => DigitalFeederEntity.fromJson(e))
          .toList() ??
          [],
      digitalFeederOfflineEntities: (json['digitalFeederOfflineEntities'] as List?)
          ?.map((e) => DigitalFeederOfflineEntity.fromJson(e))
          .toList() ??
          [],
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
      'digitalFeederEntityList':
      digitalFeederEntityList.map((e) => e.toJson()).toList(),
      'digitalFeederOfflineEntities':
      digitalFeederOfflineEntities.map((e) => e.toJson()).toList(),
    };
  }
}
