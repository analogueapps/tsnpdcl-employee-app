import 'dart:convert';

LcMasterSsList lcMasterSsListFromJson(String str) =>
    LcMasterSsList.fromJson(json.decode(str));

String lcMasterSsListToJson(LcMasterSsList data) => json.encode(data.toJson());

class LcMasterSsList {
  LcMasterSsList({
    this.optionId,
    this.optionName,
  });

  LcMasterSsList.fromJson(dynamic json) {
    optionId = json['optionId'];
    optionName = json['optionName'];
  }

  String? optionId;
  String? optionName;

  LcMasterSsList copyWith({
    String? optionId,
    String? optionName,
  }) =>
      LcMasterSsList(
        optionId: optionId ?? this.optionId,
        optionName: optionName ?? this.optionName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['optionId'] = optionId;
    map['optionName'] = optionName;
    return map;
  }
}
