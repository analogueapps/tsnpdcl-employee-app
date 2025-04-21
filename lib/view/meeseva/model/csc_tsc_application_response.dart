import 'dart:convert';

CscTscApplicationResponse cscTscApplicationResponseFromJson(String str) =>
    CscTscApplicationResponse.fromJson(json.decode(str));

String cscTscApplicationResponseToJson(CscTscApplicationResponse data) =>
    json.encode(data.toJson());

class CscTscApplicationResponse {
  CscTscApplicationResponse({
    this.remarksAllowed,
    this.editableForm,
    this.userCharges,
    this.surName,
    this.consumerName,
    this.fatherName,
    this.phoneNumber,
    this.aadhaar,
    this.doorNumber,
    this.village,
    this.town,
    this.city,
    this.district,
    this.socialGroup,
    this.socialGroupOther,
    this.registrationNumber,
    this.registrationDate,
    this.applicationDate,
    this.status,
    this.statusDate,
    this.scheme,
    this.sectionId,
    this.hno,
    this.purposeOfSupply,
    this.contractedLoad,
    this.sla,
    this.applicationCharges,
    this.developmentCharges,
    this.fAllotAeEmp,
    this.fAllotDate,
    this.fAllotLmEmp,
    this.fBy,
    this.fDate,
    this.fEmpId,
    this.fFlag,
    this.insDate,
    this.meesevaDocumentsList,
    this.opDate,
    this.regId,
    this.regUser,
    this.securityDeposit,
    this.serviceCharges,
    this.serviceType,
    this.totalAmount,
    this.empFeasibilityAllot,
    this.empFeasibilityAllotId,
    this.fAllotDateLong,
    this.feasible,
    this.feedingFlag,
    this.feasibilitySubmitDate,
    this.feasibleByAe,
    this.estimateRequired,
    this.rowrequired,
    this.poleDist,
    this.reason,
    this.substation,
    this.feederCode,
    this.dtrno,
    this.poleno,
    this.distributionCode,
    this.distributionName,
    this.meesevaFeasibility,
    this.meesevaRelDetails,
    this.formControlList,
    this.rowList,
    this.crcDateString,
    this.feasibleDate,
  });

  CscTscApplicationResponse.fromJson(dynamic json) {
    remarksAllowed = json['remarksAllowed'];
    editableForm = json['editableForm'];
    userCharges = json['userCharges'];
    surName = json['surName'];
    consumerName = json['consumerName'];
    fatherName = json['fatherName'];
    phoneNumber = json['phoneNumber'];
    aadhaar = json['aadhaar'];
    doorNumber = json['doorNumber'];
    village = json['village'];
    town = json['town'];
    city = json['city'];
    district = json['district'];
    socialGroup = json['socialGroup'];
    socialGroupOther = json['socialGroupOther'];
    registrationNumber = json['registrationNumber'];
    registrationDate = json['registrationDate'] != null
        ? RegistrationDate.fromJson(json['registrationDate'])
        : null;
    applicationDate = json['applicationDate'];
    status = json['status'];
    statusDate = json['statusDate'];
    scheme = json['scheme'];
    sectionId = json['sectionId'];
    hno = json['hno'];
    purposeOfSupply = json['purposeOfSupply'];
    contractedLoad = json['contractedLoad'];
    sla = json['sla'];
    applicationCharges = json['applicationCharges'];
    developmentCharges = json['developmentCharges'];
    fAllotAeEmp = json['fAllotAeEmp'] != null
        ? FAllotAeEmp.fromJson(json['fAllotAeEmp'])
        : null;
    fAllotDate = json['fAllotDate'] != null
        ? FAllotDate.fromJson(json['fAllotDate'])
        : null;
    fAllotLmEmp = json['fAllotLmEmp'] != null
        ? FAllotLmEmp.fromJson(json['fAllotLmEmp'])
        : null;
    fBy = json['fBy'];
    fDate = json['fDate'] != null ? FDate.fromJson(json['fDate']) : null;
    fEmpId = json['fEmpId'] != null ? FEmpId.fromJson(json['fEmpId']) : null;
    fFlag = json['fFlag'];
    insDate =
        json['insDate'] != null ? InsDate.fromJson(json['insDate']) : null;
    if (json['meesevaDocumentsList'] != null) {
      meesevaDocumentsList = [];
      // json['meesevaDocumentsList'].forEach((v) {
      //   meesevaDocumentsList?.add();
      // });
    }
    opDate = json['opDate'] != null ? OpDate.fromJson(json['opDate']) : null;
    regId = json['regId'];
    regUser = json['regUser'];
    securityDeposit = json['securityDeposit'];
    serviceCharges = json['serviceCharges'];
    serviceType = json['serviceType'];
    totalAmount = json['totalAmount'];
    empFeasibilityAllot = json['emp_feasibility_Allot'];
    empFeasibilityAllotId = json['emp_feasibility_Allot_Id'];
    fAllotDateLong = json['fAllotDateLong'];
    feasible = json['feasible'];
    feedingFlag = json['feedingFlag'];
    feasibilitySubmitDate = json['feasibilitySubmitDate'];
    feasibleByAe = json['feasibleByAe'];
    estimateRequired = json['estimateRequired'];
    rowrequired = json['rowrequired'];
    poleDist = json['poleDist'];
    reason = json['reason'];
    substation = json['substation'];
    feederCode = json['feederCode'];
    dtrno = json['dtrno'];
    poleno = json['poleno'];
    distributionCode = json['distributionCode'];
    distributionName = json['distributionName'];
    meesevaFeasibility = json['meesevaFeasibility'] != null
        ? MeesevaFeasibility.fromJson(json['meesevaFeasibility'])
        : null;
    meesevaRelDetails = json['meesevaRelDetails'] != null
        ? MeesevaRelDetails.fromJson(json['meesevaRelDetails'])
        : null;
    if (json['formControlList'] != null) {
      formControlList = [];
      // json['formControlList'].forEach((v) {
      //   formControlList?.add(Dynamic.fromJson(v));
      // });
    }
    if (json['rowList'] != null) {
      rowList = [];
      json['rowList'].forEach((v) {
        rowList?.add(RowList.fromJson(v));
      });
    }
    crcDateString = json['crcDateString'];
    feasibleDate = json['feasibleDate'] != null
        ? FeasibleDate.fromJson(json['feasibleDate'])
        : null;
  }

  bool? remarksAllowed;
  bool? editableForm;
  num? userCharges;
  String? surName;
  String? consumerName;
  String? fatherName;
  String? phoneNumber;
  String? aadhaar;
  String? doorNumber;
  String? village;
  String? town;
  String? city;
  String? district;
  String? socialGroup;
  String? socialGroupOther;
  String? registrationNumber;
  RegistrationDate? registrationDate;
  num? applicationDate;
  String? status;
  num? statusDate;
  String? scheme;
  String? sectionId;
  String? hno;
  String? purposeOfSupply;
  String? contractedLoad;
  String? sla;
  num? applicationCharges;
  num? developmentCharges;
  FAllotAeEmp? fAllotAeEmp;
  FAllotDate? fAllotDate;
  FAllotLmEmp? fAllotLmEmp;
  String? fBy;
  FDate? fDate;
  FEmpId? fEmpId;
  String? fFlag;
  InsDate? insDate;
  List<dynamic>? meesevaDocumentsList;
  OpDate? opDate;
  num? regId;
  String? regUser;
  num? securityDeposit;
  num? serviceCharges;
  String? serviceType;
  num? totalAmount;
  String? empFeasibilityAllot;
  String? empFeasibilityAllotId;
  num? fAllotDateLong;
  String? feasible;
  String? feedingFlag;
  num? feasibilitySubmitDate;
  String? feasibleByAe;
  String? estimateRequired;
  String? rowrequired;
  String? poleDist;
  String? reason;
  String? substation;
  String? feederCode;
  String? dtrno;
  String? poleno;
  String? distributionCode;
  String? distributionName;
  MeesevaFeasibility? meesevaFeasibility;
  MeesevaRelDetails? meesevaRelDetails;
  List<dynamic>? formControlList;
  List<RowList>? rowList;
  String? crcDateString;
  FeasibleDate? feasibleDate;

  CscTscApplicationResponse copyWith({
    bool? remarksAllowed,
    bool? editableForm,
    num? userCharges,
    String? surName,
    String? consumerName,
    String? fatherName,
    String? phoneNumber,
    String? aadhaar,
    String? doorNumber,
    String? village,
    String? town,
    String? city,
    String? district,
    String? socialGroup,
    String? socialGroupOther,
    String? registrationNumber,
    RegistrationDate? registrationDate,
    num? applicationDate,
    String? status,
    num? statusDate,
    String? scheme,
    String? sectionId,
    String? hno,
    String? purposeOfSupply,
    String? contractedLoad,
    String? sla,
    num? applicationCharges,
    num? developmentCharges,
    FAllotAeEmp? fAllotAeEmp,
    FAllotDate? fAllotDate,
    FAllotLmEmp? fAllotLmEmp,
    String? fBy,
    FDate? fDate,
    FEmpId? fEmpId,
    String? fFlag,
    InsDate? insDate,
    List<dynamic>? meesevaDocumentsList,
    OpDate? opDate,
    num? regId,
    String? regUser,
    num? securityDeposit,
    num? serviceCharges,
    String? serviceType,
    num? totalAmount,
    String? empFeasibilityAllot,
    String? empFeasibilityAllotId,
    num? fAllotDateLong,
    String? feasible,
    String? feedingFlag,
    num? feasibilitySubmitDate,
    String? feasibleByAe,
    String? estimateRequired,
    String? rowrequired,
    String? poleDist,
    String? reason,
    String? substation,
    String? feederCode,
    String? dtrno,
    String? poleno,
    String? distributionCode,
    String? distributionName,
    MeesevaFeasibility? meesevaFeasibility,
    MeesevaRelDetails? meesevaRelDetails,
    List<dynamic>? formControlList,
    List<RowList>? rowList,
    String? crcDateString,
    FeasibleDate? feasibleDate,
  }) =>
      CscTscApplicationResponse(
        remarksAllowed: remarksAllowed ?? this.remarksAllowed,
        editableForm: editableForm ?? this.editableForm,
        userCharges: userCharges ?? this.userCharges,
        surName: surName ?? this.surName,
        consumerName: consumerName ?? this.consumerName,
        fatherName: fatherName ?? this.fatherName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        aadhaar: aadhaar ?? this.aadhaar,
        doorNumber: doorNumber ?? this.doorNumber,
        village: village ?? this.village,
        town: town ?? this.town,
        city: city ?? this.city,
        district: district ?? this.district,
        socialGroup: socialGroup ?? this.socialGroup,
        socialGroupOther: socialGroupOther ?? this.socialGroupOther,
        registrationNumber: registrationNumber ?? this.registrationNumber,
        registrationDate: registrationDate ?? this.registrationDate,
        applicationDate: applicationDate ?? this.applicationDate,
        status: status ?? this.status,
        statusDate: statusDate ?? this.statusDate,
        scheme: scheme ?? this.scheme,
        sectionId: sectionId ?? this.sectionId,
        hno: hno ?? this.hno,
        purposeOfSupply: purposeOfSupply ?? this.purposeOfSupply,
        contractedLoad: contractedLoad ?? this.contractedLoad,
        sla: sla ?? this.sla,
        applicationCharges: applicationCharges ?? this.applicationCharges,
        developmentCharges: developmentCharges ?? this.developmentCharges,
        fAllotAeEmp: fAllotAeEmp ?? this.fAllotAeEmp,
        fAllotDate: fAllotDate ?? this.fAllotDate,
        fAllotLmEmp: fAllotLmEmp ?? this.fAllotLmEmp,
        fBy: fBy ?? this.fBy,
        fDate: fDate ?? this.fDate,
        fEmpId: fEmpId ?? this.fEmpId,
        fFlag: fFlag ?? this.fFlag,
        insDate: insDate ?? this.insDate,
        meesevaDocumentsList: meesevaDocumentsList ?? this.meesevaDocumentsList,
        opDate: opDate ?? this.opDate,
        regId: regId ?? this.regId,
        regUser: regUser ?? this.regUser,
        securityDeposit: securityDeposit ?? this.securityDeposit,
        serviceCharges: serviceCharges ?? this.serviceCharges,
        serviceType: serviceType ?? this.serviceType,
        totalAmount: totalAmount ?? this.totalAmount,
        empFeasibilityAllot: empFeasibilityAllot ?? this.empFeasibilityAllot,
        empFeasibilityAllotId:
            empFeasibilityAllotId ?? this.empFeasibilityAllotId,
        fAllotDateLong: fAllotDateLong ?? this.fAllotDateLong,
        feasible: feasible ?? this.feasible,
        feedingFlag: feedingFlag ?? this.feedingFlag,
        feasibilitySubmitDate:
            feasibilitySubmitDate ?? this.feasibilitySubmitDate,
        feasibleByAe: feasibleByAe ?? this.feasibleByAe,
        estimateRequired: estimateRequired ?? this.estimateRequired,
        rowrequired: rowrequired ?? this.rowrequired,
        poleDist: poleDist ?? this.poleDist,
        reason: reason ?? this.reason,
        substation: substation ?? this.substation,
        feederCode: feederCode ?? this.feederCode,
        dtrno: dtrno ?? this.dtrno,
        poleno: poleno ?? this.poleno,
        distributionCode: distributionCode ?? this.distributionCode,
        distributionName: distributionName ?? this.distributionName,
        meesevaFeasibility: meesevaFeasibility ?? this.meesevaFeasibility,
        meesevaRelDetails: meesevaRelDetails ?? this.meesevaRelDetails,
        formControlList: formControlList ?? this.formControlList,
        rowList: rowList ?? this.rowList,
        crcDateString: crcDateString ?? this.crcDateString,
        feasibleDate: feasibleDate ?? this.feasibleDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remarksAllowed'] = remarksAllowed;
    map['editableForm'] = editableForm;
    map['userCharges'] = userCharges;
    map['surName'] = surName;
    map['consumerName'] = consumerName;
    map['fatherName'] = fatherName;
    map['phoneNumber'] = phoneNumber;
    map['aadhaar'] = aadhaar;
    map['doorNumber'] = doorNumber;
    map['village'] = village;
    map['town'] = town;
    map['city'] = city;
    map['district'] = district;
    map['socialGroup'] = socialGroup;
    map['socialGroupOther'] = socialGroupOther;
    map['registrationNumber'] = registrationNumber;
    if (registrationDate != null) {
      map['registrationDate'] = registrationDate?.toJson();
    }
    map['applicationDate'] = applicationDate;
    map['status'] = status;
    map['statusDate'] = statusDate;
    map['scheme'] = scheme;
    map['sectionId'] = sectionId;
    map['hno'] = hno;
    map['purposeOfSupply'] = purposeOfSupply;
    map['contractedLoad'] = contractedLoad;
    map['sla'] = sla;
    map['applicationCharges'] = applicationCharges;
    map['developmentCharges'] = developmentCharges;
    if (fAllotAeEmp != null) {
      map['fAllotAeEmp'] = fAllotAeEmp?.toJson();
    }
    if (fAllotDate != null) {
      map['fAllotDate'] = fAllotDate?.toJson();
    }
    if (fAllotLmEmp != null) {
      map['fAllotLmEmp'] = fAllotLmEmp?.toJson();
    }
    map['fBy'] = fBy;
    if (fDate != null) {
      map['fDate'] = fDate?.toJson();
    }
    if (fEmpId != null) {
      map['fEmpId'] = fEmpId?.toJson();
    }
    map['fFlag'] = fFlag;
    if (insDate != null) {
      map['insDate'] = insDate?.toJson();
    }
    if (meesevaDocumentsList != null) {
      map['meesevaDocumentsList'] =
          meesevaDocumentsList?.map((v) => v.toJson()).toList();
    }
    if (opDate != null) {
      map['opDate'] = opDate?.toJson();
    }
    map['regId'] = regId;
    map['regUser'] = regUser;
    map['securityDeposit'] = securityDeposit;
    map['serviceCharges'] = serviceCharges;
    map['serviceType'] = serviceType;
    map['totalAmount'] = totalAmount;
    map['emp_feasibility_Allot'] = empFeasibilityAllot;
    map['emp_feasibility_Allot_Id'] = empFeasibilityAllotId;
    map['fAllotDateLong'] = fAllotDateLong;
    map['feasible'] = feasible;
    map['feedingFlag'] = feedingFlag;
    map['feasibilitySubmitDate'] = feasibilitySubmitDate;
    map['feasibleByAe'] = feasibleByAe;
    map['estimateRequired'] = estimateRequired;
    map['rowrequired'] = rowrequired;
    map['poleDist'] = poleDist;
    map['reason'] = reason;
    map['substation'] = substation;
    map['feederCode'] = feederCode;
    map['dtrno'] = dtrno;
    map['poleno'] = poleno;
    map['distributionCode'] = distributionCode;
    map['distributionName'] = distributionName;
    if (meesevaFeasibility != null) {
      map['meesevaFeasibility'] = meesevaFeasibility?.toJson();
    }
    if (meesevaRelDetails != null) {
      map['meesevaRelDetails'] = meesevaRelDetails?.toJson();
    }
    if (formControlList != null) {
      map['formControlList'] = formControlList?.map((v) => v.toJson()).toList();
    }
    if (rowList != null) {
      map['rowList'] = rowList?.map((v) => v.toJson()).toList();
    }
    map['crcDateString'] = crcDateString;
    if (feasibleDate != null) {
      map['feasibleDate'] = feasibleDate?.toJson();
    }
    return map;
  }
}

FeasibleDate feasibleDateFromJson(String str) =>
    FeasibleDate.fromJson(json.decode(str));

String feasibleDateToJson(FeasibleDate data) => json.encode(data.toJson());

class FeasibleDate {
  FeasibleDate({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.timezone,
  });

  FeasibleDate.fromJson(dynamic json) {
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

  FeasibleDate copyWith({
    num? year,
    num? month,
    num? day,
    num? hour,
    num? minute,
    num? second,
    num? millisecond,
    num? timezone,
  }) =>
      FeasibleDate(
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

RowList rowListFromJson(String str) => RowList.fromJson(json.decode(str));

String rowListToJson(RowList data) => json.encode(data.toJson());

class RowList {
  RowList({
    this.headerBar,
    this.label,
    this.value,
    this.displayValue,
    this.labelColor,
    this.valueColor,
    this.title,
    this.description,
    this.width,
    this.height,
    this.scaleType,
    this.rowType,
    this.id,
    this.latitude,
    this.longitude,
  });

  RowList.fromJson(dynamic json) {
    headerBar = json['headerBar'] != null
        ? HeaderBar.fromJson(json['headerBar'])
        : null;
    label = json['label'];
    value = json['value'];
    displayValue = json['displayValue'];
    labelColor = json['labelColor'];
    valueColor = json['valueColor'];
    title = json['title'];
    description = json['description'];
    width = json['width'];
    height = json['height'];
    scaleType = json['scaleType'];
    rowType = json['rowType'];
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  HeaderBar? headerBar;
  String? label;
  dynamic? value;
  String? displayValue;
  String? labelColor;
  String? valueColor;
  String? title;
  String? description;
  num? width;
  num? height;
  num? scaleType;
  num? rowType;
  String? id;
  num? latitude;
  num? longitude;

  RowList copyWith({
    HeaderBar? headerBar,
    String? label,
    dynamic? value,
    String? displayValue,
    String? labelColor,
    String? valueColor,
    String? title,
    String? description,
    num? width,
    num? height,
    num? scaleType,
    num? rowType,
    String? id,
    num? latitude,
    num? longitude,
  }) =>
      RowList(
        headerBar: headerBar ?? this.headerBar,
        label: label ?? this.label,
        value: value ?? this.value,
        displayValue: displayValue ?? this.displayValue,
        labelColor: labelColor ?? this.labelColor,
        valueColor: valueColor ?? this.valueColor,
        title: title ?? this.title,
        description: description ?? this.description,
        width: width ?? this.width,
        height: height ?? this.height,
        scaleType: scaleType ?? this.scaleType,
        rowType: rowType ?? this.rowType,
        id: id ?? this.id,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (headerBar != null) {
      map['headerBar'] = headerBar?.toJson();
    }
    map['label'] = label;
    map['value'] = value;
    map['displayValue'] = displayValue;
    map['labelColor'] = labelColor;
    map['valueColor'] = valueColor;
    map['title'] = title;
    map['description'] = description;
    map['width'] = width;
    map['height'] = height;
    map['scaleType'] = scaleType;
    map['rowType'] = rowType;
    map['id'] = id;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}

HeaderBar headerBarFromJson(String str) => HeaderBar.fromJson(json.decode(str));

String headerBarToJson(HeaderBar data) => json.encode(data.toJson());

class HeaderBar {
  HeaderBar({
    this.backGroundColor,
    this.label,
    this.labelColor,
  });

  HeaderBar.fromJson(dynamic json) {
    backGroundColor = json['backGroundColor'];
    label = json['label'];
    labelColor = json['labelColor'];
  }

  String? backGroundColor;
  String? label;
  String? labelColor;

  HeaderBar copyWith({
    String? backGroundColor,
    String? label,
    String? labelColor,
  }) =>
      HeaderBar(
        backGroundColor: backGroundColor ?? this.backGroundColor,
        label: label ?? this.label,
        labelColor: labelColor ?? this.labelColor,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backGroundColor'] = backGroundColor;
    map['label'] = label;
    map['labelColor'] = labelColor;
    return map;
  }
}

MeesevaRelDetails meesevaRelDetailsFromJson(String str) =>
    MeesevaRelDetails.fromJson(json.decode(str));

String meesevaRelDetailsToJson(MeesevaRelDetails data) =>
    json.encode(data.toJson());

class MeesevaRelDetails {
  MeesevaRelDetails({
    this.regId,
  });

  MeesevaRelDetails.fromJson(dynamic json) {
    regId = json['regId'];
  }

  num? regId;

  MeesevaRelDetails copyWith({
    num? regId,
  }) =>
      MeesevaRelDetails(
        regId: regId ?? this.regId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['regId'] = regId;
    return map;
  }
}

MeesevaFeasibility meesevaFeasibilityFromJson(String str) =>
    MeesevaFeasibility.fromJson(json.decode(str));

String meesevaFeasibilityToJson(MeesevaFeasibility data) =>
    json.encode(data.toJson());

class MeesevaFeasibility {
  MeesevaFeasibility({
    this.distributionCode,
    this.distributionName,
    this.dtr,
    this.fBy,
    this.fDate,
    this.fEmpId,
    this.fFlag,
    this.feeder,
    this.id,
    this.insDate,
    this.poleNo,
    this.ss,
  });

  MeesevaFeasibility.fromJson(dynamic json) {
    distributionCode = json['distributionCode'];
    distributionName = json['distributionName'];
    dtr = json['dtr'];
    fBy = json['fBy'];
    fDate = json['fDate'] != null ? FDate.fromJson(json['fDate']) : null;
    fEmpId = json['fEmpId'];
    fFlag = json['fFlag'];
    feeder = json['feeder'];
    id = json['id'];
    insDate =
        json['insDate'] != null ? InsDate.fromJson(json['insDate']) : null;
    poleNo = json['poleNo'];
    ss = json['ss'];
  }

  String? distributionCode;
  String? distributionName;
  String? dtr;
  String? fBy;
  FDate? fDate;
  String? fEmpId;
  String? fFlag;
  String? feeder;
  num? id;
  InsDate? insDate;
  String? poleNo;
  String? ss;

  MeesevaFeasibility copyWith({
    String? distributionCode,
    String? distributionName,
    String? dtr,
    String? fBy,
    FDate? fDate,
    String? fEmpId,
    String? fFlag,
    String? feeder,
    num? id,
    InsDate? insDate,
    String? poleNo,
    String? ss,
  }) =>
      MeesevaFeasibility(
        distributionCode: distributionCode ?? this.distributionCode,
        distributionName: distributionName ?? this.distributionName,
        dtr: dtr ?? this.dtr,
        fBy: fBy ?? this.fBy,
        fDate: fDate ?? this.fDate,
        fEmpId: fEmpId ?? this.fEmpId,
        fFlag: fFlag ?? this.fFlag,
        feeder: feeder ?? this.feeder,
        id: id ?? this.id,
        insDate: insDate ?? this.insDate,
        poleNo: poleNo ?? this.poleNo,
        ss: ss ?? this.ss,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distributionCode'] = distributionCode;
    map['distributionName'] = distributionName;
    map['dtr'] = dtr;
    map['fBy'] = fBy;
    if (fDate != null) {
      map['fDate'] = fDate?.toJson();
    }
    map['fEmpId'] = fEmpId;
    map['fFlag'] = fFlag;
    map['feeder'] = feeder;
    map['id'] = id;
    if (insDate != null) {
      map['insDate'] = insDate?.toJson();
    }
    map['poleNo'] = poleNo;
    map['ss'] = ss;
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

// InsDate insDateFromJson(String str) => InsDate.fromJson(json.decode(str));
//
// String insDateToJson(InsDate data) => json.encode(data.toJson());
//
// class InsDate {
//   InsDate({
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
//   InsDate.fromJson(dynamic json) {
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
//   InsDate copyWith({
//     num? year,
//     num? month,
//     num? day,
//     num? hour,
//     num? minute,
//     num? second,
//     num? millisecond,
//     num? timezone,
//   }) =>
//       InsDate(
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

// FDate fDateFromJson(String str) => FDate.fromJson(json.decode(str));
//
// String fDateToJson(FDate data) => json.encode(data.toJson());
//
// class FDate {
//   FDate({
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
//   FDate.fromJson(dynamic json) {
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
//   FDate copyWith({
//     num? year,
//     num? month,
//     num? day,
//     num? hour,
//     num? minute,
//     num? second,
//     num? millisecond,
//     num? timezone,
//   }) =>
//       FDate(
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
