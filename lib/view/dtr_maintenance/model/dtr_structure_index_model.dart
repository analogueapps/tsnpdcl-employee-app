import 'dart:convert';

DtrStructureIndexModel dtrStructureIndexModelFromJson(String str) =>
    DtrStructureIndexModel.fromJson(json.decode(str));

String dtrStructureIndexModelToJson(DtrStructureIndexModel data) =>
    json.encode(data.toJson());

class DtrStructureIndexModel {
  DtrStructureIndexModel({
    this.structureCode,
    this.maintenanceCount,
    this.lastMaintainedDate,
    this.distributionCode,
  });

  DtrStructureIndexModel.fromJson(dynamic json) {
    structureCode = json['structureCode'];
    maintenanceCount = json['maintenanceCount'];
    lastMaintainedDate = json['lastMaintainedDate'];
    distributionCode = json['distributionCode'];
  }

  String? structureCode;
  num? maintenanceCount;
  String? lastMaintainedDate;
  String? distributionCode;

  DtrStructureIndexModel copyWith({
    String? structureCode,
    num? maintenanceCount,
    String? lastMaintainedDate,
    String? distributionCode,
  }) =>
      DtrStructureIndexModel(
        structureCode: structureCode ?? this.structureCode,
        maintenanceCount: maintenanceCount ?? this.maintenanceCount,
        lastMaintainedDate: lastMaintainedDate ?? this.lastMaintainedDate,
        distributionCode: distributionCode ?? this.distributionCode,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['structureCode'] = structureCode;
    map['maintenanceCount'] = maintenanceCount;
    map['lastMaintainedDate'] = lastMaintainedDate;
    map['distributionCode'] = distributionCode;
    return map;
  }
}
