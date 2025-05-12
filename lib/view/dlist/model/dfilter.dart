class DFilter {
  String distributionCode;
  bool liveSelected;
  bool udcSelected;
  bool bsSelected;
  String distributionName;
  double amountFrom;
  double amountTo;

  DFilter({
    required this.distributionCode,
    required this.liveSelected,
    required this.udcSelected,
    required this.bsSelected,
    required this.distributionName,
    required this.amountFrom,
    required this.amountTo,
  });

  // ✅ Required for jsonEncode()
  Map<String, dynamic> toJson() => {
    'distributionCode': distributionCode,
    'liveSelected': liveSelected,
    'udcSelected': udcSelected,
    'bsSelected': bsSelected,
    'distributionName': distributionName,
    'amountFrom': amountFrom,
    'amountTo': amountTo,
  };

  // ✅ Optional for decoding later
  factory DFilter.fromJson(Map<String, dynamic> json) => DFilter(
    distributionCode: json['distributionCode'],
    liveSelected: json['liveSelected'],
    udcSelected: json['udcSelected'],
    bsSelected: json['bsSelected'],
    distributionName: json['distributionName'],
    amountFrom: (json['amountFrom'] as num).toDouble(),
    amountTo: (json['amountTo'] as num).toDouble(),
  );
}
