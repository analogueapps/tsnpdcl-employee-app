import 'dart:convert';

PoleRequestIndentEntity poleRequestIndentEntityFromJson(String str) =>
    PoleRequestIndentEntity.fromJson(json.decode(str));

String poleRequestIndentEntityToJson(PoleRequestIndentEntity data) =>
    json.encode(data.toJson());

class PoleRequestIndentEntity {
  PoleRequestIndentEntity({
    this.indentId,
    this.sectionId,
    this.section,
    this.indentRaisedAeEmpId,
    this.indentRaisedAeEmpDes,
    this.indentDate,
    this.requisitionNo,
    this.requestedQty,
    this.aeRemovedQty,
    this.balanceQty,
    this.aeOdRecommendedQty,
    this.approvedQty,
    this.poleType,
    this.aeOdEmpId,
    this.aeOdActionDate,
    this.erstCircleId,
    this.indentStatus,
    this.remarksByAeOd,
    this.remarksByAdeStores,
    this.employeeMasterEntityByIndentRaisedAeEmpId,
    this.employeeMasterEntityByAeOdEmpId,
    this.poleRequestIndentTrackEntitiesByIndentId,
  });

  PoleRequestIndentEntity.fromJson(dynamic json) {
    indentId = json['indentId'];
    sectionId = json['sectionId'];
    section = json['section'];
    indentRaisedAeEmpId = json['indentRaisedAeEmpId'];
    indentRaisedAeEmpDes = json['indentRaisedAeEmpDes'];
    indentDate = json['indentDate'];
    requisitionNo = json['requisitionNo'];
    requestedQty = json['requestedQty'];
    aeRemovedQty = json['aeRemovedQty'];
    balanceQty = json['balanceQty'];
    aeOdRecommendedQty = json['aeOdRecommendedQty'];
    approvedQty = json['approvedQty'];
    poleType = json['poleType'];
    aeOdEmpId = json['aeOdEmpId'];
    aeOdActionDate = json['aeOdActionDate'];
    erstCircleId = json['erstCircleId'];
    indentStatus = json['indentStatus'];
    remarksByAeOd = json['remarksByAeOd'];
    remarksByAdeStores = json['remarksByAdeStores'];
    employeeMasterEntityByIndentRaisedAeEmpId =
        json['employeeMasterEntityByIndentRaisedAeEmpId'] != null
            ? EmployeeMasterEntityByIndentRaisedAeEmpId.fromJson(
                json['employeeMasterEntityByIndentRaisedAeEmpId'])
            : null;
    employeeMasterEntityByAeOdEmpId =
        json['employeeMasterEntityByAeOdEmpId'] != null
            ? EmployeeMasterEntityByAeOdEmpId.fromJson(
                json['employeeMasterEntityByAeOdEmpId'])
            : null;
    if (json['poleRequestIndentTrackEntitiesByIndentId'] != null) {
      poleRequestIndentTrackEntitiesByIndentId = [];
      json['poleRequestIndentTrackEntitiesByIndentId'].forEach((v) {
        poleRequestIndentTrackEntitiesByIndentId
            ?.add(PoleRequestIndentTrackEntitiesByIndentId.fromJson(v));
      });
    }
  }

  num? indentId;
  String? sectionId;
  String? section;
  String? indentRaisedAeEmpId;
  String? indentRaisedAeEmpDes;
  String? indentDate;
  String? requisitionNo;
  num? requestedQty;
  num? aeRemovedQty;
  num? balanceQty;
  num? aeOdRecommendedQty;
  num? approvedQty;
  String? poleType;
  String? aeOdEmpId;
  String? aeOdActionDate;
  num? erstCircleId;
  String? indentStatus;
  String? remarksByAeOd;
  String? remarksByAdeStores;
  EmployeeMasterEntityByIndentRaisedAeEmpId?
      employeeMasterEntityByIndentRaisedAeEmpId;
  EmployeeMasterEntityByAeOdEmpId? employeeMasterEntityByAeOdEmpId;
  List<PoleRequestIndentTrackEntitiesByIndentId>?
      poleRequestIndentTrackEntitiesByIndentId;

  PoleRequestIndentEntity copyWith({
    num? indentId,
    String? sectionId,
    String? section,
    String? indentRaisedAeEmpId,
    String? indentRaisedAeEmpDes,
    String? indentDate,
    String? requisitionNo,
    num? requestedQty,
    num? aeRemovedQty,
    num? balanceQty,
    num? aeOdRecommendedQty,
    num? approvedQty,
    String? poleType,
    String? aeOdEmpId,
    String? aeOdActionDate,
    num? erstCircleId,
    String? indentStatus,
    String? remarksByAeOd,
    String? remarksByAdeStores,
    EmployeeMasterEntityByIndentRaisedAeEmpId?
        employeeMasterEntityByIndentRaisedAeEmpId,
    EmployeeMasterEntityByAeOdEmpId? employeeMasterEntityByAeOdEmpId,
    List<PoleRequestIndentTrackEntitiesByIndentId>?
        poleRequestIndentTrackEntitiesByIndentId,
  }) =>
      PoleRequestIndentEntity(
        indentId: indentId ?? this.indentId,
        sectionId: sectionId ?? this.sectionId,
        section: section ?? this.section,
        indentRaisedAeEmpId: indentRaisedAeEmpId ?? this.indentRaisedAeEmpId,
        indentRaisedAeEmpDes: indentRaisedAeEmpDes ?? this.indentRaisedAeEmpDes,
        indentDate: indentDate ?? this.indentDate,
        requisitionNo: requisitionNo ?? this.requisitionNo,
        requestedQty: requestedQty ?? this.requestedQty,
        aeRemovedQty: aeRemovedQty ?? this.aeRemovedQty,
        balanceQty: balanceQty ?? this.balanceQty,
        aeOdRecommendedQty: aeOdRecommendedQty ?? this.aeOdRecommendedQty,
        approvedQty: approvedQty ?? this.approvedQty,
        poleType: poleType ?? this.poleType,
        aeOdEmpId: aeOdEmpId ?? this.aeOdEmpId,
        aeOdActionDate: aeOdActionDate ?? this.aeOdActionDate,
        erstCircleId: erstCircleId ?? this.erstCircleId,
        indentStatus: indentStatus ?? this.indentStatus,
        remarksByAeOd: remarksByAeOd ?? this.remarksByAeOd,
        remarksByAdeStores: remarksByAdeStores ?? this.remarksByAdeStores,
        employeeMasterEntityByIndentRaisedAeEmpId:
            employeeMasterEntityByIndentRaisedAeEmpId ??
                this.employeeMasterEntityByIndentRaisedAeEmpId,
        employeeMasterEntityByAeOdEmpId: employeeMasterEntityByAeOdEmpId ??
            this.employeeMasterEntityByAeOdEmpId,
        poleRequestIndentTrackEntitiesByIndentId:
            poleRequestIndentTrackEntitiesByIndentId ??
                this.poleRequestIndentTrackEntitiesByIndentId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['indentId'] = indentId;
    map['sectionId'] = sectionId;
    map['section'] = section;
    map['indentRaisedAeEmpId'] = indentRaisedAeEmpId;
    map['indentRaisedAeEmpDes'] = indentRaisedAeEmpDes;
    map['indentDate'] = indentDate;
    map['requisitionNo'] = requisitionNo;
    map['requestedQty'] = requestedQty;
    map['aeRemovedQty'] = aeRemovedQty;
    map['balanceQty'] = balanceQty;
    map['aeOdRecommendedQty'] = aeOdRecommendedQty;
    map['approvedQty'] = approvedQty;
    map['poleType'] = poleType;
    map['aeOdEmpId'] = aeOdEmpId;
    map['aeOdActionDate'] = aeOdActionDate;
    map['erstCircleId'] = erstCircleId;
    map['indentStatus'] = indentStatus;
    map['remarksByAeOd'] = remarksByAeOd;
    map['remarksByAdeStores'] = remarksByAdeStores;
    if (employeeMasterEntityByIndentRaisedAeEmpId != null) {
      map['employeeMasterEntityByIndentRaisedAeEmpId'] =
          employeeMasterEntityByIndentRaisedAeEmpId?.toJson();
    }
    if (employeeMasterEntityByAeOdEmpId != null) {
      map['employeeMasterEntityByAeOdEmpId'] =
          employeeMasterEntityByAeOdEmpId?.toJson();
    }
    if (poleRequestIndentTrackEntitiesByIndentId != null) {
      map['poleRequestIndentTrackEntitiesByIndentId'] =
          poleRequestIndentTrackEntitiesByIndentId
              ?.map((v) => v.toJson())
              .toList();
    }
    return map;
  }
}

PoleRequestIndentTrackEntitiesByIndentId
    poleRequestIndentTrackEntitiesByIndentIdFromJson(String str) =>
        PoleRequestIndentTrackEntitiesByIndentId.fromJson(json.decode(str));

String poleRequestIndentTrackEntitiesByIndentIdToJson(
        PoleRequestIndentTrackEntitiesByIndentId data) =>
    json.encode(data.toJson());

class PoleRequestIndentTrackEntitiesByIndentId {
  PoleRequestIndentTrackEntitiesByIndentId({
    this.trackId,
    this.indentId,
    this.sectionId,
    this.indentRaisedAeEmpId,
    this.indentRaisedAeEmpDes,
    this.indentDate,
    this.requisitionNo,
    this.requestedQty,
    this.balanceQty,
    this.aeOdRecommendedQty,
    this.poleType,
    this.aeOdEmpId,
    this.aeOdActionDate,
    this.erstCircleId,
    this.indentStatus,
    this.section,
    this.employeeMasterEntityByIndentRaisedAeEmpId,
    this.employeeMasterEntityByAeOdEmpId,
    this.logDate,
  });

  PoleRequestIndentTrackEntitiesByIndentId.fromJson(dynamic json) {
    trackId = json['trackId'];
    indentId = json['indentId'];
    sectionId = json['sectionId'];
    indentRaisedAeEmpId = json['indentRaisedAeEmpId'];
    indentRaisedAeEmpDes = json['indentRaisedAeEmpDes'];
    indentDate = json['indentDate'];
    requisitionNo = json['requisitionNo'];
    requestedQty = json['requestedQty'];
    balanceQty = json['balanceQty'];
    aeOdRecommendedQty = json['aeOdRecommendedQty'];
    poleType = json['poleType'];
    aeOdEmpId = json['aeOdEmpId'];
    aeOdActionDate = json['aeOdActionDate'];
    erstCircleId = json['erstCircleId'];
    indentStatus = json['indentStatus'];
    section = json['section'];
    employeeMasterEntityByIndentRaisedAeEmpId =
        json['employeeMasterEntityByIndentRaisedAeEmpId'] != null
            ? EmployeeMasterEntityByIndentRaisedAeEmpId.fromJson(
                json['employeeMasterEntityByIndentRaisedAeEmpId'])
            : null;
    employeeMasterEntityByAeOdEmpId =
        json['employeeMasterEntityByAeOdEmpId'] != null
            ? EmployeeMasterEntityByAeOdEmpId.fromJson(
                json['employeeMasterEntityByAeOdEmpId'])
            : null;
    logDate = json['logDate'];
  }

  num? trackId;
  num? indentId;
  String? sectionId;
  String? indentRaisedAeEmpId;
  String? indentRaisedAeEmpDes;
  String? indentDate;
  String? requisitionNo;
  num? requestedQty;
  num? balanceQty;
  num? aeOdRecommendedQty;
  String? poleType;
  String? aeOdEmpId;
  String? aeOdActionDate;
  num? erstCircleId;
  String? indentStatus;
  String? section;
  EmployeeMasterEntityByIndentRaisedAeEmpId?
      employeeMasterEntityByIndentRaisedAeEmpId;
  EmployeeMasterEntityByAeOdEmpId? employeeMasterEntityByAeOdEmpId;
  String? logDate;

  PoleRequestIndentTrackEntitiesByIndentId copyWith({
    num? trackId,
    num? indentId,
    String? sectionId,
    String? indentRaisedAeEmpId,
    String? indentRaisedAeEmpDes,
    String? indentDate,
    String? requisitionNo,
    num? requestedQty,
    num? balanceQty,
    num? aeOdRecommendedQty,
    String? poleType,
    String? aeOdEmpId,
    String? aeOdActionDate,
    num? erstCircleId,
    String? indentStatus,
    String? section,
    EmployeeMasterEntityByIndentRaisedAeEmpId?
        employeeMasterEntityByIndentRaisedAeEmpId,
    EmployeeMasterEntityByAeOdEmpId? employeeMasterEntityByAeOdEmpId,
    String? logDate,
  }) =>
      PoleRequestIndentTrackEntitiesByIndentId(
        trackId: trackId ?? this.trackId,
        indentId: indentId ?? this.indentId,
        sectionId: sectionId ?? this.sectionId,
        indentRaisedAeEmpId: indentRaisedAeEmpId ?? this.indentRaisedAeEmpId,
        indentRaisedAeEmpDes: indentRaisedAeEmpDes ?? this.indentRaisedAeEmpDes,
        indentDate: indentDate ?? this.indentDate,
        requisitionNo: requisitionNo ?? this.requisitionNo,
        requestedQty: requestedQty ?? this.requestedQty,
        balanceQty: balanceQty ?? this.balanceQty,
        aeOdRecommendedQty: aeOdRecommendedQty ?? this.aeOdRecommendedQty,
        poleType: poleType ?? this.poleType,
        aeOdEmpId: aeOdEmpId ?? this.aeOdEmpId,
        aeOdActionDate: aeOdActionDate ?? this.aeOdActionDate,
        erstCircleId: erstCircleId ?? this.erstCircleId,
        indentStatus: indentStatus ?? this.indentStatus,
        section: section ?? this.section,
        employeeMasterEntityByIndentRaisedAeEmpId:
            employeeMasterEntityByIndentRaisedAeEmpId ??
                this.employeeMasterEntityByIndentRaisedAeEmpId,
        employeeMasterEntityByAeOdEmpId: employeeMasterEntityByAeOdEmpId ??
            this.employeeMasterEntityByAeOdEmpId,
        logDate: logDate ?? this.logDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['trackId'] = trackId;
    map['indentId'] = indentId;
    map['sectionId'] = sectionId;
    map['indentRaisedAeEmpId'] = indentRaisedAeEmpId;
    map['indentRaisedAeEmpDes'] = indentRaisedAeEmpDes;
    map['indentDate'] = indentDate;
    map['requisitionNo'] = requisitionNo;
    map['requestedQty'] = requestedQty;
    map['balanceQty'] = balanceQty;
    map['aeOdRecommendedQty'] = aeOdRecommendedQty;
    map['poleType'] = poleType;
    map['aeOdEmpId'] = aeOdEmpId;
    map['aeOdActionDate'] = aeOdActionDate;
    map['erstCircleId'] = erstCircleId;
    map['indentStatus'] = indentStatus;
    map['section'] = section;
    if (employeeMasterEntityByIndentRaisedAeEmpId != null) {
      map['employeeMasterEntityByIndentRaisedAeEmpId'] =
          employeeMasterEntityByIndentRaisedAeEmpId?.toJson();
    }
    if (employeeMasterEntityByAeOdEmpId != null) {
      map['employeeMasterEntityByAeOdEmpId'] =
          employeeMasterEntityByAeOdEmpId?.toJson();
    }
    map['logDate'] = logDate;
    return map;
  }
}

EmployeeMasterEntityByAeOdEmpId employeeMasterEntityByAeOdEmpIdFromJson(
        String str) =>
    EmployeeMasterEntityByAeOdEmpId.fromJson(json.decode(str));

String employeeMasterEntityByAeOdEmpIdToJson(
        EmployeeMasterEntityByAeOdEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByAeOdEmpId {
  EmployeeMasterEntityByAeOdEmpId({
    this.empId,
    this.epfAcno,
    this.epfUan,
    this.bankAcno,
    this.pancardNumber,
    this.empName,
    this.dateOfBirth,
    this.dateOfJoining,
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
    this.allowEbsAndroidApp,
  });

  EmployeeMasterEntityByAeOdEmpId.fromJson(dynamic json) {
    empId = json['empId'];
    epfAcno = json['epfAcno'];
    epfUan = json['epfUan'];
    bankAcno = json['bankAcno'];
    pancardNumber = json['pancardNumber'];
    empName = json['empName'];
    dateOfBirth = json['dateOfBirth'];
    dateOfJoining = json['dateOfJoining'];
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
    allowEbsAndroidApp = json['allowEbsAndroidApp'];
  }

  String? empId;
  String? epfAcno;
  String? epfUan;
  String? bankAcno;
  String? pancardNumber;
  String? empName;
  String? dateOfBirth;
  String? dateOfJoining;
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
  String? allowEbsAndroidApp;

  EmployeeMasterEntityByAeOdEmpId copyWith({
    String? empId,
    String? epfAcno,
    String? epfUan,
    String? bankAcno,
    String? pancardNumber,
    String? empName,
    String? dateOfBirth,
    String? dateOfJoining,
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
    String? allowEbsAndroidApp,
  }) =>
      EmployeeMasterEntityByAeOdEmpId(
        empId: empId ?? this.empId,
        epfAcno: epfAcno ?? this.epfAcno,
        epfUan: epfUan ?? this.epfUan,
        bankAcno: bankAcno ?? this.bankAcno,
        pancardNumber: pancardNumber ?? this.pancardNumber,
        empName: empName ?? this.empName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        dateOfJoining: dateOfJoining ?? this.dateOfJoining,
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
        allowEbsAndroidApp: allowEbsAndroidApp ?? this.allowEbsAndroidApp,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['empId'] = empId;
    map['epfAcno'] = epfAcno;
    map['epfUan'] = epfUan;
    map['bankAcno'] = bankAcno;
    map['pancardNumber'] = pancardNumber;
    map['empName'] = empName;
    map['dateOfBirth'] = dateOfBirth;
    map['dateOfJoining'] = dateOfJoining;
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
    map['allowEbsAndroidApp'] = allowEbsAndroidApp;
    return map;
  }
}

EmployeeMasterEntityByIndentRaisedAeEmpId
    employeeMasterEntityByIndentRaisedAeEmpIdFromJson(String str) =>
        EmployeeMasterEntityByIndentRaisedAeEmpId.fromJson(json.decode(str));

String employeeMasterEntityByIndentRaisedAeEmpIdToJson(
        EmployeeMasterEntityByIndentRaisedAeEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByIndentRaisedAeEmpId {
  EmployeeMasterEntityByIndentRaisedAeEmpId({
    this.empId,
    this.empAdhaarNumber,
    this.epfAcno,
    this.epfUan,
    this.bankAcno,
    this.pancardNumber,
    this.empName,
    this.empFatherName,
    this.dateOfBirth,
    this.dateOfJoining,
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
    this.allowEbsAndroidApp,
  });

  EmployeeMasterEntityByIndentRaisedAeEmpId.fromJson(dynamic json) {
    empId = json['empId'];
    empAdhaarNumber = json['empAdhaarNumber'];
    epfAcno = json['epfAcno'];
    epfUan = json['epfUan'];
    bankAcno = json['bankAcno'];
    pancardNumber = json['pancardNumber'];
    empName = json['empName'];
    empFatherName = json['empFatherName'];
    dateOfBirth = json['dateOfBirth'];
    dateOfJoining = json['dateOfJoining'];
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
  String? dateOfBirth;
  String? dateOfJoining;
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
  String? allowEbsAndroidApp;

  EmployeeMasterEntityByIndentRaisedAeEmpId copyWith({
    String? empId,
    String? empAdhaarNumber,
    String? epfAcno,
    String? epfUan,
    String? bankAcno,
    String? pancardNumber,
    String? empName,
    String? empFatherName,
    String? dateOfBirth,
    String? dateOfJoining,
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
    String? allowEbsAndroidApp,
  }) =>
      EmployeeMasterEntityByIndentRaisedAeEmpId(
        empId: empId ?? this.empId,
        empAdhaarNumber: empAdhaarNumber ?? this.empAdhaarNumber,
        epfAcno: epfAcno ?? this.epfAcno,
        epfUan: epfUan ?? this.epfUan,
        bankAcno: bankAcno ?? this.bankAcno,
        pancardNumber: pancardNumber ?? this.pancardNumber,
        empName: empName ?? this.empName,
        empFatherName: empFatherName ?? this.empFatherName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        dateOfJoining: dateOfJoining ?? this.dateOfJoining,
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
    map['dateOfBirth'] = dateOfBirth;
    map['dateOfJoining'] = dateOfJoining;
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
    map['allowEbsAndroidApp'] = allowEbsAndroidApp;
    return map;
  }
}

// EmployeeMasterEntityByAeOdEmpId employeeMasterEntityByAeOdEmpIdFromJson(
//         String str) =>
//     EmployeeMasterEntityByAeOdEmpId.fromJson(json.decode(str));
//
// String employeeMasterEntityByAeOdEmpIdToJson(
//         EmployeeMasterEntityByAeOdEmpId data) =>
//     json.encode(data.toJson());
//
// class EmployeeMasterEntityByAeOdEmpId {
//   EmployeeMasterEntityByAeOdEmpId({
//     this.empId,
//     this.epfAcno,
//     this.epfUan,
//     this.bankAcno,
//     this.pancardNumber,
//     this.empName,
//     this.dateOfBirth,
//     this.dateOfJoining,
//     this.designation,
//     this.cityRuralFlag,
//     this.eroCode,
//     this.unitCode,
//     this.divisionCode,
//     this.empStatus,
//     this.basic,
//     this.payStatus,
//     this.payMonthYear,
//     this.billCode,
//     this.earnedLeaves,
//     this.medicalLeaves,
//     this.locationType,
//     this.locationCode,
//     this.locationName,
//     this.empType,
//     this.changeReturnGroup,
//     this.gender,
//     this.rps,
//     this.bankCode,
//     this.designationCode,
//     this.personalMobileNo,
//     this.ofcMobileNo,
//     this.empPassword,
//     this.smartLogin,
//     this.sectionCode,
//     this.ofcType,
//     this.ofcCode,
//     this.wing,
//     this.allowEbsAndroidApp,
//   });
//
//   EmployeeMasterEntityByAeOdEmpId.fromJson(dynamic json) {
//     empId = json['empId'];
//     epfAcno = json['epfAcno'];
//     epfUan = json['epfUan'];
//     bankAcno = json['bankAcno'];
//     pancardNumber = json['pancardNumber'];
//     empName = json['empName'];
//     dateOfBirth = json['dateOfBirth'];
//     dateOfJoining = json['dateOfJoining'];
//     designation = json['designation'];
//     cityRuralFlag = json['cityRuralFlag'];
//     eroCode = json['eroCode'];
//     unitCode = json['unitCode'];
//     divisionCode = json['divisionCode'];
//     empStatus = json['empStatus'];
//     basic = json['basic'];
//     payStatus = json['payStatus'];
//     payMonthYear = json['payMonthYear'];
//     billCode = json['billCode'];
//     earnedLeaves = json['earnedLeaves'];
//     medicalLeaves = json['medicalLeaves'];
//     locationType = json['locationType'];
//     locationCode = json['locationCode'];
//     locationName = json['locationName'];
//     empType = json['empType'];
//     changeReturnGroup = json['changeReturnGroup'];
//     gender = json['gender'];
//     rps = json['rps'];
//     bankCode = json['bankCode'];
//     designationCode = json['designationCode'];
//     personalMobileNo = json['personalMobileNo'];
//     ofcMobileNo = json['ofcMobileNo'];
//     empPassword = json['empPassword'];
//     smartLogin = json['smartLogin'];
//     sectionCode = json['sectionCode'];
//     ofcType = json['ofcType'];
//     ofcCode = json['ofcCode'];
//     wing = json['wing'];
//     allowEbsAndroidApp = json['allowEbsAndroidApp'];
//   }
//
//   String? empId;
//   String? epfAcno;
//   String? epfUan;
//   String? bankAcno;
//   String? pancardNumber;
//   String? empName;
//   String? dateOfBirth;
//   String? dateOfJoining;
//   String? designation;
//   String? cityRuralFlag;
//   String? eroCode;
//   String? unitCode;
//   String? divisionCode;
//   String? empStatus;
//   num? basic;
//   String? payStatus;
//   String? payMonthYear;
//   String? billCode;
//   num? earnedLeaves;
//   num? medicalLeaves;
//   String? locationType;
//   String? locationCode;
//   String? locationName;
//   String? empType;
//   String? changeReturnGroup;
//   String? gender;
//   num? rps;
//   String? bankCode;
//   num? designationCode;
//   String? personalMobileNo;
//   String? ofcMobileNo;
//   String? empPassword;
//   String? smartLogin;
//   String? sectionCode;
//   String? ofcType;
//   String? ofcCode;
//   String? wing;
//   String? allowEbsAndroidApp;
//
//   EmployeeMasterEntityByAeOdEmpId copyWith({
//     String? empId,
//     String? epfAcno,
//     String? epfUan,
//     String? bankAcno,
//     String? pancardNumber,
//     String? empName,
//     String? dateOfBirth,
//     String? dateOfJoining,
//     String? designation,
//     String? cityRuralFlag,
//     String? eroCode,
//     String? unitCode,
//     String? divisionCode,
//     String? empStatus,
//     num? basic,
//     String? payStatus,
//     String? payMonthYear,
//     String? billCode,
//     num? earnedLeaves,
//     num? medicalLeaves,
//     String? locationType,
//     String? locationCode,
//     String? locationName,
//     String? empType,
//     String? changeReturnGroup,
//     String? gender,
//     num? rps,
//     String? bankCode,
//     num? designationCode,
//     String? personalMobileNo,
//     String? ofcMobileNo,
//     String? empPassword,
//     String? smartLogin,
//     String? sectionCode,
//     String? ofcType,
//     String? ofcCode,
//     String? wing,
//     String? allowEbsAndroidApp,
//   }) =>
//       EmployeeMasterEntityByAeOdEmpId(
//         empId: empId ?? this.empId,
//         epfAcno: epfAcno ?? this.epfAcno,
//         epfUan: epfUan ?? this.epfUan,
//         bankAcno: bankAcno ?? this.bankAcno,
//         pancardNumber: pancardNumber ?? this.pancardNumber,
//         empName: empName ?? this.empName,
//         dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//         dateOfJoining: dateOfJoining ?? this.dateOfJoining,
//         designation: designation ?? this.designation,
//         cityRuralFlag: cityRuralFlag ?? this.cityRuralFlag,
//         eroCode: eroCode ?? this.eroCode,
//         unitCode: unitCode ?? this.unitCode,
//         divisionCode: divisionCode ?? this.divisionCode,
//         empStatus: empStatus ?? this.empStatus,
//         basic: basic ?? this.basic,
//         payStatus: payStatus ?? this.payStatus,
//         payMonthYear: payMonthYear ?? this.payMonthYear,
//         billCode: billCode ?? this.billCode,
//         earnedLeaves: earnedLeaves ?? this.earnedLeaves,
//         medicalLeaves: medicalLeaves ?? this.medicalLeaves,
//         locationType: locationType ?? this.locationType,
//         locationCode: locationCode ?? this.locationCode,
//         locationName: locationName ?? this.locationName,
//         empType: empType ?? this.empType,
//         changeReturnGroup: changeReturnGroup ?? this.changeReturnGroup,
//         gender: gender ?? this.gender,
//         rps: rps ?? this.rps,
//         bankCode: bankCode ?? this.bankCode,
//         designationCode: designationCode ?? this.designationCode,
//         personalMobileNo: personalMobileNo ?? this.personalMobileNo,
//         ofcMobileNo: ofcMobileNo ?? this.ofcMobileNo,
//         empPassword: empPassword ?? this.empPassword,
//         smartLogin: smartLogin ?? this.smartLogin,
//         sectionCode: sectionCode ?? this.sectionCode,
//         ofcType: ofcType ?? this.ofcType,
//         ofcCode: ofcCode ?? this.ofcCode,
//         wing: wing ?? this.wing,
//         allowEbsAndroidApp: allowEbsAndroidApp ?? this.allowEbsAndroidApp,
//       );
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['empId'] = empId;
//     map['epfAcno'] = epfAcno;
//     map['epfUan'] = epfUan;
//     map['bankAcno'] = bankAcno;
//     map['pancardNumber'] = pancardNumber;
//     map['empName'] = empName;
//     map['dateOfBirth'] = dateOfBirth;
//     map['dateOfJoining'] = dateOfJoining;
//     map['designation'] = designation;
//     map['cityRuralFlag'] = cityRuralFlag;
//     map['eroCode'] = eroCode;
//     map['unitCode'] = unitCode;
//     map['divisionCode'] = divisionCode;
//     map['empStatus'] = empStatus;
//     map['basic'] = basic;
//     map['payStatus'] = payStatus;
//     map['payMonthYear'] = payMonthYear;
//     map['billCode'] = billCode;
//     map['earnedLeaves'] = earnedLeaves;
//     map['medicalLeaves'] = medicalLeaves;
//     map['locationType'] = locationType;
//     map['locationCode'] = locationCode;
//     map['locationName'] = locationName;
//     map['empType'] = empType;
//     map['changeReturnGroup'] = changeReturnGroup;
//     map['gender'] = gender;
//     map['rps'] = rps;
//     map['bankCode'] = bankCode;
//     map['designationCode'] = designationCode;
//     map['personalMobileNo'] = personalMobileNo;
//     map['ofcMobileNo'] = ofcMobileNo;
//     map['empPassword'] = empPassword;
//     map['smartLogin'] = smartLogin;
//     map['sectionCode'] = sectionCode;
//     map['ofcType'] = ofcType;
//     map['ofcCode'] = ofcCode;
//     map['wing'] = wing;
//     map['allowEbsAndroidApp'] = allowEbsAndroidApp;
//     return map;
//   }
// }

// EmployeeMasterEntityByIndentRaisedAeEmpId
//     employeeMasterEntityByIndentRaisedAeEmpIdFromJson(String str) =>
//         EmployeeMasterEntityByIndentRaisedAeEmpId.fromJson(json.decode(str));
//
// String employeeMasterEntityByIndentRaisedAeEmpIdToJson(
//         EmployeeMasterEntityByIndentRaisedAeEmpId data) =>
//     json.encode(data.toJson());
//
// class EmployeeMasterEntityByIndentRaisedAeEmpId {
//   EmployeeMasterEntityByIndentRaisedAeEmpId({
//     this.empId,
//     this.empAdhaarNumber,
//     this.epfAcno,
//     this.epfUan,
//     this.bankAcno,
//     this.pancardNumber,
//     this.empName,
//     this.empFatherName,
//     this.dateOfBirth,
//     this.dateOfJoining,
//     this.designation,
//     this.cityRuralFlag,
//     this.eroCode,
//     this.unitCode,
//     this.divisionCode,
//     this.empStatus,
//     this.basic,
//     this.payStatus,
//     this.payMonthYear,
//     this.billCode,
//     this.earnedLeaves,
//     this.medicalLeaves,
//     this.locationType,
//     this.locationCode,
//     this.locationName,
//     this.empType,
//     this.changeReturnGroup,
//     this.gender,
//     this.rps,
//     this.bankCode,
//     this.designationCode,
//     this.personalMobileNo,
//     this.ofcMobileNo,
//     this.empPassword,
//     this.smartLogin,
//     this.sectionCode,
//     this.ofcType,
//     this.ofcCode,
//     this.wing,
//     this.allowEbsAndroidApp,
//   });
//
//   EmployeeMasterEntityByIndentRaisedAeEmpId.fromJson(dynamic json) {
//     empId = json['empId'];
//     empAdhaarNumber = json['empAdhaarNumber'];
//     epfAcno = json['epfAcno'];
//     epfUan = json['epfUan'];
//     bankAcno = json['bankAcno'];
//     pancardNumber = json['pancardNumber'];
//     empName = json['empName'];
//     empFatherName = json['empFatherName'];
//     dateOfBirth = json['dateOfBirth'];
//     dateOfJoining = json['dateOfJoining'];
//     designation = json['designation'];
//     cityRuralFlag = json['cityRuralFlag'];
//     eroCode = json['eroCode'];
//     unitCode = json['unitCode'];
//     divisionCode = json['divisionCode'];
//     empStatus = json['empStatus'];
//     basic = json['basic'];
//     payStatus = json['payStatus'];
//     payMonthYear = json['payMonthYear'];
//     billCode = json['billCode'];
//     earnedLeaves = json['earnedLeaves'];
//     medicalLeaves = json['medicalLeaves'];
//     locationType = json['locationType'];
//     locationCode = json['locationCode'];
//     locationName = json['locationName'];
//     empType = json['empType'];
//     changeReturnGroup = json['changeReturnGroup'];
//     gender = json['gender'];
//     rps = json['rps'];
//     bankCode = json['bankCode'];
//     designationCode = json['designationCode'];
//     personalMobileNo = json['personalMobileNo'];
//     ofcMobileNo = json['ofcMobileNo'];
//     empPassword = json['empPassword'];
//     smartLogin = json['smartLogin'];
//     sectionCode = json['sectionCode'];
//     ofcType = json['ofcType'];
//     ofcCode = json['ofcCode'];
//     wing = json['wing'];
//     allowEbsAndroidApp = json['allowEbsAndroidApp'];
//   }
//
//   String? empId;
//   String? empAdhaarNumber;
//   String? epfAcno;
//   String? epfUan;
//   String? bankAcno;
//   String? pancardNumber;
//   String? empName;
//   String? empFatherName;
//   String? dateOfBirth;
//   String? dateOfJoining;
//   String? designation;
//   String? cityRuralFlag;
//   String? eroCode;
//   String? unitCode;
//   String? divisionCode;
//   String? empStatus;
//   num? basic;
//   String? payStatus;
//   String? payMonthYear;
//   String? billCode;
//   num? earnedLeaves;
//   num? medicalLeaves;
//   String? locationType;
//   String? locationCode;
//   String? locationName;
//   String? empType;
//   String? changeReturnGroup;
//   String? gender;
//   num? rps;
//   String? bankCode;
//   num? designationCode;
//   String? personalMobileNo;
//   String? ofcMobileNo;
//   String? empPassword;
//   String? smartLogin;
//   String? sectionCode;
//   String? ofcType;
//   String? ofcCode;
//   String? wing;
//   String? allowEbsAndroidApp;
//
//   EmployeeMasterEntityByIndentRaisedAeEmpId copyWith({
//     String? empId,
//     String? empAdhaarNumber,
//     String? epfAcno,
//     String? epfUan,
//     String? bankAcno,
//     String? pancardNumber,
//     String? empName,
//     String? empFatherName,
//     String? dateOfBirth,
//     String? dateOfJoining,
//     String? designation,
//     String? cityRuralFlag,
//     String? eroCode,
//     String? unitCode,
//     String? divisionCode,
//     String? empStatus,
//     num? basic,
//     String? payStatus,
//     String? payMonthYear,
//     String? billCode,
//     num? earnedLeaves,
//     num? medicalLeaves,
//     String? locationType,
//     String? locationCode,
//     String? locationName,
//     String? empType,
//     String? changeReturnGroup,
//     String? gender,
//     num? rps,
//     String? bankCode,
//     num? designationCode,
//     String? personalMobileNo,
//     String? ofcMobileNo,
//     String? empPassword,
//     String? smartLogin,
//     String? sectionCode,
//     String? ofcType,
//     String? ofcCode,
//     String? wing,
//     String? allowEbsAndroidApp,
//   }) =>
//       EmployeeMasterEntityByIndentRaisedAeEmpId(
//         empId: empId ?? this.empId,
//         empAdhaarNumber: empAdhaarNumber ?? this.empAdhaarNumber,
//         epfAcno: epfAcno ?? this.epfAcno,
//         epfUan: epfUan ?? this.epfUan,
//         bankAcno: bankAcno ?? this.bankAcno,
//         pancardNumber: pancardNumber ?? this.pancardNumber,
//         empName: empName ?? this.empName,
//         empFatherName: empFatherName ?? this.empFatherName,
//         dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//         dateOfJoining: dateOfJoining ?? this.dateOfJoining,
//         designation: designation ?? this.designation,
//         cityRuralFlag: cityRuralFlag ?? this.cityRuralFlag,
//         eroCode: eroCode ?? this.eroCode,
//         unitCode: unitCode ?? this.unitCode,
//         divisionCode: divisionCode ?? this.divisionCode,
//         empStatus: empStatus ?? this.empStatus,
//         basic: basic ?? this.basic,
//         payStatus: payStatus ?? this.payStatus,
//         payMonthYear: payMonthYear ?? this.payMonthYear,
//         billCode: billCode ?? this.billCode,
//         earnedLeaves: earnedLeaves ?? this.earnedLeaves,
//         medicalLeaves: medicalLeaves ?? this.medicalLeaves,
//         locationType: locationType ?? this.locationType,
//         locationCode: locationCode ?? this.locationCode,
//         locationName: locationName ?? this.locationName,
//         empType: empType ?? this.empType,
//         changeReturnGroup: changeReturnGroup ?? this.changeReturnGroup,
//         gender: gender ?? this.gender,
//         rps: rps ?? this.rps,
//         bankCode: bankCode ?? this.bankCode,
//         designationCode: designationCode ?? this.designationCode,
//         personalMobileNo: personalMobileNo ?? this.personalMobileNo,
//         ofcMobileNo: ofcMobileNo ?? this.ofcMobileNo,
//         empPassword: empPassword ?? this.empPassword,
//         smartLogin: smartLogin ?? this.smartLogin,
//         sectionCode: sectionCode ?? this.sectionCode,
//         ofcType: ofcType ?? this.ofcType,
//         ofcCode: ofcCode ?? this.ofcCode,
//         wing: wing ?? this.wing,
//         allowEbsAndroidApp: allowEbsAndroidApp ?? this.allowEbsAndroidApp,
//       );
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['empId'] = empId;
//     map['empAdhaarNumber'] = empAdhaarNumber;
//     map['epfAcno'] = epfAcno;
//     map['epfUan'] = epfUan;
//     map['bankAcno'] = bankAcno;
//     map['pancardNumber'] = pancardNumber;
//     map['empName'] = empName;
//     map['empFatherName'] = empFatherName;
//     map['dateOfBirth'] = dateOfBirth;
//     map['dateOfJoining'] = dateOfJoining;
//     map['designation'] = designation;
//     map['cityRuralFlag'] = cityRuralFlag;
//     map['eroCode'] = eroCode;
//     map['unitCode'] = unitCode;
//     map['divisionCode'] = divisionCode;
//     map['empStatus'] = empStatus;
//     map['basic'] = basic;
//     map['payStatus'] = payStatus;
//     map['payMonthYear'] = payMonthYear;
//     map['billCode'] = billCode;
//     map['earnedLeaves'] = earnedLeaves;
//     map['medicalLeaves'] = medicalLeaves;
//     map['locationType'] = locationType;
//     map['locationCode'] = locationCode;
//     map['locationName'] = locationName;
//     map['empType'] = empType;
//     map['changeReturnGroup'] = changeReturnGroup;
//     map['gender'] = gender;
//     map['rps'] = rps;
//     map['bankCode'] = bankCode;
//     map['designationCode'] = designationCode;
//     map['personalMobileNo'] = personalMobileNo;
//     map['ofcMobileNo'] = ofcMobileNo;
//     map['empPassword'] = empPassword;
//     map['smartLogin'] = smartLogin;
//     map['sectionCode'] = sectionCode;
//     map['ofcType'] = ofcType;
//     map['ofcCode'] = ofcCode;
//     map['wing'] = wing;
//     map['allowEbsAndroidApp'] = allowEbsAndroidApp;
//     return map;
//   }
// }
