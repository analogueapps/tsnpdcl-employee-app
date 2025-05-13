import 'dart:convert';

class MaintenanceItem {
  final int maintenanceId;
  final String inspectedEmpId;
  final String? maintenanceEmpId;
  final DateTime inspectedDate;
  final DateTime? maintenanceDate;
  final String sectionCode;
  final String ssCode;
  final String? ssName;
  final String? ssVoltage;
  final String status;
  final DateTime? scheduledDate;
  final String? scheduledMonth;
  final int scheduleId;
  final List<SSMaintenanceAttribute> ssMaintenanceAttributesEntitiesByMid;

  MaintenanceItem({
    required this.maintenanceId,
    required this.inspectedEmpId,
    this.maintenanceEmpId,
    required this.inspectedDate,
    this.maintenanceDate,
    required this.sectionCode,
    required this.ssCode,
    required this.ssName,
    this.ssVoltage,
    required this.status,
    this.scheduledDate,
    this.scheduledMonth,
    required this.scheduleId,
    required this.ssMaintenanceAttributesEntitiesByMid,
  });

  factory MaintenanceItem.fromJson(Map<String, dynamic> json) {
    return MaintenanceItem(
      maintenanceId: json['maintenanceId'],
      inspectedEmpId: json['inspectedEmpId'],
      maintenanceEmpId: json['maintenanceEmpId'],
      inspectedDate: DateTime.parse(json['inspectedDate']),
      maintenanceDate: json['maintenanceDate'] != null
          ? DateTime.parse(json['maintenanceDate'])
          : null,
      sectionCode: json['sectionCode'],
      ssCode: json['ssCode'],
      ssName: json['ssName'],
      ssVoltage: json['ssVoltage'],
      status: json['status'],
      scheduledDate: json['scheduledDate'] != null
          ? DateTime.parse(json['scheduledDate'])
          : null,
      scheduledMonth: json['scheduledMonth'],
      scheduleId: json['scheduleId'],
      ssMaintenanceAttributesEntitiesByMid:
      (json['ssMaintenanceAttributesEntitiesByMid'] as List)
          .map((e) => SSMaintenanceAttribute.fromJson(e))
          .toList(),
    );
  }
}

class SSMaintenanceAttribute {
  final int attributeId;
  final int maintenanceId;
  final String ssCode;
  final DateTime insertDate;
  final String instance;
  final String attributeType;
  final String attributeName;
  final String? attributeValue;

  SSMaintenanceAttribute({
    required this.attributeId,
    required this.maintenanceId,
    required this.ssCode,
    required this.insertDate,
    required this.instance,
    required this.attributeType,
    required this.attributeName,
    required this.attributeValue,
  });

  factory SSMaintenanceAttribute.fromJson(Map<String, dynamic> json) {
    return SSMaintenanceAttribute(
      attributeId: json['attributeId'],
      maintenanceId: json['maintenanceId'],
      ssCode: json['ssCode'],
      insertDate: DateTime.parse(json['insertDate']),
      instance: json['instance'],
      attributeType: json['attributeType'],
      attributeName: json['attributeName'],
      attributeValue: json['attributeValue'],
    );
  }
}
