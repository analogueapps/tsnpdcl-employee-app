import 'dart:convert';

PoleDumpedLocationEntity poleDumpedLocationEntityFromJson(String str) =>
    PoleDumpedLocationEntity.fromJson(json.decode(str));

String poleDumpedLocationEntityToJson(PoleDumpedLocationEntity data) =>
    json.encode(data.toJson());

class PoleDumpedLocationEntity {
  PoleDumpedLocationEntity({
    this.dumpId,
    this.dumpedQty,
    this.transportId,
    this.dumpDate,
    this.dispatchInstructionId,
    this.physicalVerifiedQuantity,
    this.dumpedLat,
    this.dumpedLon,
    this.verifiedLat,
    this.verifiedLon,
    this.verifiedDate,
    this.verifiedEmpId,
    this.dumpedImageUrl,
    this.verifiedImageUrl,
    this.status,
    this.remarks,
    this.employeeMasterEntityByVerifiedEmpId,
  });

  PoleDumpedLocationEntity.fromJson(dynamic json) {
    dumpId = json['dumpId'];
    dumpedQty = json['dumpedQty'];
    transportId = json['transportId'];
    dumpDate = json['dumpDate'];
    dispatchInstructionId = json['dispatchInstructionId'];
    physicalVerifiedQuantity = json['physicalVerifiedQuantity'];
    dumpedLat = json['dumpedLat'];
    dumpedLon = json['dumpedLon'];
    verifiedLat = json['verifiedLat'];
    verifiedLon = json['verifiedLon'];
    verifiedDate = json['verifiedDate'];
    verifiedEmpId = json['verifiedEmpId'];
    dumpedImageUrl = json['dumpedImageUrl'];
    verifiedImageUrl = json['verifiedImageUrl'];
    status = json['status'];
    remarks = json['remarks'];
    employeeMasterEntityByVerifiedEmpId =
        json['employeeMasterEntityByVerifiedEmpId'] != null
            ? EmployeeMasterEntityByVerifiedEmpId.fromJson(
                json['employeeMasterEntityByVerifiedEmpId'])
            : null;
  }

  num? dumpId;
  num? dumpedQty;
  num? transportId;
  String? dumpDate;
  num? dispatchInstructionId;
  num? physicalVerifiedQuantity;
  num? dumpedLat;
  num? dumpedLon;
  num? verifiedLat;
  num? verifiedLon;
  String? verifiedDate;
  String? verifiedEmpId;
  String? dumpedImageUrl;
  String? verifiedImageUrl;
  String? status;
  String? remarks;
  EmployeeMasterEntityByVerifiedEmpId? employeeMasterEntityByVerifiedEmpId;

  PoleDumpedLocationEntity copyWith({
    num? dumpId,
    num? dumpedQty,
    num? transportId,
    String? dumpDate,
    num? dispatchInstructionId,
    num? physicalVerifiedQuantity,
    num? dumpedLat,
    num? dumpedLon,
    num? verifiedLat,
    num? verifiedLon,
    String? verifiedDate,
    String? verifiedEmpId,
    String? dumpedImageUrl,
    String? verifiedImageUrl,
    String? status,
    String? remarks,
    EmployeeMasterEntityByVerifiedEmpId? employeeMasterEntityByVerifiedEmpId,
  }) =>
      PoleDumpedLocationEntity(
        dumpId: dumpId ?? this.dumpId,
        dumpedQty: dumpedQty ?? this.dumpedQty,
        transportId: transportId ?? this.transportId,
        dumpDate: dumpDate ?? this.dumpDate,
        dispatchInstructionId:
            dispatchInstructionId ?? this.dispatchInstructionId,
        physicalVerifiedQuantity:
            physicalVerifiedQuantity ?? this.physicalVerifiedQuantity,
        dumpedLat: dumpedLat ?? this.dumpedLat,
        dumpedLon: dumpedLon ?? this.dumpedLon,
        verifiedLat: verifiedLat ?? this.verifiedLat,
        verifiedLon: verifiedLon ?? this.verifiedLon,
        verifiedDate: verifiedDate ?? this.verifiedDate,
        verifiedEmpId: verifiedEmpId ?? this.verifiedEmpId,
        dumpedImageUrl: dumpedImageUrl ?? this.dumpedImageUrl,
        verifiedImageUrl: verifiedImageUrl ?? this.verifiedImageUrl,
        status: status ?? this.status,
        remarks: remarks ?? this.remarks,
        employeeMasterEntityByVerifiedEmpId:
            employeeMasterEntityByVerifiedEmpId ??
                this.employeeMasterEntityByVerifiedEmpId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dumpId'] = dumpId;
    map['dumpedQty'] = dumpedQty;
    map['transportId'] = transportId;
    map['dumpDate'] = dumpDate;
    map['dispatchInstructionId'] = dispatchInstructionId;
    map['physicalVerifiedQuantity'] = physicalVerifiedQuantity;
    map['dumpedLat'] = dumpedLat;
    map['dumpedLon'] = dumpedLon;
    map['verifiedLat'] = verifiedLat;
    map['verifiedLon'] = verifiedLon;
    map['verifiedDate'] = verifiedDate;
    map['verifiedEmpId'] = verifiedEmpId;
    map['dumpedImageUrl'] = dumpedImageUrl;
    map['verifiedImageUrl'] = verifiedImageUrl;
    map['status'] = status;
    map['remarks'] = remarks;
    if (employeeMasterEntityByVerifiedEmpId != null) {
      map['employeeMasterEntityByVerifiedEmpId'] =
          employeeMasterEntityByVerifiedEmpId?.toJson();
    }
    return map;
  }
}

EmployeeMasterEntityByVerifiedEmpId employeeMasterEntityByVerifiedEmpIdFromJson(
        String str) =>
    EmployeeMasterEntityByVerifiedEmpId.fromJson(json.decode(str));

String employeeMasterEntityByVerifiedEmpIdToJson(
        EmployeeMasterEntityByVerifiedEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByVerifiedEmpId {
  EmployeeMasterEntityByVerifiedEmpId({
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

  EmployeeMasterEntityByVerifiedEmpId.fromJson(dynamic json) {
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

  EmployeeMasterEntityByVerifiedEmpId copyWith({
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
      EmployeeMasterEntityByVerifiedEmpId(
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
