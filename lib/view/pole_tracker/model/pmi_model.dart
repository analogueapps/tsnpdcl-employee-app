

class FormControl {
  String? viewType;
  String? label;
  String? id;
  bool focusable;
  String? inputType;
  bool? skip;
  bool? wrapInTextInputLayout;
  bool? verticalLabeling;
  bool? clickable;
  int? maxLength;
  int minLength;
  String? hint;
  String text;
  String hintTextColor;
  String textColor;
  List<String>? items; // For SPINNER
  HeaderBar? headerBar;
  bool? captureRequired;
  bool required;
  bool? signatureEditable;
  double? minimumAccuracy;

  FormControl({
    required this.viewType,
    required this.label,
    required this.id,
    required this.focusable,
    required this.inputType,
    required this.skip,
    required this.wrapInTextInputLayout,
    required this.verticalLabeling,
    required this.clickable,
    required this.maxLength,
    required this.minLength,
    required this.hint,
    required this.text,
    required this.hintTextColor,
    required this.textColor,
    this.items,
    this.headerBar,
    required this.captureRequired,
    required this.required,
    required this.signatureEditable,
    required this.minimumAccuracy,
  });

  factory FormControl.fromJson(Map<String, dynamic> json) {
    return FormControl(
      viewType: json['viewType'],
      label: json['label'],
      id: json['id'],
      focusable: json['focusable'] ?? false,
      inputType: json['inputType'],
      skip: json['skip'],
      wrapInTextInputLayout: json['wrapInTextInputLayout'],
      verticalLabeling: json['verticalLabeling'],
      clickable: json['clickable'],
      maxLength: json['maxLength'],
      minLength: json['minLength']??0,
      hint: json['hint'],
      text: json['text'] ?? '',
      hintTextColor: json['hintTextColor']??"",
      textColor: json['textColor']??"",
      items: json['items'] != null ? List<String>.from(json['items']) : null,
      headerBar: json['headerBar'] != null ? HeaderBar.fromJson(json['headerBar']) : null,
      captureRequired: json['captureRequired'] ?? false,
      required: json['required']?? false,
      signatureEditable: json['signatureEditable']?? false,
      minimumAccuracy: (json['minimumAccuracy']?? 0 as num).toDouble() ,
    );
  }

  @override
  String toString() {
    return 'FormControl('
        'viewType: $viewType, '
        'label: $label, '
        'id: $id, '
        'focusable: $focusable, '
        'inputType: $inputType, '
        'skip: $skip, '
        'wrapInTextInputLayout: $wrapInTextInputLayout, '
        'verticalLabeling: $verticalLabeling, '
        'clickable: $clickable, '
        'maxLength: $maxLength, '
        'minLength: $minLength, '
        'hint: $hint, '
        'text: $text, '
        'hintTextColor: $hintTextColor, '
        'textColor: $textColor, '
        'items: $items, '
        'headerBar: $headerBar, '
        'captureRequired: $captureRequired, '
        'required: $required, '
        'signatureEditable: $signatureEditable, '
        'minimumAccuracy: $minimumAccuracy'
        ')';
  }

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

  factory HeaderBar.fromJson(Map<String, dynamic> json) {
    return HeaderBar(
      backGroundColor: json['backGroundColor'] ??"",
      label: json['label']??"",
      labelColor: json['labelColor']??"",
    );
  }

  @override
  String toString() {
    return 'HeaderBar('
        'backGroundColor: $backGroundColor, '
        'label: $label, '
        'labelColor: $labelColor'
        ')';
  }


}

class RowItem {
  String label;
  String? value;
  String displayValue;
  String labelColor;
  String valueColor;
  HeaderBar? headerBar;

  RowItem({
    required this.label,
    this.value,
    required this.displayValue,
    required this.labelColor,
    required this.valueColor,
    this.headerBar,
  });

  factory RowItem.fromJson(Map<String, dynamic> json) {
    return RowItem(
      label: json['label'] ??"",
      value: json['value']?.toString() ??"",
      displayValue: json['displayValue']?? "",
      labelColor: json['labelColor'] ?? "",
      valueColor: json['valueColor'] ?? "",
      headerBar: json['headerBar'] != null ? HeaderBar.fromJson(json['headerBar']) : null,
    );
  }
  @override
  String toString() {
    return 'RowItem('
        'label: $label, '
        'value: $value, '
        'displayValue: $displayValue, '
        'labelColor: $labelColor, '
        'valueColor: $valueColor, '
        'headerBar: $headerBar'
        ')';
  }


}