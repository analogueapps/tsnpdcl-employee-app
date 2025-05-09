import 'dart:convert';

List<SsDataModel> SsDataModelFromJson(String str) =>
    List<SsDataModel>.from(json.decode(str).map((x) => SsDataModel.fromJson(x)));

String SsDataModelToJson(List<SsDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


  class SsDataModel {
  final String? ssCode;
  final String? ssName;
  final String? sectionName;
  final String? sectionCode;

  SsDataModel({
  this.ssCode,
  this.ssName,
  this.sectionName,
  this.sectionCode,
  });

  factory SsDataModel.fromJson(Map<String, dynamic> json) {
    return SsDataModel(
      ssCode: json['ssCode'],
      ssName: json['ssName'],
      sectionName: json['sectionName'],
      sectionCode: json['sectionCode'],
    );
  }
  @override
  String toString() {
  return 'SsDataModel(ssCode: $ssCode, ssName: $ssName)';
  }



  Map<String, dynamic> toJson() => {
    "ssCode": ssCode,
    "ssName": ssName,
    "sectionName": sectionName,
    "sectionCode": sectionCode,
  };

  SsDataModel copyWith({
    String? ssCode,
    String? ssName,
    String? sectionName,
    String? sectionCode,
  }) =>
      SsDataModel(
        ssCode: ssCode ?? this.ssCode,
        ssName: ssName ?? this.ssName,
        sectionName: sectionName ?? this.sectionName,
        sectionCode: sectionCode ?? this.sectionCode,
      );
}