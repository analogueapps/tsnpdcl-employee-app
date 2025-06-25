class ConsumerUscnoModel {
  final String consumerName;
  final String? surname;
  final String uscNo;
  final String? scNo;
  final String? cat;
  final String? subCat;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? address4;
  final String? areaCode;
  final String? areaName;
  final String? eroCode;
  final String? fatherName;
  final String? pinCode;
  final String? section;
  final String? trivectorFlag;
  final String? solarMeterFlag;
  final double? kwhFr;
  final double? kvAhFr;
  final double? ltMtrFr;
  final double? solarMtrKwhFr;
  final double? solarMtrKvAhFr;
  final String? readingDate;
  final String? meterSlNo;
  final String? meterMake;
  final String? meterCapacity;
  final double? load;
  final String? billStatus;

  ConsumerUscnoModel({
    required this.consumerName,
    this.surname,
    required this.uscNo,
    this.scNo,
    this.cat,
    this.subCat,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.areaCode,
    this.areaName,
    this.eroCode,
    this.fatherName,
    this.pinCode,
    this.section,
    this.trivectorFlag,
    this.solarMeterFlag,
    this.kwhFr,
    this.kvAhFr,
    this.ltMtrFr,
    this.solarMtrKwhFr,
    this.solarMtrKvAhFr,
    this.readingDate,
    this.meterSlNo,
    this.meterMake,
    this.meterCapacity,
    this.load,
    this.billStatus,
  });

  factory ConsumerUscnoModel.fromJson(Map<String, dynamic> json) {
    return ConsumerUscnoModel(
      consumerName: json['consumerName'],
      surname: json['surname'],
      uscNo: json['uscNo'],
      scNo: json['scNo'],
      cat: json['cat'],
      subCat: json['subCat'],
      address1: json['address1'],
      address2: json['address2'],
      address3: json['address3'],
      address4: json['address4'],
      areaCode: json['areaCode'],
      areaName: json['areaName'],
      eroCode: json['eroCode'],
      fatherName: json['fatherName'],
      pinCode: json['pinCode'],
      section: json['section'],
      trivectorFlag: json['trivectorFlag'],
      solarMeterFlag: json['solarMeterFlag'],
      kwhFr: (json['kwhFr'] as num?)?.toDouble(),
      kvAhFr: (json['kvAhFr'] as num?)?.toDouble(),
      ltMtrFr: (json['ltMtrFr'] as num?)?.toDouble(),
      solarMtrKwhFr: (json['solarMtrKwhFr'] as num?)?.toDouble(),
      solarMtrKvAhFr: (json['solarMtrKvAhFr'] as num?)?.toDouble(),
      readingDate: json['readingDate'],
      meterSlNo: json['meterSlNo'],
      meterMake: json['meterMake'],
      meterCapacity: json['meterCapacity'],
      load: (json['load'] as num?)?.toDouble(),
      billStatus: json['billStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'consumerName': consumerName,
      'surname': surname,
      'uscNo': uscNo,
      'scNo': scNo,
      'cat': cat,
      'subCat': subCat,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'address4': address4,
      'areaCode': areaCode,
      'areaName': areaName,
      'eroCode': eroCode,
      'fatherName': fatherName,
      'pinCode': pinCode,
      'section': section,
      'trivectorFlag': trivectorFlag,
      'solarMeterFlag': solarMeterFlag,
      'kwhFr': kwhFr,
      'kvAhFr': kvAhFr,
      'ltMtrFr': ltMtrFr,
      'solarMtrKwhFr': solarMtrKwhFr,
      'solarMtrKvAhFr': solarMtrKvAhFr,
      'readingDate': readingDate,
      'meterSlNo': meterSlNo,
      'meterMake': meterMake,
      'meterCapacity': meterCapacity,
      'load': load,
      'billStatus': billStatus,
    };
  }
}
