class DocketEntity {
  final int id;
  final String estimateNo;
  final String? circleId;
  final String? circle;
  final String? divisionCode;
  final String? division;
  final String? subdivision;
  final String? subdivisionId;
  final String? section;
  final String? sectionId;
  final String? worklDesc;
  final String isDone;
  final String createdBy;
  final String insertDate;
  final String? doneMarkedBy;
  final String voltage;
  final String ssCode;
  final String ssName;
  final String fdrCode;
  final String fdrName;
  final String typeOfProposal;
  final String? remarks;

  DocketEntity({
    required this.id,
    required this.estimateNo,
    required this.circleId,
    required this.circle,
    required this.divisionCode,
    required this.division,
    required this.subdivision,
    required this.subdivisionId,
    required this.section,
    required this.sectionId,
    required this.worklDesc,
    required this.isDone,
    required this.createdBy,
    required this.insertDate,
    required this.voltage,
    required this.ssCode,
    required this.ssName,
    required this.fdrCode,
    required this.fdrName,
    required this.typeOfProposal,
    required this.doneMarkedBy,
    required this.remarks,
  });

  factory DocketEntity.fromJson(Map<String, dynamic> json) {
    return DocketEntity(
      id: json['id'],
      estimateNo: json['estimateNo'],
      circleId: json['circleId'],
      circle: json['circle'],
      divisionCode: json['divisionCode'],
      division: json['division'],
      subdivision: json['subdivision'],
      subdivisionId: json['subdivisionId'],
      section: json['section'],
      sectionId: json['sectionId'],
      worklDesc: json['worklDesc'],
      isDone: json['isDone'],
      createdBy: json['createdBy'],
      insertDate: json['insertDate'],
      voltage: json['voltage'],
      ssCode: json['ssCode'],
      ssName: json['ssName'],
      fdrCode: json['fdrCode'],
      fdrName: json['fdrName'],
      doneMarkedBy: json['doneMarkedBy'],
      remarks: json['remarks'],
      typeOfProposal: json['typeOfProposal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estimateNo': estimateNo,
      'circleId': circleId,
      'circle': circle,
      'divisionCode': divisionCode,
      'division': division,
      'subdivision': subdivision,
      'subdivisionId': subdivisionId,
      'section': section,
      'sectionId': sectionId,
      'worklDesc': worklDesc,
      'isDone': isDone,
      'createdBy': createdBy,
      'insertDate': insertDate,
      'voltage': voltage,
      'ssCode': ssCode,
      'ssName': ssName,
      'fdrCode': fdrCode,
      'fdrName': fdrName,
      'remarks':remarks,
      'doneMarkedBy':doneMarkedBy,
      'typeOfProposal': typeOfProposal,
    };
  }

  // @override
  // String toString() {
  //   return 'DocketEntity(id: $id, estimateNo: $estimateNo, circle: $circle, division: $division, subdivision: $subdivision, section: $section, ssName: $ssName, fdrName: $fdrName, worklDesc: $worklDesc, insertDate: $insertDate)';
  // }

}
