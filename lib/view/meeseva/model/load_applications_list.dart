import 'dart:convert';

LoadApplicationsList loadApplicationsListFromJson(String str) =>
    LoadApplicationsList.fromJson(json.decode(str));

String loadApplicationsListToJson(LoadApplicationsList data) =>
    json.encode(data.toJson());

class LoadApplicationsList {
  LoadApplicationsList({
    this.aadhaar,
    this.applicationCharges,
    this.city,
    this.consumerName,
    this.contractedLoad,
    this.developmentCharges,
    this.district,
    this.doorNumber,
    this.dtrno,
    this.fAllotAeEmp,
    this.fAllotDate,
    this.fAllotLmEmp,
    this.aAllotLmEmp,
    this.fBy,
    this.fDate,
    this.fEmpId,
    this.fFlag,
    this.fatherName,
    this.feederCode,
    this.insDate,
    this.opDate,
    this.phoneNumber,
    this.poleno,
    this.purposeOfSupply,
    this.regId,
    this.regUser,
    this.photoUrl,
    this.registrationDate,
    this.registrationDateAsLong,
    this.registrationNumber,
    this.scheme,
    this.sectionId,
    this.securityDeposit,
    this.serviceCharges,
    this.serviceType,
    this.socialGroup,
    this.socialGroupOther,
    this.status,
    this.surName,
    this.totalAmount,
    this.town,
    this.userCharges,
    this.village,
  });

  LoadApplicationsList.fromJson(dynamic json) {
    aadhaar = json['aadhaar'];
    applicationCharges = json['applicationCharges'];
    city = json['city'];
    consumerName = json['consumerName'];
    contractedLoad = json['contractedLoad'];
    developmentCharges = json['developmentCharges'];
    district = json['district'];
    doorNumber = json['doorNumber'];
    dtrno = json['dtrno'];
    fAllotAeEmp = json['fAllotAeEmp'] != null
        ? FAllotAeEmp.fromJson(json['fAllotAeEmp'])
        : null;
    fAllotDate = json['fAllotDate'] != null
        ? FAllotDate.fromJson(json['fAllotDate'])
        : null;
    fAllotLmEmp = json['fAllotLmEmp'] != null
        ? FAllotLmEmp.fromJson(json['fAllotLmEmp'])
        : null;
    aAllotLmEmp = json['aAllotLmEmp'] != null
        ? FAllotLmEmp.fromJson(json['aAllotLmEmp'])
        : null;
    fBy = json['fBy'];
    fDate = json['fDate'] != null ? FDate.fromJson(json['fDate']) : null;
    fEmpId = json['fEmpId'] != null ? FEmpId.fromJson(json['fEmpId']) : null;
    fFlag = json['fFlag'];
    fatherName = json['fatherName'];
    feederCode = json['feederCode'];
    insDate =
        json['insDate'] != null ? InsDate.fromJson(json['insDate']) : null;
    opDate = json['opDate'] != null ? OpDate.fromJson(json['opDate']) : null;
    phoneNumber = json['phoneNumber'];
    poleno = json['poleno'];
    purposeOfSupply = json['purposeOfSupply'];
    regId = json['regId'];
    regUser = json['regUser'];
    photoUrl = json['photoUrl'];
    registrationDate = json['registrationDate'] != null
        ? RegistrationDate.fromJson(json['registrationDate'])
        : null;
    registrationDateAsLong = json['registrationDateAsLong'];
    registrationNumber = json['registrationNumber'];
    scheme = json['scheme'];
    sectionId = json['sectionId'];
    securityDeposit = json['securityDeposit'];
    serviceCharges = json['serviceCharges'];
    serviceType = json['serviceType'];
    socialGroup = json['socialGroup'];
    socialGroupOther = json['socialGroupOther'];
    status = json['status'];
    surName = json['surName'];
    totalAmount = json['totalAmount'];
    town = json['town'];
    userCharges = json['userCharges'];
    village = json['village'];
  }

  String? aadhaar;
  num? applicationCharges;
  String? city;
  String? consumerName;
  String? contractedLoad;
  num? developmentCharges;
  String? district;
  String? doorNumber;
  String? dtrno;
  FAllotAeEmp? fAllotAeEmp;
  FAllotDate? fAllotDate;
  FAllotLmEmp? fAllotLmEmp;
  FAllotLmEmp? aAllotLmEmp;
  String? fBy;
  FDate? fDate;
  FEmpId? fEmpId;
  String? fFlag;
  String? fatherName;
  String? feederCode;
  InsDate? insDate;
  OpDate? opDate;
  String? phoneNumber;
  String? poleno;
  String? purposeOfSupply;
  num? regId;
  String? regUser;
  String? photoUrl;
  RegistrationDate? registrationDate;
  dynamic? registrationDateAsLong;
  String? registrationNumber;
  String? scheme;
  String? sectionId;
  num? securityDeposit;
  num? serviceCharges;
  String? serviceType;
  String? socialGroup;
  String? socialGroupOther;
  String? status;
  String? surName;
  num? totalAmount;
  String? town;
  num? userCharges;
  String? village;

  LoadApplicationsList copyWith({
    String? aadhaar,
    num? applicationCharges,
    String? city,
    String? consumerName,
    String? contractedLoad,
    num? developmentCharges,
    String? district,
    String? doorNumber,
    String? dtrno,
    FAllotAeEmp? fAllotAeEmp,
    FAllotDate? fAllotDate,
    FAllotLmEmp? fAllotLmEmp,
    FAllotLmEmp? aAllotLmEmp,
    String? fBy,
    FDate? fDate,
    FEmpId? fEmpId,
    String? fFlag,
    String? fatherName,
    String? feederCode,
    InsDate? insDate,
    OpDate? opDate,
    String? phoneNumber,
    String? poleno,
    String? purposeOfSupply,
    num? regId,
    String? regUser,
    String? photoUrl,
    RegistrationDate? registrationDate,
    dynamic? registrationDateAsLong,
    String? registrationNumber,
    String? scheme,
    String? sectionId,
    num? securityDeposit,
    num? serviceCharges,
    String? serviceType,
    String? socialGroup,
    String? socialGroupOther,
    String? status,
    String? surName,
    num? totalAmount,
    String? town,
    num? userCharges,
    String? village,
  }) =>
      LoadApplicationsList(
        aadhaar: aadhaar ?? this.aadhaar,
        applicationCharges: applicationCharges ?? this.applicationCharges,
        city: city ?? this.city,
        consumerName: consumerName ?? this.consumerName,
        contractedLoad: contractedLoad ?? this.contractedLoad,
        developmentCharges: developmentCharges ?? this.developmentCharges,
        district: district ?? this.district,
        doorNumber: doorNumber ?? this.doorNumber,
        dtrno: dtrno ?? this.dtrno,
        fAllotAeEmp: fAllotAeEmp ?? this.fAllotAeEmp,
        fAllotDate: fAllotDate ?? this.fAllotDate,
        fAllotLmEmp: fAllotLmEmp ?? this.fAllotLmEmp,
        aAllotLmEmp: aAllotLmEmp ?? this.aAllotLmEmp,
        fBy: fBy ?? this.fBy,
        fDate: fDate ?? this.fDate,
        fEmpId: fEmpId ?? this.fEmpId,
        fFlag: fFlag ?? this.fFlag,
        fatherName: fatherName ?? this.fatherName,
        feederCode: feederCode ?? this.feederCode,
        insDate: insDate ?? this.insDate,
        opDate: opDate ?? this.opDate,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        poleno: poleno ?? this.poleno,
        purposeOfSupply: purposeOfSupply ?? this.purposeOfSupply,
        regId: regId ?? this.regId,
        regUser: regUser ?? this.regUser,
        photoUrl: photoUrl ?? this.photoUrl,
        registrationDate: registrationDate ?? this.registrationDate,
        registrationDateAsLong:
            registrationDateAsLong ?? this.registrationDateAsLong,
        registrationNumber: registrationNumber ?? this.registrationNumber,
        scheme: scheme ?? this.scheme,
        sectionId: sectionId ?? this.sectionId,
        securityDeposit: securityDeposit ?? this.securityDeposit,
        serviceCharges: serviceCharges ?? this.serviceCharges,
        serviceType: serviceType ?? this.serviceType,
        socialGroup: socialGroup ?? this.socialGroup,
        socialGroupOther: socialGroupOther ?? this.socialGroupOther,
        status: status ?? this.status,
        surName: surName ?? this.surName,
        totalAmount: totalAmount ?? this.totalAmount,
        town: town ?? this.town,
        userCharges: userCharges ?? this.userCharges,
        village: village ?? this.village,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aadhaar'] = aadhaar;
    map['applicationCharges'] = applicationCharges;
    map['city'] = city;
    map['consumerName'] = consumerName;
    map['contractedLoad'] = contractedLoad;
    map['developmentCharges'] = developmentCharges;
    map['district'] = district;
    map['doorNumber'] = doorNumber;
    map['dtrno'] = dtrno;
    if (fAllotAeEmp != null) {
      map['fAllotAeEmp'] = fAllotAeEmp?.toJson();
    }
    if (fAllotDate != null) {
      map['fAllotDate'] = fAllotDate?.toJson();
    }
    if (fAllotLmEmp != null) {
      map['fAllotLmEmp'] = fAllotLmEmp?.toJson();
    }
    if (aAllotLmEmp != null) {
      map['aAllotLmEmp'] = aAllotLmEmp?.toJson();
    }
    map['fBy'] = fBy;
    if (fDate != null) {
      map['fDate'] = fDate?.toJson();
    }
    if (fEmpId != null) {
      map['fEmpId'] = fEmpId?.toJson();
    }
    map['fFlag'] = fFlag;
    map['fatherName'] = fatherName;
    map['feederCode'] = feederCode;
    if (insDate != null) {
      map['insDate'] = insDate?.toJson();
    }
    if (opDate != null) {
      map['opDate'] = opDate?.toJson();
    }
    map['phoneNumber'] = phoneNumber;
    map['poleno'] = poleno;
    map['purposeOfSupply'] = purposeOfSupply;
    map['regId'] = regId;
    map['regUser'] = regUser;
    map['photoUrl'] = photoUrl;
    if (registrationDate != null) {
      map['registrationDate'] = registrationDate?.toJson();
    }
    map['registrationDateAsLong'] = registrationDateAsLong;
    map['registrationNumber'] = registrationNumber;
    map['scheme'] = scheme;
    map['sectionId'] = sectionId;
    map['securityDeposit'] = securityDeposit;
    map['serviceCharges'] = serviceCharges;
    map['serviceType'] = serviceType;
    map['socialGroup'] = socialGroup;
    map['socialGroupOther'] = socialGroupOther;
    map['status'] = status;
    map['surName'] = surName;
    map['totalAmount'] = totalAmount;
    map['town'] = town;
    map['userCharges'] = userCharges;
    map['village'] = village;
    return map;
  }
}

RegistrationDate registrationDateFromJson(String str) =>
    RegistrationDate.fromJson(json.decode(str));

String registrationDateToJson(RegistrationDate data) =>
    json.encode(data.toJson());

class RegistrationDate {
  RegistrationDate({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.timezone,
  });

  RegistrationDate.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
    millisecond = json['millisecond'];
    timezone = json['timezone'];
  }

  num? year;
  num? month;
  num? day;
  num? hour;
  num? minute;
  num? second;
  num? millisecond;
  num? timezone;

  RegistrationDate copyWith({
    num? year,
    num? month,
    num? day,
    num? hour,
    num? minute,
    num? second,
    num? millisecond,
    num? timezone,
  }) =>
      RegistrationDate(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        millisecond: millisecond ?? this.millisecond,
        timezone: timezone ?? this.timezone,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['day'] = day;
    map['hour'] = hour;
    map['minute'] = minute;
    map['second'] = second;
    map['millisecond'] = millisecond;
    map['timezone'] = timezone;
    return map;
  }
}

OpDate opDateFromJson(String str) => OpDate.fromJson(json.decode(str));

String opDateToJson(OpDate data) => json.encode(data.toJson());

class OpDate {
  OpDate({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.timezone,
  });

  OpDate.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
    millisecond = json['millisecond'];
    timezone = json['timezone'];
  }

  num? year;
  num? month;
  num? day;
  num? hour;
  num? minute;
  num? second;
  num? millisecond;
  num? timezone;

  OpDate copyWith({
    num? year,
    num? month,
    num? day,
    num? hour,
    num? minute,
    num? second,
    num? millisecond,
    num? timezone,
  }) =>
      OpDate(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        millisecond: millisecond ?? this.millisecond,
        timezone: timezone ?? this.timezone,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['day'] = day;
    map['hour'] = hour;
    map['minute'] = minute;
    map['second'] = second;
    map['millisecond'] = millisecond;
    map['timezone'] = timezone;
    return map;
  }
}

InsDate insDateFromJson(String str) => InsDate.fromJson(json.decode(str));

String insDateToJson(InsDate data) => json.encode(data.toJson());

class InsDate {
  InsDate({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.timezone,
  });

  InsDate.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
    millisecond = json['millisecond'];
    timezone = json['timezone'];
  }

  num? year;
  num? month;
  num? day;
  num? hour;
  num? minute;
  num? second;
  num? millisecond;
  num? timezone;

  InsDate copyWith({
    num? year,
    num? month,
    num? day,
    num? hour,
    num? minute,
    num? second,
    num? millisecond,
    num? timezone,
  }) =>
      InsDate(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        millisecond: millisecond ?? this.millisecond,
        timezone: timezone ?? this.timezone,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['day'] = day;
    map['hour'] = hour;
    map['minute'] = minute;
    map['second'] = second;
    map['millisecond'] = millisecond;
    map['timezone'] = timezone;
    return map;
  }
}

FEmpId fEmpIdFromJson(String str) => FEmpId.fromJson(json.decode(str));

String fEmpIdToJson(FEmpId data) => json.encode(data.toJson());

class FEmpId {
  FEmpId({
    this.bankAcno,
    this.bankCode,
    this.basic,
    this.billCode,
    this.changeReturnGroup,
    this.cityRuralFlag,
    this.dateOfBirth,
    this.dateOfJoining,
    this.designation,
    this.designationCode,
    this.divisionCode,
    this.earnedLeaves,
    this.empAdhaarNumber,
    this.empFatherName,
    this.empId,
    this.empName,
    this.empPassword,
    this.empStatus,
    this.empSurname,
    this.empType,
    this.epfAcno,
    this.epfUan,
    this.eroCode,
    this.gender,
    this.locationCode,
    this.locationName,
    this.locationType,
    this.medicalLeaves,
    this.ofcCode,
    this.ofcMobileNo,
    this.ofcType,
    this.pancardNumber,
    this.payMonthYear,
    this.payStatus,
    this.personalMobileNo,
    this.rps,
    this.sectionCode,
    this.smartLogin,
    this.unitCode,
    this.wing,
  });

  FEmpId.fromJson(dynamic json) {
    bankAcno = json['bankAcno'];
    bankCode = json['bankCode'];
    basic = json['basic'];
    billCode = json['billCode'];
    changeReturnGroup = json['changeReturnGroup'];
    cityRuralFlag = json['cityRuralFlag'];
    dateOfBirth = json['dateOfBirth'] != null
        ? DateOfBirth.fromJson(json['dateOfBirth'])
        : null;
    dateOfJoining = json['dateOfJoining'] != null
        ? DateOfJoining.fromJson(json['dateOfJoining'])
        : null;
    designation = json['designation'];
    designationCode = json['designationCode'];
    divisionCode = json['divisionCode'];
    earnedLeaves = json['earnedLeaves'];
    empAdhaarNumber = json['empAdhaarNumber'];
    empFatherName = json['empFatherName'];
    empId = json['empId'];
    empName = json['empName'];
    empPassword = json['empPassword'];
    empStatus = json['empStatus'];
    empSurname = json['empSurname'];
    empType = json['empType'];
    epfAcno = json['epfAcno'];
    epfUan = json['epfUan'];
    eroCode = json['eroCode'];
    gender = json['gender'];
    locationCode = json['locationCode'];
    locationName = json['locationName'];
    locationType = json['locationType'];
    medicalLeaves = json['medicalLeaves'];
    ofcCode = json['ofcCode'];
    ofcMobileNo = json['ofcMobileNo'];
    ofcType = json['ofcType'];
    pancardNumber = json['pancardNumber'];
    payMonthYear = json['payMonthYear'];
    payStatus = json['payStatus'];
    personalMobileNo = json['personalMobileNo'];
    rps = json['rps'];
    sectionCode = json['sectionCode'];
    smartLogin = json['smartLogin'];
    unitCode = json['unitCode'];
    wing = json['wing'];
  }

  String? bankAcno;
  String? bankCode;
  num? basic;
  String? billCode;
  String? changeReturnGroup;
  String? cityRuralFlag;
  DateOfBirth? dateOfBirth;
  DateOfJoining? dateOfJoining;
  String? designation;
  num? designationCode;
  String? divisionCode;
  num? earnedLeaves;
  String? empAdhaarNumber;
  String? empFatherName;
  String? empId;
  String? empName;
  String? empPassword;
  String? empStatus;
  String? empSurname;
  String? empType;
  String? epfAcno;
  String? epfUan;
  String? eroCode;
  String? gender;
  String? locationCode;
  String? locationName;
  String? locationType;
  num? medicalLeaves;
  String? ofcCode;
  String? ofcMobileNo;
  String? ofcType;
  String? pancardNumber;
  String? payMonthYear;
  String? payStatus;
  String? personalMobileNo;
  num? rps;
  String? sectionCode;
  String? smartLogin;
  String? unitCode;
  String? wing;

  FEmpId copyWith({
    String? bankAcno,
    String? bankCode,
    num? basic,
    String? billCode,
    String? changeReturnGroup,
    String? cityRuralFlag,
    DateOfBirth? dateOfBirth,
    DateOfJoining? dateOfJoining,
    String? designation,
    num? designationCode,
    String? divisionCode,
    num? earnedLeaves,
    String? empAdhaarNumber,
    String? empFatherName,
    String? empId,
    String? empName,
    String? empPassword,
    String? empStatus,
    String? empSurname,
    String? empType,
    String? epfAcno,
    String? epfUan,
    String? eroCode,
    String? gender,
    String? locationCode,
    String? locationName,
    String? locationType,
    num? medicalLeaves,
    String? ofcCode,
    String? ofcMobileNo,
    String? ofcType,
    String? pancardNumber,
    String? payMonthYear,
    String? payStatus,
    String? personalMobileNo,
    num? rps,
    String? sectionCode,
    String? smartLogin,
    String? unitCode,
    String? wing,
  }) =>
      FEmpId(
        bankAcno: bankAcno ?? this.bankAcno,
        bankCode: bankCode ?? this.bankCode,
        basic: basic ?? this.basic,
        billCode: billCode ?? this.billCode,
        changeReturnGroup: changeReturnGroup ?? this.changeReturnGroup,
        cityRuralFlag: cityRuralFlag ?? this.cityRuralFlag,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        dateOfJoining: dateOfJoining ?? this.dateOfJoining,
        designation: designation ?? this.designation,
        designationCode: designationCode ?? this.designationCode,
        divisionCode: divisionCode ?? this.divisionCode,
        earnedLeaves: earnedLeaves ?? this.earnedLeaves,
        empAdhaarNumber: empAdhaarNumber ?? this.empAdhaarNumber,
        empFatherName: empFatherName ?? this.empFatherName,
        empId: empId ?? this.empId,
        empName: empName ?? this.empName,
        empPassword: empPassword ?? this.empPassword,
        empStatus: empStatus ?? this.empStatus,
        empSurname: empSurname ?? this.empSurname,
        empType: empType ?? this.empType,
        epfAcno: epfAcno ?? this.epfAcno,
        epfUan: epfUan ?? this.epfUan,
        eroCode: eroCode ?? this.eroCode,
        gender: gender ?? this.gender,
        locationCode: locationCode ?? this.locationCode,
        locationName: locationName ?? this.locationName,
        locationType: locationType ?? this.locationType,
        medicalLeaves: medicalLeaves ?? this.medicalLeaves,
        ofcCode: ofcCode ?? this.ofcCode,
        ofcMobileNo: ofcMobileNo ?? this.ofcMobileNo,
        ofcType: ofcType ?? this.ofcType,
        pancardNumber: pancardNumber ?? this.pancardNumber,
        payMonthYear: payMonthYear ?? this.payMonthYear,
        payStatus: payStatus ?? this.payStatus,
        personalMobileNo: personalMobileNo ?? this.personalMobileNo,
        rps: rps ?? this.rps,
        sectionCode: sectionCode ?? this.sectionCode,
        smartLogin: smartLogin ?? this.smartLogin,
        unitCode: unitCode ?? this.unitCode,
        wing: wing ?? this.wing,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bankAcno'] = bankAcno;
    map['bankCode'] = bankCode;
    map['basic'] = basic;
    map['billCode'] = billCode;
    map['changeReturnGroup'] = changeReturnGroup;
    map['cityRuralFlag'] = cityRuralFlag;
    if (dateOfBirth != null) {
      map['dateOfBirth'] = dateOfBirth?.toJson();
    }
    if (dateOfJoining != null) {
      map['dateOfJoining'] = dateOfJoining?.toJson();
    }
    map['designation'] = designation;
    map['designationCode'] = designationCode;
    map['divisionCode'] = divisionCode;
    map['earnedLeaves'] = earnedLeaves;
    map['empAdhaarNumber'] = empAdhaarNumber;
    map['empFatherName'] = empFatherName;
    map['empId'] = empId;
    map['empName'] = empName;
    map['empPassword'] = empPassword;
    map['empStatus'] = empStatus;
    map['empSurname'] = empSurname;
    map['empType'] = empType;
    map['epfAcno'] = epfAcno;
    map['epfUan'] = epfUan;
    map['eroCode'] = eroCode;
    map['gender'] = gender;
    map['locationCode'] = locationCode;
    map['locationName'] = locationName;
    map['locationType'] = locationType;
    map['medicalLeaves'] = medicalLeaves;
    map['ofcCode'] = ofcCode;
    map['ofcMobileNo'] = ofcMobileNo;
    map['ofcType'] = ofcType;
    map['pancardNumber'] = pancardNumber;
    map['payMonthYear'] = payMonthYear;
    map['payStatus'] = payStatus;
    map['personalMobileNo'] = personalMobileNo;
    map['rps'] = rps;
    map['sectionCode'] = sectionCode;
    map['smartLogin'] = smartLogin;
    map['unitCode'] = unitCode;
    map['wing'] = wing;
    return map;
  }
}

DateOfJoining dateOfJoiningFromJson(String str) =>
    DateOfJoining.fromJson(json.decode(str));

String dateOfJoiningToJson(DateOfJoining data) => json.encode(data.toJson());

class DateOfJoining {
  DateOfJoining({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.timezone,
  });

  DateOfJoining.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
    millisecond = json['millisecond'];
    timezone = json['timezone'];
  }

  num? year;
  num? month;
  num? day;
  num? hour;
  num? minute;
  num? second;
  num? millisecond;
  num? timezone;

  DateOfJoining copyWith({
    num? year,
    num? month,
    num? day,
    num? hour,
    num? minute,
    num? second,
    num? millisecond,
    num? timezone,
  }) =>
      DateOfJoining(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        millisecond: millisecond ?? this.millisecond,
        timezone: timezone ?? this.timezone,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['day'] = day;
    map['hour'] = hour;
    map['minute'] = minute;
    map['second'] = second;
    map['millisecond'] = millisecond;
    map['timezone'] = timezone;
    return map;
  }
}

DateOfBirth dateOfBirthFromJson(String str) =>
    DateOfBirth.fromJson(json.decode(str));

String dateOfBirthToJson(DateOfBirth data) => json.encode(data.toJson());

class DateOfBirth {
  DateOfBirth({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.timezone,
  });

  DateOfBirth.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
    millisecond = json['millisecond'];
    timezone = json['timezone'];
  }

  num? year;
  num? month;
  num? day;
  num? hour;
  num? minute;
  num? second;
  num? millisecond;
  num? timezone;

  DateOfBirth copyWith({
    num? year,
    num? month,
    num? day,
    num? hour,
    num? minute,
    num? second,
    num? millisecond,
    num? timezone,
  }) =>
      DateOfBirth(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        millisecond: millisecond ?? this.millisecond,
        timezone: timezone ?? this.timezone,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['day'] = day;
    map['hour'] = hour;
    map['minute'] = minute;
    map['second'] = second;
    map['millisecond'] = millisecond;
    map['timezone'] = timezone;
    return map;
  }
}

FDate fDateFromJson(String str) => FDate.fromJson(json.decode(str));

String fDateToJson(FDate data) => json.encode(data.toJson());

class FDate {
  FDate({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.timezone,
  });

  FDate.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
    millisecond = json['millisecond'];
    timezone = json['timezone'];
  }

  num? year;
  num? month;
  num? day;
  num? hour;
  num? minute;
  num? second;
  num? millisecond;
  num? timezone;

  FDate copyWith({
    num? year,
    num? month,
    num? day,
    num? hour,
    num? minute,
    num? second,
    num? millisecond,
    num? timezone,
  }) =>
      FDate(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        millisecond: millisecond ?? this.millisecond,
        timezone: timezone ?? this.timezone,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['day'] = day;
    map['hour'] = hour;
    map['minute'] = minute;
    map['second'] = second;
    map['millisecond'] = millisecond;
    map['timezone'] = timezone;
    return map;
  }
}

FAllotLmEmp fAllotLmEmpFromJson(String str) =>
    FAllotLmEmp.fromJson(json.decode(str));

String fAllotLmEmpToJson(FAllotLmEmp data) => json.encode(data.toJson());

class FAllotLmEmp {
  FAllotLmEmp({
    this.bankAcno,
    this.bankCode,
    this.basic,
    this.billCode,
    this.changeReturnGroup,
    this.cityRuralFlag,
    this.dateOfBirth,
    this.dateOfJoining,
    this.designation,
    this.designationCode,
    this.divisionCode,
    this.earnedLeaves,
    this.empId,
    this.empName,
    this.empPassword,
    this.empStatus,
    this.empType,
    this.epfAcno,
    this.epfUan,
    this.eroCode,
    this.gender,
    this.incrementRevisionDate,
    this.locationCode,
    this.locationName,
    this.locationType,
    this.ofcCode,
    this.ofcMobileNo,
    this.ofcType,
    this.pancardNumber,
    this.payMonthYear,
    this.payStatus,
    this.personalMobileNo,
    this.rps,
    this.sectionCode,
    this.smartLogin,
    this.unitCode,
    this.wing,
  });

  FAllotLmEmp.fromJson(dynamic json) {
    bankAcno = json['bankAcno'];
    bankCode = json['bankCode'];
    basic = json['basic'];
    billCode = json['billCode'];
    changeReturnGroup = json['changeReturnGroup'];
    cityRuralFlag = json['cityRuralFlag'];
    dateOfBirth = json['dateOfBirth'] != null
        ? DateOfBirth.fromJson(json['dateOfBirth'])
        : null;
    dateOfJoining = json['dateOfJoining'] != null
        ? DateOfJoining.fromJson(json['dateOfJoining'])
        : null;
    designation = json['designation'];
    designationCode = json['designationCode'];
    divisionCode = json['divisionCode'];
    earnedLeaves = json['earnedLeaves'];
    empId = json['empId'];
    empName = json['empName'];
    empPassword = json['empPassword'];
    empStatus = json['empStatus'];
    empType = json['empType'];
    epfAcno = json['epfAcno'];
    epfUan = json['epfUan'];
    eroCode = json['eroCode'];
    gender = json['gender'];
    incrementRevisionDate = json['incrementRevisionDate'] != null
        ? IncrementRevisionDate.fromJson(json['incrementRevisionDate'])
        : null;
    locationCode = json['locationCode'];
    locationName = json['locationName'];
    locationType = json['locationType'];
    ofcCode = json['ofcCode'];
    ofcMobileNo = json['ofcMobileNo'];
    ofcType = json['ofcType'];
    pancardNumber = json['pancardNumber'];
    payMonthYear = json['payMonthYear'];
    payStatus = json['payStatus'];
    personalMobileNo = json['personalMobileNo'];
    rps = json['rps'];
    sectionCode = json['sectionCode'];
    smartLogin = json['smartLogin'];
    unitCode = json['unitCode'];
    wing = json['wing'];
  }

  String? bankAcno;
  String? bankCode;
  num? basic;
  String? billCode;
  String? changeReturnGroup;
  String? cityRuralFlag;
  DateOfBirth? dateOfBirth;
  DateOfJoining? dateOfJoining;
  String? designation;
  num? designationCode;
  String? divisionCode;
  num? earnedLeaves;
  String? empId;
  String? empName;
  String? empPassword;
  String? empStatus;
  String? empType;
  String? epfAcno;
  String? epfUan;
  String? eroCode;
  String? gender;
  IncrementRevisionDate? incrementRevisionDate;
  String? locationCode;
  String? locationName;
  String? locationType;
  String? ofcCode;
  String? ofcMobileNo;
  String? ofcType;
  String? pancardNumber;
  String? payMonthYear;
  String? payStatus;
  String? personalMobileNo;
  num? rps;
  String? sectionCode;
  String? smartLogin;
  String? unitCode;
  String? wing;

  FAllotLmEmp copyWith({
    String? bankAcno,
    String? bankCode,
    num? basic,
    String? billCode,
    String? changeReturnGroup,
    String? cityRuralFlag,
    DateOfBirth? dateOfBirth,
    DateOfJoining? dateOfJoining,
    String? designation,
    num? designationCode,
    String? divisionCode,
    num? earnedLeaves,
    String? empId,
    String? empName,
    String? empPassword,
    String? empStatus,
    String? empType,
    String? epfAcno,
    String? epfUan,
    String? eroCode,
    String? gender,
    IncrementRevisionDate? incrementRevisionDate,
    String? locationCode,
    String? locationName,
    String? locationType,
    String? ofcCode,
    String? ofcMobileNo,
    String? ofcType,
    String? pancardNumber,
    String? payMonthYear,
    String? payStatus,
    String? personalMobileNo,
    num? rps,
    String? sectionCode,
    String? smartLogin,
    String? unitCode,
    String? wing,
  }) =>
      FAllotLmEmp(
        bankAcno: bankAcno ?? this.bankAcno,
        bankCode: bankCode ?? this.bankCode,
        basic: basic ?? this.basic,
        billCode: billCode ?? this.billCode,
        changeReturnGroup: changeReturnGroup ?? this.changeReturnGroup,
        cityRuralFlag: cityRuralFlag ?? this.cityRuralFlag,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        dateOfJoining: dateOfJoining ?? this.dateOfJoining,
        designation: designation ?? this.designation,
        designationCode: designationCode ?? this.designationCode,
        divisionCode: divisionCode ?? this.divisionCode,
        earnedLeaves: earnedLeaves ?? this.earnedLeaves,
        empId: empId ?? this.empId,
        empName: empName ?? this.empName,
        empPassword: empPassword ?? this.empPassword,
        empStatus: empStatus ?? this.empStatus,
        empType: empType ?? this.empType,
        epfAcno: epfAcno ?? this.epfAcno,
        epfUan: epfUan ?? this.epfUan,
        eroCode: eroCode ?? this.eroCode,
        gender: gender ?? this.gender,
        incrementRevisionDate:
            incrementRevisionDate ?? this.incrementRevisionDate,
        locationCode: locationCode ?? this.locationCode,
        locationName: locationName ?? this.locationName,
        locationType: locationType ?? this.locationType,
        ofcCode: ofcCode ?? this.ofcCode,
        ofcMobileNo: ofcMobileNo ?? this.ofcMobileNo,
        ofcType: ofcType ?? this.ofcType,
        pancardNumber: pancardNumber ?? this.pancardNumber,
        payMonthYear: payMonthYear ?? this.payMonthYear,
        payStatus: payStatus ?? this.payStatus,
        personalMobileNo: personalMobileNo ?? this.personalMobileNo,
        rps: rps ?? this.rps,
        sectionCode: sectionCode ?? this.sectionCode,
        smartLogin: smartLogin ?? this.smartLogin,
        unitCode: unitCode ?? this.unitCode,
        wing: wing ?? this.wing,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bankAcno'] = bankAcno;
    map['bankCode'] = bankCode;
    map['basic'] = basic;
    map['billCode'] = billCode;
    map['changeReturnGroup'] = changeReturnGroup;
    map['cityRuralFlag'] = cityRuralFlag;
    if (dateOfBirth != null) {
      map['dateOfBirth'] = dateOfBirth?.toJson();
    }
    if (dateOfJoining != null) {
      map['dateOfJoining'] = dateOfJoining?.toJson();
    }
    map['designation'] = designation;
    map['designationCode'] = designationCode;
    map['divisionCode'] = divisionCode;
    map['earnedLeaves'] = earnedLeaves;
    map['empId'] = empId;
    map['empName'] = empName;
    map['empPassword'] = empPassword;
    map['empStatus'] = empStatus;
    map['empType'] = empType;
    map['epfAcno'] = epfAcno;
    map['epfUan'] = epfUan;
    map['eroCode'] = eroCode;
    map['gender'] = gender;
    if (incrementRevisionDate != null) {
      map['incrementRevisionDate'] = incrementRevisionDate?.toJson();
    }
    map['locationCode'] = locationCode;
    map['locationName'] = locationName;
    map['locationType'] = locationType;
    map['ofcCode'] = ofcCode;
    map['ofcMobileNo'] = ofcMobileNo;
    map['ofcType'] = ofcType;
    map['pancardNumber'] = pancardNumber;
    map['payMonthYear'] = payMonthYear;
    map['payStatus'] = payStatus;
    map['personalMobileNo'] = personalMobileNo;
    map['rps'] = rps;
    map['sectionCode'] = sectionCode;
    map['smartLogin'] = smartLogin;
    map['unitCode'] = unitCode;
    map['wing'] = wing;
    return map;
  }
}

IncrementRevisionDate incrementRevisionDateFromJson(String str) =>
    IncrementRevisionDate.fromJson(json.decode(str));

String incrementRevisionDateToJson(IncrementRevisionDate data) =>
    json.encode(data.toJson());

class IncrementRevisionDate {
  IncrementRevisionDate({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.timezone,
  });

  IncrementRevisionDate.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
    millisecond = json['millisecond'];
    timezone = json['timezone'];
  }

  num? year;
  num? month;
  num? day;
  num? hour;
  num? minute;
  num? second;
  num? millisecond;
  num? timezone;

  IncrementRevisionDate copyWith({
    num? year,
    num? month,
    num? day,
    num? hour,
    num? minute,
    num? second,
    num? millisecond,
    num? timezone,
  }) =>
      IncrementRevisionDate(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        millisecond: millisecond ?? this.millisecond,
        timezone: timezone ?? this.timezone,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['day'] = day;
    map['hour'] = hour;
    map['minute'] = minute;
    map['second'] = second;
    map['millisecond'] = millisecond;
    map['timezone'] = timezone;
    return map;
  }
}

// DateOfJoining dateOfJoiningFromJson(String str) =>
//     DateOfJoining.fromJson(json.decode(str));
//
// String dateOfJoiningToJson(DateOfJoining data) => json.encode(data.toJson());
//
// class DateOfJoining {
//   DateOfJoining({
//     this.year,
//     this.month,
//     this.day,
//     this.hour,
//     this.minute,
//     this.second,
//     this.millisecond,
//     this.timezone,
//   });
//
//   DateOfJoining.fromJson(dynamic json) {
//     year = json['year'];
//     month = json['month'];
//     day = json['day'];
//     hour = json['hour'];
//     minute = json['minute'];
//     second = json['second'];
//     millisecond = json['millisecond'];
//     timezone = json['timezone'];
//   }
//
//   num? year;
//   num? month;
//   num? day;
//   num? hour;
//   num? minute;
//   num? second;
//   num? millisecond;
//   num? timezone;
//
//   DateOfJoining copyWith({
//     num? year,
//     num? month,
//     num? day,
//     num? hour,
//     num? minute,
//     num? second,
//     num? millisecond,
//     num? timezone,
//   }) =>
//       DateOfJoining(
//         year: year ?? this.year,
//         month: month ?? this.month,
//         day: day ?? this.day,
//         hour: hour ?? this.hour,
//         minute: minute ?? this.minute,
//         second: second ?? this.second,
//         millisecond: millisecond ?? this.millisecond,
//         timezone: timezone ?? this.timezone,
//       );
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['year'] = year;
//     map['month'] = month;
//     map['day'] = day;
//     map['hour'] = hour;
//     map['minute'] = minute;
//     map['second'] = second;
//     map['millisecond'] = millisecond;
//     map['timezone'] = timezone;
//     return map;
//   }
// }
//
// DateOfBirth dateOfBirthFromJson(String str) =>
//     DateOfBirth.fromJson(json.decode(str));
//
// String dateOfBirthToJson(DateOfBirth data) => json.encode(data.toJson());
//
// class DateOfBirth {
//   DateOfBirth({
//     this.year,
//     this.month,
//     this.day,
//     this.hour,
//     this.minute,
//     this.second,
//     this.millisecond,
//     this.timezone,
//   });
//
//   DateOfBirth.fromJson(dynamic json) {
//     year = json['year'];
//     month = json['month'];
//     day = json['day'];
//     hour = json['hour'];
//     minute = json['minute'];
//     second = json['second'];
//     millisecond = json['millisecond'];
//     timezone = json['timezone'];
//   }
//
//   num? year;
//   num? month;
//   num? day;
//   num? hour;
//   num? minute;
//   num? second;
//   num? millisecond;
//   num? timezone;
//
//   DateOfBirth copyWith({
//     num? year,
//     num? month,
//     num? day,
//     num? hour,
//     num? minute,
//     num? second,
//     num? millisecond,
//     num? timezone,
//   }) =>
//       DateOfBirth(
//         year: year ?? this.year,
//         month: month ?? this.month,
//         day: day ?? this.day,
//         hour: hour ?? this.hour,
//         minute: minute ?? this.minute,
//         second: second ?? this.second,
//         millisecond: millisecond ?? this.millisecond,
//         timezone: timezone ?? this.timezone,
//       );
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['year'] = year;
//     map['month'] = month;
//     map['day'] = day;
//     map['hour'] = hour;
//     map['minute'] = minute;
//     map['second'] = second;
//     map['millisecond'] = millisecond;
//     map['timezone'] = timezone;
//     return map;
//   }
// }

FAllotDate fAllotDateFromJson(String str) =>
    FAllotDate.fromJson(json.decode(str));

String fAllotDateToJson(FAllotDate data) => json.encode(data.toJson());

class FAllotDate {
  FAllotDate({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.timezone,
  });

  FAllotDate.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
    millisecond = json['millisecond'];
    timezone = json['timezone'];
  }

  num? year;
  num? month;
  num? day;
  num? hour;
  num? minute;
  num? second;
  num? millisecond;
  num? timezone;

  FAllotDate copyWith({
    num? year,
    num? month,
    num? day,
    num? hour,
    num? minute,
    num? second,
    num? millisecond,
    num? timezone,
  }) =>
      FAllotDate(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        millisecond: millisecond ?? this.millisecond,
        timezone: timezone ?? this.timezone,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['day'] = day;
    map['hour'] = hour;
    map['minute'] = minute;
    map['second'] = second;
    map['millisecond'] = millisecond;
    map['timezone'] = timezone;
    return map;
  }
}

FAllotAeEmp fAllotAeEmpFromJson(String str) =>
    FAllotAeEmp.fromJson(json.decode(str));

String fAllotAeEmpToJson(FAllotAeEmp data) => json.encode(data.toJson());

class FAllotAeEmp {
  FAllotAeEmp({
    this.bankAcno,
    this.bankCode,
    this.basic,
    this.billCode,
    this.changeReturnGroup,
    this.cityRuralFlag,
    this.dateOfBirth,
    this.dateOfJoining,
    this.designation,
    this.designationCode,
    this.divisionCode,
    this.earnedLeaves,
    this.empAdhaarNumber,
    this.empFatherName,
    this.empId,
    this.empName,
    this.empPassword,
    this.empStatus,
    this.empSurname,
    this.empType,
    this.epfAcno,
    this.epfUan,
    this.eroCode,
    this.gender,
    this.locationCode,
    this.locationName,
    this.locationType,
    this.medicalLeaves,
    this.ofcCode,
    this.ofcMobileNo,
    this.ofcType,
    this.pancardNumber,
    this.payMonthYear,
    this.payStatus,
    this.personalMobileNo,
    this.rps,
    this.sectionCode,
    this.smartLogin,
    this.unitCode,
    this.wing,
  });

  FAllotAeEmp.fromJson(dynamic json) {
    bankAcno = json['bankAcno'];
    bankCode = json['bankCode'];
    basic = json['basic'];
    billCode = json['billCode'];
    changeReturnGroup = json['changeReturnGroup'];
    cityRuralFlag = json['cityRuralFlag'];
    dateOfBirth = json['dateOfBirth'] != null
        ? DateOfBirth.fromJson(json['dateOfBirth'])
        : null;
    dateOfJoining = json['dateOfJoining'] != null
        ? DateOfJoining.fromJson(json['dateOfJoining'])
        : null;
    designation = json['designation'];
    designationCode = json['designationCode'];
    divisionCode = json['divisionCode'];
    earnedLeaves = json['earnedLeaves'];
    empAdhaarNumber = json['empAdhaarNumber'];
    empFatherName = json['empFatherName'];
    empId = json['empId'];
    empName = json['empName'];
    empPassword = json['empPassword'];
    empStatus = json['empStatus'];
    empSurname = json['empSurname'];
    empType = json['empType'];
    epfAcno = json['epfAcno'];
    epfUan = json['epfUan'];
    eroCode = json['eroCode'];
    gender = json['gender'];
    locationCode = json['locationCode'];
    locationName = json['locationName'];
    locationType = json['locationType'];
    medicalLeaves = json['medicalLeaves'];
    ofcCode = json['ofcCode'];
    ofcMobileNo = json['ofcMobileNo'];
    ofcType = json['ofcType'];
    pancardNumber = json['pancardNumber'];
    payMonthYear = json['payMonthYear'];
    payStatus = json['payStatus'];
    personalMobileNo = json['personalMobileNo'];
    rps = json['rps'];
    sectionCode = json['sectionCode'];
    smartLogin = json['smartLogin'];
    unitCode = json['unitCode'];
    wing = json['wing'];
  }

  String? bankAcno;
  String? bankCode;
  num? basic;
  String? billCode;
  String? changeReturnGroup;
  String? cityRuralFlag;
  DateOfBirth? dateOfBirth;
  DateOfJoining? dateOfJoining;
  String? designation;
  num? designationCode;
  String? divisionCode;
  num? earnedLeaves;
  String? empAdhaarNumber;
  String? empFatherName;
  String? empId;
  String? empName;
  String? empPassword;
  String? empStatus;
  String? empSurname;
  String? empType;
  String? epfAcno;
  String? epfUan;
  String? eroCode;
  String? gender;
  String? locationCode;
  String? locationName;
  String? locationType;
  num? medicalLeaves;
  String? ofcCode;
  String? ofcMobileNo;
  String? ofcType;
  String? pancardNumber;
  String? payMonthYear;
  String? payStatus;
  String? personalMobileNo;
  num? rps;
  String? sectionCode;
  String? smartLogin;
  String? unitCode;
  String? wing;

  FAllotAeEmp copyWith({
    String? bankAcno,
    String? bankCode,
    num? basic,
    String? billCode,
    String? changeReturnGroup,
    String? cityRuralFlag,
    DateOfBirth? dateOfBirth,
    DateOfJoining? dateOfJoining,
    String? designation,
    num? designationCode,
    String? divisionCode,
    num? earnedLeaves,
    String? empAdhaarNumber,
    String? empFatherName,
    String? empId,
    String? empName,
    String? empPassword,
    String? empStatus,
    String? empSurname,
    String? empType,
    String? epfAcno,
    String? epfUan,
    String? eroCode,
    String? gender,
    String? locationCode,
    String? locationName,
    String? locationType,
    num? medicalLeaves,
    String? ofcCode,
    String? ofcMobileNo,
    String? ofcType,
    String? pancardNumber,
    String? payMonthYear,
    String? payStatus,
    String? personalMobileNo,
    num? rps,
    String? sectionCode,
    String? smartLogin,
    String? unitCode,
    String? wing,
  }) =>
      FAllotAeEmp(
        bankAcno: bankAcno ?? this.bankAcno,
        bankCode: bankCode ?? this.bankCode,
        basic: basic ?? this.basic,
        billCode: billCode ?? this.billCode,
        changeReturnGroup: changeReturnGroup ?? this.changeReturnGroup,
        cityRuralFlag: cityRuralFlag ?? this.cityRuralFlag,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        dateOfJoining: dateOfJoining ?? this.dateOfJoining,
        designation: designation ?? this.designation,
        designationCode: designationCode ?? this.designationCode,
        divisionCode: divisionCode ?? this.divisionCode,
        earnedLeaves: earnedLeaves ?? this.earnedLeaves,
        empAdhaarNumber: empAdhaarNumber ?? this.empAdhaarNumber,
        empFatherName: empFatherName ?? this.empFatherName,
        empId: empId ?? this.empId,
        empName: empName ?? this.empName,
        empPassword: empPassword ?? this.empPassword,
        empStatus: empStatus ?? this.empStatus,
        empSurname: empSurname ?? this.empSurname,
        empType: empType ?? this.empType,
        epfAcno: epfAcno ?? this.epfAcno,
        epfUan: epfUan ?? this.epfUan,
        eroCode: eroCode ?? this.eroCode,
        gender: gender ?? this.gender,
        locationCode: locationCode ?? this.locationCode,
        locationName: locationName ?? this.locationName,
        locationType: locationType ?? this.locationType,
        medicalLeaves: medicalLeaves ?? this.medicalLeaves,
        ofcCode: ofcCode ?? this.ofcCode,
        ofcMobileNo: ofcMobileNo ?? this.ofcMobileNo,
        ofcType: ofcType ?? this.ofcType,
        pancardNumber: pancardNumber ?? this.pancardNumber,
        payMonthYear: payMonthYear ?? this.payMonthYear,
        payStatus: payStatus ?? this.payStatus,
        personalMobileNo: personalMobileNo ?? this.personalMobileNo,
        rps: rps ?? this.rps,
        sectionCode: sectionCode ?? this.sectionCode,
        smartLogin: smartLogin ?? this.smartLogin,
        unitCode: unitCode ?? this.unitCode,
        wing: wing ?? this.wing,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bankAcno'] = bankAcno;
    map['bankCode'] = bankCode;
    map['basic'] = basic;
    map['billCode'] = billCode;
    map['changeReturnGroup'] = changeReturnGroup;
    map['cityRuralFlag'] = cityRuralFlag;
    if (dateOfBirth != null) {
      map['dateOfBirth'] = dateOfBirth?.toJson();
    }
    if (dateOfJoining != null) {
      map['dateOfJoining'] = dateOfJoining?.toJson();
    }
    map['designation'] = designation;
    map['designationCode'] = designationCode;
    map['divisionCode'] = divisionCode;
    map['earnedLeaves'] = earnedLeaves;
    map['empAdhaarNumber'] = empAdhaarNumber;
    map['empFatherName'] = empFatherName;
    map['empId'] = empId;
    map['empName'] = empName;
    map['empPassword'] = empPassword;
    map['empStatus'] = empStatus;
    map['empSurname'] = empSurname;
    map['empType'] = empType;
    map['epfAcno'] = epfAcno;
    map['epfUan'] = epfUan;
    map['eroCode'] = eroCode;
    map['gender'] = gender;
    map['locationCode'] = locationCode;
    map['locationName'] = locationName;
    map['locationType'] = locationType;
    map['medicalLeaves'] = medicalLeaves;
    map['ofcCode'] = ofcCode;
    map['ofcMobileNo'] = ofcMobileNo;
    map['ofcType'] = ofcType;
    map['pancardNumber'] = pancardNumber;
    map['payMonthYear'] = payMonthYear;
    map['payStatus'] = payStatus;
    map['personalMobileNo'] = personalMobileNo;
    map['rps'] = rps;
    map['sectionCode'] = sectionCode;
    map['smartLogin'] = smartLogin;
    map['unitCode'] = unitCode;
    map['wing'] = wing;
    return map;
  }
}

// DateOfJoining dateOfJoiningFromJson(String str) =>
//     DateOfJoining.fromJson(json.decode(str));
//
// String dateOfJoiningToJson(DateOfJoining data) => json.encode(data.toJson());
//
// class DateOfJoining {
//   DateOfJoining({
//     this.year,
//     this.month,
//     this.day,
//     this.hour,
//     this.minute,
//     this.second,
//     this.millisecond,
//     this.timezone,
//   });
//
//   DateOfJoining.fromJson(dynamic json) {
//     year = json['year'];
//     month = json['month'];
//     day = json['day'];
//     hour = json['hour'];
//     minute = json['minute'];
//     second = json['second'];
//     millisecond = json['millisecond'];
//     timezone = json['timezone'];
//   }
//
//   num? year;
//   num? month;
//   num? day;
//   num? hour;
//   num? minute;
//   num? second;
//   num? millisecond;
//   num? timezone;
//
//   DateOfJoining copyWith({
//     num? year,
//     num? month,
//     num? day,
//     num? hour,
//     num? minute,
//     num? second,
//     num? millisecond,
//     num? timezone,
//   }) =>
//       DateOfJoining(
//         year: year ?? this.year,
//         month: month ?? this.month,
//         day: day ?? this.day,
//         hour: hour ?? this.hour,
//         minute: minute ?? this.minute,
//         second: second ?? this.second,
//         millisecond: millisecond ?? this.millisecond,
//         timezone: timezone ?? this.timezone,
//       );
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['year'] = year;
//     map['month'] = month;
//     map['day'] = day;
//     map['hour'] = hour;
//     map['minute'] = minute;
//     map['second'] = second;
//     map['millisecond'] = millisecond;
//     map['timezone'] = timezone;
//     return map;
//   }
// }
//
// DateOfBirth dateOfBirthFromJson(String str) =>
//     DateOfBirth.fromJson(json.decode(str));
//
// String dateOfBirthToJson(DateOfBirth data) => json.encode(data.toJson());
//
// class DateOfBirth {
//   DateOfBirth({
//     this.year,
//     this.month,
//     this.day,
//     this.hour,
//     this.minute,
//     this.second,
//     this.millisecond,
//     this.timezone,
//   });
//
//   DateOfBirth.fromJson(dynamic json) {
//     year = json['year'];
//     month = json['month'];
//     day = json['day'];
//     hour = json['hour'];
//     minute = json['minute'];
//     second = json['second'];
//     millisecond = json['millisecond'];
//     timezone = json['timezone'];
//   }
//
//   num? year;
//   num? month;
//   num? day;
//   num? hour;
//   num? minute;
//   num? second;
//   num? millisecond;
//   num? timezone;
//
//   DateOfBirth copyWith({
//     num? year,
//     num? month,
//     num? day,
//     num? hour,
//     num? minute,
//     num? second,
//     num? millisecond,
//     num? timezone,
//   }) =>
//       DateOfBirth(
//         year: year ?? this.year,
//         month: month ?? this.month,
//         day: day ?? this.day,
//         hour: hour ?? this.hour,
//         minute: minute ?? this.minute,
//         second: second ?? this.second,
//         millisecond: millisecond ?? this.millisecond,
//         timezone: timezone ?? this.timezone,
//       );
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['year'] = year;
//     map['month'] = month;
//     map['day'] = day;
//     map['hour'] = hour;
//     map['minute'] = minute;
//     map['second'] = second;
//     map['millisecond'] = millisecond;
//     map['timezone'] = timezone;
//     return map;
//   }
// }
