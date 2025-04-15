import 'dart:convert';

MaintenanceFinishedModel maintenanceFromJson(String str) =>
    MaintenanceFinishedModel.fromJson(json.decode(str));

String maintenanceToJson(MaintenanceFinishedModel data) => json.encode(data.toJson());

class MaintenanceFinishedModel {
  MaintenanceFinishedModel({
    this.maintenanceId,
    this.inspectedEmpId,
    this.maintenanceEmpId,
    this.inspectedDate,
    this.maintenanceDate,
    this.sectionCode,
    this.ssCode,
    this.ssName,
    this.ssVoltage,
    this.status,
    this.scheduledDate,
    this.scheduledMonth,
    this.scheduleId,
    this.ssMaintenanceAttributesEntitiesByMid,
  });

  MaintenanceFinishedModel.fromJson(dynamic json) {
    maintenanceId = json['maintenanceId'];
    inspectedEmpId = json['inspectedEmpId'];
    maintenanceEmpId = json['maintenanceEmpId'];
    inspectedDate = json['inspectedDate'] != null
        ? DateTime.parse(json['inspectedDate'])
        : null;
    maintenanceDate = json['maintenanceDate'] != null
        ? DateTime.parse(json['maintenanceDate'])
        : null;
    sectionCode = json['sectionCode'];
    ssCode = json['ssCode'];
    ssName = json['ssName'];
    ssVoltage = json['ssVoltage'];
    status = json['status'];
    scheduledDate = json['scheduledDate'];
    scheduledMonth = json['scheduledMonth'];
    scheduleId = json['scheduleId'];
    ssMaintenanceAttributesEntitiesByMid =
    json['ssMaintenanceAttributesEntitiesByMid'] != null
        ? List<dynamic>.from(json['ssMaintenanceAttributesEntitiesByMid'])
        : [];
  }

  int? maintenanceId;
  String? inspectedEmpId;
  String? maintenanceEmpId;
  DateTime? inspectedDate;
  DateTime? maintenanceDate;
  String? sectionCode;
  String? ssCode;
  String? ssName;
  dynamic ssVoltage;
  String? status;
  dynamic scheduledDate;
  dynamic scheduledMonth;
  int? scheduleId;
  List<dynamic>? ssMaintenanceAttributesEntitiesByMid;

  MaintenanceFinishedModel copyWith({
    int? maintenanceId,
    String? inspectedEmpId,
    String? maintenanceEmpId,
    DateTime? inspectedDate,
    DateTime? maintenanceDate,
    String? sectionCode,
    String? ssCode,
    String? ssName,
    dynamic ssVoltage,
    String? status,
    dynamic scheduledDate,
    dynamic scheduledMonth,
    int? scheduleId,
    List<dynamic>? ssMaintenanceAttributesEntitiesByMid,
  }) =>
      MaintenanceFinishedModel(
        maintenanceId: maintenanceId ?? this.maintenanceId,
        inspectedEmpId: inspectedEmpId ?? this.inspectedEmpId,
        maintenanceEmpId: maintenanceEmpId ?? this.maintenanceEmpId,
        inspectedDate: inspectedDate ?? this.inspectedDate,
        maintenanceDate: maintenanceDate ?? this.maintenanceDate,
        sectionCode: sectionCode ?? this.sectionCode,
        ssCode: ssCode ?? this.ssCode,
        ssName: ssName ?? this.ssName,
        ssVoltage: ssVoltage ?? this.ssVoltage,
        status: status ?? this.status,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        scheduledMonth: scheduledMonth ?? this.scheduledMonth,
        scheduleId: scheduleId ?? this.scheduleId,
        ssMaintenanceAttributesEntitiesByMid:
        ssMaintenanceAttributesEntitiesByMid ??
            this.ssMaintenanceAttributesEntitiesByMid,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maintenanceId'] = maintenanceId;
    map['inspectedEmpId'] = inspectedEmpId;
    map['maintenanceEmpId'] = maintenanceEmpId;
    map['inspectedDate'] = inspectedDate?.toIso8601String();
    map['maintenanceDate'] = maintenanceDate?.toIso8601String();
    map['sectionCode'] = sectionCode;
    map['ssCode'] = ssCode;
    map['ssName'] = ssName;
    map['ssVoltage'] = ssVoltage;
    map['status'] = status;
    map['scheduledDate'] = scheduledDate;
    map['scheduledMonth'] = scheduledMonth;
    map['scheduleId'] = scheduleId;
    map['ssMaintenanceAttributesEntitiesByMid'] =
        ssMaintenanceAttributesEntitiesByMid;
    return map;
  }
}