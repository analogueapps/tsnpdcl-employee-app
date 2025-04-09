import 'dart:convert';

GisSurveyData gisSurveyDataFromJson(String str) => GisSurveyData.fromJson(json.decode(str));

String gisSurveyDataToJson(GisSurveyData data) => json.encode(data.toJson());

class GisSurveyData {
  GisSurveyData({
    required this.surveyId,
    required this.sectionCode,
    required this.sanctionNo,
    required this.beforeLat,
    required this.pbeforeLon,
    required this.beforeImageUrl,
    required this.surveyorId,
    required this.timeOfSurveyor,
    required this.feederCode,
    required this.lineType,
    required this.dateOfBeforeMarked,
    required this.feederName,
    required this.status,
    required this.monthYear,
    required this.workDescription,
    required this.circleCode,
    required this.circle,
    required this.divisionCode,
    required this.division,
    required this.subdivision,
    required this.subdivisionCode,
    required this.section,
    required this.gisId,
    required this.sapUploadFlag,
    required this.pointVoltage,
  });

  GisSurveyData.fromJson(dynamic json) {
    try {
      surveyId = json['surveyId'] is int ? json['surveyId'] as int : int.tryParse(json['surveyId']?.toString() ?? '') ?? 0;
      sectionCode = json['sectionCode']?.toString() ?? '';
      sanctionNo = json['sanctionNo']?.toString() ?? '';
      beforeLat = json['beforeLat'] is double
          ? json['beforeLat'] as double
          : double.tryParse(json['beforeLat']?.toString() ?? '') ?? 0.0;
      pbeforeLon = json['pbeforeLon'] is double
          ? json['pbeforeLon'] as double
          : double.tryParse(json['pbeforeLon']?.toString() ?? '') ?? 0.0;
      beforeImageUrl = json['beforeImageUrl']?.toString() ?? '';
      surveyorId = json['surveyorId']?.toString() ?? '';
      timeOfSurveyor = json['timeOfSurveyor']?.toString() ?? '';
      feederCode = json['feederCode']?.toString() ?? '';
      lineType = json['lineType']?.toString() ?? '';
      dateOfBeforeMarked = json['dateOfBeforeMarked']?.toString() ?? '';
      feederName = json['feederName']?.toString() ?? '';
      status = json['status']?.toString() ?? '';
      monthYear = json['monthYear']?.toString() ?? '';
      workDescription = json['workDescription']?.toString() ?? '';
      circleCode = json['circleCode']?.toString() ?? '';
      circle = json['circle']?.toString() ?? '';
      divisionCode = json['divisionCode']?.toString() ?? '';
      division = json['division']?.toString() ?? '';
      subdivision = json['subdivision']?.toString() ?? '';
      subdivisionCode = json['subdivisionCode']?.toString() ?? '';
      section = json['section']?.toString() ?? '';
      gisId = json['gisId'] is int ? json['gisId'] as int : int.tryParse(json['gisId']?.toString() ?? '') ?? 0;
      sapUploadFlag = json['sapUploadFlag']?.toString() ?? '';
      pointVoltage = json['pointVoltage']?.toString() ?? '';
    } catch (e) {
      print("Error parsing GisSurveyData: $e");
      throw FormatException("Invalid GIS survey data format");
    }
  }

  int? surveyId;
  String? sectionCode;
  String? sanctionNo;
  double? beforeLat;
  double? pbeforeLon;
  String? beforeImageUrl;
  String? surveyorId;
  String? timeOfSurveyor;
  String? feederCode;
  String? lineType;
  String? dateOfBeforeMarked;
  String? feederName;
  String? status;
  String? monthYear;
  String? workDescription;
  String? circleCode;
  String? circle;
  String? divisionCode;
  String? division;
  String? subdivision;
  String? subdivisionCode;
  String? section;
  int? gisId;
  String? sapUploadFlag;
  String? pointVoltage;

  GisSurveyData copyWith({
    int? surveyId,
    String? sectionCode,
    String? sanctionNo,
    double? beforeLat,
    double? pbeforeLon,
    String? beforeImageUrl,
    String? surveyorId,
    String? timeOfSurveyor,
    String? feederCode,
    String? lineType,
    String? dateOfBeforeMarked,
    String? feederName,
    String? status,
    String? monthYear,
    String? workDescription,
    String? circleCode,
    String? circle,
    String? divisionCode,
    String? division,
    String? subdivision,
    String? subdivisionCode,
    String? section,
    int? gisId,
    String? sapUploadFlag,
    String? pointVoltage,
  }) =>
      GisSurveyData(
        surveyId: surveyId ?? this.surveyId,
        sectionCode: sectionCode ?? this.sectionCode,
        sanctionNo: sanctionNo ?? this.sanctionNo,
        beforeLat: beforeLat ?? this.beforeLat,
        pbeforeLon: pbeforeLon ?? this.pbeforeLon,
        beforeImageUrl: beforeImageUrl ?? this.beforeImageUrl,
        surveyorId: surveyorId ?? this.surveyorId,
        timeOfSurveyor: timeOfSurveyor ?? this.timeOfSurveyor,
        feederCode: feederCode ?? this.feederCode,
        lineType: lineType ?? this.lineType,
        dateOfBeforeMarked: dateOfBeforeMarked ?? this.dateOfBeforeMarked,
        feederName: feederName ?? this.feederName,
        status: status ?? this.status,
        monthYear: monthYear ?? this.monthYear,
        workDescription: workDescription ?? this.workDescription,
        circleCode: circleCode ?? this.circleCode,
        circle: circle ?? this.circle,
        divisionCode: divisionCode ?? this.divisionCode,
        division: division ?? this.division,
        subdivision: subdivision ?? this.subdivision,
        subdivisionCode: subdivisionCode ?? this.subdivisionCode,
        section: section ?? this.section,
        gisId: gisId ?? this.gisId,
        sapUploadFlag: sapUploadFlag ?? this.sapUploadFlag,
        pointVoltage: pointVoltage ?? this.pointVoltage,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['surveyId'] = surveyId;
    map['sectionCode'] = sectionCode;
    map['sanctionNo'] = sanctionNo;
    map['beforeLat'] = beforeLat;
    map['pbeforeLon'] = pbeforeLon;
    map['beforeImageUrl'] = beforeImageUrl;
    map['surveyorId'] = surveyorId;
    map['timeOfSurveyor'] = timeOfSurveyor;
    map['feederCode'] = feederCode;
    map['lineType'] = lineType;
    map['dateOfBeforeMarked'] = dateOfBeforeMarked;
    map['feederName'] = feederName;
    map['status'] = status;
    map['monthYear'] = monthYear;
    map['workDescription'] = workDescription;
    map['circleCode'] = circleCode;
    map['circle'] = circle;
    map['divisionCode'] = divisionCode;
    map['division'] = division;
    map['subdivision'] = subdivision;
    map['subdivisionCode'] = subdivisionCode;
    map['section'] = section;
    map['gisId'] = gisId;
    map['sapUploadFlag'] = sapUploadFlag;
    map['pointVoltage'] = pointVoltage;
    return map;
  }
}