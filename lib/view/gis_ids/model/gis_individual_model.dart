import 'dart:convert';

GisSurveyData gisSurveyDataFromJson(String str) =>
    GisSurveyData.fromJson(json.decode(str));

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
    required this.editable,
    required this.afterImageUrl,
    required this.afterLat,
    required this.remarksBySurveyor,
    required this.afterLon,
    required this.dateOfBeforeMarkedAsLong,
    required this.dateOfAfterMarked,
    required this.dateOfAfterMarkedAsLong,
    required this.formControlList,
    required this.rowList,
  });

  GisSurveyData.fromJson(dynamic json) {
    try {
      surveyId = json['surveyId'] is int
          ? json['surveyId'] as int
          : int.tryParse(json['surveyId']?.toString() ?? '') ?? 0;
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
      gisId = json['gisId'] is int
          ? json['gisId'] as int
          : int.tryParse(json['gisId']?.toString() ?? '') ?? 0;
      sapUploadFlag = json['sapUploadFlag']?.toString() ?? '';
      pointVoltage = json['pointVoltage']?.toString() ?? '';
      editable = json['editable'] as bool? ?? false;
      afterImageUrl = json['afterImageUrl']?.toString() ?? '';
      afterLat = json['afterLat'] is double
          ? json['afterLat'] as double
          : double.tryParse(json['afterLat']?.toString() ?? '') ?? 0.0;
      afterLon = json['afterLon'] is double
          ? json['afterLon'] as double
          : double.tryParse(json['afterLon']?.toString() ?? '') ?? 0.0;
      dateOfBeforeMarkedAsLong = json['dateOfBeforeMarkedAsLong'] is int
          ? json['dateOfBeforeMarkedAsLong'] as int
          : int.tryParse(json['dateOfBeforeMarkedAsLong']?.toString() ?? '') ??
              0;
      dateOfAfterMarked = json['dateOfAfterMarked']?.toString() ?? '';
      dateOfAfterMarkedAsLong = json['dateOfAfterMarkedAsLong'] is int
          ? json['dateOfAfterMarkedAsLong'] as int
          : int.tryParse(json['dateOfAfterMarkedAsLong']?.toString() ?? '') ??
              0;
      formControlList = json['formControlList'] is List
          ? List<dynamic>.from(json['formControlList'])
          : [];
      rowList = (json['rowList'] as List<dynamic>?)
              ?.map((e) => RowListItem.fromJson(e))
              .toList() ??
          [];
    } catch (e) {
      print("Error parsing GisSurveyData: $e");
      throw const FormatException("Invalid GIS survey data format");
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
  bool? editable;
  String? afterImageUrl;
  double? afterLat;
  double? afterLon;
  int? dateOfBeforeMarkedAsLong;
  String? dateOfAfterMarked;
  String? remarksBySurveyor;
  int? dateOfAfterMarkedAsLong;
  List<dynamic>? formControlList;
  List<RowListItem>? rowList;

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
    bool? editable,
    String? afterImageUrl,
    double? afterLat,
    String? remarksBySurveyor,
    double? afterLon,
    int? dateOfBeforeMarkedAsLong,
    String? dateOfAfterMarked,
    int? dateOfAfterMarkedAsLong,
    List<dynamic>? formControlList,
    List<RowListItem>? rowList,
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
        editable: editable ?? this.editable,
        afterImageUrl: afterImageUrl ?? this.afterImageUrl,
        afterLat: afterLat ?? this.afterLat,
        afterLon: afterLon ?? this.afterLon,
        dateOfBeforeMarkedAsLong:
            dateOfBeforeMarkedAsLong ?? this.dateOfBeforeMarkedAsLong,
        remarksBySurveyor: remarksBySurveyor ?? this.remarksBySurveyor,
        dateOfAfterMarked: dateOfAfterMarked ?? this.dateOfAfterMarked,
        dateOfAfterMarkedAsLong:
            dateOfAfterMarkedAsLong ?? this.dateOfAfterMarkedAsLong,
        formControlList: formControlList ?? this.formControlList,
        rowList: rowList ?? this.rowList,
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
    map['editable'] = editable;
    map['afterImageUrl'] = afterImageUrl;
    map['afterLat'] = afterLat;
    map['afterLon'] = afterLon;
    map['dateOfBeforeMarkedAsLong'] = dateOfBeforeMarkedAsLong;
    map[' remarksBySurveyor;'] = remarksBySurveyor;
    map['dateOfAfterMarked'] = dateOfAfterMarked;
    map['dateOfAfterMarkedAsLong'] = dateOfAfterMarkedAsLong;
    map['formControlList'] = formControlList;
    map['rowList'] = rowList?.map((e) => e.toJson()).toList();
    return map;
  }

  @override
  String toString() {
    return '''
GisSurveyData(
  surveyId: $surveyId,
  sectionCode: $sectionCode,
  sanctionNo: $sanctionNo,
  beforeLat: $beforeLat,
  pbeforeLon: $pbeforeLon,
  beforeImageUrl: $beforeImageUrl,
  surveyorId: $surveyorId,
  timeOfSurveyor: $timeOfSurveyor,
  feederCode: $feederCode,
  lineType: $lineType,
  dateOfBeforeMarked: $dateOfBeforeMarked,
  feederName: $feederName,
  status: $status,
  monthYear: $monthYear,
  workDescription: $workDescription,
  circleCode: $circleCode,
  circle: $circle,
  divisionCode: $divisionCode,
  division: $division,
  subdivision: $subdivision,
  subdivisionCode: $subdivisionCode,
  section: $section,
  gisId: $gisId,
  sapUploadFlag: $sapUploadFlag,
  pointVoltage: $pointVoltage,
  editable: $editable,
  afterImageUrl: $afterImageUrl,
  afterLat: $afterLat,
  remarksBySurveyor:$remarksBySurveyor;
  afterLon: $afterLon,
  dateOfBeforeMarkedAsLong: $dateOfBeforeMarkedAsLong,
  dateOfAfterMarked: $dateOfAfterMarked,
  dateOfAfterMarkedAsLong: $dateOfAfterMarkedAsLong,
  formControlList: $formControlList,
  rowList: $rowList
)''';
  }
}

class RowListItem {
  RowListItem({
    this.label,
    this.value,
    this.displayValue,
    this.labelColor,
    this.valueColor,
    this.headerBar,
    this.width,
    this.height,
    this.scaleType,
    this.rowType,
    this.latitude,
    this.longitude,
    this.title,
    this.description,
    this.url,
    this.id,
  });

  RowListItem.fromJson(Map<String, dynamic> json) {
    label = json['label']?.toString();
    value = json['value'];
    displayValue = json['displayValue']?.toString();
    labelColor = json['labelColor']?.toString();
    valueColor = json['valueColor']?.toString();
    headerBar = json['headerBar'] != null
        ? HeaderBar.fromJson(json['headerBar'])
        : null;
    width = json['width'] is int
        ? json['width'] as int
        : int.tryParse(json['width']?.toString() ?? '') ?? 0;
    height = json['height'] is int
        ? json['height'] as int
        : int.tryParse(json['height']?.toString() ?? '') ?? 0;
    scaleType = json['scaleType'] is int
        ? json['scaleType'] as int
        : int.tryParse(json['scaleType']?.toString() ?? '') ?? 0;
    rowType = json['rowType'] is int
        ? json['rowType'] as int
        : int.tryParse(json['rowType']?.toString() ?? '') ?? 0;
    latitude = json['latitude'] is double
        ? json['latitude'] as double
        : double.tryParse(json['latitude']?.toString() ?? '') ?? 0.0;
    longitude = json['longitude'] is double
        ? json['longitude'] as double
        : double.tryParse(json['longitude']?.toString() ?? '') ?? 0.0;
    title = json['title']?.toString();
    description = json['description']?.toString();
    url = json['url']?.toString();
    id = json['id']?.toString();
  }

  String? label;
  dynamic value;
  String? displayValue;
  String? labelColor;
  String? valueColor;
  HeaderBar? headerBar;
  int? width;
  int? height;
  int? scaleType;
  int? rowType;
  double? latitude;
  double? longitude;
  String? title;
  String? description;
  String? url;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    map['displayValue'] = displayValue;
    map['labelColor'] = labelColor;
    map['valueColor'] = valueColor;
    if (headerBar != null) {
      map['headerBar'] = headerBar!.toJson();
    }
    map['width'] = width;
    map['height'] = height;
    map['scaleType'] = scaleType;
    map['rowType'] = rowType;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return '''
RowListItem(
  label: $label,
  value: $value,
  displayValue: $displayValue,
  labelColor: $labelColor,
  valueColor: $valueColor,
  headerBar: $headerBar,
  width: $width,
  height: $height,
  scaleType: $scaleType,
  rowType: $rowType,
  latitude: $latitude,
  longitude: $longitude,
  title: $title,
  description: $description,
  url: $url,
  id: $id
)''';
  }
}

class HeaderBar {
  HeaderBar({
    this.backGroundColor,
    this.label,
    this.labelColor,
  });

  HeaderBar.fromJson(Map<String, dynamic> json) {
    backGroundColor = json['backGroundColor']?.toString();
    label = json['label']?.toString();
    labelColor = json['labelColor']?.toString();
  }

  String? backGroundColor;
  String? label;
  String? labelColor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backGroundColor'] = backGroundColor;
    map['label'] = label;
    map['labelColor'] = labelColor;
    return map;
  }

  @override
  String toString() {
    return '''
HeaderBar(
  backGroundColor: $backGroundColor,
  label: $label,
  labelColor: $labelColor
)''';
  }
}
