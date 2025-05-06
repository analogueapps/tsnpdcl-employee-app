class PendingFinishedListModel {
  final int surveyId;
  final String sectionCode;
  final String sanctionNo;
  final double poleALat;
  final double poleALon;
  final double poleBLat;
  final double poleBLon;
  final String poleAImageUrl;
  final String poleBImageUrl;
  final String surveyorId;
  final String timeOfSurveyor;
   String? remarksBySurveyor;
  final String feederCode;
  final String poleType;
  final String dateOfAbMarked;
  final String feederName;
  final String status;
  final String monthYear;
  final String workDescription;
  final String circleCode;
  final String divisionCode;
  final String subdivisionCode;
  final String section;
  final String subdivision;
  final String division;
  final String circle;
  final String distance;

  PendingFinishedListModel({
    required this.surveyId,
    required this.sectionCode,
    required this.sanctionNo,
    required this.poleALat,
    required this.poleALon,
    required this.poleBLat,
    required this.poleBLon,
    required this.poleAImageUrl,
    required this.poleBImageUrl,
    required this.surveyorId,
    required this.timeOfSurveyor,
     this.remarksBySurveyor,
    required this.feederCode,
    required this.poleType,
    required this.dateOfAbMarked,
    required this.feederName,
    required this.status,
    required this.monthYear,
    required this.workDescription,
    required this.circleCode,
    required this.divisionCode,
    required this.subdivisionCode,
    required this.section,
    required this.subdivision,
    required this.division,
    required this.circle,
    required this.distance,
  });

  factory PendingFinishedListModel.fromJson(Map<String, dynamic> json) {
    return PendingFinishedListModel(
      surveyId: json['surveyId'],
      sectionCode: json['sectionCode'],
      sanctionNo: json['sanctionNo'],
      poleALat: json['poleALat'],
      poleALon: json['poleALon'],
      poleBLat: json['poleBLat'],
      poleBLon: json['poleBLon'],
      poleAImageUrl: json['poleAImageUrl'],
      poleBImageUrl: json['poleBImageUrl'],
      surveyorId: json['surveyorId'],
      timeOfSurveyor: json['timeOfSurveyor'],
      remarksBySurveyor: json['remarksBySurveyor'],
      feederCode: json['feederCode'],
      poleType: json['poleType'],
      dateOfAbMarked: json['dateOfAbMarked'],
      feederName: json['feederName'],
      status: json['status'],
      monthYear: json['monthYear'],
      workDescription: json['workDescription'],
      circleCode: json['circleCode'],
      divisionCode: json['divisionCode'],
      subdivisionCode: json['subdivisionCode'],
      section: json['section'],
      subdivision: json['subdivision'],
      division: json['division'],
      circle: json['circle'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surveyId': surveyId,
      'sectionCode': sectionCode,
      'sanctionNo': sanctionNo,
      'poleALat': poleALat,
      'poleALon': poleALon,
      'poleBLat': poleBLat,
      'poleBLon': poleBLon,
      'poleAImageUrl': poleAImageUrl,
      'poleBImageUrl': poleBImageUrl,
      'surveyorId': surveyorId,
      'timeOfSurveyor': timeOfSurveyor,
      'remarksBySurveyor': remarksBySurveyor,
      'feederCode': feederCode,
      'poleType': poleType,
      'dateOfAbMarked': dateOfAbMarked,
      'feederName': feederName,
      'status': status,
      'monthYear': monthYear,
      'workDescription': workDescription,
      'circleCode': circleCode,
      'divisionCode': divisionCode,
      'subdivisionCode': subdivisionCode,
      'section': section,
      'subdivision': subdivision,
      'division': division,
      'circle': circle,
      'distance': distance,
    };
  }
}


//import 'dart:convert';
//
// String rawJson = /* your JSON string here */;
// List<dynamic> surveyList = json.decode(json.decode(rawJson)["objectJson"]);
// List<Survey> surveys = surveyList.map((e) => Survey.fromJson(e)).toList();