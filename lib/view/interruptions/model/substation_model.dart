import 'dart:convert';

SubstationModel SubstationModelFromJson(String str) =>
    SubstationModel.fromJson(json.decode(str));

String SubstationModelToJson(SubstationModel data) =>
    json.encode(data.toJson());

class SubstationModel {
  SubstationModel({
    this.optionId,
    this.optionName,
  });

  SubstationModel.fromJson(dynamic json) {
    optionId = json['optionId'];
    optionName = json['optionName'];
  }

  String? optionId;
  String? optionName;

  SubstationModel copyWith({
    String? optionId,
    String? optionName,
  }) =>
      SubstationModel(
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

