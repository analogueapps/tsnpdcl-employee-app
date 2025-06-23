import 'dart:convert';


class DtrInspectionSheetEntity {
  final int sheetId;
  final String sectionCode;
  final String? equipmentCode;
  final String sectionName;
  final String lmEmpId;
  final String aeEmpId;
  final String insertDate;
  final String structureCode;
  final String? structureCapacity;
  final String abSwitchAvailable;
  final String abSwitchType;
  final String abSwitchStatus;
  final int abContactsDamaged;
  final int abBrassStripDamaged;
  final int nylonBushDamaged;
  final String hG11KvFuseSetAvailable;
  final int hornsToBeReplaced;
  final String gapIsNotCorrect;
  final int hgFuseSetPostTypeInsulatorsCount;
  final int htBushesDamageCount;
  final int htBushRodsDamCount;
  final int ltBushesDamageCount;
  final int ltBushRodsDamCount;
  final String ltBiMetalClampsAvailable;
  final int ltBiMetalClampsDamCount;
  final int oilShortageInLiters;
  final String oilLeakage;
  final String gasketsDamaged;
  final String ltBreaker;
  final String ltBreakerStatus;
  final String ltFuseSetAvailable;
  final String diaphragmStatus;
  final String ltFuseSetStatus;
  final String ltFuseWire;
  final String ltPvcCable;
  final String ltPvcCableStatus;
  final String lightningArrestors;
  final int earthPits;
  final String earthPipes;
  final String earthPipesStatus;
  final String earthing;
  final String doubleEarthing;
  final int noOfLooseLinesOnDtr;
  final int treeCuttingRequired;
  final double dtrAglLoadHp;
  final double domesticNonDomLoad;
  final double industrialLoadInHp;
  final double waterWorksLoadInHp;
  final double otherLoadInKw;
  final double rPhaseCurrent;
  final double yPhaseCurrent;
  final double bPhaseCurrent;
  final double nPhaseCurrent;
  final String otherObservationsByLm;
  final DateTime reportSubmitDate;
  final String? deviceId;
  final String status;
  final String? distbuCode;
  final EmployeeMasterEntityByLmEmpId employeeMasterEntityByLmEmpId;
  final EmployeeMasterEntityByLmEmpId employeeMasterEntityByAeEmpId;
  final int maintenanceSheetId;
  // final  dtrPostMaintenanceSheetEntityByMaintenanceSheetId;
  final String?  dtrFencingRequired;
  final String?  dtrPlinthAsPerStandards;
  final String?  dtrSurroundingNeatlyMaintained;
  final String?  entryType;
  final DateTime?  scheduledDate;
  final String?  scheduledMonth;
  final String?  beforeMaintenanceImage;
  final String?  beforeLat;
  final String?  beforeLon;
  DtrInspectionSheetEntity({
    required this.sheetId,
    required this.sectionCode,
    this.equipmentCode,
    required this.sectionName,
    required this.lmEmpId,
    required this.aeEmpId,
    required this.insertDate,
    required this.structureCode,
    this.structureCapacity,
    required this.abSwitchAvailable,
    required this.abSwitchType,
    required this.abSwitchStatus,
    required this.abContactsDamaged,
    required this.abBrassStripDamaged,
    required this.nylonBushDamaged,
    required this.hG11KvFuseSetAvailable,
    required this.hornsToBeReplaced,
    required this.gapIsNotCorrect,
    required this.hgFuseSetPostTypeInsulatorsCount,
    required this.htBushesDamageCount,
    required this.htBushRodsDamCount,
    required this.ltBushesDamageCount,
    required this.ltBushRodsDamCount,
    required this.ltBiMetalClampsAvailable,
    required this.ltBiMetalClampsDamCount,
    required this.oilShortageInLiters,
    required this.oilLeakage,
    required this.gasketsDamaged,
    required this.ltBreaker,
    required this.ltBreakerStatus,
    required this.ltFuseSetAvailable,
    required this.diaphragmStatus,
    required this.ltFuseSetStatus,
    required this.ltFuseWire,
    required this.ltPvcCable,
    required this.ltPvcCableStatus,
    required this.lightningArrestors,
    required this.earthPits,
    required this.earthPipes,
    required this.earthPipesStatus,
    required this.earthing,
    required this.doubleEarthing,
    required this.noOfLooseLinesOnDtr,
    required this.treeCuttingRequired,
    required this.dtrAglLoadHp,
    required this.domesticNonDomLoad,
    required this.industrialLoadInHp,
    required this.waterWorksLoadInHp,
    required this.otherLoadInKw,
    required this.rPhaseCurrent,
    required this.yPhaseCurrent,
    required this.bPhaseCurrent,
    required this.nPhaseCurrent,
    required this.otherObservationsByLm,
    required this.reportSubmitDate,
    this.deviceId,
    required this.status,
    this.distbuCode,
    required this.employeeMasterEntityByLmEmpId,
    required this.employeeMasterEntityByAeEmpId,
    required this.maintenanceSheetId,
    this.dtrFencingRequired,
    this.dtrPlinthAsPerStandards,
    this.dtrSurroundingNeatlyMaintained,
    this.entryType,
    this.scheduledDate,
    this.scheduledMonth,
    this.beforeMaintenanceImage,
    this.beforeLat,
    this.beforeLon,
  });

  factory DtrInspectionSheetEntity.fromJson(Map<String, dynamic> json) {
    return DtrInspectionSheetEntity(
      sheetId: json['sheetId'],
      sectionCode: json['sectionCode'],
      equipmentCode: json['equipmentCode'],
      sectionName: json['sectionName'],
      lmEmpId: json['lmEmpId'],
      aeEmpId: json['aeEmpId'],
      insertDate:json['insertDate'],
      structureCode: json['structureCode'],
      structureCapacity: json['structureCapacity'],
      abSwitchAvailable: json['abSwitchAvailable'],
      abSwitchType: json['abSwitchType'],
      abSwitchStatus: json['abSwitchStatus'],
      abContactsDamaged: json['abContactsDamaged'],
      abBrassStripDamaged: json['abBrassStripDamaged'],
      nylonBushDamaged: json['nylonBushDamaged'],
      hG11KvFuseSetAvailable: json['hG11KvFuseSetAvailable'],
      hornsToBeReplaced: json['hornsToBeReplaced'],
      gapIsNotCorrect: json['gapIsNotCorrect'],
      hgFuseSetPostTypeInsulatorsCount: json['hgFuseSetPostTypeInsulatorsCount'],
      htBushesDamageCount: json['htBushesDamageCount'],
      htBushRodsDamCount: json['htBushRodsDamCount'],
      ltBushesDamageCount: json['ltBushesDamageCount'],
      ltBushRodsDamCount: json['ltBushRodsDamCount'],
      ltBiMetalClampsAvailable: json['ltBiMetalClampsAvailable'],
      ltBiMetalClampsDamCount: json['ltBiMetalClampsDamCount'],
      oilShortageInLiters: json['oilShortageInLiters'],
      oilLeakage: json['oilLeakage'],
      gasketsDamaged: json['gasketsDamaged'],
      ltBreaker: json['ltBreaker'],
      ltBreakerStatus: json['ltBreakerStatus'],
      ltFuseSetAvailable: json['ltFuseSetAvailable'],
      diaphragmStatus: json['diaphragmStatus'],
      ltFuseSetStatus: json['ltFuseSetStatus'],
      ltFuseWire: json['ltFuseWire'],
      ltPvcCable: json['ltPvcCable'],
      ltPvcCableStatus: json['ltPvcCableStatus'],
      lightningArrestors: json['lightningArrestors'],
      earthPits: json['earthPits'],
      earthPipes: json['earthPipes'],
      earthPipesStatus: json['earthPipesStatus'],
      earthing: json['earthing'],
      doubleEarthing: json['doubleEarthing'],
      noOfLooseLinesOnDtr: json['noOfLooseLinesOnDtr'],
      treeCuttingRequired: json['treeCuttingRequired'],
      dtrAglLoadHp: (json['dtrAglLoadHp'] as num).toDouble(),
      domesticNonDomLoad: (json['domesticNonDomLoad'] as num).toDouble(),
      industrialLoadInHp: (json['industrialLoadInHp'] as num).toDouble(),
      waterWorksLoadInHp: (json['waterWorksLoadInHp'] as num).toDouble(),
      otherLoadInKw: (json['otherLoadInKw'] as num).toDouble(),
      rPhaseCurrent: (json['rPhaseCurrent'] as num).toDouble(),
      yPhaseCurrent: (json['yPhaseCurrent'] as num).toDouble(),
      bPhaseCurrent: (json['bPhaseCurrent'] as num).toDouble(),
      nPhaseCurrent: (json['nPhaseCurrent'] as num).toDouble(),
      otherObservationsByLm: json['otherObservationsByLm'],
      reportSubmitDate: DateTime.parse(json['reportSubmitDate']),
      deviceId: json['deviceId'],
      status: json['status'],
      distbuCode: json['distbuCode'],
      employeeMasterEntityByLmEmpId: EmployeeMasterEntityByLmEmpId.fromJson(json['employeeMasterEntityByLmEmpId']),
      employeeMasterEntityByAeEmpId: EmployeeMasterEntityByLmEmpId.fromJson(json['employeeMasterEntityByAeEmpId']),
      maintenanceSheetId: json['maintenanceSheetId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sheetId': sheetId,
      'sectionCode': sectionCode,
      'equipmentCode': equipmentCode,
      'sectionName': sectionName,
      'lmEmpId': lmEmpId,
      'aeEmpId': aeEmpId,
      'insertDate': insertDate,
      'structureCode': structureCode,
      'structureCapacity': structureCapacity,
      'abSwitchAvailable': abSwitchAvailable,
      'abSwitchType': abSwitchType,
      'abSwitchStatus': abSwitchStatus,
      'abContactsDamaged': abContactsDamaged,
      'abBrassStripDamaged': abBrassStripDamaged,
      'nylonBushDamaged': nylonBushDamaged,
      'hG11KvFuseSetAvailable': hG11KvFuseSetAvailable,
      'hornsToBeReplaced': hornsToBeReplaced,
      'gapIsNotCorrect': gapIsNotCorrect,
      'hgFuseSetPostTypeInsulatorsCount': hgFuseSetPostTypeInsulatorsCount,
      'htBushesDamageCount': htBushesDamageCount,
      'htBushRodsDamCount': htBushRodsDamCount,
      'ltBushesDamageCount': ltBushesDamageCount,
      'ltBushRodsDamCount': ltBushRodsDamCount,
      'ltBiMetalClampsAvailable': ltBiMetalClampsAvailable,
      'ltBiMetalClampsDamCount': ltBiMetalClampsDamCount,
      'oilShortageInLiters': oilShortageInLiters,
      'oilLeakage': oilLeakage,
      'gasketsDamaged': gasketsDamaged,
      'ltBreaker': ltBreaker,
      'ltBreakerStatus': ltBreakerStatus,
      'ltFuseSetAvailable': ltFuseSetAvailable,
      'diaphragmStatus': diaphragmStatus,
      'ltFuseSetStatus': ltFuseSetStatus,
      'ltFuseWire': ltFuseWire,
      'ltPvcCable': ltPvcCable,
      'ltPvcCableStatus': ltPvcCableStatus,
      'lightningArrestors': lightningArrestors,
      'earthPits': earthPits,
      'earthPipes': earthPipes,
      'earthPipesStatus': earthPipesStatus,
      'earthing': earthing,
      'doubleEarthing': doubleEarthing,
      'noOfLooseLinesOnDtr': noOfLooseLinesOnDtr,
      'treeCuttingRequired': treeCuttingRequired,
      'dtrAglLoadHp': dtrAglLoadHp,
      'domesticNonDomLoad': domesticNonDomLoad,
      'industrialLoadInHp': industrialLoadInHp,
      'waterWorksLoadInHp': waterWorksLoadInHp,
      'otherLoadInKw': otherLoadInKw,
      'rPhaseCurrent': rPhaseCurrent,
      'yPhaseCurrent': yPhaseCurrent,
      'bPhaseCurrent': bPhaseCurrent,
      'nPhaseCurrent': nPhaseCurrent,
      'otherObservationsByLm': otherObservationsByLm,
      'reportSubmitDate': reportSubmitDate.toIso8601String(),
      'deviceId': deviceId,
      'status': status,
      'distbuCode': distbuCode,
      'employeeMasterEntityByLmEmpId': employeeMasterEntityByLmEmpId.toJson(),
      'employeeMasterEntityByAeEmpId': employeeMasterEntityByAeEmpId.toJson(),
      'maintenanceSheetId':maintenanceSheetId
    };
  }
}

class EmployeeMasterEntityByLmEmpId {
  String? empId;
  String? empAdhaarNumber;
  String? epfAcno;
  String? epfUan;
  dynamic gpfAcno;
  String? bankAcno;
  String? pancardNumber;
  String? empName;
  String? empSurname;
  String? empFatherName;
  String? dateOfBirth;
  String? dateOfJoining;
  String? designation;
  String? cityRuralFlag;
  dynamic incrementRevisionDate;
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

  EmployeeMasterEntityByLmEmpId({
    required this.empId,
    required this.empName,
    required this.designation,
    required this.gender,
    this.empAdhaarNumber,
    this.epfAcno,
    this.epfUan,
    this.gpfAcno,
    this.bankAcno,
    this.pancardNumber,
    this.empSurname,
    this.empFatherName,
    this.dateOfBirth,
    this.dateOfJoining,
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

   EmployeeMasterEntityByLmEmpId.fromJson( dynamic json) {

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

  Map<String, dynamic> toJson() {
    return {
      'empId': empId,
      'empAdhaarNumber': empAdhaarNumber,
      'epfAcno': epfAcno,
      'epfUan': epfUan,
      'gpfAcno': gpfAcno,
      'bankAcno': bankAcno,
      'pancardNumber': pancardNumber,
      'empName': empName,
      'empSurname': empSurname,
      'empFatherName': empFatherName,
      'dateOfBirth': dateOfBirth,
      'dateOfJoining': dateOfJoining,
      'designation': designation,
      'cityRuralFlag': cityRuralFlag,
      'incrementRevisionDate': incrementRevisionDate,
      'eroCode': eroCode,
      'unitCode': unitCode,
      'divisionCode': divisionCode,
      'userLogId': userLogId,
      'empStatus': empStatus,
      'basic': basic,
      'payStatus': payStatus,
      'payMonthYear': payMonthYear,
      'billCode': billCode,
      'locationType': locationType,
      'locationCode': locationCode,
      'locationName': locationName,
      'empType': empType,
      'changeReturnGroup': changeReturnGroup,
      'gender': gender,
      'qr': qr,
      'rps': rps,
      'bankCode': bankCode,
      'designationCode': designationCode,
      'mobileno': mobileno,
      'personalMobileNo': personalMobileNo,
      'ofcMobileNo': ofcMobileNo,
      'empPost': empPost,
      'smartLogin': smartLogin,
      'sectionCode': sectionCode,
      'ofcType': ofcType,
      'ofcCode': ofcCode,
      'wing': wing,
      'pensioncode': pensioncode,
      'ppono': ppono,
      'familypensionerName': familypensionerName,
      'familypensionerAmount': familypensionerAmount,
      'pensioncommutedAmount': pensioncommutedAmount,
      'pensioncommutedDate': pensioncommutedDate,
      'reducedpensionDate': reducedpensionDate,
      'dateOfRetirement': dateOfRetirement,
      'allowEbsAndroidApp': allowEbsAndroidApp,
      'facDocument': facDocument,
      'otp': otp,
      'otpDate': otpDate,
      'rcEro': rcEro,
      'rcCode': rcCode,
      'rcFlag': rcFlag,
      'rcMonth': rcMonth,
      'rcAuthDevice': rcAuthDevice,
      'rcAuthDeviceDate': rcAuthDeviceDate,
      'isSsOp': isSsOp,
      'ssOpSsCode': ssOpSsCode,
    };
  }
}



