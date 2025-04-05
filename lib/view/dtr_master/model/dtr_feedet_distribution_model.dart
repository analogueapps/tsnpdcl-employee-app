import 'dart:convert';

FeederDisModel feederDisModelFromJson(String str) => FeederDisModel.fromJson(json.decode(str));
String feederDisModelToJson(FeederDisModel data) => json.encode(data.toJson());

class FeederDisModel {
  FeederDisModel({
    this.optionCode,
    this.optionName,
    this.loadPattern,
    this.lon,
    this.ltFuseType,
    this.landMark,
    this.searchString,
    this.feederName,
    this.structureCode,
    this.plinthType,
    this.distributionCode,
    this.distributionName,
    this.hgFuseSet,
    this.createdBy,
    this.ssNo,
    this.ssCode,
    this.capacity,
    this.ltFuseSet,
    this.abSwitch,
    this.sectionCode,
    this.feederCode,
    this.createdDate,
    this.lat,
    this.structureType,
  });

  FeederDisModel.fromJson(dynamic json) {
    try {
      optionCode = json['optionCode']?.toString();
      optionName = json['optionName']?.toString();
      loadPattern = json['loadPattern']?.toString();
      lon = json['lon'] is num ? json['lon'] as double? : double.tryParse(json['lon']?.toString() ?? '');
      ltFuseType = json['ltFuseType']?.toString();
      landMark = json['landMark']?.toString();
      searchString = json['searchString']?.toString();
      feederName = json['feederName']?.toString();
      structureCode = json['structureCode']?.toString();
      plinthType = json['plinthType']?.toString();
      distributionCode = json['distributionCode']?.toString();
      distributionName = json['distributionName']?.toString();
      hgFuseSet = json['hgFuseSet']?.toString();
      createdBy = json['createdBy']?.toString();
      ssNo = json['ssNo']?.toString();
      ssCode = json['ssCode']?.toString();
      capacity = json['capacity']?.toString();
      ltFuseSet = json['ltFuseSet']?.toString();
      abSwitch = json['abSwitch']?.toString();
      sectionCode = json['sectionCode']?.toString();
      feederCode = json['feederCode']?.toString();
      createdDate = json['createdDate']?.toString();
      lat = json['lat'] is num ? json['lat'] as double? : double.tryParse(json['lat']?.toString() ?? '');
      structureType = json['structureType']?.toString();
    } catch (e) {
      print("Error parsing FeederDisModel: $e");
      throw FormatException("Invalid feeder/distribution data format");
    }
  }

  String? optionCode;
  String? optionName;
  String? loadPattern;
  double? lon;
  String? ltFuseType;
  String? landMark;
  String? searchString;
  String? feederName;
  String? structureCode;
  String? plinthType;
  String? distributionCode;
  String? distributionName;
  String? hgFuseSet;
  String? createdBy;
  String? ssNo;
  String? ssCode;
  String? capacity;
  String? ltFuseSet;
  String? abSwitch;
  String? sectionCode;
  String? feederCode;
  String? createdDate;
  double? lat;
  String? structureType;

  FeederDisModel copyWith({
    String? optionCode,
    String? optionName,
    String? loadPattern,
    double? lon,
    String? ltFuseType,
    String? landMark,
    String? searchString,
    String? feederName,
    String? structureCode,
    String? plinthType,
    String? distributionCode,
    String? distributionName,
    String? hgFuseSet,
    String? createdBy,
    String? ssNo,
    String? ssCode,
    String? capacity,
    String? ltFuseSet,
    String? abSwitch,
    String? sectionCode,
    String? feederCode,
    String? createdDate,
    double? lat,
    String? structureType,
  }) => FeederDisModel(
    optionCode: optionCode ?? this.optionCode,
    optionName: optionName ?? this.optionName,
    loadPattern: loadPattern ?? this.loadPattern,
    lon: lon ?? this.lon,
    ltFuseType: ltFuseType ?? this.ltFuseType,
    landMark: landMark ?? this.landMark,
    searchString: searchString ?? this.searchString,
    feederName: feederName ?? this.feederName,
    structureCode: structureCode ?? this.structureCode,
    plinthType: plinthType ?? this.plinthType,
    distributionCode: distributionCode ?? this.distributionCode,
    distributionName: distributionName ?? this.distributionName,
    hgFuseSet: hgFuseSet ?? this.hgFuseSet,
    createdBy: createdBy ?? this.createdBy,
    ssNo: ssNo ?? this.ssNo,
    ssCode: ssCode ?? this.ssCode,
    capacity: capacity ?? this.capacity,
    ltFuseSet: ltFuseSet ?? this.ltFuseSet,
    abSwitch: abSwitch ?? this.abSwitch,
    sectionCode: sectionCode ?? this.sectionCode,
    feederCode: feederCode ?? this.feederCode,
    createdDate: createdDate ?? this.createdDate,
    lat: lat ?? this.lat,
    structureType: structureType ?? this.structureType,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['optionCode'] = optionCode;
    map['optionName'] = optionName;
    map['loadPattern'] = loadPattern;
    map['lon'] = lon;
    map['ltFuseType'] = ltFuseType;
    map['landMark'] = landMark;
    map['searchString'] = searchString;
    map['feederName'] = feederName;
    map['structureCode'] = structureCode;
    map['plinthType'] = plinthType;
    map['distributionCode'] = distributionCode;
    map['distributionName'] = distributionName;
    map['hgFuseSet'] = hgFuseSet;
    map['createdBy'] = createdBy;
    map['ssNo'] = ssNo;
    map['ssCode'] = ssCode;
    map['capacity'] = capacity;
    map['ltFuseSet'] = ltFuseSet;
    map['abSwitch'] = abSwitch;
    map['sectionCode'] = sectionCode;
    map['feederCode'] = feederCode;
    map['createdDate'] = createdDate;
    map['lat'] = lat;
    map['structureType'] = structureType;
    return map;
  }
}