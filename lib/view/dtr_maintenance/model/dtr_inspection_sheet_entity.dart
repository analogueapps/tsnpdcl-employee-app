import 'dart:convert';

DtrInspectionSheetEntity dtrInspectionSheetEntityFromJson(String str) =>
    DtrInspectionSheetEntity.fromJson(json.decode(str));

String dtrInspectionSheetEntityToJson(DtrInspectionSheetEntity data) =>
    json.encode(data.toJson());

class DtrInspectionSheetEntity {
  DtrInspectionSheetEntity({
    this.sheetId,
    this.sectionCode,
    this.equipmentCode,
    this.sectionName,
    this.lmEmpId,
    this.aeEmpId,
    this.insertDate,
    this.structureCode,
    this.structureCapacity,
    this.abSwitchAvailable,
    this.abSwitchType,
    this.abSwitchStatus,
    this.abContactsDamaged,
    this.abBrassStripDamaged,
    this.nylonBushDamaged,
    this.hG11KvFuseSetAvailable,
    this.hornsToBeReplaced,
    this.gapIsNotCorrect,
    this.hgFuseSetPostTypeInsulatorsCount,
    this.htBushesDamageCount,
    this.htBushRodsDamCount,
    this.ltBushesDamageCount,
    this.ltBushRodsDamCount,
    this.ltBiMetalClampsAvailable,
    this.ltBiMetalClampsDamCount,
    this.oilShortageInLiters,
    this.oilLeakage,
    this.gasketsDamaged,
    this.ltBreaker,
    this.ltBreakerStatus,
    this.ltFuseSetAvailable,
    this.diaphragmStatus,
    this.ltFuseSetStatus,
    this.ltFuseWire,
    this.ltPvcCable,
    this.ltPvcCableStatus,
    this.lightningArrestors,
    this.earthPits,
    this.earthPipes,
    this.earthPipesStatus,
    this.earthing,
    this.doubleEarthing,
    this.noOfLooseLinesOnDtr,
    this.treeCuttingRequired,
    this.dtrAglLoadHp,
    this.domesticNonDomLoad,
    this.industrialLoadInHp,
    this.waterWorksLoadInHp,
    this.otherLoadInKw,
    this.rPhaseCurrent,
    this.yPhaseCurrent,
    this.bPhaseCurrent,
    this.nPhaseCurrent,
    this.otherObservationsByLm,
    this.reportSubmitDate,
    this.deviceId,
    this.status,
    this.distbuCode,
    this.employeeMasterEntityByLmEmpId,
    this.employeeMasterEntityByAeEmpId,
    this.maintenanceSheetId,
    this.dtrPostMaintenanceSheetEntityByMaintenanceSheetId,
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

  DtrInspectionSheetEntity.fromJson(dynamic json) {
    sheetId = json['sheetId'];
    sectionCode = json['sectionCode'];
    equipmentCode = json['equipmentCode'];
    sectionName = json['sectionName'];
    lmEmpId = json['lmEmpId'];
    aeEmpId = json['aeEmpId'];
    insertDate = json['insertDate'];
    structureCode = json['structureCode'];
    structureCapacity = json['structureCapacity'];
    abSwitchAvailable = json['abSwitchAvailable'];
    abSwitchType = json['abSwitchType'];
    abSwitchStatus = json['abSwitchStatus'];
    abContactsDamaged = json['abContactsDamaged'];
    abBrassStripDamaged = json['abBrassStripDamaged'];
    nylonBushDamaged = json['nylonBushDamaged'];
    hG11KvFuseSetAvailable = json['hG11KvFuseSetAvailable'];
    hornsToBeReplaced = json['hornsToBeReplaced'];
    gapIsNotCorrect = json['gapIsNotCorrect'];
    hgFuseSetPostTypeInsulatorsCount = json['hgFuseSetPostTypeInsulatorsCount'];
    htBushesDamageCount = json['htBushesDamageCount'];
    htBushRodsDamCount = json['htBushRodsDamCount'];
    ltBushesDamageCount = json['ltBushesDamageCount'];
    ltBushRodsDamCount = json['ltBushRodsDamCount'];
    ltBiMetalClampsAvailable = json['ltBiMetalClampsAvailable'];
    ltBiMetalClampsDamCount = json['ltBiMetalClampsDamCount'];
    oilShortageInLiters = json['oilShortageInLiters'];
    oilLeakage = json['oilLeakage'];
    gasketsDamaged = json['gasketsDamaged'];
    ltBreaker = json['ltBreaker'];
    ltBreakerStatus = json['ltBreakerStatus'];
    ltFuseSetAvailable = json['ltFuseSetAvailable'];
    diaphragmStatus = json['diaphragmStatus'];
    ltFuseSetStatus = json['ltFuseSetStatus'];
    ltFuseWire = json['ltFuseWire'];
    ltPvcCable = json['ltPvcCable'];
    ltPvcCableStatus = json['ltPvcCableStatus'];
    lightningArrestors = json['lightningArrestors'];
    earthPits = json['earthPits'];
    earthPipes = json['earthPipes'];
    earthPipesStatus = json['earthPipesStatus'];
    earthing = json['earthing'];
    doubleEarthing = json['doubleEarthing'];
    noOfLooseLinesOnDtr = json['noOfLooseLinesOnDtr'];
    treeCuttingRequired = json['treeCuttingRequired'];
    dtrAglLoadHp = json['dtrAglLoadHp'];
    domesticNonDomLoad = json['domesticNonDomLoad'];
    industrialLoadInHp = json['industrialLoadInHp'];
    waterWorksLoadInHp = json['waterWorksLoadInHp'];
    otherLoadInKw = json['otherLoadInKw'];
    rPhaseCurrent = json['rPhaseCurrent'];
    yPhaseCurrent = json['yPhaseCurrent'];
    bPhaseCurrent = json['bPhaseCurrent'];
    nPhaseCurrent = json['nPhaseCurrent'];
    otherObservationsByLm = json['otherObservationsByLm'];
    reportSubmitDate = json['reportSubmitDate'];
    deviceId = json['deviceId'];
    status = json['status'];
    distbuCode = json['distbuCode'];
    employeeMasterEntityByLmEmpId =
        json['employeeMasterEntityByLmEmpId'] != null
            ? EmployeeMasterEntityByLmEmpId.fromJson(
                json['employeeMasterEntityByLmEmpId'])
            : null;
    employeeMasterEntityByAeEmpId =
        json['employeeMasterEntityByAeEmpId'] != null
            ? EmployeeMasterEntityByAeEmpId.fromJson(
                json['employeeMasterEntityByAeEmpId'])
            : null;
    maintenanceSheetId = json['maintenanceSheetId'];
    dtrPostMaintenanceSheetEntityByMaintenanceSheetId =
        json['dtrPostMaintenanceSheetEntityByMaintenanceSheetId'];
    dtrFencingRequired = json['dtrFencingRequired'];
    dtrPlinthAsPerStandards = json['dtrPlinthAsPerStandards'];
    dtrSurroundingNeatlyMaintained = json['dtrSurroundingNeatlyMaintained'];
    entryType = json['entryType'];
    scheduledDate = json['scheduledDate'];
    scheduledMonth = json['scheduledMonth'];
    beforeMaintenanceImage = json['beforeMaintenanceImage'];
    beforeLat = json['beforeLat'];
    beforeLon = json['beforeLon'];
  }

  num? sheetId;
  String? sectionCode;
  dynamic equipmentCode;
  String? sectionName;
  String? lmEmpId;
  String? aeEmpId;
  String? insertDate;
  String? structureCode;
  dynamic structureCapacity;
  dynamic abSwitchAvailable;
  dynamic abSwitchType;
  dynamic abSwitchStatus;
  dynamic abContactsDamaged;
  dynamic abBrassStripDamaged;
  dynamic nylonBushDamaged;
  dynamic hG11KvFuseSetAvailable;
  dynamic hornsToBeReplaced;
  dynamic gapIsNotCorrect;
  dynamic hgFuseSetPostTypeInsulatorsCount;
  dynamic htBushesDamageCount;
  dynamic htBushRodsDamCount;
  dynamic ltBushesDamageCount;
  dynamic ltBushRodsDamCount;
  dynamic ltBiMetalClampsAvailable;
  dynamic ltBiMetalClampsDamCount;
  dynamic oilShortageInLiters;
  dynamic oilLeakage;
  dynamic gasketsDamaged;
  dynamic ltBreaker;
  dynamic ltBreakerStatus;
  dynamic ltFuseSetAvailable;
  dynamic diaphragmStatus;
  dynamic ltFuseSetStatus;
  dynamic ltFuseWire;
  dynamic ltPvcCable;
  dynamic ltPvcCableStatus;
  dynamic lightningArrestors;
  dynamic earthPits;
  dynamic earthPipes;
  dynamic earthPipesStatus;
  dynamic earthing;
  dynamic doubleEarthing;
  dynamic noOfLooseLinesOnDtr;
  dynamic treeCuttingRequired;
  dynamic dtrAglLoadHp;
  dynamic domesticNonDomLoad;
  dynamic industrialLoadInHp;
  dynamic waterWorksLoadInHp;
  dynamic otherLoadInKw;
  dynamic rPhaseCurrent;
  dynamic yPhaseCurrent;
  dynamic bPhaseCurrent;
  dynamic nPhaseCurrent;
  dynamic otherObservationsByLm;
  dynamic reportSubmitDate;
  dynamic deviceId;
  String? status;
  dynamic distbuCode;
  EmployeeMasterEntityByLmEmpId? employeeMasterEntityByLmEmpId;
  EmployeeMasterEntityByAeEmpId? employeeMasterEntityByAeEmpId;
  dynamic maintenanceSheetId;
  dynamic dtrPostMaintenanceSheetEntityByMaintenanceSheetId;
  dynamic dtrFencingRequired;
  dynamic dtrPlinthAsPerStandards;
  dynamic dtrSurroundingNeatlyMaintained;
  dynamic entryType;
  dynamic scheduledDate;
  dynamic scheduledMonth;
  dynamic beforeMaintenanceImage;
  dynamic beforeLat;
  dynamic beforeLon;

  DtrInspectionSheetEntity copyWith({
    num? sheetId,
    String? sectionCode,
    dynamic equipmentCode,
    String? sectionName,
    String? lmEmpId,
    String? aeEmpId,
    String? insertDate,
    String? structureCode,
    dynamic structureCapacity,
    dynamic abSwitchAvailable,
    dynamic abSwitchType,
    dynamic abSwitchStatus,
    dynamic abContactsDamaged,
    dynamic abBrassStripDamaged,
    dynamic nylonBushDamaged,
    dynamic hG11KvFuseSetAvailable,
    dynamic hornsToBeReplaced,
    dynamic gapIsNotCorrect,
    dynamic hgFuseSetPostTypeInsulatorsCount,
    dynamic htBushesDamageCount,
    dynamic htBushRodsDamCount,
    dynamic ltBushesDamageCount,
    dynamic ltBushRodsDamCount,
    dynamic ltBiMetalClampsAvailable,
    dynamic ltBiMetalClampsDamCount,
    dynamic oilShortageInLiters,
    dynamic oilLeakage,
    dynamic gasketsDamaged,
    dynamic ltBreaker,
    dynamic ltBreakerStatus,
    dynamic ltFuseSetAvailable,
    dynamic diaphragmStatus,
    dynamic ltFuseSetStatus,
    dynamic ltFuseWire,
    dynamic ltPvcCable,
    dynamic ltPvcCableStatus,
    dynamic lightningArrestors,
    dynamic earthPits,
    dynamic earthPipes,
    dynamic earthPipesStatus,
    dynamic earthing,
    dynamic doubleEarthing,
    dynamic noOfLooseLinesOnDtr,
    dynamic treeCuttingRequired,
    dynamic dtrAglLoadHp,
    dynamic domesticNonDomLoad,
    dynamic industrialLoadInHp,
    dynamic waterWorksLoadInHp,
    dynamic otherLoadInKw,
    dynamic rPhaseCurrent,
    dynamic yPhaseCurrent,
    dynamic bPhaseCurrent,
    dynamic nPhaseCurrent,
    dynamic otherObservationsByLm,
    dynamic reportSubmitDate,
    dynamic deviceId,
    String? status,
    dynamic distbuCode,
    EmployeeMasterEntityByLmEmpId? employeeMasterEntityByLmEmpId,
    EmployeeMasterEntityByAeEmpId? employeeMasterEntityByAeEmpId,
    dynamic maintenanceSheetId,
    dynamic dtrPostMaintenanceSheetEntityByMaintenanceSheetId,
    dynamic dtrFencingRequired,
    dynamic dtrPlinthAsPerStandards,
    dynamic dtrSurroundingNeatlyMaintained,
    dynamic entryType,
    dynamic scheduledDate,
    dynamic scheduledMonth,
    dynamic beforeMaintenanceImage,
    dynamic beforeLat,
    dynamic beforeLon,
  }) =>
      DtrInspectionSheetEntity(
        sheetId: sheetId ?? this.sheetId,
        sectionCode: sectionCode ?? this.sectionCode,
        equipmentCode: equipmentCode ?? this.equipmentCode,
        sectionName: sectionName ?? this.sectionName,
        lmEmpId: lmEmpId ?? this.lmEmpId,
        aeEmpId: aeEmpId ?? this.aeEmpId,
        insertDate: insertDate ?? this.insertDate,
        structureCode: structureCode ?? this.structureCode,
        structureCapacity: structureCapacity ?? this.structureCapacity,
        abSwitchAvailable: abSwitchAvailable ?? this.abSwitchAvailable,
        abSwitchType: abSwitchType ?? this.abSwitchType,
        abSwitchStatus: abSwitchStatus ?? this.abSwitchStatus,
        abContactsDamaged: abContactsDamaged ?? this.abContactsDamaged,
        abBrassStripDamaged: abBrassStripDamaged ?? this.abBrassStripDamaged,
        nylonBushDamaged: nylonBushDamaged ?? this.nylonBushDamaged,
        hG11KvFuseSetAvailable:
            hG11KvFuseSetAvailable ?? this.hG11KvFuseSetAvailable,
        hornsToBeReplaced: hornsToBeReplaced ?? this.hornsToBeReplaced,
        gapIsNotCorrect: gapIsNotCorrect ?? this.gapIsNotCorrect,
        hgFuseSetPostTypeInsulatorsCount: hgFuseSetPostTypeInsulatorsCount ??
            this.hgFuseSetPostTypeInsulatorsCount,
        htBushesDamageCount: htBushesDamageCount ?? this.htBushesDamageCount,
        htBushRodsDamCount: htBushRodsDamCount ?? this.htBushRodsDamCount,
        ltBushesDamageCount: ltBushesDamageCount ?? this.ltBushesDamageCount,
        ltBushRodsDamCount: ltBushRodsDamCount ?? this.ltBushRodsDamCount,
        ltBiMetalClampsAvailable:
            ltBiMetalClampsAvailable ?? this.ltBiMetalClampsAvailable,
        ltBiMetalClampsDamCount:
            ltBiMetalClampsDamCount ?? this.ltBiMetalClampsDamCount,
        oilShortageInLiters: oilShortageInLiters ?? this.oilShortageInLiters,
        oilLeakage: oilLeakage ?? this.oilLeakage,
        gasketsDamaged: gasketsDamaged ?? this.gasketsDamaged,
        ltBreaker: ltBreaker ?? this.ltBreaker,
        ltBreakerStatus: ltBreakerStatus ?? this.ltBreakerStatus,
        ltFuseSetAvailable: ltFuseSetAvailable ?? this.ltFuseSetAvailable,
        diaphragmStatus: diaphragmStatus ?? this.diaphragmStatus,
        ltFuseSetStatus: ltFuseSetStatus ?? this.ltFuseSetStatus,
        ltFuseWire: ltFuseWire ?? this.ltFuseWire,
        ltPvcCable: ltPvcCable ?? this.ltPvcCable,
        ltPvcCableStatus: ltPvcCableStatus ?? this.ltPvcCableStatus,
        lightningArrestors: lightningArrestors ?? this.lightningArrestors,
        earthPits: earthPits ?? this.earthPits,
        earthPipes: earthPipes ?? this.earthPipes,
        earthPipesStatus: earthPipesStatus ?? this.earthPipesStatus,
        earthing: earthing ?? this.earthing,
        doubleEarthing: doubleEarthing ?? this.doubleEarthing,
        noOfLooseLinesOnDtr: noOfLooseLinesOnDtr ?? this.noOfLooseLinesOnDtr,
        treeCuttingRequired: treeCuttingRequired ?? this.treeCuttingRequired,
        dtrAglLoadHp: dtrAglLoadHp ?? this.dtrAglLoadHp,
        domesticNonDomLoad: domesticNonDomLoad ?? this.domesticNonDomLoad,
        industrialLoadInHp: industrialLoadInHp ?? this.industrialLoadInHp,
        waterWorksLoadInHp: waterWorksLoadInHp ?? this.waterWorksLoadInHp,
        otherLoadInKw: otherLoadInKw ?? this.otherLoadInKw,
        rPhaseCurrent: rPhaseCurrent ?? this.rPhaseCurrent,
        yPhaseCurrent: yPhaseCurrent ?? this.yPhaseCurrent,
        bPhaseCurrent: bPhaseCurrent ?? this.bPhaseCurrent,
        nPhaseCurrent: nPhaseCurrent ?? this.nPhaseCurrent,
        otherObservationsByLm:
            otherObservationsByLm ?? this.otherObservationsByLm,
        reportSubmitDate: reportSubmitDate ?? this.reportSubmitDate,
        deviceId: deviceId ?? this.deviceId,
        status: status ?? this.status,
        distbuCode: distbuCode ?? this.distbuCode,
        employeeMasterEntityByLmEmpId:
            employeeMasterEntityByLmEmpId ?? this.employeeMasterEntityByLmEmpId,
        employeeMasterEntityByAeEmpId:
            employeeMasterEntityByAeEmpId ?? this.employeeMasterEntityByAeEmpId,
        maintenanceSheetId: maintenanceSheetId ?? this.maintenanceSheetId,
        dtrPostMaintenanceSheetEntityByMaintenanceSheetId:
            dtrPostMaintenanceSheetEntityByMaintenanceSheetId ??
                this.dtrPostMaintenanceSheetEntityByMaintenanceSheetId,
        dtrFencingRequired: dtrFencingRequired ?? this.dtrFencingRequired,
        dtrPlinthAsPerStandards:
            dtrPlinthAsPerStandards ?? this.dtrPlinthAsPerStandards,
        dtrSurroundingNeatlyMaintained: dtrSurroundingNeatlyMaintained ??
            this.dtrSurroundingNeatlyMaintained,
        entryType: entryType ?? this.entryType,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        scheduledMonth: scheduledMonth ?? this.scheduledMonth,
        beforeMaintenanceImage:
            beforeMaintenanceImage ?? this.beforeMaintenanceImage,
        beforeLat: beforeLat ?? this.beforeLat,
        beforeLon: beforeLon ?? this.beforeLon,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sheetId'] = sheetId;
    map['sectionCode'] = sectionCode;
    map['equipmentCode'] = equipmentCode;
    map['sectionName'] = sectionName;
    map['lmEmpId'] = lmEmpId;
    map['aeEmpId'] = aeEmpId;
    map['insertDate'] = insertDate;
    map['structureCode'] = structureCode;
    map['structureCapacity'] = structureCapacity;
    map['abSwitchAvailable'] = abSwitchAvailable;
    map['abSwitchType'] = abSwitchType;
    map['abSwitchStatus'] = abSwitchStatus;
    map['abContactsDamaged'] = abContactsDamaged;
    map['abBrassStripDamaged'] = abBrassStripDamaged;
    map['nylonBushDamaged'] = nylonBushDamaged;
    map['hG11KvFuseSetAvailable'] = hG11KvFuseSetAvailable;
    map['hornsToBeReplaced'] = hornsToBeReplaced;
    map['gapIsNotCorrect'] = gapIsNotCorrect;
    map['hgFuseSetPostTypeInsulatorsCount'] = hgFuseSetPostTypeInsulatorsCount;
    map['htBushesDamageCount'] = htBushesDamageCount;
    map['htBushRodsDamCount'] = htBushRodsDamCount;
    map['ltBushesDamageCount'] = ltBushesDamageCount;
    map['ltBushRodsDamCount'] = ltBushRodsDamCount;
    map['ltBiMetalClampsAvailable'] = ltBiMetalClampsAvailable;
    map['ltBiMetalClampsDamCount'] = ltBiMetalClampsDamCount;
    map['oilShortageInLiters'] = oilShortageInLiters;
    map['oilLeakage'] = oilLeakage;
    map['gasketsDamaged'] = gasketsDamaged;
    map['ltBreaker'] = ltBreaker;
    map['ltBreakerStatus'] = ltBreakerStatus;
    map['ltFuseSetAvailable'] = ltFuseSetAvailable;
    map['diaphragmStatus'] = diaphragmStatus;
    map['ltFuseSetStatus'] = ltFuseSetStatus;
    map['ltFuseWire'] = ltFuseWire;
    map['ltPvcCable'] = ltPvcCable;
    map['ltPvcCableStatus'] = ltPvcCableStatus;
    map['lightningArrestors'] = lightningArrestors;
    map['earthPits'] = earthPits;
    map['earthPipes'] = earthPipes;
    map['earthPipesStatus'] = earthPipesStatus;
    map['earthing'] = earthing;
    map['doubleEarthing'] = doubleEarthing;
    map['noOfLooseLinesOnDtr'] = noOfLooseLinesOnDtr;
    map['treeCuttingRequired'] = treeCuttingRequired;
    map['dtrAglLoadHp'] = dtrAglLoadHp;
    map['domesticNonDomLoad'] = domesticNonDomLoad;
    map['industrialLoadInHp'] = industrialLoadInHp;
    map['waterWorksLoadInHp'] = waterWorksLoadInHp;
    map['otherLoadInKw'] = otherLoadInKw;
    map['rPhaseCurrent'] = rPhaseCurrent;
    map['yPhaseCurrent'] = yPhaseCurrent;
    map['bPhaseCurrent'] = bPhaseCurrent;
    map['nPhaseCurrent'] = nPhaseCurrent;
    map['otherObservationsByLm'] = otherObservationsByLm;
    map['reportSubmitDate'] = reportSubmitDate;
    map['deviceId'] = deviceId;
    map['status'] = status;
    map['distbuCode'] = distbuCode;
    if (employeeMasterEntityByLmEmpId != null) {
      map['employeeMasterEntityByLmEmpId'] =
          employeeMasterEntityByLmEmpId?.toJson();
    }
    if (employeeMasterEntityByAeEmpId != null) {
      map['employeeMasterEntityByAeEmpId'] =
          employeeMasterEntityByAeEmpId?.toJson();
    }
    map['maintenanceSheetId'] = maintenanceSheetId;
    map['dtrPostMaintenanceSheetEntityByMaintenanceSheetId'] =
        dtrPostMaintenanceSheetEntityByMaintenanceSheetId;
    map['dtrFencingRequired'] = dtrFencingRequired;
    map['dtrPlinthAsPerStandards'] = dtrPlinthAsPerStandards;
    map['dtrSurroundingNeatlyMaintained'] = dtrSurroundingNeatlyMaintained;
    map['entryType'] = entryType;
    map['scheduledDate'] = scheduledDate;
    map['scheduledMonth'] = scheduledMonth;
    map['beforeMaintenanceImage'] = beforeMaintenanceImage;
    map['beforeLat'] = beforeLat;
    map['beforeLon'] = beforeLon;
    return map;
  }
}

EmployeeMasterEntityByAeEmpId employeeMasterEntityByAeEmpIdFromJson(
        String str) =>
    EmployeeMasterEntityByAeEmpId.fromJson(json.decode(str));

String employeeMasterEntityByAeEmpIdToJson(
        EmployeeMasterEntityByAeEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByAeEmpId {
  EmployeeMasterEntityByAeEmpId({
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

  EmployeeMasterEntityByAeEmpId.fromJson(dynamic json) {
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

  EmployeeMasterEntityByAeEmpId copyWith({
    String? empId,
    String? empAdhaarNumber,
    String? epfAcno,
    String? epfUan,
    dynamic gpfAcno,
    String? bankAcno,
    String? pancardNumber,
    String? empName,
    String? empSurname,
    String? empFatherName,
    String? dateOfBirth,
    String? dateOfJoining,
    String? designation,
    String? cityRuralFlag,
    dynamic incrementRevisionDate,
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
      EmployeeMasterEntityByAeEmpId(
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

EmployeeMasterEntityByLmEmpId employeeMasterEntityByLmEmpIdFromJson(
        String str) =>
    EmployeeMasterEntityByLmEmpId.fromJson(json.decode(str));

String employeeMasterEntityByLmEmpIdToJson(
        EmployeeMasterEntityByLmEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByLmEmpId {
  EmployeeMasterEntityByLmEmpId({
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

  EmployeeMasterEntityByLmEmpId.fromJson(dynamic json) {
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
  String? epfAcno;
  String? epfUan;
  dynamic gpfAcno;
  String? bankAcno;
  String? pancardNumber;
  String? empName;
  dynamic empSurname;
  dynamic empFatherName;
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
  String? otp;
  String? otpDate;
  dynamic rcEro;
  dynamic rcCode;
  dynamic rcFlag;
  dynamic rcMonth;
  dynamic rcAuthDevice;
  dynamic rcAuthDeviceDate;
  dynamic isSsOp;
  dynamic ssOpSsCode;

  EmployeeMasterEntityByLmEmpId copyWith({
    String? empId,
    dynamic empAdhaarNumber,
    String? epfAcno,
    String? epfUan,
    dynamic gpfAcno,
    String? bankAcno,
    String? pancardNumber,
    String? empName,
    dynamic empSurname,
    dynamic empFatherName,
    String? dateOfBirth,
    String? dateOfJoining,
    String? designation,
    String? cityRuralFlag,
    dynamic incrementRevisionDate,
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
    String? otp,
    String? otpDate,
    dynamic rcEro,
    dynamic rcCode,
    dynamic rcFlag,
    dynamic rcMonth,
    dynamic rcAuthDevice,
    dynamic rcAuthDeviceDate,
    dynamic isSsOp,
    dynamic ssOpSsCode,
  }) =>
      EmployeeMasterEntityByLmEmpId(
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
