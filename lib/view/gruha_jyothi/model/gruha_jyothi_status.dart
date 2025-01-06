import 'dart:convert';

GruhaJyothiStatus gruhaJyothiStatusFromJson(String str) =>
    GruhaJyothiStatus.fromJson(json.decode(str));

String gruhaJyothiStatusToJson(GruhaJyothiStatus data) =>
    json.encode(data.toJson());

class GruhaJyothiStatus {
  GruhaJyothiStatus({
    this.rationNo,
    this.status,
    this.remarks,
    this.scno,
    this.aadharNo,
    this.uscno,
    this.mobileNo,
  });

  GruhaJyothiStatus.fromJson(dynamic json) {
    rationNo = json['rationNo'];
    status = json['status'];
    remarks = json['remarks'];
    scno = json['scno'];
    aadharNo = json['aadharNo'];
    uscno = json['uscno'];
    mobileNo = json['mobileNo'];
  }

  String? rationNo;
  String? status;
  String? remarks;
  String? scno;
  String? aadharNo;
  String? uscno;
  String? mobileNo;

  GruhaJyothiStatus copyWith({
    String? rationNo,
    String? status,
    String? remarks,
    String? scno,
    String? aadharNo,
    String? uscno,
    String? mobileNo,
  }) =>
      GruhaJyothiStatus(
        rationNo: rationNo ?? this.rationNo,
        status: status ?? this.status,
        remarks: remarks ?? this.remarks,
        scno: scno ?? this.scno,
        aadharNo: aadharNo ?? this.aadharNo,
        uscno: uscno ?? this.uscno,
        mobileNo: mobileNo ?? this.mobileNo,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rationNo'] = rationNo;
    map['status'] = status;
    map['remarks'] = remarks;
    map['scno'] = scno;
    map['aadharNo'] = aadharNo;
    map['uscno'] = uscno;
    map['mobileNo'] = mobileNo;
    return map;
  }
}
