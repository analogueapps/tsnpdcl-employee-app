class CccComplaintModel {
  final String cccComplaintId;
  final int eroCode;
  final String sectionId;
  final String? aaoEmpId;
  final String status;
  final String insDate;
  final String? remarks;
  final String statusDate;
  final String? aeEmpId;
  final String? appBcId;
  final String consName;
  final String consPhone;
  final String uscNo;
  final String complaintType;
  final String subComplaintType;

  CccComplaintModel({
    required this.cccComplaintId,
    required this.eroCode,
    required this.sectionId,
    this.aaoEmpId,
    required this.status,
    required this.insDate,
    this.remarks,
    required this.statusDate,
    this.aeEmpId,
    this.appBcId,
    required this.consName,
    required this.consPhone,
    required this.uscNo,
    required this.complaintType,
    required this.subComplaintType,
  });

  factory CccComplaintModel.fromJson(Map<String, dynamic> json) {
    return CccComplaintModel(
      cccComplaintId: json['cccComplaintId'] ?? '',
      eroCode: json['eroCode'] ?? 0,
      sectionId: json['sectionId'] ?? '',
      aaoEmpId: json['aaoEmpId'],
      status: json['status'] ?? '',
      insDate: json['insDate'] ?? '',
      remarks: json['remarks'],
      statusDate: json['statusDate'] ?? '',
      aeEmpId: json['aeEmpId'],
      appBcId: json['appBcId'],
      consName: json['consName'] ?? '',
      consPhone: json['consPhone'] ?? '',
      uscNo: json['uscNo'] ?? '',
      complaintType: json['complaintType'] ?? '',
      subComplaintType: json['subComplaintType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cccComplaintId': cccComplaintId,
      'eroCode': eroCode,
      'sectionId': sectionId,
      'aaoEmpId': aaoEmpId,
      'status': status,
      'insDate': insDate,
      'remarks': remarks,
      'statusDate': statusDate,
      'aeEmpId': aeEmpId,
      'appBcId': appBcId,
      'consName': consName,
      'consPhone': consPhone,
      'uscNo': uscNo,
      'complaintType': complaintType,
      'subComplaintType': subComplaintType,
    };
  }
}
