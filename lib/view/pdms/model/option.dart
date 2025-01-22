class Option {
  String? optionCode;
  String? optionId;
  String optionName;

  Option({this.optionCode, required this.optionId, required this.optionName});

  String? getOptionCode() {
    return optionCode ?? optionId;
  }

  String? getOptionId() {
    return optionId;
  }

  String getOptionName() {
    return optionName;
  }
}

