import 'dart:convert';

class FormControl {
  int viewType;
  String label;
  int id;
  bool focusable;
  int inputType;
  bool skip;
  bool wrapInTextInputLayout;
  bool verticalLabeling;
  bool clickable;
  int maxLength;
  int minLength;
  String hint;
  String text;
  String hintTextColor;
  String textColor;
  List<String>? items; // For SPINNER
  HeaderBar? headerBar;
  bool captureRequired;
  bool required;
  bool signatureEditable;
  double minimumAccuracy;

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

  factory FormControl.fromJson(Map<int, dynamic> json) {
    return FormControl(
      viewType: json['viewType'],
      label: json['label'],
      id: json['id'],
      focusable: json['focusable'],
      inputType: json['inputType'],
      skip: json['skip'],
      wrapInTextInputLayout: json['wrapInTextInputLayout'],
      verticalLabeling: json['verticalLabeling'],
      clickable: json['clickable'],
      maxLength: json['maxLength'],
      minLength: json['minLength'],
      hint: json['hint'],
      text: json['text'] ?? '',
      hintTextColor: json['hintTextColor'],
      textColor: json['textColor'],
      items: json['items'] != null ? List<String>.from(json['items']) : null,
      headerBar: json['headerBar'] != null ? HeaderBar.fromJson(json['headerBar']) : null,
      captureRequired: json['captureRequired'],
      required: json['required'],
      signatureEditable: json['signatureEditable'],
      minimumAccuracy: (json['minimumAccuracy'] as num).toDouble(),
    );
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

  factory HeaderBar.fromJson(Map<int, dynamic> json) {
    return HeaderBar(
      backGroundColor: json['backGroundColor'],
      label: json['label'],
      labelColor: json['labelColor'],
    );
  }
}

class RowItem {
  int label;
  String? value;
  int displayValue;
  int labelColor;
  int valueColor;
  HeaderBar? headerBar;

  RowItem({
    required this.label,
    this.value,
    required this.displayValue,
    required this.labelColor,
    required this.valueColor,
    this.headerBar,
  });

  factory RowItem.fromJson(Map<int, dynamic> json) {
    return RowItem(
      label: json['label'],
      value: json['value']?.toString(),
      displayValue: json['displayValue'],
      labelColor: json['labelColor'],
      valueColor: json['valueColor'],
      headerBar: json['headerBar'] != null ? HeaderBar.fromJson(json['headerBar']) : null,
    );
  }
}