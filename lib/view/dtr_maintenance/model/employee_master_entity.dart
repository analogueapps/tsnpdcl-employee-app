import 'dart:convert';

EmployeeMasterEntity employeeMasterEntityFromJson(String str) =>
    EmployeeMasterEntity.fromJson(json.decode(str));

String employeeMasterEntityToJson(EmployeeMasterEntity data) =>
    json.encode(data.toJson());

class EmployeeMasterEntity {
  EmployeeMasterEntity({
    this.empId,
    this.empAdhaarNumber,
    this.epfAcno,
    this.epfUan,
    this.gpfAcno,
    this.bankAcno,
    this.pancardNumber,
    this.empName,
    this.empSurname,
    this.empFatherName,
    this.dateOfBirth,
    this.dateOfJoining,
    this.designation,
    this.cityRuralFlag,
    this.incrementRevisionDate,
    this.eroCode,
    this.unitCode,
    this.divisionCode,
    this.userLogId,
    this.empStatus,
    this.basic,
    this.payStatus,
    this.payMonthYear,
    this.billCode,
    this.locationType,
    this.locationCode,
    this.locationName,
    this.empType,
    this.changeReturnGroup,
    this.gender,
    this.qr,
    this.rps,
    this.bankCode,
    this.designationCode,
    this.mobileno,
    this.personalMobileNo,
    this.ofcMobileNo,
    this.empPost,
    this.smartLogin,
    this.sectionCode,
    this.ofcType,
    this.ofcCode,
    this.wing,
    this.pensioncode,
    this.ppono,
    this.familypensionerName,
    this.familypensionerAmount,
    this.pensioncommutedAmount,
    this.pensioncommutedDate,
    this.reducedpensionDate,
    this.dateOfRetirement,
    this.allowEbsAndroidApp,
    this.facDocument,
    this.otp,
    this.otpDate,
    this.rcEro,
    this.rcCode,
    this.rcFlag,
    this.rcMonth,
    this.rcAuthDevice,
    this.rcAuthDeviceDate,
    this.isSsOp,
    this.ssOpSsCode,
  });

  EmployeeMasterEntity.fromJson(dynamic json) {
    empId = json['empId'];
    empAdhaarNumber = json['empAdhaarNumber'];
    epfAcno = json['epfAcno'];
    epfUan = json['epfUan'];
    gpfAcno = json['gpfAcno'];
    bankAcno = json['bankAcno'];
    pancardNumber = json['pancardNumber'];
    empName = json['empName'];
    empSurname = json['empSurname'];
    empFatherName = json['empFatherName'];
    dateOfBirth = json['dateOfBirth'];
    dateOfJoining = json['dateOfJoining'];
    designation = json['designation'];
    cityRuralFlag = json['cityRuralFlag'];
    incrementRevisionDate = json['incrementRevisionDate'];
    eroCode = json['eroCode'];
    unitCode = json['unitCode'];
    divisionCode = json['divisionCode'];
    userLogId = json['userLogId'];
    empStatus = json['empStatus'];
    basic = json['basic'];
    payStatus = json['payStatus'];
    payMonthYear = json['payMonthYear'];
    billCode = json['billCode'];
    locationType = json['locationType'];
    locationCode = json['locationCode'];
    locationName = json['locationName'];
    empType = json['empType'];
    changeReturnGroup = json['changeReturnGroup'];
    gender = json['gender'];
    qr = json['qr'];
    rps = json['rps'];
    bankCode = json['bankCode'];
    designationCode = json['designationCode'];
    mobileno = json['mobileno'];
    personalMobileNo = json['personalMobileNo'];
    ofcMobileNo = json['ofcMobileNo'];
    empPost = json['empPost'];
    smartLogin = json['smartLogin'];
    sectionCode = json['sectionCode'];
    ofcType = json['ofcType'];
    ofcCode = json['ofcCode'];
    wing = json['wing'];
    pensioncode = json['pensioncode'];
    ppono = json['ppono'];
    familypensionerName = json['familypensionerName'];
    familypensionerAmount = json['familypensionerAmount'];
    pensioncommutedAmount = json['pensioncommutedAmount'];
    pensioncommutedDate = json['pensioncommutedDate'];
    reducedpensionDate = json['reducedpensionDate'];
    dateOfRetirement = json['dateOfRetirement'];
    allowEbsAndroidApp = json['allowEbsAndroidApp'];
    facDocument = json['facDocument'];
    otp = json['otp'];
    otpDate = json['otpDate'];
    rcEro = json['rcEro'];
    rcCode = json['rcCode'];
    rcFlag = json['rcFlag'];
    rcMonth = json['rcMonth'];
    rcAuthDevice = json['rcAuthDevice'];
    rcAuthDeviceDate = json['rcAuthDeviceDate'];
    isSsOp = json['isSsOp'];
    ssOpSsCode = json['ssOpSsCode'];
  }

  String? empId;
  dynamic empAdhaarNumber;
  dynamic epfAcno;
  dynamic epfUan;
  String? gpfAcno;
  String? bankAcno;
  String? pancardNumber;
  String? empName;
  dynamic empSurname;
  dynamic empFatherName;
  String? dateOfBirth;
  String? dateOfJoining;
  String? designation;
  String? cityRuralFlag;
  String? incrementRevisionDate;
  String? eroCode;
  String? unitCode;
  String? divisionCode;
  dynamic userLogId;
  String? empStatus;
  num? basic;
  String? payStatus;
  String? payMonthYear;
  String? billCode;
  String? locationType;
  String? locationCode;
  String? locationName;
  String? empType;
  String? changeReturnGroup;
  String? gender;
  dynamic qr;
  num? rps;
  String? bankCode;
  num? designationCode;
  dynamic mobileno;
  String? personalMobileNo;
  String? ofcMobileNo;
  dynamic empPost;
  String? smartLogin;
  String? sectionCode;
  String? ofcType;
  String? ofcCode;
  String? wing;
  dynamic pensioncode;
  dynamic ppono;
  dynamic familypensionerName;
  dynamic familypensionerAmount;
  dynamic pensioncommutedAmount;
  dynamic pensioncommutedDate;
  dynamic reducedpensionDate;
  dynamic dateOfRetirement;
  String? allowEbsAndroidApp;
  dynamic facDocument;
  dynamic otp;
  dynamic otpDate;
  dynamic rcEro;
  dynamic rcCode;
  dynamic rcFlag;
  dynamic rcMonth;
  dynamic rcAuthDevice;
  dynamic rcAuthDeviceDate;
  dynamic isSsOp;
  dynamic ssOpSsCode;

  EmployeeMasterEntity copyWith({
    String? empId,
    dynamic empAdhaarNumber,
    dynamic epfAcno,
    dynamic epfUan,
    String? gpfAcno,
    String? bankAcno,
    String? pancardNumber,
    String? empName,
    dynamic empSurname,
    dynamic empFatherName,
    String? dateOfBirth,
    String? dateOfJoining,
    String? designation,
    String? cityRuralFlag,
    String? incrementRevisionDate,
    String? eroCode,
    String? unitCode,
    String? divisionCode,
    dynamic userLogId,
    String? empStatus,
    num? basic,
    String? payStatus,
    String? payMonthYear,
    String? billCode,
    String? locationType,
    String? locationCode,
    String? locationName,
    String? empType,
    String? changeReturnGroup,
    String? gender,
    dynamic qr,
    num? rps,
    String? bankCode,
    num? designationCode,
    dynamic mobileno,
    String? personalMobileNo,
    String? ofcMobileNo,
    dynamic empPost,
    String? smartLogin,
    String? sectionCode,
    String? ofcType,
    String? ofcCode,
    String? wing,
    dynamic pensioncode,
    dynamic ppono,
    dynamic familypensionerName,
    dynamic familypensionerAmount,
    dynamic pensioncommutedAmount,
    dynamic pensioncommutedDate,
    dynamic reducedpensionDate,
    dynamic dateOfRetirement,
    String? allowEbsAndroidApp,
    dynamic facDocument,
    dynamic otp,
    dynamic otpDate,
    dynamic rcEro,
    dynamic rcCode,
    dynamic rcFlag,
    dynamic rcMonth,
    dynamic rcAuthDevice,
    dynamic rcAuthDeviceDate,
    dynamic isSsOp,
    dynamic ssOpSsCode,
  }) =>
      EmployeeMasterEntity(
        empId: empId ?? this.empId,
        empAdhaarNumber: empAdhaarNumber ?? this.empAdhaarNumber,
        epfAcno: epfAcno ?? this.epfAcno,
        epfUan: epfUan ?? this.epfUan,
        gpfAcno: gpfAcno ?? this.gpfAcno,
        bankAcno: bankAcno ?? this.bankAcno,
        pancardNumber: pancardNumber ?? this.pancardNumber,
        empName: empName ?? this.empName,
        empSurname: empSurname ?? this.empSurname,
        empFatherName: empFatherName ?? this.empFatherName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        dateOfJoining: dateOfJoining ?? this.dateOfJoining,
        designation: designation ?? this.designation,
        cityRuralFlag: cityRuralFlag ?? this.cityRuralFlag,
        incrementRevisionDate:
            incrementRevisionDate ?? this.incrementRevisionDate,
        eroCode: eroCode ?? this.eroCode,
        unitCode: unitCode ?? this.unitCode,
        divisionCode: divisionCode ?? this.divisionCode,
        userLogId: userLogId ?? this.userLogId,
        empStatus: empStatus ?? this.empStatus,
        basic: basic ?? this.basic,
        payStatus: payStatus ?? this.payStatus,
        payMonthYear: payMonthYear ?? this.payMonthYear,
        billCode: billCode ?? this.billCode,
        locationType: locationType ?? this.locationType,
        locationCode: locationCode ?? this.locationCode,
        locationName: locationName ?? this.locationName,
        empType: empType ?? this.empType,
        changeReturnGroup: changeReturnGroup ?? this.changeReturnGroup,
        gender: gender ?? this.gender,
        qr: qr ?? this.qr,
        rps: rps ?? this.rps,
        bankCode: bankCode ?? this.bankCode,
        designationCode: designationCode ?? this.designationCode,
        mobileno: mobileno ?? this.mobileno,
        personalMobileNo: personalMobileNo ?? this.personalMobileNo,
        ofcMobileNo: ofcMobileNo ?? this.ofcMobileNo,
        empPost: empPost ?? this.empPost,
        smartLogin: smartLogin ?? this.smartLogin,
        sectionCode: sectionCode ?? this.sectionCode,
        ofcType: ofcType ?? this.ofcType,
        ofcCode: ofcCode ?? this.ofcCode,
        wing: wing ?? this.wing,
        pensioncode: pensioncode ?? this.pensioncode,
        ppono: ppono ?? this.ppono,
        familypensionerName: familypensionerName ?? this.familypensionerName,
        familypensionerAmount:
            familypensionerAmount ?? this.familypensionerAmount,
        pensioncommutedAmount:
            pensioncommutedAmount ?? this.pensioncommutedAmount,
        pensioncommutedDate: pensioncommutedDate ?? this.pensioncommutedDate,
        reducedpensionDate: reducedpensionDate ?? this.reducedpensionDate,
        dateOfRetirement: dateOfRetirement ?? this.dateOfRetirement,
        allowEbsAndroidApp: allowEbsAndroidApp ?? this.allowEbsAndroidApp,
        facDocument: facDocument ?? this.facDocument,
        otp: otp ?? this.otp,
        otpDate: otpDate ?? this.otpDate,
        rcEro: rcEro ?? this.rcEro,
        rcCode: rcCode ?? this.rcCode,
        rcFlag: rcFlag ?? this.rcFlag,
        rcMonth: rcMonth ?? this.rcMonth,
        rcAuthDevice: rcAuthDevice ?? this.rcAuthDevice,
        rcAuthDeviceDate: rcAuthDeviceDate ?? this.rcAuthDeviceDate,
        isSsOp: isSsOp ?? this.isSsOp,
        ssOpSsCode: ssOpSsCode ?? this.ssOpSsCode,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['empId'] = empId;
    map['empAdhaarNumber'] = empAdhaarNumber;
    map['epfAcno'] = epfAcno;
    map['epfUan'] = epfUan;
    map['gpfAcno'] = gpfAcno;
    map['bankAcno'] = bankAcno;
    map['pancardNumber'] = pancardNumber;
    map['empName'] = empName;
    map['empSurname'] = empSurname;
    map['empFatherName'] = empFatherName;
    map['dateOfBirth'] = dateOfBirth;
    map['dateOfJoining'] = dateOfJoining;
    map['designation'] = designation;
    map['cityRuralFlag'] = cityRuralFlag;
    map['incrementRevisionDate'] = incrementRevisionDate;
    map['eroCode'] = eroCode;
    map['unitCode'] = unitCode;
    map['divisionCode'] = divisionCode;
    map['userLogId'] = userLogId;
    map['empStatus'] = empStatus;
    map['basic'] = basic;
    map['payStatus'] = payStatus;
    map['payMonthYear'] = payMonthYear;
    map['billCode'] = billCode;
    map['locationType'] = locationType;
    map['locationCode'] = locationCode;
    map['locationName'] = locationName;
    map['empType'] = empType;
    map['changeReturnGroup'] = changeReturnGroup;
    map['gender'] = gender;
    map['qr'] = qr;
    map['rps'] = rps;
    map['bankCode'] = bankCode;
    map['designationCode'] = designationCode;
    map['mobileno'] = mobileno;
    map['personalMobileNo'] = personalMobileNo;
    map['ofcMobileNo'] = ofcMobileNo;
    map['empPost'] = empPost;
    map['smartLogin'] = smartLogin;
    map['sectionCode'] = sectionCode;
    map['ofcType'] = ofcType;
    map['ofcCode'] = ofcCode;
    map['wing'] = wing;
    map['pensioncode'] = pensioncode;
    map['ppono'] = ppono;
    map['familypensionerName'] = familypensionerName;
    map['familypensionerAmount'] = familypensionerAmount;
    map['pensioncommutedAmount'] = pensioncommutedAmount;
    map['pensioncommutedDate'] = pensioncommutedDate;
    map['reducedpensionDate'] = reducedpensionDate;
    map['dateOfRetirement'] = dateOfRetirement;
    map['allowEbsAndroidApp'] = allowEbsAndroidApp;
    map['facDocument'] = facDocument;
    map['otp'] = otp;
    map['otpDate'] = otpDate;
    map['rcEro'] = rcEro;
    map['rcCode'] = rcCode;
    map['rcFlag'] = rcFlag;
    map['rcMonth'] = rcMonth;
    map['rcAuthDevice'] = rcAuthDevice;
    map['rcAuthDeviceDate'] = rcAuthDeviceDate;
    map['isSsOp'] = isSsOp;
    map['ssOpSsCode'] = ssOpSsCode;
    return map;
  }
}
