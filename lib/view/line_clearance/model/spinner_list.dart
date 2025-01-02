import 'dart:convert';

SpinnerList spinnerListFromJson(String str) =>
    SpinnerList.fromJson(json.decode(str));

String spinnerListToJson(SpinnerList data) => json.encode(data.toJson());

class SpinnerList {
  SpinnerList({
    this.optionCode,
    this.optionName,
  });

  SpinnerList.fromJson(dynamic json) {
    optionCode = json['optionCode'];
    optionName = json['optionName'];
  }

  String? optionCode;
  String? optionName;

  SpinnerList copyWith({
    String? optionCode,
    String? optionName,
  }) =>
      SpinnerList(
        optionCode: optionCode ?? this.optionCode,
        optionName: optionName ?? this.optionName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['optionCode'] = optionCode;
    map['optionName'] = optionName;
    return map;
  }
}
