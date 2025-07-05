class CatInspectionModel {
  final int uan;
  final String? scno;
  final String? name;
  final String? address;
  final String? poleno;
  final String? gjApprovedBeneficiary;
  final String? billDate;
  final String? status;
  final int? previousUnits;
  final int? presentUnits;
  final String? irdaFlag;
  final String? areacode;
  final String? areaname;
  final int? newsapSecCode;
  final String? digitalStructCode;
  final String? fieldobservFlag;
  final String? empid;
  final String? datetime;
  final String? suppressedBy;
  final String? suppressedByDesig;
  final String? monthyear;
  final String? uanmonth;
  final String? remarks;
  final String? filedobservFlag;
  final String? lastpaiddt;
  final double? lastpaidamt;
  final double? arrear;
  final int? cat;
  final int? subcat;
  final int? reviewCat;
  final int? reviewSubcat;
  final String? dateOfInspection;
  final String? statusAtInspection;
  final String? amountPaidYesNo;

  CatInspectionModel({
    required this.uan,
    this.scno,
    this.name,
    this.address,
    this.poleno,
    this.gjApprovedBeneficiary,
    this.billDate,
    this.status,
    this.previousUnits,
    this.presentUnits,
    this.irdaFlag,
    this.areacode,
    this.areaname,
    this.newsapSecCode,
    this.digitalStructCode,
    this.fieldobservFlag,
    this.empid,
    this.datetime,
    this.suppressedBy,
    this.suppressedByDesig,
    this.monthyear,
    this.uanmonth,
    this.remarks,
    this.filedobservFlag,
    this.lastpaiddt,
    this.lastpaidamt,
    this.arrear,
    this.cat,
    this.subcat,
    this.reviewCat,
    this.reviewSubcat,
    this.dateOfInspection,
    this.statusAtInspection,
    this.amountPaidYesNo,
  });

  factory CatInspectionModel.fromJson(Map<String, dynamic> json) {
    return CatInspectionModel(
      uan: json['uan'],
      scno: json['scno'],
      name: json['name'],
      address: json['address'],
      poleno: json['poleno'],
      gjApprovedBeneficiary: json['gjApprovedBeneficiary'],
      billDate: json['billDate'],
      status: json['status'],
      previousUnits: json['previousUnits'],
      presentUnits: json['presentUnits'],
      irdaFlag: json['irdaFlag'],
      areacode: json['areacode'],
      areaname: json['areaname'],
      newsapSecCode: json['newsapSecCode'],
      digitalStructCode: json['digitalStructCode'],
      fieldobservFlag: json['fieldobservFlag'],
      empid: json['empid'],
      datetime: json['datetime'],
      suppressedBy: json['suppressedBy'],
      suppressedByDesig: json['suppressedByDesig'],
      monthyear: json['monthyear'],
      uanmonth: json['uanmonth'],
      remarks: json['remarks'],
      filedobservFlag: json['filedobservFlag'],
      lastpaiddt: json['lastpaiddt'],
      lastpaidamt: (json['lastpaidamt'] != null) ? json['lastpaidamt'].toDouble() : null,
      arrear: (json['arrear'] != null) ? json['arrear'].toDouble() : null,
      cat: json['cat'],
      subcat: json['subcat'],
      reviewCat: json['reviewCat'],
      reviewSubcat: json['reviewSubcat'],
      dateOfInspection: json['dateOfInspection'],
      statusAtInspection: json['statusAtInspection'],
      amountPaidYesNo: json['amountPaidYesNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uan': uan,
      'scno': scno,
      'name': name,
      'address': address,
      'poleno': poleno,
      'gjApprovedBeneficiary': gjApprovedBeneficiary,
      'billDate': billDate,
      'status': status,
      'previousUnits': previousUnits,
      'presentUnits': presentUnits,
      'irdaFlag': irdaFlag,
      'areacode': areacode,
      'areaname': areaname,
      'newsapSecCode': newsapSecCode,
      'digitalStructCode': digitalStructCode,
      'fieldobservFlag': fieldobservFlag,
      'empid': empid,
      'datetime': datetime,
      'suppressedBy': suppressedBy,
      'suppressedByDesig': suppressedByDesig,
      'monthyear': monthyear,
      'uanmonth': uanmonth,
      'remarks': remarks,
      'filedobservFlag': filedobservFlag,
      'lastpaiddt': lastpaiddt,
      'lastpaidamt': lastpaidamt,
      'arrear': arrear,
      'cat': cat,
      'subcat': subcat,
      'reviewCat': reviewCat,
      'reviewSubcat': reviewSubcat,
      'dateOfInspection': dateOfInspection,
      'statusAtInspection': statusAtInspection,
      'amountPaidYesNo': amountPaidYesNo,
    };
  }
}
