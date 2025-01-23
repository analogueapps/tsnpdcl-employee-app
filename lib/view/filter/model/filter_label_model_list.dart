import 'dart:convert';

FilterLabelModelList filterLabelModelListFromJson(String str) =>
    FilterLabelModelList.fromJson(json.decode(str));

String filterLabelModelListToJson(FilterLabelModelList data) =>
    json.encode(data.toJson());

class FilterLabelModelList {
  FilterLabelModelList({
    this.labelName,
    this.labelCode,
    this.optionList,
    this.isSelected, // Default value for isChecked
  });

  FilterLabelModelList.fromJson(dynamic json) {
    labelName = json['labelName'];
    labelCode = json['labelCode'];
    if (json['optionList'] != null) {
      optionList = [];
      json['optionList'].forEach((v) {
        optionList?.add(OptionList.fromJson(v));
      });
    }
    isSelected = json['isSelected'] ?? false; // Default to false if not provided
  }

  String? labelName;
  num? labelCode;
  List<OptionList>? optionList;
  bool? isSelected;

  FilterLabelModelList copyWith({
    String? labelName,
    num? labelCode,
    List<OptionList>? optionList,
    bool? isSelected,
  }) =>
      FilterLabelModelList(
        labelName: labelName ?? this.labelName,
        labelCode: labelCode ?? this.labelCode,
        optionList: optionList ?? this.optionList,
        isSelected: isSelected ?? this.isSelected,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['labelName'] = labelName;
    map['labelCode'] = labelCode;
    if (optionList != null) {
      map['optionList'] = optionList?.map((v) => v.toJson()).toList();
    }
    map['isChecked'] = isSelected;
    return map;
  }
}

OptionList optionListFromJson(String str) =>
    OptionList.fromJson(json.decode(str));

String optionListToJson(OptionList data) => json.encode(data.toJson());

class OptionList {
  OptionList({
    this.optionId,
    this.optionName,
    this.isSelected, // Default value for isChecked
  });

  OptionList.fromJson(dynamic json) {
    optionId = json['optionId'];
    optionName = json['optionName'];
    isSelected = json['isSelected'] ?? false; // Default to false if not provided
  }

  String? optionId;
  String? optionName;
  bool? isSelected;

  OptionList copyWith({
    String? optionId,
    String? optionName,
    bool? isSelected,
  }) =>
      OptionList(
        optionId: optionId ?? this.optionId,
        optionName: optionName ?? this.optionName,
        isSelected: isSelected ?? this.isSelected,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['optionId'] = optionId;
    map['optionName'] = optionName;
    map['isChecked'] = isSelected;
    return map;
  }
}
