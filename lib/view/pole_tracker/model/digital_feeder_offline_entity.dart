class DigitalFeederOfflineEntity {
  int localId;
  int previousPoleLocalId;
  int id;
  String? poleNum;
  int? newProposalId;
  int? sourceId;
  String? sourceLat;
  String? sourceLon;
  String? sourceType;
  String? isProposalExecuted;
  int? distfrmSourcePole;
  String? sourceAtsCode;
  String? poleType;
  String? poleHeight;
  String? noOfCkts;
  String? formation;
  String? typeOfPoint;
  String? crossing;
  String? condLoadCode;
  String? loadType;
  String? haveLoad;
  String? condSize;
  String? lat;
  String? lon;
  String? remarks;
  String? purpose;
  String? voltage;
  String? ssCode;
  String? feederCode;
  String? ssVolt;
  String? feederVolt;
  DateTime? insertDate;
  String? createdBy;
  String? crossingText;
  String? tempSeries;
  String? tapping;

  DigitalFeederOfflineEntity({
    required this.localId,
    required this.previousPoleLocalId,
    required this.id,
    this.poleNum,
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
    this.insertDate,
    this.createdBy,
    this.crossingText,
    this.tempSeries,
    this.tapping,
  });

  factory DigitalFeederOfflineEntity.fromJson(Map<String, dynamic> json) {
    return DigitalFeederOfflineEntity(
      localId: json['localId'] ?? 0,
      previousPoleLocalId: json['previousPoleLocalId'] ?? 0,
      id: json['id'] ?? 0,
      poleNum: json['poleNum'],
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
      insertDate: json['insertDate'] != null
          ? DateTime.tryParse(json['insertDate'])
          : null,
      createdBy: json['createdBy'],
      crossingText: json['crossingText'],
      tempSeries: json['tempSeries'],
      tapping: json['tapping'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localId': localId,
      'previousPoleLocalId': previousPoleLocalId,
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
      'insertDate': insertDate?.toIso8601String(),
      'createdBy': createdBy,
      'crossingText': crossingText,
      'tempSeries': tempSeries,
      'tapping': tapping,
    };
  }
}
