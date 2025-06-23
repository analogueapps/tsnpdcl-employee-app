

class CategoryChangeRequestModel {
  final int regId;
  final String regNum;
  final String scno;
  final String consumerName;
  final String? existCat;
  final int? existLoad;
  final dynamic distribution;
  final String? sectionId;
  final String? informatName;
  final String? serviceChangeType;
  final String? doorNo;
  final String? street;
  final String? area;
  final String? town;
  final int? mobile;
  final dynamic phoneNo;
  final dynamic email;
  final String? reqCat;
  final int? reqLoad;
  final int? applicationCharges;
  final int? developmentCharges;
  final int? securityDeposit;
  final int? supervisionCharges;
  final int? totalAmount;
  final String? isAmountPaid;
  final dynamic idDocName;
  final dynamic idDocContentType;
  final String? presentLogin;
  final String? presentLoginLocationCode;
  final String? regUser;
  final String? status;
  final String? regIp;
  final String? insDate;
  final int? ero;
  final dynamic idName;
  final String? eroName;
  final dynamic paaCode;
  final dynamic oldSectionId;
  final dynamic reason;
  final dynamic dispatchNo;
  final String? dispatchDate;
  final dynamic oldPresentLogin;
  final dynamic oldPrsLoginLocationCode;
  final dynamic presentLoad;
  final dynamic discount;
  final dynamic pincode;
  final String? district;
  final String? isGstnAvail;
  final dynamic gstnNo;
  final String? entryFlag;
  final String? subServiceType;
  final dynamic consumerType;
  final dynamic consumerTypeOthers;
  final dynamic purposeOfSupply;
  final dynamic purposeOfSupplyOthers;
  final String? surname;
  final String? fatherName;
  final dynamic socialGroup;
  final dynamic socialGroupOthers;
  final String? categoryType;
  final String? changedCategoryType;
  final dynamic aadhar;
  final dynamic rationcardNo;
  final dynamic pan;
  final String? infRelation;
  final String? locationType;
  final String? locationName;
  final String? ldistrict;
  final String? lmandal;
  final String? lvillage;
  final String? cdistrict;
  final String? cmandal;
  final String? cvillage;
  final dynamic lpincode;
  final dynamic cpincode;
  final String? deliveryType;
  final dynamic existScno;
  final dynamic changedSurname;
  final dynamic changedConsumername;
  final dynamic changedFathername;
  final dynamic changedSocialGrp;
  final dynamic changedSocialGrpOther;
  final dynamic changedMobileno;
  final dynamic reasonOfChange;
  final dynamic infDistrict;
  final dynamic infMandal;
  final dynamic infVillage;
  final dynamic infPincode;
  final dynamic infDoorno;
  final int? userCharges;
  final int? serviceCharge;
  final int? challanAmount;
  final int? postalCharge;
  final int? inspectionCharge;
  final int? acCGst;
  final int? acSGst;
  final int? acGst;
  final int? dcCGst;
  final int? dcSGst;
  final int? dcGst;
  final int? inspCGst;
  final int? inspSGst;
  final int? inspGst;
  final dynamic deletedReason;
  final dynamic deletedBy;
  final dynamic deletedDate;
  final String? regDate;
  final int? totalCGst;
  final int? totalSGst;
  final int? totalGst;
  final dynamic infMobileNo;
  final int? uscno;
  final dynamic ebsRemarks;
  final dynamic ebsStatus;
  final dynamic ebsBy;
  final dynamic ebsDate;
  final dynamic rrDocNo;
  final dynamic ebsIp;
  final dynamic noofdays;
  final dynamic estimateRequired;
  final dynamic prNo;
  final dynamic prDate;
  final dynamic statusDate;
  final dynamic aeEmpId;
  final dynamic lmEmpId;
  final dynamic meterMake;
  final dynamic meterCapacity;
  final dynamic meterSlNo;
  final dynamic meterFr;
  final dynamic testReportPath;

  CategoryChangeRequestModel({
    required this.regId,
    required this.regNum,
    required this.scno,
    required this.consumerName,
    this.existCat,
    this.existLoad,
    this.distribution,
    this.sectionId,
    this.informatName,
    this.serviceChangeType,
    this.doorNo,
    this.street,
    this.area,
    this.town,
    this.mobile,
    this.phoneNo,
    this.email,
    this.reqCat,
    this.reqLoad,
    this.applicationCharges,
    this.developmentCharges,
    this.securityDeposit,
    this.supervisionCharges,
    this.totalAmount,
    this.isAmountPaid,
    this.idDocName,
    this.idDocContentType,
    this.presentLogin,
    this.presentLoginLocationCode,
    this.regUser,
    this.status,
    this.regIp,
    this.insDate,
    this.ero,
    this.idName,
    this.eroName,
    this.paaCode,
    this.oldSectionId,
    this.reason,
    this.dispatchNo,
    this.dispatchDate,
    this.oldPresentLogin,
    this.oldPrsLoginLocationCode,
    this.presentLoad,
    this.discount,
    this.pincode,
    this.district,
    this.isGstnAvail,
    this.gstnNo,
    this.entryFlag,
    this.subServiceType,
    this.consumerType,
    this.consumerTypeOthers,
    this.purposeOfSupply,
    this.purposeOfSupplyOthers,
    this.surname,
    this.fatherName,
    this.socialGroup,
    this.socialGroupOthers,
    this.categoryType,
    this.changedCategoryType,
    this.aadhar,
    this.rationcardNo,
    this.pan,
    this.infRelation,
    this.locationType,
    this.locationName,
    this.ldistrict,
    this.lmandal,
    this.lvillage,
    this.cdistrict,
    this.cmandal,
    this.cvillage,
    this.lpincode,
    this.cpincode,
    this.deliveryType,
    this.existScno,
    this.changedSurname,
    this.changedConsumername,
    this.changedFathername,
    this.changedSocialGrp,
    this.changedSocialGrpOther,
    this.changedMobileno,
    this.reasonOfChange,
    this.infDistrict,
    this.infMandal,
    this.infVillage,
    this.infPincode,
    this.infDoorno,
    this.userCharges,
    this.serviceCharge,
    this.challanAmount,
    this.postalCharge,
    this.inspectionCharge,
    this.acCGst,
    this.acSGst,
    this.acGst,
    this.dcCGst,
    this.dcSGst,
    this.dcGst,
    this.inspCGst,
    this.inspSGst,
    this.inspGst,
    this.deletedReason,
    this.deletedBy,
    this.deletedDate,
    this.regDate,
    this.totalCGst,
    this.totalSGst,
    this.totalGst,
    this.infMobileNo,
    this.uscno,
    this.ebsRemarks,
    this.ebsStatus,
    this.ebsBy,
    this.ebsDate,
    this.rrDocNo,
    this.ebsIp,
    this.noofdays,
    this.estimateRequired,
    this.prNo,
    this.prDate,
    this.statusDate,
    this.aeEmpId,
    this.lmEmpId,
    this.meterMake,
    this.meterCapacity,
    this.meterSlNo,
    this.meterFr,
    this.testReportPath,
  });

  factory CategoryChangeRequestModel.fromJson(Map<String, dynamic> json) {
    return CategoryChangeRequestModel(
      regId: json['regId'],
      regNum: json['regNum'],
      scno: json['scno'],
      consumerName: json['consumerName'],
      existCat: json['existCat'],
      existLoad: json['existLoad'],
      distribution: json['distribution'],
      sectionId: json['sectionId'],
      informatName: json['informatName'],
      serviceChangeType: json['serviceChangeType'],
      doorNo: json['doorNo'],
      street: json['street'],
      area: json['area'],
      town: json['town'],
      mobile: json['mobile'],
      phoneNo: json['phoneNo'],
      email: json['email'],
      reqCat: json['reqCat'],
      reqLoad: json['reqLoad'],
      applicationCharges: json['applicationCharges'],
      developmentCharges: json['developmentCharges'],
      securityDeposit: json['securityDeposit'],
      supervisionCharges: json['supervisionCharges'],
      totalAmount: json['totalAmount'],
      isAmountPaid: json['isAmountPaid'],
      idDocName: json['idDocName'],
      idDocContentType: json['idDocContentType'],
      presentLogin: json['presentLogin'],
      presentLoginLocationCode: json['presentLoginLocationCode'],
      regUser: json['regUser'],
      status: json['status'],
      regIp: json['regIp'],
      insDate: json['insDate'],
      ero: json['ero'],
      idName: json['idName'],
      eroName: json['eroName'],
      paaCode: json['paaCode'],
      oldSectionId: json['oldSectionId'],
      reason: json['reason'],
      dispatchNo: json['dispatchNo'],
      dispatchDate: json['dispatchDate'],
      oldPresentLogin: json['oldPresentLogin'],
      oldPrsLoginLocationCode: json['oldPrsLoginLocationCode'],
      presentLoad: json['presentLoad'],
      discount: json['discount'],
      pincode: json['pincode'],
      district: json['district'],
      isGstnAvail: json['isGstnAvail'],
      gstnNo: json['gstnNo'],
      entryFlag: json['entryFlag'],
      subServiceType: json['subServiceType'],
      consumerType: json['consumerType'],
      consumerTypeOthers: json['consumerTypeOthers'],
      purposeOfSupply: json['purposeOfSupply'],
      purposeOfSupplyOthers: json['purposeOfSupplyOthers'],
      surname: json['surname'],
      fatherName: json['fatherName'],
      socialGroup: json['socialGroup'],
      socialGroupOthers: json['socialGroupOthers'],
      categoryType: json['categoryType'],
      changedCategoryType: json['changedCategoryType'],
      aadhar: json['aadhar'],
      rationcardNo: json['rationcardNo'],
      pan: json['pan'],
      infRelation: json['infRelation'],
      locationType: json['locationType'],
      locationName: json['locationName'],
      ldistrict: json['ldistrict'],
      lmandal: json['lmandal'],
      lvillage: json['lvillage'],
      cdistrict: json['cdistrict'],
      cmandal: json['cmandal'],
      cvillage: json['cvillage'],
      lpincode: json['lpincode'],
      cpincode: json['cpincode'],
      deliveryType: json['deliveryType'],
      existScno: json['existScno'],
      changedSurname: json['changedSurname'],
      changedConsumername: json['changedConsumername'],
      changedFathername: json['changedFathername'],
      changedSocialGrp: json['changedSocialGrp'],
      changedSocialGrpOther: json['changedSocialGrpOther'],
      changedMobileno: json['changedMobileno'],
      reasonOfChange: json['reasonOfChange'],
      infDistrict: json['infDistrict'],
      infMandal: json['infMandal'],
      infVillage: json['infVillage'],
      infPincode: json['infPincode'],
      infDoorno: json['infDoorno'],
      userCharges: json['userCharges'],
      serviceCharge: json['serviceCharge'],
      challanAmount: json['challanAmount'],
      postalCharge: json['postalCharge'],
      inspectionCharge: json['inspectionCharge'],
      acCGst: json['acCGst'],
      acSGst: json['acSGst'],
      acGst: json['acGst'],
      dcCGst: json['dcCGst'],
      dcSGst: json['dcSGst'],
      dcGst: json['dcGst'],
      inspCGst: json['inspCGst'],
      inspSGst: json['inspSGst'],
      inspGst: json['inspGst'],
      deletedReason: json['deletedReason'],
      deletedBy: json['deletedBy'],
      deletedDate: json['deletedDate'],
      regDate: json['regDate'],
      totalCGst: json['totalCGst'],
      totalSGst: json['totalSGst'],
      totalGst: json['totalGst'],
      infMobileNo: json['infMobileNo'],
      uscno: json['uscno'],
      ebsRemarks: json['ebsRemarks'],
      ebsStatus: json['ebsStatus'],
      ebsBy: json['ebsBy'],
      ebsDate: json['ebsDate'],
      rrDocNo: json['rrDocNo'],
      ebsIp: json['ebsIp'],
      noofdays: json['noofdays'],
      estimateRequired: json['estimateRequired'],
      prNo: json['prNo'],
      prDate: json['prDate'],
      statusDate: json['statusDate'],
      aeEmpId: json['aeEmpId'],
      lmEmpId: json['lmEmpId'],
      meterMake: json['meterMake'],
      meterCapacity: json['meterCapacity'],
      meterSlNo: json['meterSlNo'],
      meterFr: json['meterFr'],
      testReportPath: json['testReportPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'regId': regId,
      'regNum': regNum,
      'scno': scno,
      'consumerName': consumerName,
      'existCat': existCat,
      'existLoad': existLoad,
      'distribution': distribution,
      'sectionId': sectionId,
      'informatName': informatName,
      'serviceChangeType': serviceChangeType,
      'doorNo': doorNo,
      'street': street,
      'area': area,
      'town': town,
      'mobile': mobile,
      'phoneNo': phoneNo,
      'email': email,
      'reqCat': reqCat,
      'reqLoad': reqLoad,
      'applicationCharges': applicationCharges,
      'developmentCharges': developmentCharges,
      'securityDeposit': securityDeposit,
      'supervisionCharges': supervisionCharges,
      'totalAmount': totalAmount,
      'isAmountPaid': isAmountPaid,
      'idDocName': idDocName,
      'idDocContentType': idDocContentType,
      'presentLogin': presentLogin,
      'presentLoginLocationCode': presentLoginLocationCode,
      'regUser': regUser,
      'status': status,
      'regIp': regIp,
      'insDate': insDate,
      'ero': ero,
      'idName': idName,
      'eroName': eroName,
      'paaCode': paaCode,
      'oldSectionId': oldSectionId,
      'reason': reason,
      'dispatchNo': dispatchNo,
      'dispatchDate': dispatchDate,
      'oldPresentLogin': oldPresentLogin,
      'oldPrsLoginLocationCode': oldPrsLoginLocationCode,
      'presentLoad': presentLoad,
      'discount': discount,
      'pincode': pincode,
      'district': district,
      'isGstnAvail': isGstnAvail,
      'gstnNo': gstnNo,
      'entryFlag': entryFlag,
      'subServiceType': subServiceType,
      'consumerType': consumerType,
      'consumerTypeOthers': consumerTypeOthers,
      'purposeOfSupply': purposeOfSupply,
      'purposeOfSupplyOthers': purposeOfSupplyOthers,
      'surname': surname,
      'fatherName': fatherName,
      'socialGroup': socialGroup,
      'socialGroupOthers': socialGroupOthers,
      'categoryType': categoryType,
      'changedCategoryType': changedCategoryType,
      'aadhar': aadhar,
      'rationcardNo': rationcardNo,
      'pan': pan,
      'infRelation': infRelation,
      'locationType': locationType,
      'locationName': locationName,
      'ldistrict': ldistrict,
      'lmandal': lmandal,
      'lvillage': lvillage,
      'cdistrict': cdistrict,
      'cmandal': cmandal,
      'cvillage': cvillage,
      'lpincode': lpincode,
      'cpincode': cpincode,
      'deliveryType': deliveryType,
      'existScno': existScno,
      'changedSurname': changedSurname,
      'changedConsumername': changedConsumername,
      'changedFathername': changedFathername,
      'changedSocialGrp': changedSocialGrp,
      'changedSocialGrpOther': changedSocialGrpOther,
      'changedMobileno': changedMobileno,
      'reasonOfChange': reasonOfChange,
      'infDistrict': infDistrict,
      'infMandal': infMandal,
      'infVillage': infVillage,
      'infPincode': infPincode,
      'infDoorno': infDoorno,
      'userCharges': userCharges,
      'serviceCharge': serviceCharge,
      'challanAmount': challanAmount,
      'postalCharge': postalCharge,
      'inspectionCharge': inspectionCharge,
      'acCGst': acCGst,
      'acSGst': acSGst,
      'acGst': acGst,
      'dcCGst': dcCGst,
      'dcSGst': dcSGst,
      'dcGst': dcGst,
      'inspCGst': inspCGst,
      'inspSGst': inspSGst,
      'inspGst': inspGst,
      'deletedReason': deletedReason,
      'deletedBy': deletedBy,
      'deletedDate': deletedDate,
      'regDate': regDate,
      'totalCGst': totalCGst,
      'totalSGst': totalSGst,
      'totalGst': totalGst,
      'infMobileNo': infMobileNo,
      'uscno': uscno,
      'ebsRemarks': ebsRemarks,
      'ebsStatus': ebsStatus,
      'ebsBy': ebsBy,
      'ebsDate': ebsDate,
      'rrDocNo': rrDocNo,
      'ebsIp': ebsIp,
      'noofdays': noofdays,
      'estimateRequired': estimateRequired,
      'prNo': prNo,
      'prDate': prDate,
      'statusDate': statusDate,
      'aeEmpId': aeEmpId,
      'lmEmpId': lmEmpId,
      'meterMake': meterMake,
      'meterCapacity': meterCapacity,
      'meterSlNo': meterSlNo,
      'meterFr': meterFr,
      'testReportPath': testReportPath
    };
  }

}
