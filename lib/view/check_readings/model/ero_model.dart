import 'dart:convert';

EroModel eroModelFromJson(String str) =>
    EroModel.fromJson(json.decode(str));

String eroModelToJson(EroModel data) => json.encode(data.toJson());

class EroModel {
  final String optionId; // Force String type
  final String optionName;

  EroModel({
    required this.optionId,
    required this.optionName,
  });

  factory EroModel.fromJson(dynamic json) {
    try {
      final map = json is Map ? json : {};
      return EroModel(
        optionId: map['optionId']?.toString() ?? '0',
        optionName: map['optionName']?.toString() ?? '',
      );
    } catch (e) {
      print('Model creation error: $e');
      return EroModel(optionId: '0', optionName: 'Error');
    }
  }

  EroModel copyWith({
    String? optionId,
    String? optionName,
  }) =>
      EroModel(
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