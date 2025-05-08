class OverloadDtrListModel {
  final int recordId;
  final String dtrStructureCode;
  final String equipmentCode;
  final String empId;
  final DateTime insertDate;
  final String readingDate;
  final String readingTime;
  final double ir;
  final double iy;
  final double ib;
  final double iNeutral;
  final double totalLoadKva;
  final String sectionCode;
  final String dtrCapacity;
  final String dtrMake;
  final String dtrSerial;
  final String distCode;
  final String distName;
  final String feederName;
  final String feedderCode;
  final String locationType;
  final dynamic loadBalanceDone;

  OverloadDtrListModel({
    required this.recordId,
    required this.dtrStructureCode,
    required this.equipmentCode,
    required this.empId,
    required this.insertDate,
    required this.readingDate,
    required this.readingTime,
    required this.ir,
    required this.iy,
    required this.ib,
    required this.iNeutral,
    required this.totalLoadKva,
    required this.sectionCode,
    required this.dtrCapacity,
    required this.dtrMake,
    required this.dtrSerial,
    required this.distCode,
    required this.distName,
    required this.feederName,
    required this.feedderCode,
    required this.locationType,
    this.loadBalanceDone,
  });

  factory OverloadDtrListModel.fromJson(Map<String, dynamic> json) {
    return OverloadDtrListModel(
      recordId: json['recordId'],
      dtrStructureCode: json['dtrStructureCode'],
      equipmentCode: json['equipmentCode'],
      empId: json['empId'],
      insertDate: DateTime.parse(json['insertDate']),
      readingDate: json['readingDate'],
      readingTime: json['readingTime'],
      ir: json['ir'].toDouble(),
      iy: json['iy'].toDouble(),
      ib: json['ib'].toDouble(),
      iNeutral: json['iNeutral'].toDouble(),
      totalLoadKva: json['totalLoadKva'].toDouble(),
      sectionCode: json['sectionCode'],
      dtrCapacity: json['dtrCapacity'],
      dtrMake: json['dtrMake'],
      dtrSerial: json['dtrSerial'],
      distCode: json['distCode'],
      distName: json['distName'],
      feederName: json['feederName'],
      feedderCode: json['feedderCode'],
      locationType: json['locationType'],
      loadBalanceDone: json['loadBalanceDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recordId': recordId,
      'dtrStructureCode': dtrStructureCode,
      'equipmentCode': equipmentCode,
      'empId': empId,
      'insertDate': insertDate.toIso8601String(),
      'readingDate': readingDate,
      'readingTime': readingTime,
      'ir': ir,
      'iy': iy,
      'ib': ib,
      'iNeutral': iNeutral,
      'totalLoadKva': totalLoadKva,
      'sectionCode': sectionCode,
      'dtrCapacity': dtrCapacity,
      'dtrMake': dtrMake,
      'dtrSerial': dtrSerial,
      'distCode': distCode,
      'distName': distName,
      'feederName': feederName,
      'feedderCode': feedderCode,
      'locationType': locationType,
      'loadBalanceDone': loadBalanceDone,
    };
  }
}
