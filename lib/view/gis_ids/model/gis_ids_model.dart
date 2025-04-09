import 'dart:convert';

GisIdsModel gisIdFromJson(String str) => GisIdsModel.fromJson(json.decode(str));

String gisIdToJson(GisIdsModel data) => json.encode(data.toJson());

class GisIdsModel {
  GisIdsModel({
    required this.gisId,
    required this.regNum,
    required this.regDate,
    required this.feederCode,
    required this.ssCode,
    required this.workDescription,
    required this.insertDate,
    required this.ip,
    required this.empId,
    required this.deleteStatus,
    required this.sectionCode,
    required this.sapUploadFlag,
    required this.sapUpRemarks,
    required this.sapUpDate,
  });

  GisIdsModel.fromJson(dynamic json) {
    try {
      gisId = json['gisId'] is int ? json['gisId'] as int : int.tryParse(json['gisId']?.toString() ?? '') ?? 0;
      regNum = json['regNum']?.toString() ?? '';
      regDate = json['regDate']?.toString() ?? '';
      feederCode = json['feederCode']?.toString() ?? '';
      ssCode = json['ssCode']?.toString() ?? '';
      workDescription = json['workDescription']?.toString() ?? '';
      insertDate = json['insertDate']?.toString() ?? '';
      ip = json['ip']?.toString() ?? '';
      empId = json['empId']?.toString() ?? '';
      deleteStatus = json['deleteStatus']?.toString() ?? '';
      sectionCode = json['sectionCode']?.toString() ?? '';
      sapUploadFlag = json['sapUploadFlag']?.toString() ?? '';
      sapUpRemarks = json['sapUpRemarks']?.toString() ?? '';
      sapUpDate = json['sapUpDate']?.toString() ?? '';
    } catch (e) {
      print("Error parsing GisId: $e");
      throw FormatException("Invalid GIS ID data format");
    }
  }

  int? gisId;
  String? regNum;
  String? regDate;
  String? feederCode;
  String? ssCode;
  String? workDescription;
  String? insertDate;
  String? ip;
  String? empId;
  String? deleteStatus;
  String? sectionCode;
  String? sapUploadFlag;
  String? sapUpRemarks;
  String? sapUpDate;

  GisIdsModel copyWith({
    int? gisId,
    String? regNum,
    String? regDate,
    String? feederCode,
    String? ssCode,
    String? workDescription,
    String? insertDate,
    String? ip,
    String? empId,
    String? deleteStatus,
    String? sectionCode,
    String? sapUploadFlag,
    String? sapUpRemarks,
    String? sapUpDate,
  }) =>
      GisIdsModel(
        gisId: gisId ?? this.gisId,
        regNum: regNum ?? this.regNum,
        regDate: regDate ?? this.regDate,
        feederCode: feederCode ?? this.feederCode,
        ssCode: ssCode ?? this.ssCode,
        workDescription: workDescription ?? this.workDescription,
        insertDate: insertDate ?? this.insertDate,
        ip: ip ?? this.ip,
        empId: empId ?? this.empId,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        sectionCode: sectionCode ?? this.sectionCode,
        sapUploadFlag: sapUploadFlag ?? this.sapUploadFlag,
        sapUpRemarks: sapUpRemarks ?? this.sapUpRemarks,
        sapUpDate: sapUpDate ?? this.sapUpDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gisId'] = gisId;
    map['regNum'] = regNum;
    map['regDate'] = regDate;
    map['feederCode'] = feederCode;
    map['ssCode'] = ssCode;
    map['workDescription'] = workDescription;
    map['insertDate'] = insertDate;
    map['ip'] = ip;
    map['empId'] = empId;
    map['deleteStatus'] = deleteStatus;
    map['sectionCode'] = sectionCode;
    map['sapUploadFlag'] = sapUploadFlag;
    map['sapUpRemarks'] = sapUpRemarks;
    map['sapUpDate'] = sapUpDate;
    return map;
  }
}