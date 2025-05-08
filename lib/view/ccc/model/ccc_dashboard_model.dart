class CccResponse {
  final List<CccAbstractItem> cccAbstractList;
  final int resolved;
  final int open;
  final int closed;
  final int reOpen;
  final int inProgress;

  CccResponse({
    required this.cccAbstractList,
    required this.resolved,
    required this.open,
    required this.closed,
    required this.reOpen,
    required this.inProgress,
  });

  factory CccResponse.fromJson(Map<String, dynamic> json) {
    return CccResponse(
      cccAbstractList: (json['cccAbstractList'] as List<dynamic>)
          .map((e) => CccAbstractItem.fromJson(e))
          .toList(),
      resolved: json['resolved'] ?? 0,
      open: json['open'] ?? 0,
      closed: json['closed'] ?? 0,
      reOpen: json['reOpen'] ?? 0,
      inProgress: json['inProgress'] ?? 0,
    );
  }
}

class CccAbstractItem {
  final String? officeCode;
  final String officeType;
  final String officeName;
  final int? resolved;
  final int? open;
  final int? closed;
  final int? reOpen;
  final int? inProgress;

  CccAbstractItem({
    required this.officeCode,
    required this.officeType,
    required this.officeName,
    this.resolved,
    this.open,
    this.closed,
    this.reOpen,
    this.inProgress,
  });

  factory CccAbstractItem.fromJson(Map<String, dynamic> json) {
    return CccAbstractItem(
      officeCode: json['officeCode'],
      officeType: json['officeType'] ?? '',
      officeName: json['officeName'] ?? '',
      resolved: json['resolved'],
      open: json['open'],
      closed: json['closed'],
      reOpen: json['reOpen'],
      inProgress: json['inProgress'],
    );
  }
}
