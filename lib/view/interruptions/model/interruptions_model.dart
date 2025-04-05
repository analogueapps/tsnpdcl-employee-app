class  InterruptionsModel{
  final String optionCode;
  final String optionName;

  InterruptionsModel({
    required this.optionCode,
    required this.optionName,
  });

  factory InterruptionsModel.fromJson(Map<String, dynamic> json) {
    return InterruptionsModel(
      optionCode: json['optionCode'] as String? ?? '',
      optionName: json['optionName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'optionCode': optionCode,
    'optionName': optionName,
  };
}

