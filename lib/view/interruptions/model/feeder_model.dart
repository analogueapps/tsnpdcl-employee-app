import 'dart:convert';

FeederModel FeederModelFromJson(String str) =>
    FeederModel.fromJson(json.decode(str));

String FeederModelToJson(FeederModel data) => json.encode(data.toJson());

class FeederModel {
  FeederModel({
    this.optionId,
    this.optionName,
  });

  FeederModel.fromJson(dynamic json) {
    optionId = json['optionId']?.toString();
    optionName = json['optionName'];
  }

  String? optionId;
  String? optionName;

  FeederModel copyWith({
    String? optionId,
    String? optionName,
  }) =>
      FeederModel(
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
