class ViewScheduleModel {
  final int tourId;
  final String aeEmpId;
  final String aeName;
  final String aeDesignation;
  final DateTime insertDate;
  final String type;
  final String? itemId;
  final String itemCode;
  final String itemName;
  final String? voltage;
  final String scheduledDate;
  final String scheduledMonth;
  final String circle;
  final String circleId;
  final String division;
  final String divisionId;
  final String subDivision;
  final String subDivisionId;
  final String section;
  final String sectionId;
  final String? adeEmpId;
  final String? adeEmpName;
  final String? adeEmpDesignation;
  final String? adeRemarks;
  final String? adeReportDate;
  final String? deEmpId;
  final String? deEmpName;
  final String? deEmpDesignation;
  final String? deRemarks;
  final String? deReportDate;
  final String status;
  final String? adeStatus;
  final String? deStatus;

  ViewScheduleModel({
    required this.tourId,
    required this.aeEmpId,
    required this.aeName,
    required this.aeDesignation,
    required this.insertDate,
    required this.type,
    required this.itemId,
    required this.itemCode,
    required this.itemName,
    required this.voltage,
    required this.scheduledDate,
    required this.scheduledMonth,
    required this.circle,
    required this.circleId,
    required this.division,
    required this.divisionId,
    required this.subDivision,
    required this.subDivisionId,
    required this.section,
    required this.sectionId,
    this.adeEmpId,
    this.adeEmpName,
    this.adeEmpDesignation,
    this.adeRemarks,
    this.adeReportDate,
    this.deEmpId,
    this.deEmpName,
    this.deEmpDesignation,
    this.deRemarks,
    this.deReportDate,
    required this.status,
    this.adeStatus,
    this.deStatus,
  });

  factory ViewScheduleModel.fromJson(Map<String, dynamic> json) {
    return ViewScheduleModel(
      tourId: json['tourId'],
      aeEmpId: json['aeEmpId'],
      aeName: json['aeName'],
      aeDesignation: json['aeDesignation'],
      insertDate: DateTime.parse(json['insertDate']),
      type: json['type'],
      itemId: json['itemId'],
      itemCode: json['itemCode'],
      itemName: json['itemName'],
      voltage: json['voltage'],
      scheduledDate: json['scheduledDate'],
      scheduledMonth: json['scheduledMonth'],
      circle: json['circle'],
      circleId: json['circleId'],
      division: json['division'],
      divisionId: json['divisionId'],
      subDivision: json['subDivision'],
      subDivisionId: json['subDivisionId'],
      section: json['section'],
      sectionId: json['sectionId'],
      adeEmpId: json['adeEmpId'],
      adeEmpName: json['adeEmpName'],
      adeEmpDesignation: json['adeEmpDesignation'],
      adeRemarks: json['adeRemarks'],
      adeReportDate: json['adeReportDate'],
      deEmpId: json['deEmpId'],
      deEmpName: json['deEmpName'],
      deEmpDesignation: json['deEmpDesignation'],
      deRemarks: json['deRemarks'],
      deReportDate: json['deReportDate'],
      status: json['status'],
      adeStatus: json['adeStatus'],
      deStatus: json['deStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tourId': tourId,
      'aeEmpId': aeEmpId,
      'aeName': aeName,
      'aeDesignation': aeDesignation,
      'insertDate': insertDate.toIso8601String(),
      'type': type,
      'itemId': itemId,
      'itemCode': itemCode,
      'itemName': itemName,
      'voltage': voltage,
      'scheduledDate': scheduledDate,
      'scheduledMonth': scheduledMonth,
      'circle': circle,
      'circleId': circleId,
      'division': division,
      'divisionId': divisionId,
      'subDivision': subDivision,
      'subDivisionId': subDivisionId,
      'section': section,
      'sectionId': sectionId,
      'adeEmpId': adeEmpId,
      'adeEmpName': adeEmpName,
      'adeEmpDesignation': adeEmpDesignation,
      'adeRemarks': adeRemarks,
      'adeReportDate': adeReportDate,
      'deEmpId': deEmpId,
      'deEmpName': deEmpName,
      'deEmpDesignation': deEmpDesignation,
      'deRemarks': deRemarks,
      'deReportDate': deReportDate,
      'status': status,
      'adeStatus': adeStatus,
      'deStatus': deStatus,
    };
  }
}
