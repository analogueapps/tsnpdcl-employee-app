import 'dart:convert';

NpdclUser npdclUserFromJson(String str) => NpdclUser.fromJson(json.decode(str));

String npdclUserToJson(NpdclUser data) => json.encode(data.toJson());

class NpdclUser {
  NpdclUser({
    this.empId,
    this.empAdhaarNumber,
    this.epfAcno,
    this.epfUan,
    this.bankAcno,
    this.pancardNumber,
    this.empName,
    this.empFatherName,
    this.designation,
    this.cityRuralFlag,
    this.eroCode,
    this.unitCode,
    this.divisionCode,
    this.empStatus,
    this.basic,
    this.payStatus,
    this.payMonthYear,
    this.billCode,
    this.earnedLeaves,
    this.medicalLeaves,
    this.locationType,
    this.locationCode,
    this.locationName,
    this.empType,
    this.changeReturnGroup,
    this.gender,
    this.rps,
    this.bankCode,
    this.designationCode,
    this.personalMobileNo,
    this.ofcMobileNo,
    this.empPassword,
    this.smartLogin,
    this.sectionCode,
    this.ofcType,
    this.ofcCode,
    this.wing,
    this.tokenHolder,
    this.secMasterEntity,
    this.allowEbsAndroidApp,
  });

  NpdclUser.fromJson(dynamic json) {
    empId = json['empId'];
    empAdhaarNumber = json['empAdhaarNumber'];
    epfAcno = json['epfAcno'];
    epfUan = json['epfUan'];
    bankAcno = json['bankAcno'];
    pancardNumber = json['pancardNumber'];
    empName = json['empName'];
    empFatherName = json['empFatherName'];
    designation = json['designation'];
    cityRuralFlag = json['cityRuralFlag'];
    eroCode = json['eroCode'];
    unitCode = json['unitCode'];
    divisionCode = json['divisionCode'];
    empStatus = json['empStatus'];
    basic = json['basic'];
    payStatus = json['payStatus'];
    payMonthYear = json['payMonthYear'];
    billCode = json['billCode'];
    earnedLeaves = json['earnedLeaves'];
    medicalLeaves = json['medicalLeaves'];
    locationType = json['locationType'];
    locationCode = json['locationCode'];
    locationName = json['locationName'];
    empType = json['empType'];
    changeReturnGroup = json['changeReturnGroup'];
    gender = json['gender'];
    rps = json['rps'];
    bankCode = json['bankCode'];
    designationCode = json['designationCode'];
    personalMobileNo = json['personalMobileNo'];
    ofcMobileNo = json['ofcMobileNo'];
    empPassword = json['empPassword'];
    smartLogin = json['smartLogin'];
    sectionCode = json['sectionCode'];
    ofcType = json['ofcType'];
    ofcCode = json['ofcCode'];
    wing = json['wing'];
    tokenHolder = json['tokenHolder'];
    secMasterEntity = json['secMasterEntity'] != null
        ? SecMasterEntity.fromJson(json['secMasterEntity'])
        : null;
    allowEbsAndroidApp = json['allowEbsAndroidApp'];
  }

  String? empId;
  String? empAdhaarNumber;
  String? epfAcno;
  String? epfUan;
  String? bankAcno;
  String? pancardNumber;
  String? empName;
  String? empFatherName;
  String? designation;
  String? cityRuralFlag;
  String? eroCode;
  String? unitCode;
  String? divisionCode;
  String? empStatus;
  num? basic;
  String? payStatus;
  String? payMonthYear;
  String? billCode;
  num? earnedLeaves;
  num? medicalLeaves;
  String? locationType;
  String? locationCode;
  String? locationName;
  String? empType;
  String? changeReturnGroup;
  String? gender;
  num? rps;
  String? bankCode;
  num? designationCode;
  String? personalMobileNo;
  String? ofcMobileNo;
  String? empPassword;
  String? smartLogin;
  String? sectionCode;
  String? ofcType;
  String? ofcCode;
  String? wing;
  String? tokenHolder;
  SecMasterEntity? secMasterEntity;
  String? allowEbsAndroidApp;

  NpdclUser copyWith({
    String? empId,
    String? empAdhaarNumber,
    String? epfAcno,
    String? epfUan,
    String? bankAcno,
    String? pancardNumber,
    String? empName,
    String? empFatherName,
    String? designation,
    String? cityRuralFlag,
    String? eroCode,
    String? unitCode,
    String? divisionCode,
    String? empStatus,
    num? basic,
    String? payStatus,
    String? payMonthYear,
    String? billCode,
    num? earnedLeaves,
    num? medicalLeaves,
    String? locationType,
    String? locationCode,
    String? locationName,
    String? empType,
    String? changeReturnGroup,
    String? gender,
    num? rps,
    String? bankCode,
    num? designationCode,
    String? personalMobileNo,
    String? ofcMobileNo,
    String? empPassword,
    String? smartLogin,
    String? sectionCode,
    String? ofcType,
    String? ofcCode,
    String? wing,
    String? tokenHolder,
    SecMasterEntity? secMasterEntity,
    String? allowEbsAndroidApp,
  }) =>
      NpdclUser(
        empId: empId ?? this.empId,
        empAdhaarNumber: empAdhaarNumber ?? this.empAdhaarNumber,
        epfAcno: epfAcno ?? this.epfAcno,
        epfUan: epfUan ?? this.epfUan,
        bankAcno: bankAcno ?? this.bankAcno,
        pancardNumber: pancardNumber ?? this.pancardNumber,
        empName: empName ?? this.empName,
        empFatherName: empFatherName ?? this.empFatherName,
        designation: designation ?? this.designation,
        cityRuralFlag: cityRuralFlag ?? this.cityRuralFlag,
        eroCode: eroCode ?? this.eroCode,
        unitCode: unitCode ?? this.unitCode,
        divisionCode: divisionCode ?? this.divisionCode,
        empStatus: empStatus ?? this.empStatus,
        basic: basic ?? this.basic,
        payStatus: payStatus ?? this.payStatus,
        payMonthYear: payMonthYear ?? this.payMonthYear,
        billCode: billCode ?? this.billCode,
        earnedLeaves: earnedLeaves ?? this.earnedLeaves,
        medicalLeaves: medicalLeaves ?? this.medicalLeaves,
        locationType: locationType ?? this.locationType,
        locationCode: locationCode ?? this.locationCode,
        locationName: locationName ?? this.locationName,
        empType: empType ?? this.empType,
        changeReturnGroup: changeReturnGroup ?? this.changeReturnGroup,
        gender: gender ?? this.gender,
        rps: rps ?? this.rps,
        bankCode: bankCode ?? this.bankCode,
        designationCode: designationCode ?? this.designationCode,
        personalMobileNo: personalMobileNo ?? this.personalMobileNo,
        ofcMobileNo: ofcMobileNo ?? this.ofcMobileNo,
        empPassword: empPassword ?? this.empPassword,
        smartLogin: smartLogin ?? this.smartLogin,
        sectionCode: sectionCode ?? this.sectionCode,
        ofcType: ofcType ?? this.ofcType,
        ofcCode: ofcCode ?? this.ofcCode,
        wing: wing ?? this.wing,
        tokenHolder: tokenHolder ?? this.tokenHolder,
        secMasterEntity: secMasterEntity ?? this.secMasterEntity,
        allowEbsAndroidApp: allowEbsAndroidApp ?? this.allowEbsAndroidApp,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['empId'] = empId;
    map['empAdhaarNumber'] = empAdhaarNumber;
    map['epfAcno'] = epfAcno;
    map['epfUan'] = epfUan;
    map['bankAcno'] = bankAcno;
    map['pancardNumber'] = pancardNumber;
    map['empName'] = empName;
    map['empFatherName'] = empFatherName;
    map['designation'] = designation;
    map['cityRuralFlag'] = cityRuralFlag;
    map['eroCode'] = eroCode;
    map['unitCode'] = unitCode;
    map['divisionCode'] = divisionCode;
    map['empStatus'] = empStatus;
    map['basic'] = basic;
    map['payStatus'] = payStatus;
    map['payMonthYear'] = payMonthYear;
    map['billCode'] = billCode;
    map['earnedLeaves'] = earnedLeaves;
    map['medicalLeaves'] = medicalLeaves;
    map['locationType'] = locationType;
    map['locationCode'] = locationCode;
    map['locationName'] = locationName;
    map['empType'] = empType;
    map['changeReturnGroup'] = changeReturnGroup;
    map['gender'] = gender;
    map['rps'] = rps;
    map['bankCode'] = bankCode;
    map['designationCode'] = designationCode;
    map['personalMobileNo'] = personalMobileNo;
    map['ofcMobileNo'] = ofcMobileNo;
    map['empPassword'] = empPassword;
    map['smartLogin'] = smartLogin;
    map['sectionCode'] = sectionCode;
    map['ofcType'] = ofcType;
    map['ofcCode'] = ofcCode;
    map['wing'] = wing;
    map['tokenHolder'] = tokenHolder;
    if (secMasterEntity != null) {
      map['secMasterEntity'] = secMasterEntity?.toJson();
    }
    map['allowEbsAndroidApp'] = allowEbsAndroidApp;
    return map;
  }
}

SecMasterEntity secMasterEntityFromJson(String str) =>
    SecMasterEntity.fromJson(json.decode(str));

String secMasterEntityToJson(SecMasterEntity data) =>
    json.encode(data.toJson());

class SecMasterEntity {
  SecMasterEntity({
    this.section,
    this.sectionId,
    this.sectionType,
    this.subDivision,
    this.subDivisionId,
    this.subDivisionType,
    this.division,
    this.divisionId,
    this.divisionType,
    this.circle,
    this.circleId,
    this.sectionPhone,
    this.subdivisionPhone,
    this.divisionPhone,
    this.oldSectionId,
    this.ero,
    this.eroId,
  });

  SecMasterEntity.fromJson(dynamic json) {
    section = json['section'];
    sectionId = json['sectionId'];
    sectionType = json['sectionType'];
    subDivision = json['subDivision'];
    subDivisionId = json['subDivisionId'];
    subDivisionType = json['subDivisionType'];
    division = json['division'];
    divisionId = json['divisionId'];
    divisionType = json['divisionType'];
    circle = json['circle'];
    circleId = json['circleId'];
    sectionPhone = json['sectionPhone'];
    subdivisionPhone = json['subdivisionPhone'];
    divisionPhone = json['divisionPhone'];
    oldSectionId = json['oldSectionId'];
    ero = json['ero'];
    eroId = json['eroId'];
  }

  String? section;
  String? sectionId;
  String? sectionType;
  String? subDivision;
  String? subDivisionId;
  String? subDivisionType;
  String? division;
  String? divisionId;
  String? divisionType;
  String? circle;
  String? circleId;
  String? sectionPhone;
  String? subdivisionPhone;
  String? divisionPhone;
  String? oldSectionId;
  String? ero;
  String? eroId;

  SecMasterEntity copyWith({
    String? section,
    String? sectionId,
    String? sectionType,
    String? subDivision,
    String? subDivisionId,
    String? subDivisionType,
    String? division,
    String? divisionId,
    String? divisionType,
    String? circle,
    String? circleId,
    String? sectionPhone,
    String? subdivisionPhone,
    String? divisionPhone,
    String? oldSectionId,
    String? ero,
    String? eroId,
  }) =>
      SecMasterEntity(
        section: section ?? this.section,
        sectionId: sectionId ?? this.sectionId,
        sectionType: sectionType ?? this.sectionType,
        subDivision: subDivision ?? this.subDivision,
        subDivisionId: subDivisionId ?? this.subDivisionId,
        subDivisionType: subDivisionType ?? this.subDivisionType,
        division: division ?? this.division,
        divisionId: divisionId ?? this.divisionId,
        divisionType: divisionType ?? this.divisionType,
        circle: circle ?? this.circle,
        circleId: circleId ?? this.circleId,
        sectionPhone: sectionPhone ?? this.sectionPhone,
        subdivisionPhone: subdivisionPhone ?? this.subdivisionPhone,
        divisionPhone: divisionPhone ?? this.divisionPhone,
        oldSectionId: oldSectionId ?? this.oldSectionId,
        ero: ero ?? this.ero,
        eroId: eroId ?? this.eroId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['section'] = section;
    map['sectionId'] = sectionId;
    map['sectionType'] = sectionType;
    map['subDivision'] = subDivision;
    map['subDivisionId'] = subDivisionId;
    map['subDivisionType'] = subDivisionType;
    map['division'] = division;
    map['divisionId'] = divisionId;
    map['divisionType'] = divisionType;
    map['circle'] = circle;
    map['circleId'] = circleId;
    map['sectionPhone'] = sectionPhone;
    map['subdivisionPhone'] = subdivisionPhone;
    map['divisionPhone'] = divisionPhone;
    map['oldSectionId'] = oldSectionId;
    map['ero'] = ero;
    map['eroId'] = eroId;
    return map;
  }
}
