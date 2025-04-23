import 'dart:convert';

EroModel eroModelFromJson(String str) => EroModel.fromJson(json.decode(str));

String eroModelToJson(EroModel data) => json.encode(data.toJson());

class EroModel {
  final String optionId;
  final String optionName;

  EroModel({
    required this.optionId,
    required this.optionName,
  });

  factory EroModel.fromJson(dynamic json) {
    final map = json is Map ? json : {};
    return EroModel(
      optionId: map['optionId']?.toString() ?? '0',
      optionName: map['optionName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'optionId': optionId,
    'optionName': optionName,
  };
}
