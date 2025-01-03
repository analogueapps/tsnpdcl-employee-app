import 'dart:convert';

NewSketchPropEntity newSketchPropEntityFromJson(String str) =>
    NewSketchPropEntity.fromJson(json.decode(str));

String newSketchPropEntityToJson(NewSketchPropEntity data) =>
    json.encode(data.toJson());

class NewSketchPropEntity {
  NewSketchPropEntity({
    this.id,
    this.estimateNo,
    this.circleId,
    this.circle,
    this.divisionCode,
    this.division,
    this.subdivision,
    this.subdivisionId,
    this.section,
    this.sectionId,
    this.proposalDesc,
    this.isDone,
    this.createdBy,
    this.insertDate,
    this.voltage,
    this.ssCode,
    this.ssName,
    this.fdrCode,
    this.fdrName,
    this.typeOfProposal,
  });

  NewSketchPropEntity.fromJson(dynamic json) {
    id = json['id'];
    estimateNo = json['estimateNo'];
    circleId = json['circleId'];
    circle = json['circle'];
    divisionCode = json['divisionCode'];
    division = json['division'];
    subdivision = json['subdivision'];
    subdivisionId = json['subdivisionId'];
    section = json['section'];
    sectionId = json['sectionId'];
    proposalDesc = json['proposalDesc'];
    isDone = json['isDone'];
    createdBy = json['createdBy'];
    insertDate = json['insertDate'];
    voltage = json['voltage'];
    ssCode = json['ssCode'];
    ssName = json['ssName'];
    fdrCode = json['fdrCode'];
    fdrName = json['fdrName'];
    typeOfProposal = json['typeOfProposal'];
  }

  num? id;
  String? estimateNo;
  String? circleId;
  String? circle;
  String? divisionCode;
  String? division;
  String? subdivision;
  String? subdivisionId;
  String? section;
  String? sectionId;
  String? proposalDesc;
  String? isDone;
  String? createdBy;
  String? insertDate;
  String? voltage;
  String? ssCode;
  String? ssName;
  String? fdrCode;
  String? fdrName;
  String? typeOfProposal;

  NewSketchPropEntity copyWith({
    num? id,
    String? estimateNo,
    String? circleId,
    String? circle,
    String? divisionCode,
    String? division,
    String? subdivision,
    String? subdivisionId,
    String? section,
    String? sectionId,
    String? proposalDesc,
    String? isDone,
    String? createdBy,
    String? insertDate,
    String? voltage,
    String? ssCode,
    String? ssName,
    String? fdrCode,
    String? fdrName,
    String? typeOfProposal,
  }) =>
      NewSketchPropEntity(
        id: id ?? this.id,
        estimateNo: estimateNo ?? this.estimateNo,
        circleId: circleId ?? this.circleId,
        circle: circle ?? this.circle,
        divisionCode: divisionCode ?? this.divisionCode,
        division: division ?? this.division,
        subdivision: subdivision ?? this.subdivision,
        subdivisionId: subdivisionId ?? this.subdivisionId,
        section: section ?? this.section,
        sectionId: sectionId ?? this.sectionId,
        proposalDesc: sectionId ?? this.proposalDesc,
        isDone: isDone ?? this.isDone,
        createdBy: createdBy ?? this.createdBy,
        insertDate: insertDate ?? this.insertDate,
        voltage: voltage ?? this.voltage,
        ssCode: ssCode ?? this.ssCode,
        ssName: ssName ?? this.ssName,
        fdrCode: fdrCode ?? this.fdrCode,
        fdrName: fdrName ?? this.fdrName,
        typeOfProposal: typeOfProposal ?? this.typeOfProposal,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['estimateNo'] = estimateNo;
    map['circleId'] = circleId;
    map['circle'] = circle;
    map['divisionCode'] = divisionCode;
    map['division'] = division;
    map['subdivision'] = subdivision;
    map['subdivisionId'] = subdivisionId;
    map['section'] = section;
    map['sectionId'] = sectionId;
    map['proposalDesc'] = proposalDesc;
    map['isDone'] = isDone;
    map['createdBy'] = createdBy;
    map['insertDate'] = insertDate;
    map['voltage'] = voltage;
    map['ssCode'] = ssCode;
    map['ssName'] = ssName;
    map['fdrCode'] = fdrCode;
    map['fdrName'] = fdrName;
    map['typeOfProposal'] = typeOfProposal;
    return map;
  }
}
