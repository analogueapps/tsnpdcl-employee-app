import 'dart:convert';

DigitalFeederEntity digitalFeederEntityFromJson(String str) =>
    DigitalFeederEntity.fromJson(json.decode(str));

String digitalFeederEntityToJson(DigitalFeederEntity data) =>
    json.encode(data.toJson());

class DigitalFeederEntity {
  DigitalFeederEntity({
    this.id,
    this.newProposalId,
    this.sourceId,
    this.sourceLat,
    this.sourceLon,
    this.sourceType,
    this.isProposalExecuted,
    this.poleType,
    this.poleHeight,
    this.noOfCkts,
    this.formation,
    this.typeOfPoint,
    this.crossing,
    this.loadType,
    this.haveLoad,
    this.condSize,
    this.lat,
    this.lon,
    this.purpose,
    this.voltage,
    this.ssCode,
    this.feederCode,
    this.ssVolt,
    this.feederVolt,
    this.insertDate,
    this.createdBy,
    this.poleNum,
    this.tempSeries,
    this.tapping,
    this.distanceFeeder,
    this.circleCode,
    this.fName,
    this.sName,
    this.extensionPole,
  });

  DigitalFeederEntity.fromJson(dynamic json) {
    id = json['id'];
    newProposalId = json['newProposalId'];
    sourceId = json['sourceId'];
    sourceLat = json['sourceLat'];
    sourceLon = json['sourceLon'];
    sourceType = json['sourceType'];
    isProposalExecuted = json['isProposalExecuted'];
    poleType = json['poleType'];
    poleHeight = json['poleHeight'];
    noOfCkts = json['noOfCkts'];
    formation = json['formation'];
    typeOfPoint = json['typeOfPoint'];
    crossing = json['crossing'];
    loadType = json['loadType'];
    haveLoad = json['haveLoad'];
    condSize = json['condSize'];
    lat = json['lat'];
    lon = json['lon'];
    purpose = json['purpose'];
    voltage = json['voltage'];
    ssCode = json['ssCode'];
    feederCode = json['feederCode'];
    ssVolt = json['ssVolt'];
    feederVolt = json['feederVolt'];
    insertDate = json['insertDate'];
    createdBy = json['createdBy'];
    poleNum = json['poleNum'];
    tapping = json['tapping'];
    distanceFeeder = json['distanceFeeder'];
    circleCode = json['circleCode'];
    fName = json['fName'];
    sName = json['sName'];
    extensionPole = json['extensionPole'];
  }

  num? id;
  num? newProposalId;
  num? sourceId;
  String? sourceLat;
  String? sourceLon;
  String? sourceType;
  String? isProposalExecuted;
  String? poleType;
  String? poleHeight;
  String? noOfCkts;
  String? formation;
  String? typeOfPoint;
  String? crossing;
  String? loadType;
  String? haveLoad;
  String? condSize;
  String? lat;
  String? lon;
  String? purpose;
  String? voltage;
  String? ssCode;
  String? feederCode;
  String? ssVolt;
  String? feederVolt;
  String? insertDate;
  String? createdBy;
  String? poleNum;
  String? tempSeries;
  String? tapping;
  String? distanceFeeder;
  num? circleCode;
  String? fName;
  String? sName;
  String? extensionPole;

  DigitalFeederEntity copyWith({
    num? id,
    num? newProposalId,
    num? sourceId,
    String? sourceLat,
    String? sourceLon,
    String? sourceType,
    String? isProposalExecuted,
    String? poleType,
    String? poleHeight,
    String? noOfCkts,
    String? formation,
    String? typeOfPoint,
    String? crossing,
    String? loadType,
    String? haveLoad,
    String? condSize,
    String? lat,
    String? lon,
    String? purpose,
    String? voltage,
    String? ssCode,
    String? feederCode,
    String? ssVolt,
    String? feederVolt,
    String? insertDate,
    String? createdBy,
    String? poleNum,
    String? tempSeries,
    String? tapping,
    String? distanceFeeder,
    num? circleCode,
    String? fName,
    String? sName,
    String? extensionPole,
  }) =>
      DigitalFeederEntity(
        id: id ?? this.id,
        newProposalId: newProposalId ?? this.newProposalId,
        sourceId: sourceId ?? this.sourceId,
        sourceLat: sourceLat ?? this.sourceLat,
        sourceLon: sourceLon ?? this.sourceLon,
        sourceType: sourceType ?? this.sourceType,
        isProposalExecuted: isProposalExecuted ?? this.isProposalExecuted,
        poleType: poleType ?? this.poleType,
        poleHeight: poleHeight ?? this.poleHeight,
        noOfCkts: noOfCkts ?? this.noOfCkts,
        formation: formation ?? this.formation,
        typeOfPoint: typeOfPoint ?? this.typeOfPoint,
        crossing: crossing ?? this.crossing,
        loadType: loadType ?? this.loadType,
        haveLoad: haveLoad ?? this.haveLoad,
        condSize: condSize ?? this.condSize,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        purpose: purpose ?? this.purpose,
        voltage: voltage ?? this.voltage,
        ssCode: ssCode ?? this.ssCode,
        feederCode: feederCode ?? this.feederCode,
        ssVolt: ssVolt ?? this.ssVolt,
        feederVolt: feederVolt ?? this.feederVolt,
        insertDate: insertDate ?? this.insertDate,
        createdBy: createdBy ?? this.createdBy,
        poleNum: poleNum ?? this.poleNum,
        tempSeries: tempSeries ?? this.tempSeries,
        tapping: tapping ?? this.tapping,
        distanceFeeder: distanceFeeder ?? this.distanceFeeder,
        circleCode: circleCode ?? this.circleCode,
        fName: fName ?? this.fName,
        sName: sName ?? this.sName,
        extensionPole: extensionPole ?? this.extensionPole,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['newProposalId'] = newProposalId;
    map['sourceId'] = sourceId;
    map['sourceLat'] = sourceLat;
    map['sourceLon'] = sourceLon;
    map['sourceType'] = sourceType;
    map['isProposalExecuted'] = isProposalExecuted;
    map['poleType'] = poleType;
    map['poleHeight'] = poleHeight;
    map['noOfCkts'] = noOfCkts;
    map['formation'] = formation;
    map['typeOfPoint'] = typeOfPoint;
    map['crossing'] = crossing;
    map['loadType'] = loadType;
    map['haveLoad'] = haveLoad;
    map['condSize'] = condSize;
    map['lat'] = lat;
    map['lon'] = lon;
    map['purpose'] = purpose;
    map['voltage'] = voltage;
    map['ssCode'] = ssCode;
    map['feederCode'] = feederCode;
    map['ssVolt'] = ssVolt;
    map['feederVolt'] = feederVolt;
    map['insertDate'] = insertDate;
    map['createdBy'] = createdBy;
    map['poleNum'] = poleNum;
    map['tempSeries'] = tempSeries;
    map['tapping'] = tapping;
    map['distanceFeeder'] = distanceFeeder;
    map['circleCode'] = circleCode;
    map['fName'] = fName;
    map['sName'] = sName;
    map['extensionPole'] = extensionPole;
    return map;
  }
}
