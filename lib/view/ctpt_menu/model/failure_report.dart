import 'dart:convert';

FailureReportModel failureReportFromJson(String str) =>
    FailureReportModel.fromJson(json.decode(str));

String failureReportToJson(FailureReportModel data) => json.encode(data.toJson());

class FailureReportModel {
  FailureReportModel({
    required this.regNo,
    required this.village,
    required this.scNo,
    required this.date,
    required this.status,
  });

  FailureReportModel.fromJson(dynamic json) {
    try {
      regNo = json['regNo']?.toString() ?? '';
      village = json['village']?.toString() ?? '';
      scNo = json['scNo']?.toString() ?? '';
      date = json['opDate']?.toString() ?? '';
      status = json['status']?.toString() ?? '';
    } catch (e) {
      print("Error parsing FailureReport: $e");
      throw FormatException("Invalid failure report data format");
    }
  }

  String? regNo;
  String? village;
  String? scNo;
  String? date;
  String? status;

  FailureReportModel copyWith({
    String? regNo,
    String? village,
    String? scNo,
    String? date,
    String? status,
  }) =>
      FailureReportModel(
        regNo: regNo ?? this.regNo,
        village: village ?? this.village,
        scNo: scNo ?? this.scNo,
        date: date ?? this.date,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['regNo'] = regNo;
    map['village'] = village;
    map['scNo'] = scNo;
    map['opDate'] = date;
    map['status'] = status;
    return map;
  }
}