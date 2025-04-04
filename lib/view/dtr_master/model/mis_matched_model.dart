import 'dart:convert';

MisMatchedModel MisMatchedModelFromJson(String str) =>
    MisMatchedModel.fromJson(json.decode(str));

String MisMatchedModelToJson(MisMatchedModel data) =>
    json.encode(data.toJson());

class MisMatchedModel {
  MisMatchedModel({
    this.sapEquipmentCode,
    this.structureCode,
    this.make,
    this.slNo,
    this.yearOfMfg,
    this.url,
    this.wing,
    this.phyLocAdd,
    this.statusRemarks,

  });

  MisMatchedModel.fromJson(dynamic json) {
    try {
      sapEquipmentCode = json['sapEquipmentCode']?.toString();
      structureCode = json['structureCode']?.toString();

      // Handle make which might come as String or num
      if (json['make'] != null) {
        make = json['make']?.toString();
      }

      slNo = json['slNo']?.toString();

      // Handle yearOfMfg which might come as String or num
      if (json['yearOfMfg'] != null) {
        yearOfMfg = json['yearOfMfg']?.toString();
      }

      url = json['url']?.toString();
      wing = json['wing']?.toString();
      phyLocAdd = json['phyLocAdd']?.toString();
      statusRemarks = json['statusRemarks']?.toString();
    } catch (e) {
      print("Error parsing MisMatchedModel: $e");
      throw FormatException("Invalid meter data format");
    }
  }

  String? sapEquipmentCode;
  String? structureCode;
  String? make;
  String? slNo;
  String? yearOfMfg;
  String? url;
  String? newMeterId;
  String? wing;
  String? phyLocAdd;
  String? statusRemarks;


  MisMatchedModel copyWith({

    String? sapEquipmentCode,
    String? structureCode,
    String? make,
    String? slNo,
    String? yearOfMfg,
    String? url,
    String? wing,
    String? phyLocAdd,
    String? statusRemarks,


  }) =>
      MisMatchedModel(

        sapEquipmentCode: sapEquipmentCode ?? this.sapEquipmentCode,
        structureCode: structureCode ?? this.structureCode,
        make: make ?? this.make,
        slNo: slNo ?? this.slNo,
        yearOfMfg: yearOfMfg ?? this.yearOfMfg,
        url: url ?? this.url,
        wing: wing ?? this.wing,
        phyLocAdd: phyLocAdd ?? this.phyLocAdd,
        statusRemarks: statusRemarks ?? this.statusRemarks,


      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sapEquipmentCode'] = sapEquipmentCode;
    map['structureCode'] = structureCode;
    map['make'] = make;
    map['slNo'] = slNo;
    map['yearOfMfg'] = yearOfMfg;
    map['url'] = url;
    map['wing'] = wing;
    map['phyLocAdd'] = phyLocAdd;
    map['statusRemarks'] = statusRemarks;


    return map;
  }
}
