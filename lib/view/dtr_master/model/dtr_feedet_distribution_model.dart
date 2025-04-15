import 'dart:convert';

FeederDisModel feederDisModelFromJson(String str) => FeederDisModel.fromJson(json.decode(str));
String feederDisModelToJson(FeederDisModel data) => json.encode(data.toJson());

class FeederDisModel {
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
  List<DTRModel>? dtrs;

  FeederDisModel({
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
    this.dtrs,
  });

  factory FeederDisModel.fromJson(dynamic json) {
    try {
      return FeederDisModel(
        loadPattern: json['loadPattern']?.toString(),
        lon: json['lon'] is num
            ? (json['lon'] as num).toDouble()
            : double.tryParse(json['lon']?.toString() ?? ''),
        ltFuseType: json['ltFuseType']?.toString(),
        landMark: json['landMark']?.toString(),
        searchString: json['searchString']?.toString(),
        feederName: json['feederName']?.toString(),
        structureCode: json['structureCode']?.toString(),
        plinthType: json['plinthType']?.toString(),
        distributionCode: json['distributionCode']?.toString(),
        distributionName: json['distributionName']?.toString(),
        hgFuseSet: json['hgFuseSet']?.toString(),
        createdBy: json['createdBy']?.toString(),
        ssNo: json['ssNo']?.toString(),
        ssCode: json['ssCode']?.toString(),
        capacity: json['capacity']?.toString(),
        ltFuseSet: json['ltFuseSet']?.toString(),
        abSwitch: json['abSwitch']?.toString(),
        sectionCode: json['sectionCode']?.toString(),
        feederCode: json['feederCode']?.toString(),
        createdDate: json['createdDate']?.toString(),
        lat: json['lat'] is num
            ? (json['lat'] as num).toDouble()
            : double.tryParse(json['lat']?.toString() ?? ''),
        structureType: json['structureType']?.toString(),
        dtrs: json['dtrs'] != null
            ? (json['dtrs'] as List<dynamic>)
            .map((e) => DTRModel.fromJson(e as Map<String, dynamic>))
            .toList()
            : null,
      );
    } catch (e) {
      print("Error parsing FeederDisModel: $e");
      throw FormatException("Invalid feeder/distribution data format");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'loadPattern': loadPattern,
      'lon': lon,
      'ltFuseType': ltFuseType,
      'landMark': landMark,
      'searchString': searchString,
      'feederName': feederName,
      'structureCode': structureCode,
      'plinthType': plinthType,
      'distributionCode': distributionCode,
      'distributionName': distributionName,
      'hgFuseSet': hgFuseSet,
      'createdBy': createdBy,
      'ssNo': ssNo,
      'ssCode': ssCode,
      'capacity': capacity,
      'ltFuseSet': ltFuseSet,
      'abSwitch': abSwitch,
      'sectionCode': sectionCode,
      'feederCode': feederCode,
      'createdDate': createdDate,
      'lat': lat,
      'structureType': structureType,
      'dtrs': dtrs?.map((e) => e.toJson()).toList(),
    };
  }
}

class DTRModel {
  String? ymfd;
  String? searchString;
  String? feederName;
  String? structureCode;
  String? structureCapacity;
  String? distributionName;
  String? meterPhase;
  String? sectionCode;
  String? dtrCapacity;
  String? feederCode;
  String? createdDate;
  double? lat;
  double? lon;
  String? phyLoc;
  String? landMark;
  String? status;
  String? locType;
  String? confirmDate;
  String? distributionCode;
  String? url;
  String? createdBy;
  String? ratio;
  String? equipmentCode;
  String? slno;
  String? make;
  String? phase;

  DTRModel({
    this.ymfd,
    this.searchString,
    this.feederName,
    this.structureCode,
    this.structureCapacity,
    this.distributionName,
    this.meterPhase,
    this.sectionCode,
    this.dtrCapacity,
    this.feederCode,
    this.createdDate,
    this.lat,
    this.lon,
    this.phyLoc,
    this.landMark,
    this.status,
    this.locType,
    this.confirmDate,
    this.distributionCode,
    this.url,
    this.createdBy,
    this.ratio,
    this.equipmentCode,
    this.slno,
    this.make,
    this.phase,
  });

  factory DTRModel.fromJson(Map<String, dynamic> json) {
    return DTRModel(
      ymfd: json['ymfd']?.toString(),
      searchString: json['searchString']?.toString(),
      feederName: json['feederName']?.toString(),
      structureCode: json['structureCode']?.toString(),
      structureCapacity: json['structureCapacity']?.toString(),
      distributionName: json['distributionName']?.toString(),
      meterPhase: json['meterPhase']?.toString(),
      sectionCode: json['sectionCode']?.toString(),
      dtrCapacity: json['dtrCapacity']?.toString(),
      feederCode: json['feederCode']?.toString(),
      createdDate: json['createdDate']?.toString(),
      lat: json['lat'] is num
          ? (json['lat'] as num).toDouble()
          : double.tryParse(json['lat']?.toString() ?? ''),
      lon: json['lon'] is num
          ? (json['lon'] as num).toDouble()
          : double.tryParse(json['lon']?.toString() ?? ''),
      phyLoc: json['phyLoc']?.toString(),
      landMark: json['landMark']?.toString(),
      status: json['status']?.toString(),
      locType: json['locType']?.toString(),
      confirmDate: json['confirmDate']?.toString(),
      distributionCode: json['distributionCode']?.toString(),
      url: json['url']?.toString(),
      createdBy: json['createdBy']?.toString(),
      ratio: json['ratio']?.toString(),
      equipmentCode: json['equipmentCode']?.toString(),
      slno: json['slno']?.toString(),
      make: json['make']?.toString(),
      phase: json['phase']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'ymfd': ymfd,
    'searchString': searchString,
    'feederName': feederName,
    'structureCode': structureCode,
    'structureCapacity': structureCapacity,
    'distributionName': distributionName,
    'meterPhase': meterPhase,
    'sectionCode': sectionCode,
    'dtrCapacity': dtrCapacity,
    'feederCode': feederCode,
    'createdDate': createdDate,
    'lat': lat,
    'lon': lon,
    'phyLoc': phyLoc,
    'landMark': landMark,
    'status': status,
    'locType': locType,
    'confirmDate': confirmDate,
    'distributionCode': distributionCode,
    'url': url,
    'createdBy': createdBy,
    'ratio': ratio,
    'equipmentCode': equipmentCode,
    'slno': slno,
    'make': make,
    'phase': phase,
  };
}