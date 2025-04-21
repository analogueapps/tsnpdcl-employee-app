// models.dart (same as previous)
import 'dart:convert';
import 'dart:io';

class DTR {
  DTR({
    required this.capacity,
    required this.make,
    required this.makeVendorId,
    required this.imageFile,
    required this.phase,
    required this.meterPhase,
    required this.dtrChargeDate,
    required this.ratio,
    required this.sapEquipmentNo,
    required this.serialNo,
    required this.yearOfMfg,
  });

  final String capacity;
  final String make;
  final String makeVendorId;
  final File imageFile;
  final String phase;
  final String meterPhase;
  final String dtrChargeDate;
  final String ratio;
  final String sapEquipmentNo;
  final String serialNo;
  final String yearOfMfg;

  Map<String, dynamic> toJson(String imageUrl) {
    return {
      'capacity': capacity,
      'make': make,
      'makeVendorId': makeVendorId,
      'url': imageUrl,
      'phase': phase,
      'meterPhase': meterPhase,
      'chargeDate': dtrChargeDate,
      'appVersion': '1.0.0',
      'ratio': ratio,
      'equipmentCode': sapEquipmentNo,
      'slno': serialNo,
      'year': yearOfMfg,
    };
  }
}

class Option {
  Option({
    required this.optionCode,
    required this.optionName,
  });

  final String optionCode;
  final String optionName;

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      optionCode: json['optionCode']?.toString() ?? '',
      optionName: json['optionName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionCode': optionCode,
      'optionName': optionName,
    };
  }
}

class Structure {
  Structure({
    required this.replace,
    required this.structureCode,
    required this.abSwitch,
    required this.capacity,
    required this.landMark,
    required this.distributionCode,
    required this.distribution,
    required this.structureType,
    required this.feederCode,
    required this.feederName,
    required this.hgFuseSet,
    required this.lat,
    required this.lon,
    required this.loadPattern,
    required this.ltFuseSet,
    required this.ltFuseType,
    required this.plinthType,
    required this.ssCode,
    required this.ssName,
    required this.ssNo,
    this.spmfl,
    required this.dtrs,
  });

  final String replace;
  final String structureCode;
  final String abSwitch;
  final String capacity;
  final String landMark;
  final String distributionCode;
  final String distribution;
  final String structureType;
  final String feederCode;
  final String feederName;
  final String hgFuseSet;
  final double lat;
  final double lon;
  final String loadPattern;
  final String ltFuseSet;
  final String ltFuseType;
  final String plinthType;
  final String ssCode;
  final String ssName;
  final String ssNo;
  final String? spmfl;
  final List<DTR> dtrs;

  Map<String, dynamic> toJson(List<String> imageUrls) {
    final dtrsJson = <Map<String, dynamic>>[];
    for (int i = 0; i < dtrs.length; i++) {
      dtrsJson.add(dtrs[i].toJson(imageUrls[i]));
    }

    final json = {
      'replace': replace,
      'structureCode': structureCode,
      'abSwitch': abSwitch,
      'capacity': capacity,
      'landMark': landMark,
      'distributionCode': distributionCode,
      'distribution': distribution,
      'structureType': structureType,
      'feederCode': feederCode,
      'feederName': feederName,
      'hgFuseSet': hgFuseSet,
      'lat': lat,
      'lon': lon,
      'loadPattern': loadPattern,
      'ltFuseSet': ltFuseSet,
      'ltFuseType': ltFuseType,
      'plinthType': plinthType,
      'ssCode': ssCode,
      'ssName': ssName,
      'ssNo': ssNo,
      'dtrs': dtrsJson,
    };

    if (spmfl != null) {
      json['spmfl'] = spmfl as Object;
    }

    return json;
  }
}