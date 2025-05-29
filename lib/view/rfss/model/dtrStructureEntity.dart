class DTRStructureEntity {
  final String structureCode;
  final String distributionCode;
  final String distributionName;
  final String feederName;
  final String feederCode;
  final String capacity;
  final String landMark;
  final double lat;
  final double lon;
  final String sectionCode;
  final String createdBy;
  final String createdDate;
  final String searchString;
  final String ssNo;
  final String ssCode;
  final String structureType;
  final String plinthType;
  final String abSwitch;
  final String hgFuseSet;
  final String ltFuseSet;
  final String ltFuseType;
  final String loadPattern;
  final int? failureCount;

  DTRStructureEntity({
    required this.structureCode,
    required this.distributionCode,
    required this.distributionName,
    required this.feederName,
    required this.feederCode,
    required this.capacity,
    required this.landMark,
    required this.lat,
    required this.lon,
    required this.sectionCode,
    required this.createdBy,
    required this.createdDate,
    required this.searchString,
    required this.ssNo,
    required this.ssCode,
    required this.structureType,
    required this.plinthType,
    required this.abSwitch,
    required this.hgFuseSet,
    required this.ltFuseSet,
    required this.ltFuseType,
    required this.loadPattern,
    this.failureCount,
  });

  factory DTRStructureEntity.fromJson(Map<String, dynamic> json) {
    return DTRStructureEntity(
      structureCode: json['structureCode'] ?? '',
      distributionCode: json['distributionCode'] ?? '',
      distributionName: json['distributionName'] ?? '',
      feederName: json['feederName'] ?? '',
      feederCode: json['feederCode'] ?? '',
      capacity: json['capacity'] ?? '',
      landMark: json['landMark'] ?? '',
      lat: double.tryParse(json['lat']?.toString() ?? '0') ?? 0.0,
      lon: double.tryParse(json['lon']?.toString() ?? '0') ?? 0.0,
      sectionCode: json['sectionCode'] ?? '',
      createdBy: json['createdBy'] ?? '',
      createdDate: json['createdDate'] ?? '',
      searchString: json['searchString'] ?? '',
      ssNo: json['ssNo'] ?? '',
      ssCode: json['ssCode'] ?? '',
      structureType: json['structureType'] ?? '',
      plinthType: json['plinthType'] ?? '',
      abSwitch: json['abSwitch'] ?? '',
      hgFuseSet: json['hgFuseSet'] ?? '',
      ltFuseSet: json['ltFuseSet'] ?? '',
      ltFuseType: json['ltFuseType'] ?? '',
      loadPattern: json['loadPattern'] ?? '',
      failureCount: json['failureCount'] != null
          ? int.tryParse(json['failureCount'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'structureCode': structureCode,
      'distributionCode': distributionCode,
      'distributionName': distributionName,
      'feederName': feederName,
      'feederCode': feederCode,
      'capacity': capacity,
      'landMark': landMark,
      'lat': lat,
      'lon': lon,
      'sectionCode': sectionCode,
      'createdBy': createdBy,
      'createdDate': createdDate,
      'searchString': searchString,
      'ssNo': ssNo,
      'ssCode': ssCode,
      'structureType': structureType,
      'plinthType': plinthType,
      'abSwitch': abSwitch,
      'hgFuseSet': hgFuseSet,
      'ltFuseSet': ltFuseSet,
      'ltFuseType': ltFuseType,
      'loadPattern': loadPattern,
      'failureCount': failureCount,
    };
  }
}
