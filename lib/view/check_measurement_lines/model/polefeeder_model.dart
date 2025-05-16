class PoleFeederEntity {
  final int id;
  final String? poleNum;
  final int? newProposalId;
  final int? sourceId;
  final String? sourceLat;
  final String? sourceLon;
  final String? sourceType;
  final String? isProposalExecuted;
  final int? distfrmSourcePole;
  final String? sourceAtsCode;
  final String? poleType;
  final String? poleHeight;
  final String? noOfCkts;
  final String? formation;
  final String? typeOfPoint;
  final String? crossing;
  final String? condLoadCode;
  final String? loadType;
  final String? haveLoad;
  final String? condSize;
  final String? lat;
  final String? lon;
  final String? remarks;
  final String? purpose;
  final String? voltage;
  final String? ssCode;
  final String? feederCode;
  final String? ssVolt;
  final String? feederVolt;
  final String? createdBy;
  final String? crossingText;
  final String? tempSeries;
  final String? tapping;
  final int? dtrId;
  final int? noOfAglCon;
  final DateTime? insertDate;

  PoleFeederEntity({
    required this.id,
    required this.poleNum,
    this.newProposalId,
    this.sourceId,
    this.sourceLat,
    this.sourceLon,
    this.sourceType,
    this.isProposalExecuted,
    this.distfrmSourcePole,
    this.sourceAtsCode,
    this.poleType,
    this.poleHeight,
    this.noOfCkts,
    this.formation,
    this.typeOfPoint,
    this.crossing,
    this.condLoadCode,
    this.loadType,
    this.haveLoad,
    this.condSize,
    this.lat,
    this.lon,
    this.remarks,
    this.purpose,
    this.voltage,
    this.ssCode,
    this.feederCode,
    this.ssVolt,
    this.feederVolt,
    this.createdBy,
    this.crossingText,
    this.tempSeries,
    this.tapping,
    this.dtrId,
    this.noOfAglCon,
    this.insertDate,
  });

  factory PoleFeederEntity.fromJson(Map<String, dynamic> json) {
    return PoleFeederEntity(
      id: json['id'],
      poleNum: json['poleNum'] ?? '',
      newProposalId: json['newProposalId'],
      sourceId: json['sourceId'],
      sourceLat: json['sourceLat'],
      sourceLon: json['sourceLon'],
      sourceType: json['sourceType'],
      isProposalExecuted: json['isProposalExecuted'],
      distfrmSourcePole: json['distfrmSourcePole'],
      sourceAtsCode: json['sourceAtsCode'],
      poleType: json['poleType'],
      poleHeight: json['poleHeight'],
      noOfCkts: json['noOfCkts'],
      formation: json['formation'],
      typeOfPoint: json['typeOfPoint'],
      crossing: json['crossing'],
      condLoadCode: json['condLoadCode'],
      loadType: json['loadType'],
      haveLoad: json['haveLoad'],
      condSize: json['condSize'],
      lat: json['lat'],
      lon: json['lon'],
      remarks: json['remarks'],
      purpose: json['purpose'],
      voltage: json['voltage'],
      ssCode: json['ssCode'],
      feederCode: json['feederCode'],
      ssVolt: json['ssVolt'],
      feederVolt: json['feederVolt'],
      createdBy: json['createdBy'],
      crossingText: json['crossingText'],
      tempSeries: json['tempSeries'],
      tapping: json['tapping'],
      dtrId: json['dtrId'],
      noOfAglCon: json['noOfAglCon'],
      insertDate: json['insertDate'] != null
          ? DateTime.tryParse(json['insertDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poleNum': poleNum,
      'newProposalId': newProposalId,
      'sourceId': sourceId,
      'sourceLat': sourceLat,
      'sourceLon': sourceLon,
      'sourceType': sourceType,
      'isProposalExecuted': isProposalExecuted,
      'distfrmSourcePole': distfrmSourcePole,
      'sourceAtsCode': sourceAtsCode,
      'poleType': poleType,
      'poleHeight': poleHeight,
      'noOfCkts': noOfCkts,
      'formation': formation,
      'typeOfPoint': typeOfPoint,
      'crossing': crossing,
      'condLoadCode': condLoadCode,
      'loadType': loadType,
      'haveLoad': haveLoad,
      'condSize': condSize,
      'lat': lat,
      'lon': lon,
      'remarks': remarks,
      'purpose': purpose,
      'voltage': voltage,
      'ssCode': ssCode,
      'feederCode': feederCode,
      'ssVolt': ssVolt,
      'feederVolt': feederVolt,
      'createdBy': createdBy,
      'crossingText': crossingText,
      'tempSeries': tempSeries,
      'tapping': tapping,
      'dtrId': dtrId,
      'noOfAglCon': noOfAglCon,
      'insertDate': insertDate?.toIso8601String(),
    };
  }
}
