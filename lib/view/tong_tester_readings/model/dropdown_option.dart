class DropdownOption {
  final String optionId;
  final String optionName;

  DropdownOption({required this.optionId, required this.optionName});

  factory DropdownOption.fromJson(Map<String, dynamic> json) {
    return DropdownOption(
      optionId: json['optionId']?.toString() ?? '',
      optionName: json['optionName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'optionId': optionId,
    'optionName': optionName,
  };
}
