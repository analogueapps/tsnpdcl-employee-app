class CccOpenModel {
  final String? hNo;
  final String? area;
  final String? type;
  final String? scNo;
  final String? uscNo;
  final String? address;
  final String? section;
  final String? complaintSource;
  final String? landmark;
  final String? poleNumber;
  final String? consumerName;
  final String? additionalInfo;
  final String? remarks;
  final String? registeredMobileNumber;
  final String? ticketNumber;
  final String? priority;
  final String? circle;
  final String? status;
  final String? ae;
  final String? entryDate;
  final String? complaintType;
  final String? complaintSubType;
  final String? mobileNo;
  final String? userId;
  final String? userName;
  final String? statusUpdatedOn;

  CccOpenModel({
    this.hNo,
    this.area,
    this.type,
    this.scNo,
    this.uscNo,
    this.address,
    this.section,
    this.complaintSource,
    this.landmark,
    this.poleNumber,
    this.consumerName,
    this.additionalInfo,
    this.remarks,
    this.registeredMobileNumber,
    this.ticketNumber,
    this.priority,
    this.circle,
    this.status,
    this.ae,
    this.entryDate,
    this.complaintType,
    this.complaintSubType,
    this.mobileNo,
    this.userId,
    this.userName,
    this.statusUpdatedOn,
  });

  factory CccOpenModel.fromJson(Map<String, dynamic> json) {
    return CccOpenModel(
      hNo: json['hNo'],
      area: json['area'],
      type: json['type'],
      scNo: json['scNo'],
      uscNo: json['uscNo'],
      address: json['address'],
      section: json['section'],
      complaintSource: json['complaintSource'],
      landmark: json['landmark'],
      poleNumber: json['poleNumber'],
      consumerName: json['consumerName'],
      additionalInfo: json['additionalInfo'],
      remarks: json['remarks'],
      registeredMobileNumber: json['registeredMobileNumber'],
      ticketNumber: json['ticketNumber'],
      priority: json['priority'],
      circle: json['circle'],
      status: json['status'],
      ae: json['ae'],
      entryDate: json['entryDate'],
      complaintType: json['complaintType'],
      complaintSubType: json['complaintSubType'],
      mobileNo: json['mobileNo'],
      userId: json['userId'],
      userName: json['userName'],
      statusUpdatedOn: json['status_updated_on'],
    );
  }
}
