import 'dart:convert';

InductionPointsOfFeederList inductionPointsOfFeederListFromJson(String str) =>
    InductionPointsOfFeederList.fromJson(json.decode(str));

String inductionPointsOfFeederListToJson(InductionPointsOfFeederList data) =>
    json.encode(data.toJson());

class InductionPointsOfFeederList {
  InductionPointsOfFeederList({
    this.indId,
    this.ssCode,
    this.fdrCode,
    this.inductionSource,
    this.indEhtSs,
    this.indFdr33KvCode,
    this.indSs33KvCode,
    this.indFdr11KvCode,
    this.interferenceType,
    this.indDtrStructCode,
    this.insDate,
    this.empId,
    this.sectionCode,
    this.deleteFlag,
    this.remarks,
    this.deleteDate,
    this.deleteEmpId,
    this.insertDeviceId,
    this.deletedDeviceId,
    this.indSSName,
    this.indFdrName,
  });

  InductionPointsOfFeederList.fromJson(dynamic json) {
    indId = json['indId'];
    ssCode = json['ssCode'];
    fdrCode = json['fdrCode'];
    inductionSource = json['inductionSource'];
    indEhtSs = json['indEhtSs'];
    indFdr33KvCode = json['indFdr33KvCode'];
    indSs33KvCode = json['indSs33KvCode'];
    indFdr11KvCode = json['indFdr11KvCode'];
    interferenceType = json['interferenceType'];
    indDtrStructCode = json['indDtrStructCode'];
    insDate = json['insDate'];
    empId = json['empId'];
    sectionCode = json['sectionCode'];
    deleteFlag = json['deleteFlag'];
    remarks = json['remarks'];
    deleteDate = json['deleteDate'];
    deleteEmpId = json['deleteEmpId'];
    insertDeviceId = json['insertDeviceId'];
    deletedDeviceId = json['deletedDeviceId'];
    indSSName = json['indSSName'];
    indFdrName = json['indFdrName'];
  }

  num? indId;
  String? ssCode;
  String? fdrCode;
  String? inductionSource;
  dynamic indEhtSs;
  dynamic indFdr33KvCode;
  String? indSs33KvCode;
  String? indFdr11KvCode;
  String? interferenceType;
  dynamic indDtrStructCode;
  String? insDate;
  String? empId;
  String? sectionCode;
  String? deleteFlag;
  dynamic remarks;
  dynamic deleteDate;
  dynamic deleteEmpId;
  String? insertDeviceId;
  dynamic deletedDeviceId;
  String? indSSName;
  String? indFdrName;

  InductionPointsOfFeederList copyWith({
    num? indId,
    String? ssCode,
    String? fdrCode,
    String? inductionSource,
    dynamic indEhtSs,
    dynamic indFdr33KvCode,
    String? indSs33KvCode,
    String? indFdr11KvCode,
    String? interferenceType,
    dynamic indDtrStructCode,
    String? insDate,
    String? empId,
    String? sectionCode,
    String? deleteFlag,
    dynamic remarks,
    dynamic deleteDate,
    dynamic deleteEmpId,
    String? insertDeviceId,
    dynamic deletedDeviceId,
    String? indSSName,
    String? indFdrName,
  }) =>
      InductionPointsOfFeederList(
        indId: indId ?? this.indId,
        ssCode: ssCode ?? this.ssCode,
        fdrCode: fdrCode ?? this.fdrCode,
        inductionSource: inductionSource ?? this.inductionSource,
        indEhtSs: indEhtSs ?? this.indEhtSs,
        indFdr33KvCode: indFdr33KvCode ?? this.indFdr33KvCode,
        indSs33KvCode: indSs33KvCode ?? this.indSs33KvCode,
        indFdr11KvCode: indFdr11KvCode ?? this.indFdr11KvCode,
        interferenceType: interferenceType ?? this.interferenceType,
        indDtrStructCode: indDtrStructCode ?? this.indDtrStructCode,
        insDate: insDate ?? this.insDate,
        empId: empId ?? this.empId,
        sectionCode: sectionCode ?? this.sectionCode,
        deleteFlag: deleteFlag ?? this.deleteFlag,
        remarks: remarks ?? this.remarks,
        deleteDate: deleteDate ?? this.deleteDate,
        deleteEmpId: deleteEmpId ?? this.deleteEmpId,
        insertDeviceId: insertDeviceId ?? this.insertDeviceId,
        deletedDeviceId: deletedDeviceId ?? this.deletedDeviceId,
        indSSName: indSSName ?? this.indSSName,
        indFdrName: indFdrName ?? this.indFdrName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['indId'] = indId;
    map['ssCode'] = ssCode;
    map['fdrCode'] = fdrCode;
    map['inductionSource'] = inductionSource;
    map['indEhtSs'] = indEhtSs;
    map['indFdr33KvCode'] = indFdr33KvCode;
    map['indSs33KvCode'] = indSs33KvCode;
    map['indFdr11KvCode'] = indFdr11KvCode;
    map['interferenceType'] = interferenceType;
    map['indDtrStructCode'] = indDtrStructCode;
    map['insDate'] = insDate;
    map['empId'] = empId;
    map['sectionCode'] = sectionCode;
    map['deleteFlag'] = deleteFlag;
    map['remarks'] = remarks;
    map['deleteDate'] = deleteDate;
    map['deleteEmpId'] = deleteEmpId;
    map['insertDeviceId'] = insertDeviceId;
    map['deletedDeviceId'] = deletedDeviceId;
    map['indSSName'] = indSSName;
    map['indFdrName'] = indFdrName;
    return map;
  }
}
