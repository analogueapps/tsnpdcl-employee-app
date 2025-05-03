import 'dart:convert';

ServiceDetailsModel serviceDetailsModelFromJson(String str) =>
    ServiceDetailsModel.fromJson(json.decode(str));

String serviceDetailsModelToJson(ServiceDetailsModel data) =>
    json.encode(data.toJson());

class ServiceDetailsModel {
  final String area;
  final String areaCode;
  final String avgUnits;
  final Bill bill;
  final String cat;
  final String circle;
  final String ebs2DigitSecCode;
  final String eroName;
  final String eroPhone;
  final String erono;
  final String errorCause;
  final String kvahClosingReading;
  final String kwhClosingReading;
  final String load;
  final String mobile;
  final String name;
  final String poleNo;
  final String scno;
  final String sectionName;
  final String sectionPhone;
  final String status;
  final String subCat;
  final String uscno;

  ServiceDetailsModel({
    required this.area,
    required this.areaCode,
    required this.avgUnits,
    required this.bill,
    required this.cat,
    required this.circle,
    required this.ebs2DigitSecCode,
    required this.eroName,
    required this.eroPhone,
    required this.erono,
    required this.errorCause,
    required this.kvahClosingReading,
    required this.kwhClosingReading,
    required this.load,
    required this.mobile,
    required this.name,
    required this.poleNo,
    required this.scno,
    required this.sectionName,
    required this.sectionPhone,
    required this.status,
    required this.subCat,
    required this.uscno,
  });

  factory ServiceDetailsModel.fromJson(dynamic json) {
    final map = json is Map ? json : {};
    return ServiceDetailsModel(
      area: map['area']?.toString() ?? '',
      areaCode: map['areaCode']?.toString() ?? '',
      avgUnits: map['avgUnits']?.toString() ?? '',
      bill: Bill.fromJson(map['bill']),
      cat: map['cat']?.toString() ?? '',
      circle: map['circle']?.toString() ?? '',
      ebs2DigitSecCode: map['ebs2DigitSecCode']?.toString() ?? '',
      eroName: map['eroName']?.toString() ?? '',
      eroPhone: map['eroPhone']?.toString() ?? '',
      erono: map['erono']?.toString() ?? '',
      errorCause: map['errorCause']?.toString() ?? '',
      kvahClosingReading: map['kvahClosingReading']?.toString() ?? '',
      kwhClosingReading: map['kwhClosingReading']?.toString() ?? '',
      load: map['load']?.toString() ?? '',
      mobile: map['mobile']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      poleNo: map['poleNo']?.toString() ?? '',
      scno: map['scno']?.toString() ?? '',
      sectionName: map['sectionName']?.toString() ?? '',
      sectionPhone: map['sectionPhone']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      subCat: map['subCat']?.toString() ?? '',
      uscno: map['uscno']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'area': area,
    'areaCode': areaCode,
    'avgUnits': avgUnits,
    'bill': bill.toJson(),
    'cat': cat,
    'circle': circle,
    'ebs2DigitSecCode': ebs2DigitSecCode,
    'eroName': eroName,
    'eroPhone': eroPhone,
    'erono': erono,
    'errorCause': errorCause,
    'kvahClosingReading': kvahClosingReading,
    'kwhClosingReading': kwhClosingReading,
    'load': load,
    'mobile': mobile,
    'name': name,
    'poleNo': poleNo,
    'scno': scno,
    'sectionName': sectionName,
    'sectionPhone': sectionPhone,
    'status': status,
    'subCat': subCat,
    'uscno': uscno,
  };
}

class Bill {
  final String billAmount;
  final int billDueDate;
  final int billedDate;
  final int discDate;

  Bill({
    required this.billAmount,
    required this.billDueDate,
    required this.billedDate,
    required this.discDate,
  });

  factory Bill.fromJson(dynamic json) {
    final map = json is Map ? json : {};
    return Bill(
      billAmount: map['billAmount']?.toString() ?? '0',
      billDueDate: map['billDueDate'] ?? 0,
      billedDate: map['billedDate'] ?? 0,
      discDate: map['discDate'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'billAmount': billAmount,
    'billDueDate': billDueDate,
    'billedDate': billedDate,
    'discDate': discDate,
  };
}
