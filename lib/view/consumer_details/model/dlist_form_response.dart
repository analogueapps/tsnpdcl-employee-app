import 'dart:convert';

DlistFormResponse dlistFormResponseFromJson(String str) =>
    DlistFormResponse.fromJson(json.decode(str));

String dlistFormResponseToJson(DlistFormResponse data) =>
    json.encode(data.toJson());

class DlistFormResponse {
  DlistFormResponse({
    this.editable,
    this.scno,
    this.uscno,
    this.consumerName,
    this.category,
    this.section,
    this.address,
    this.amountDue,
    this.billAmount,
    this.billDate,
    this.db,
    this.discDate,
    this.dueDate,
    this.ero,
    this.errorCause,
    this.status,
    this.rowList,
    this.formControlList,
  });

  DlistFormResponse.fromJson(dynamic json) {
    editable = json['editable'];
    scno = json['scno'];
    uscno = json['uscno'];
    consumerName = json['consumerName'];
    category = json['category'];
    section = json['section'];
    address = json['address'];
    amountDue = json['amountDue'];
    billAmount = json['billAmount'];
    billDate = json['billDate'];
    db = json['db'];
    discDate = json['discDate'];
    dueDate = json['dueDate'];
    ero = json['ero'];
    errorCause = json['errorCause'];
    status = json['status'];
    if (json['rowList'] != null) {
      rowList = [];
      json['rowList'].forEach((v) {
        rowList?.add(RowList.fromJson(v));
      });
    }
    if (json['formControlList'] != null) {
      formControlList = [];
      json['formControlList'].forEach((v) {
        formControlList?.add(FormControlList.fromJson(v));
      });
    }
  }

  bool? editable;
  String? scno;
  String? uscno;
  String? consumerName;
  String? category;
  String? section;
  String? address;
  String? amountDue;
  String? billAmount;
  String? billDate;
  String? db;
  String? discDate;
  String? dueDate;
  String? ero;
  String? errorCause;
  String? status;
  List<RowList>? rowList;
  List<FormControlList>? formControlList;

  DlistFormResponse copyWith({
    bool? editable,
    String? scno,
    String? uscno,
    String? consumerName,
    String? category,
    String? section,
    String? address,
    String? amountDue,
    String? billAmount,
    String? billDate,
    String? db,
    String? discDate,
    String? dueDate,
    String? ero,
    String? errorCause,
    String? status,
    List<RowList>? rowList,
    List<FormControlList>? formControlList,
  }) =>
      DlistFormResponse(
        editable: editable ?? this.editable,
        scno: scno ?? this.scno,
        uscno: uscno ?? this.uscno,
        consumerName: consumerName ?? this.consumerName,
        category: category ?? this.category,
        section: section ?? this.section,
        address: address ?? this.address,
        amountDue: amountDue ?? this.amountDue,
        billAmount: billAmount ?? this.billAmount,
        billDate: billDate ?? this.billDate,
        db: db ?? this.db,
        discDate: discDate ?? this.discDate,
        dueDate: dueDate ?? this.dueDate,
        ero: ero ?? this.ero,
        errorCause: errorCause ?? this.errorCause,
        status: status ?? this.status,
        rowList: rowList ?? this.rowList,
        formControlList: formControlList ?? this.formControlList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['editable'] = editable;
    map['scno'] = scno;
    map['uscno'] = uscno;
    map['consumerName'] = consumerName;
    map['category'] = category;
    map['section'] = section;
    map['address'] = address;
    map['amountDue'] = amountDue;
    map['billAmount'] = billAmount;
    map['billDate'] = billDate;
    map['db'] = db;
    map['discDate'] = discDate;
    map['dueDate'] = dueDate;
    map['ero'] = ero;
    map['errorCause'] = errorCause;
    map['status'] = status;
    if (rowList != null) {
      map['rowList'] = rowList?.map((v) => v.toJson()).toList();
    }
    if (formControlList != null) {
      map['formControlList'] = formControlList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

FormControlList formControlListFromJson(String str) =>
    FormControlList.fromJson(json.decode(str));

String formControlListToJson(FormControlList data) =>
    json.encode(data.toJson());

class FormControlList {
  FormControlList({
    this.viewType,
    this.label,
    this.id,
    this.focusable,
    this.inputType,
    this.skip,
    this.wrapInTextInputLayout,
    this.verticalLabeling,
    this.clickable,
    this.maxLength,
    this.minLength,
    this.hint,
    this.text,
    this.hintTextColor,
    this.textColor,
    this.fetchItemsOnNetwork,
    this.allowSelectionAtZeroIndex,
    this.requireFurtherSelection,
    this.httpMethod,
    this.servletPath,
    this.fetchOptionsOnItemSelected,
    this.useFirebaseAuth,
    this.width,
    this.height,
    this.scaleType,
    this.actualValue,
    this.captureRequired,
    this.required,
    this.signatureEditable,
    this.minimumAccuracy,
  });

  FormControlList.fromJson(dynamic json) {
    viewType = json['viewType'];
    label = json['label'];
    id = json['id'];
    focusable = json['focusable'];
    inputType = json['inputType'];
    skip = json['skip'];
    wrapInTextInputLayout = json['wrapInTextInputLayout'];
    verticalLabeling = json['verticalLabeling'];
    clickable = json['clickable'];
    maxLength = json['maxLength'];
    minLength = json['minLength'];
    hint = json['hint'];
    text = json['text'];
    hintTextColor = json['hintTextColor'];
    textColor = json['textColor'];
    fetchItemsOnNetwork = json['fetchItemsOnNetwork'];
    allowSelectionAtZeroIndex = json['allowSelectionAtZeroIndex'];
    requireFurtherSelection = json['requireFurtherSelection'];
    httpMethod = json['httpMethod'];
    servletPath = json['servletPath'];
    fetchOptionsOnItemSelected = json['fetchOptionsOnItemSelected'];
    useFirebaseAuth = json['useFirebaseAuth'];
    width = json['width'];
    height = json['height'];
    scaleType = json['scaleType'];
    actualValue = json['actualValue'];
    captureRequired = json['captureRequired'];
    required = json['required'];
    signatureEditable = json['signatureEditable'];
    minimumAccuracy = json['minimumAccuracy'];
  }

  String? viewType;
  String? label;
  String? id;
  bool? focusable;
  String? inputType;
  bool? skip;
  bool? wrapInTextInputLayout;
  bool? verticalLabeling;
  bool? clickable;
  num? maxLength;
  num? minLength;
  String? hint;
  String? text;
  String? hintTextColor;
  String? textColor;
  bool? fetchItemsOnNetwork;
  bool? allowSelectionAtZeroIndex;
  bool? requireFurtherSelection;
  String? httpMethod;
  String? servletPath;
  bool? fetchOptionsOnItemSelected;
  bool? useFirebaseAuth;
  num? width;
  num? height;
  num? scaleType;
  String? actualValue;
  bool? captureRequired;
  bool? required;
  bool? signatureEditable;
  num? minimumAccuracy;

  FormControlList copyWith({
    String? viewType,
    String? label,
    String? id,
    bool? focusable,
    String? inputType,
    bool? skip,
    bool? wrapInTextInputLayout,
    bool? verticalLabeling,
    bool? clickable,
    num? maxLength,
    num? minLength,
    String? hint,
    String? text,
    String? hintTextColor,
    String? textColor,
    bool? fetchItemsOnNetwork,
    bool? allowSelectionAtZeroIndex,
    bool? requireFurtherSelection,
    String? httpMethod,
    String? servletPath,
    bool? fetchOptionsOnItemSelected,
    bool? useFirebaseAuth,
    num? width,
    num? height,
    num? scaleType,
    String? actualValue,
    bool? captureRequired,
    bool? required,
    bool? signatureEditable,
    num? minimumAccuracy,
  }) =>
      FormControlList(
        viewType: viewType ?? this.viewType,
        label: label ?? this.label,
        id: id ?? this.id,
        focusable: focusable ?? this.focusable,
        inputType: inputType ?? this.inputType,
        skip: skip ?? this.skip,
        wrapInTextInputLayout:
            wrapInTextInputLayout ?? this.wrapInTextInputLayout,
        verticalLabeling: verticalLabeling ?? this.verticalLabeling,
        clickable: clickable ?? this.clickable,
        maxLength: maxLength ?? this.maxLength,
        minLength: minLength ?? this.minLength,
        hint: hint ?? this.hint,
        text: text ?? this.text,
        hintTextColor: hintTextColor ?? this.hintTextColor,
        textColor: textColor ?? this.textColor,
        fetchItemsOnNetwork: fetchItemsOnNetwork ?? this.fetchItemsOnNetwork,
        allowSelectionAtZeroIndex:
            allowSelectionAtZeroIndex ?? this.allowSelectionAtZeroIndex,
        requireFurtherSelection:
            requireFurtherSelection ?? this.requireFurtherSelection,
        httpMethod: httpMethod ?? this.httpMethod,
        servletPath: servletPath ?? this.servletPath,
        fetchOptionsOnItemSelected:
            fetchOptionsOnItemSelected ?? this.fetchOptionsOnItemSelected,
        useFirebaseAuth: useFirebaseAuth ?? this.useFirebaseAuth,
        width: width ?? this.width,
        height: height ?? this.height,
        scaleType: scaleType ?? this.scaleType,
        actualValue: actualValue ?? this.actualValue,
        captureRequired: captureRequired ?? this.captureRequired,
        required: required ?? this.required,
        signatureEditable: signatureEditable ?? this.signatureEditable,
        minimumAccuracy: minimumAccuracy ?? this.minimumAccuracy,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['viewType'] = viewType;
    map['label'] = label;
    map['id'] = id;
    map['focusable'] = focusable;
    map['inputType'] = inputType;
    map['skip'] = skip;
    map['wrapInTextInputLayout'] = wrapInTextInputLayout;
    map['verticalLabeling'] = verticalLabeling;
    map['clickable'] = clickable;
    map['maxLength'] = maxLength;
    map['minLength'] = minLength;
    map['hint'] = hint;
    map['text'] = text;
    map['hintTextColor'] = hintTextColor;
    map['textColor'] = textColor;
    map['fetchItemsOnNetwork'] = fetchItemsOnNetwork;
    map['allowSelectionAtZeroIndex'] = allowSelectionAtZeroIndex;
    map['requireFurtherSelection'] = requireFurtherSelection;
    map['httpMethod'] = httpMethod;
    map['servletPath'] = servletPath;
    map['fetchOptionsOnItemSelected'] = fetchOptionsOnItemSelected;
    map['useFirebaseAuth'] = useFirebaseAuth;
    map['width'] = width;
    map['height'] = height;
    map['scaleType'] = scaleType;
    map['actualValue'] = actualValue;
    map['captureRequired'] = captureRequired;
    map['required'] = required;
    map['signatureEditable'] = signatureEditable;
    map['minimumAccuracy'] = minimumAccuracy;
    return map;
  }
}

RowList rowListFromJson(String str) => RowList.fromJson(json.decode(str));

String rowListToJson(RowList data) => json.encode(data.toJson());

class RowList {
  RowList({
    this.label,
    this.value,
    this.displayValue,
    this.labelColor,
    this.valueColor,
    this.width,
    this.height,
    this.scaleType,
    this.rowType,
    this.latitude,
    this.longitude,
  });

  RowList.fromJson(dynamic json) {
    label = json['label'];
    value = json['value'];
    displayValue = json['displayValue'];
    labelColor = json['labelColor'];
    valueColor = json['valueColor'];
    width = json['width'];
    height = json['height'];
    scaleType = json['scaleType'];
    rowType = json['rowType'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  String? label;
  String? value;
  String? displayValue;
  String? labelColor;
  String? valueColor;
  num? width;
  num? height;
  num? scaleType;
  num? rowType;
  num? latitude;
  num? longitude;

  RowList copyWith({
    String? label,
    String? value,
    String? displayValue,
    String? labelColor,
    String? valueColor,
    num? width,
    num? height,
    num? scaleType,
    num? rowType,
    num? latitude,
    num? longitude,
  }) =>
      RowList(
        label: label ?? this.label,
        value: value ?? this.value,
        displayValue: displayValue ?? this.displayValue,
        labelColor: labelColor ?? this.labelColor,
        valueColor: valueColor ?? this.valueColor,
        width: width ?? this.width,
        height: height ?? this.height,
        scaleType: scaleType ?? this.scaleType,
        rowType: rowType ?? this.rowType,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    map['displayValue'] = displayValue;
    map['labelColor'] = labelColor;
    map['valueColor'] = valueColor;
    map['width'] = width;
    map['height'] = height;
    map['scaleType'] = scaleType;
    map['rowType'] = rowType;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}
