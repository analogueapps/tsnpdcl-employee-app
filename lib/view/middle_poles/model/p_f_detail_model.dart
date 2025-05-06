class PFDetailModel {
  bool editable;
  int surveyId;
  String status;
  String feederName;
  String workDescription;
  String poleType;
  String sectionCode;
  String sanctionNo;
  String poleAImageUrl;
  double poleALat;
  double poleALon;
  String poleBImageUrl;
  double poleBLat;
  double poleBLon;
  String distance;
  String remarksBySurveyor;
  String surveyorId;
  String timeOfSurveyor;
  String feederCode;
  int? dateOfAbMarkedAsLong;
  String? dateOfAbMarked;
  int? dateOfMpMarkedAsLong;
  List<FormControl>? formControlList;
  List<RowItem>? rowList;
  double? middlePoleLat;
  double? middlePoleLon;
  String? middlePoleImageUrl;
  String? circleCode;
  String? divisionCode;
  String? subdivisionCode;
  String? section;
  String? subdivision;
  String? division;
  String? circle;
  String? monthYear;


  PFDetailModel({
    required this.editable,
    required this.surveyId,
    required this.status,
    required this.feederName,
    required this.workDescription,
    required this.poleType,
    required this.sectionCode,
    required this.sanctionNo,
    required this.poleAImageUrl,
    required this.poleALat,
    required this.poleALon,
    required this.poleBImageUrl,
    required this.poleBLat,
    required this.poleBLon,
    required this.distance,
    required this.remarksBySurveyor,
    required this.surveyorId,
    required this.timeOfSurveyor,
    required this.feederCode,
     this.dateOfAbMarkedAsLong,
     this.dateOfAbMarked,
     this.dateOfMpMarkedAsLong,
     this.formControlList,
     this.rowList,
    this.middlePoleLat,
     this.middlePoleLon,
     this.middlePoleImageUrl,
     this.circleCode,
     this.divisionCode,
     this.subdivisionCode,
     this.section,
     this.subdivision,
     this.division,
     this.circle,
     this.monthYear,
  });

  factory PFDetailModel.fromJson(Map<String, dynamic> json) => PFDetailModel(
    editable: json['editable'] ?? false,
    surveyId: json['surveyId'],
    status: json['status'] ?? '',
    feederName: json['feederName'] ?? '',
    workDescription: json['workDescription'] ?? '',
    poleType: json['poleType'] ?? '',
    sectionCode: json['sectionCode'] ?? '',
    sanctionNo: json['sanctionNo'] ?? '',
    poleAImageUrl: json['poleAImageUrl'] ?? '',
    poleALat: (json['poleALat'] ?? 0).toDouble(),
    poleALon: (json['poleALon'] ?? 0).toDouble(),
    poleBImageUrl: json['poleBImageUrl'] ?? '',
    poleBLat: (json['poleBLat'] ?? 0).toDouble(),
    poleBLon: (json['poleBLon'] ?? 0).toDouble(),
    distance: json['distance'] ?? '',
    remarksBySurveyor: json['remarksBySurveyor'] ?? '',
    surveyorId: json['surveyorId'] ?? '',
    timeOfSurveyor: json['timeOfSurveyor'] ?? '',
    feederCode: json['feederCode'] ?? '',
    dateOfAbMarkedAsLong: json['dateOfAbMarkedAsLong'],
    dateOfAbMarked: json['dateOfAbMarked'],
    dateOfMpMarkedAsLong: json['dateOfMpMarkedAsLong'],
    formControlList: json['formControlList'] != null
        ? List<FormControl>.from(json['formControlList'].map((x) => FormControl.fromJson(x)))
        : null,
    rowList: json['rowList'] != null
        ? List<RowItem>.from(json['rowList'].map((x) => RowItem.fromJson(x)))
        : null,
    middlePoleLat: (json['middlePoleLat'] ?? 0).toDouble(),
    middlePoleLon: (json['middlePoleLon'] ?? 0).toDouble(),
    middlePoleImageUrl: json['middlePoleImageUrl'] ?? '',
    circleCode: json['circleCode'] ?? '',
    divisionCode: json['divisionCode'] ?? '',
    subdivisionCode: json['subdivisionCode'] ?? '',
    section: json['section'] ?? '',
    subdivision: json['subdivision'] ?? '',
    division: json['division'] ?? '',
    circle: json['circle'] ?? '',
    monthYear: json['monthYear'] ?? '',
  );
}


class FormControl {
  String viewType;
  String id;
  String? label;
  bool focusable;
  bool skip;
  bool wrapInTextInputLayout;
  bool verticalLabeling;
  bool clickable;
  int maxLength;
  int minLength;
  String? inputType;
  String? hint;
  String? text;
  String? hintTextColor;
  String? textColor;
  bool fetchItemsOnNetwork;
  bool allowSelectionAtZeroIndex;
  bool requireFurtherSelection;
  bool fetchOptionsOnItemSelected;
  bool useFirebaseAuth;
  String? title;
  String? description;
  int width;
  int height;
  int scaleType;
  String? uploadUrl;
  bool captureRequired;
  bool required;
  bool signatureEditable;
  String? buttonText;
  String? longitudeFieldName;
  double? minimumAccuracy;
  String? latitudeFieldName;
  String? httpMethod;
  String? servletPath;

  FormControl({
    required this.viewType,
    required this.id,
    this.label,
    required this.focusable,
    required this.skip,
    required this.wrapInTextInputLayout,
    required this.verticalLabeling,
    required this.clickable,
    required this.maxLength,
    required this.minLength,
    this.inputType,
    this.hint,
    this.text,
    this.hintTextColor,
    this.textColor,
    required this.fetchItemsOnNetwork,
    required this.allowSelectionAtZeroIndex,
    required this.requireFurtherSelection,
    required this.fetchOptionsOnItemSelected,
    required this.useFirebaseAuth,
    this.title,
    this.description,
    required this.width,
    required this.height,
    required this.scaleType,
    this.uploadUrl,
    required this.captureRequired,
    required this.required,
    required this.signatureEditable,
    this.buttonText,
    this.longitudeFieldName,
    this.minimumAccuracy,
    this.latitudeFieldName,
    this.httpMethod,
    this.servletPath,
  });

  factory FormControl.fromJson(Map<String, dynamic> json) => FormControl(
    viewType: json['viewType'],
    id: json['id'],
    label: json['label'],
    focusable: json['focusable'],
    skip: json['skip'],
    wrapInTextInputLayout: json['wrapInTextInputLayout'],
    verticalLabeling: json['verticalLabeling'],
    clickable: json['clickable'],
    maxLength: json['maxLength'],
    minLength: json['minLength'],
    inputType: json['inputType'],
    hint: json['hint'],
    text: json['text'],
    hintTextColor: json['hintTextColor'],
    textColor: json['textColor'],
    fetchItemsOnNetwork: json['fetchItemsOnNetwork'],
    allowSelectionAtZeroIndex: json['allowSelectionAtZeroIndex'],
    requireFurtherSelection: json['requireFurtherSelection'],
    fetchOptionsOnItemSelected: json['fetchOptionsOnItemSelected'],
    useFirebaseAuth: json['useFirebaseAuth'],
    title: json['title'],
    description: json['description'],
    width: json['width'],
    height: json['height'],
    scaleType: json['scaleType'],
    uploadUrl: json['uploadUrl'],
    captureRequired: json['captureRequired'],
    required: json['required'],
    signatureEditable: json['signatureEditable'],
    buttonText: json['buttonText'],
    longitudeFieldName: json['longitudeFieldName'],
    minimumAccuracy: (json['minimumAccuracy'] ?? 0).toDouble(),
    latitudeFieldName: json['latitudeFieldName'],
    httpMethod: json['httpMethod'],
    servletPath: json['servletPath'],
  );
}

class RowItem {
  String? label;
  dynamic value;
  String? displayValue;
  String? labelColor;
  String? valueColor;
  int width;
  int height;
  int scaleType;
  int rowType;
  double latitude;
  double longitude;
  HeaderBar? headerBar;
  String? title;
  String? description;
  String? url;
  String? id;

  RowItem({
    this.label,
    this.value,
    this.displayValue,
    this.labelColor,
    this.valueColor,
    required this.width,
    required this.height,
    required this.scaleType,
    required this.rowType,
    required this.latitude,
    required this.longitude,
    this.headerBar,
    this.title,
    this.description,
    this.url,
    this.id,
  });

  factory RowItem.fromJson(Map<String, dynamic> json) => RowItem(
    label: json['label'],
    value: json['value'],
    displayValue: json['displayValue'],
    labelColor: json['labelColor'],
    valueColor: json['valueColor'],
    width: json['width'],
    height: json['height'],
    scaleType: json['scaleType'],
    rowType: json['rowType'],
    latitude: (json['latitude'] ?? 0).toDouble(),
    longitude: (json['longitude'] ?? 0).toDouble(),
    headerBar: json['headerBar'] != null
        ? HeaderBar.fromJson(json['headerBar'])
        : null,
    title: json['title'],
    description: json['description'],
    url: json['url'],
    id: json['id'],
  );
}

class HeaderBar {
  String backGroundColor;
  String label;
  String labelColor;

  HeaderBar({
    required this.backGroundColor,
    required this.label,
    required this.labelColor,
  });

  factory HeaderBar.fromJson(Map<String, dynamic> json) => HeaderBar(
    backGroundColor: json['backGroundColor'],
    label: json['label'],
    labelColor: json['labelColor'],
  );
}
