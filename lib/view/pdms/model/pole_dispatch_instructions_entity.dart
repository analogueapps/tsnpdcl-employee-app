import 'dart:convert';

PoleDispatchInstructionsEntity poleDispatchInstructionsEntityFromJson(
        String str) =>
    PoleDispatchInstructionsEntity.fromJson(json.decode(str));

String poleDispatchInstructionsEntityToJson(
        PoleDispatchInstructionsEntity data) =>
    json.encode(data.toJson());

class PoleDispatchInstructionsEntity {
  PoleDispatchInstructionsEntity({
    this.dispatchInstructionId,
    this.purchaseOrderNo,
    this.qtyToBeDispatched,
    this.diDate,
    this.diAdeEmpId,
    this.sectionId,
    this.section,
    this.erstCircleId,
    this.diStatus,
    this.firmId,
    this.deliveredQty,
    this.dispatchedQty,
    this.dispatchPendingQty,
    this.verifiedQty,
    this.form13IssuedQty,
    this.form13IssuedDate,
    this.form13IssuedEmpId,
    this.employeeMasterEntityByDiAdeEmpId,
    this.polePurchaseOrdersEntityByPurchaseOrderNo,
    this.employeeMasterEntityByForm13IssuedEmpId,
    this.poleManufacturingFirmEntityByFirmId,
    this.poleDumpedLocationEntitiesByDispatchInstructionsId,
    this.poleTransportEntitiesByDispatchInstructionsId,
  });

  PoleDispatchInstructionsEntity.fromJson(dynamic json) {
    dispatchInstructionId = json['dispatchInstructionId'];
    purchaseOrderNo = json['purchaseOrderNo'];
    qtyToBeDispatched = json['qtyToBeDispatched'];
    diDate = json['diDate'];
    diAdeEmpId = json['diAdeEmpId'];
    sectionId = json['sectionId'];
    section = json['section'];
    erstCircleId = json['erstCircleId'];
    diStatus = json['diStatus'];
    firmId = json['firmId'];
    deliveredQty = json['deliveredQty'];
    dispatchedQty = json['dispatchedQty'];
    dispatchPendingQty = json['dispatchPendingQty'];
    verifiedQty = json['verifiedQty'];
    form13IssuedQty = json['form13IssuedQty'];
    form13IssuedDate = json['form13IssuedDate'];
    form13IssuedEmpId = json['form13IssuedEmpId'];
    employeeMasterEntityByDiAdeEmpId =
        json['employeeMasterEntityByDiAdeEmpId'] != null
            ? EmployeeMasterEntityByDiAdeEmpId.fromJson(
                json['employeeMasterEntityByDiAdeEmpId'])
            : null;
    polePurchaseOrdersEntityByPurchaseOrderNo =
        json['polePurchaseOrdersEntityByPurchaseOrderNo'] != null
            ? PolePurchaseOrdersEntityByPurchaseOrderNo.fromJson(
                json['polePurchaseOrdersEntityByPurchaseOrderNo'])
            : null;
    employeeMasterEntityByForm13IssuedEmpId =
        json['employeeMasterEntityByForm13IssuedEmpId'] != null
            ? EmployeeMasterEntityByForm13IssuedEmpId.fromJson(
                json['employeeMasterEntityByForm13IssuedEmpId'])
            : null;
    poleManufacturingFirmEntityByFirmId =
        json['poleManufacturingFirmEntityByFirmId'] != null
            ? PoleManufacturingFirmEntityByFirmId.fromJson(
                json['poleManufacturingFirmEntityByFirmId'])
            : null;
    if (json['poleDumpedLocationEntitiesByDispatchInstructionsId'] != null) {
      poleDumpedLocationEntitiesByDispatchInstructionsId = [];
      json['poleDumpedLocationEntitiesByDispatchInstructionsId'].forEach((v) {
        poleDumpedLocationEntitiesByDispatchInstructionsId?.add(
            PoleDumpedLocationEntitiesByDispatchInstructionsId.fromJson(v));
      });
    }
    if (json['poleTransportEntitiesByDispatchInstructionsId'] != null) {
      poleTransportEntitiesByDispatchInstructionsId = [];
      json['poleTransportEntitiesByDispatchInstructionsId'].forEach((v) {
        poleTransportEntitiesByDispatchInstructionsId
            ?.add(PoleTransportEntitiesByDispatchInstructionsId.fromJson(v));
      });
    }
  }

  num? dispatchInstructionId;
  String? purchaseOrderNo;
  num? qtyToBeDispatched;
  String? diDate;
  String? diAdeEmpId;
  String? sectionId;
  String? section;
  num? erstCircleId;
  String? diStatus;
  num? firmId;
  num? deliveredQty;
  num? dispatchedQty;
  num? dispatchPendingQty;
  num? verifiedQty;
  num? form13IssuedQty;
  String? form13IssuedDate;
  String? form13IssuedEmpId;
  EmployeeMasterEntityByDiAdeEmpId? employeeMasterEntityByDiAdeEmpId;
  PolePurchaseOrdersEntityByPurchaseOrderNo?
      polePurchaseOrdersEntityByPurchaseOrderNo;
  EmployeeMasterEntityByForm13IssuedEmpId?
      employeeMasterEntityByForm13IssuedEmpId;
  PoleManufacturingFirmEntityByFirmId? poleManufacturingFirmEntityByFirmId;
  List<PoleDumpedLocationEntitiesByDispatchInstructionsId>?
      poleDumpedLocationEntitiesByDispatchInstructionsId;
  List<PoleTransportEntitiesByDispatchInstructionsId>?
      poleTransportEntitiesByDispatchInstructionsId;

  PoleDispatchInstructionsEntity copyWith({
    num? dispatchInstructionId,
    String? purchaseOrderNo,
    num? qtyToBeDispatched,
    String? diDate,
    String? diAdeEmpId,
    String? sectionId,
    String? section,
    num? erstCircleId,
    String? diStatus,
    num? firmId,
    num? deliveredQty,
    num? dispatchedQty,
    num? dispatchPendingQty,
    num? verifiedQty,
    num? form13IssuedQty,
    String? form13IssuedDate,
    String? form13IssuedEmpId,
    EmployeeMasterEntityByDiAdeEmpId? employeeMasterEntityByDiAdeEmpId,
    PolePurchaseOrdersEntityByPurchaseOrderNo?
        polePurchaseOrdersEntityByPurchaseOrderNo,
    EmployeeMasterEntityByForm13IssuedEmpId?
        employeeMasterEntityByForm13IssuedEmpId,
    PoleManufacturingFirmEntityByFirmId? poleManufacturingFirmEntityByFirmId,
    List<PoleDumpedLocationEntitiesByDispatchInstructionsId>?
        poleDumpedLocationEntitiesByDispatchInstructionsId,
    List<PoleTransportEntitiesByDispatchInstructionsId>?
        poleTransportEntitiesByDispatchInstructionsId,
  }) =>
      PoleDispatchInstructionsEntity(
        dispatchInstructionId:
            dispatchInstructionId ?? this.dispatchInstructionId,
        purchaseOrderNo: purchaseOrderNo ?? this.purchaseOrderNo,
        qtyToBeDispatched: qtyToBeDispatched ?? this.qtyToBeDispatched,
        diDate: diDate ?? this.diDate,
        diAdeEmpId: diAdeEmpId ?? this.diAdeEmpId,
        sectionId: sectionId ?? this.sectionId,
        section: section ?? this.section,
        erstCircleId: erstCircleId ?? this.erstCircleId,
        diStatus: diStatus ?? this.diStatus,
        firmId: firmId ?? this.firmId,
        deliveredQty: deliveredQty ?? this.deliveredQty,
        dispatchedQty: dispatchedQty ?? this.dispatchedQty,
        dispatchPendingQty: dispatchPendingQty ?? this.dispatchPendingQty,
        verifiedQty: verifiedQty ?? this.verifiedQty,
        form13IssuedQty: form13IssuedQty ?? this.form13IssuedQty,
        form13IssuedDate: form13IssuedDate ?? this.form13IssuedDate,
        form13IssuedEmpId: form13IssuedEmpId ?? this.form13IssuedEmpId,
        employeeMasterEntityByDiAdeEmpId: employeeMasterEntityByDiAdeEmpId ??
            this.employeeMasterEntityByDiAdeEmpId,
        polePurchaseOrdersEntityByPurchaseOrderNo:
            polePurchaseOrdersEntityByPurchaseOrderNo ??
                this.polePurchaseOrdersEntityByPurchaseOrderNo,
        employeeMasterEntityByForm13IssuedEmpId:
            employeeMasterEntityByForm13IssuedEmpId ??
                this.employeeMasterEntityByForm13IssuedEmpId,
        poleManufacturingFirmEntityByFirmId:
            poleManufacturingFirmEntityByFirmId ??
                this.poleManufacturingFirmEntityByFirmId,
        poleDumpedLocationEntitiesByDispatchInstructionsId:
            poleDumpedLocationEntitiesByDispatchInstructionsId ??
                this.poleDumpedLocationEntitiesByDispatchInstructionsId,
        poleTransportEntitiesByDispatchInstructionsId:
            poleTransportEntitiesByDispatchInstructionsId ??
                this.poleTransportEntitiesByDispatchInstructionsId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dispatchInstructionId'] = dispatchInstructionId;
    map['purchaseOrderNo'] = purchaseOrderNo;
    map['qtyToBeDispatched'] = qtyToBeDispatched;
    map['diDate'] = diDate;
    map['diAdeEmpId'] = diAdeEmpId;
    map['sectionId'] = sectionId;
    map['section'] = section;
    map['erstCircleId'] = erstCircleId;
    map['diStatus'] = diStatus;
    map['firmId'] = firmId;
    map['deliveredQty'] = deliveredQty;
    map['dispatchedQty'] = dispatchedQty;
    map['dispatchPendingQty'] = dispatchPendingQty;
    map['verifiedQty'] = verifiedQty;
    map['form13IssuedQty'] = form13IssuedQty;
    map['form13IssuedDate'] = form13IssuedDate;
    map['form13IssuedEmpId'] = form13IssuedEmpId;
    if (employeeMasterEntityByDiAdeEmpId != null) {
      map['employeeMasterEntityByDiAdeEmpId'] =
          employeeMasterEntityByDiAdeEmpId?.toJson();
    }
    if (polePurchaseOrdersEntityByPurchaseOrderNo != null) {
      map['polePurchaseOrdersEntityByPurchaseOrderNo'] =
          polePurchaseOrdersEntityByPurchaseOrderNo?.toJson();
    }
    if (employeeMasterEntityByForm13IssuedEmpId != null) {
      map['employeeMasterEntityByForm13IssuedEmpId'] =
          employeeMasterEntityByForm13IssuedEmpId?.toJson();
    }
    if (poleManufacturingFirmEntityByFirmId != null) {
      map['poleManufacturingFirmEntityByFirmId'] =
          poleManufacturingFirmEntityByFirmId?.toJson();
    }
    if (poleDumpedLocationEntitiesByDispatchInstructionsId != null) {
      map['poleDumpedLocationEntitiesByDispatchInstructionsId'] =
          poleDumpedLocationEntitiesByDispatchInstructionsId
              ?.map((v) => v.toJson())
              .toList();
    }
    if (poleTransportEntitiesByDispatchInstructionsId != null) {
      map['poleTransportEntitiesByDispatchInstructionsId'] =
          poleTransportEntitiesByDispatchInstructionsId
              ?.map((v) => v.toJson())
              .toList();
    }
    return map;
  }
}

PoleTransportEntitiesByDispatchInstructionsId
    poleTransportEntitiesByDispatchInstructionsIdFromJson(String str) =>
        PoleTransportEntitiesByDispatchInstructionsId.fromJson(
            json.decode(str));

String poleTransportEntitiesByDispatchInstructionsIdToJson(
        PoleTransportEntitiesByDispatchInstructionsId data) =>
    json.encode(data.toJson());

class PoleTransportEntitiesByDispatchInstructionsId {
  PoleTransportEntitiesByDispatchInstructionsId({
    this.transportId,
    this.vehicleNo,
    this.driverName,
    this.driverPhone,
    this.dispatchInstructionId,
    this.dispatchDate,
    this.expectedDeliveryDate,
    this.transportQty,
    this.poleDumpedLocationEntityListByTransportId,
  });

  PoleTransportEntitiesByDispatchInstructionsId.fromJson(dynamic json) {
    transportId = json['transportId'];
    vehicleNo = json['vehicleNo'];
    driverName = json['driverName'];
    driverPhone = json['driverPhone'];
    dispatchInstructionId = json['dispatchInstructionId'];
    dispatchDate = json['dispatchDate'];
    expectedDeliveryDate = json['expectedDeliveryDate'];
    transportQty = json['transportQty'];
    if (json['poleDumpedLocationEntityListByTransportId'] != null) {
      poleDumpedLocationEntityListByTransportId = [];
      json['poleDumpedLocationEntityListByTransportId'].forEach((v) {
        poleDumpedLocationEntityListByTransportId
            ?.add(PoleDumpedLocationEntityListByTransportId.fromJson(v));
      });
    }
  }

  num? transportId;
  String? vehicleNo;
  String? driverName;
  String? driverPhone;
  num? dispatchInstructionId;
  String? dispatchDate;
  String? expectedDeliveryDate;
  num? transportQty;
  List<PoleDumpedLocationEntityListByTransportId>?
      poleDumpedLocationEntityListByTransportId;

  PoleTransportEntitiesByDispatchInstructionsId copyWith({
    num? transportId,
    String? vehicleNo,
    String? driverName,
    String? driverPhone,
    num? dispatchInstructionId,
    String? dispatchDate,
    String? expectedDeliveryDate,
    num? transportQty,
    List<PoleDumpedLocationEntityListByTransportId>?
        poleDumpedLocationEntityListByTransportId,
  }) =>
      PoleTransportEntitiesByDispatchInstructionsId(
        transportId: transportId ?? this.transportId,
        vehicleNo: vehicleNo ?? this.vehicleNo,
        driverName: driverName ?? this.driverName,
        driverPhone: driverPhone ?? this.driverPhone,
        dispatchInstructionId:
            dispatchInstructionId ?? this.dispatchInstructionId,
        dispatchDate: dispatchDate ?? this.dispatchDate,
        expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
        transportQty: transportQty ?? this.transportQty,
        poleDumpedLocationEntityListByTransportId:
            poleDumpedLocationEntityListByTransportId ??
                this.poleDumpedLocationEntityListByTransportId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transportId'] = transportId;
    map['vehicleNo'] = vehicleNo;
    map['driverName'] = driverName;
    map['driverPhone'] = driverPhone;
    map['dispatchInstructionId'] = dispatchInstructionId;
    map['dispatchDate'] = dispatchDate;
    map['expectedDeliveryDate'] = expectedDeliveryDate;
    map['transportQty'] = transportQty;
    if (poleDumpedLocationEntityListByTransportId != null) {
      map['poleDumpedLocationEntityListByTransportId'] =
          poleDumpedLocationEntityListByTransportId
              ?.map((v) => v.toJson())
              .toList();
    }
    return map;
  }
}

PoleDumpedLocationEntityListByTransportId
    poleDumpedLocationEntityListByTransportIdFromJson(String str) =>
        PoleDumpedLocationEntityListByTransportId.fromJson(json.decode(str));

String poleDumpedLocationEntityListByTransportIdToJson(
        PoleDumpedLocationEntityListByTransportId data) =>
    json.encode(data.toJson());

class PoleDumpedLocationEntityListByTransportId {
  PoleDumpedLocationEntityListByTransportId({
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

  PoleDumpedLocationEntityListByTransportId.fromJson(dynamic json) {
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

  PoleDumpedLocationEntityListByTransportId copyWith({
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
      PoleDumpedLocationEntityListByTransportId(
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

PoleDumpedLocationEntitiesByDispatchInstructionsId
    poleDumpedLocationEntitiesByDispatchInstructionsIdFromJson(String str) =>
        PoleDumpedLocationEntitiesByDispatchInstructionsId.fromJson(
            json.decode(str));

String poleDumpedLocationEntitiesByDispatchInstructionsIdToJson(
        PoleDumpedLocationEntitiesByDispatchInstructionsId data) =>
    json.encode(data.toJson());

class PoleDumpedLocationEntitiesByDispatchInstructionsId {
  PoleDumpedLocationEntitiesByDispatchInstructionsId({
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

  PoleDumpedLocationEntitiesByDispatchInstructionsId.fromJson(dynamic json) {
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

  PoleDumpedLocationEntitiesByDispatchInstructionsId copyWith({
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
      PoleDumpedLocationEntitiesByDispatchInstructionsId(
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

// EmployeeMasterEntityByVerifiedEmpId employeeMasterEntityByVerifiedEmpIdFromJson(
//         String str) =>
//     EmployeeMasterEntityByVerifiedEmpId.fromJson(json.decode(str));
//
// String employeeMasterEntityByVerifiedEmpIdToJson(
//         EmployeeMasterEntityByVerifiedEmpId data) =>
//     json.encode(data.toJson());
//
// class EmployeeMasterEntityByVerifiedEmpId {
//   EmployeeMasterEntityByVerifiedEmpId({
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
//   EmployeeMasterEntityByVerifiedEmpId.fromJson(dynamic json) {
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
//   EmployeeMasterEntityByVerifiedEmpId copyWith({
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
//       EmployeeMasterEntityByVerifiedEmpId(
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

PoleManufacturingFirmEntityByFirmId poleManufacturingFirmEntityByFirmIdFromJson(
        String str) =>
    PoleManufacturingFirmEntityByFirmId.fromJson(json.decode(str));

String poleManufacturingFirmEntityByFirmIdToJson(
        PoleManufacturingFirmEntityByFirmId data) =>
    json.encode(data.toJson());

class PoleManufacturingFirmEntityByFirmId {
  PoleManufacturingFirmEntityByFirmId({
    this.firmId,
    this.mobileNo,
    this.firmName,
    this.sapVendorId,
    this.loginPassword,
    this.blockListed,
    this.insertDate,
    this.createdIpAddress,
    this.createdEmpId,
    this.supplierName,
  });

  PoleManufacturingFirmEntityByFirmId.fromJson(dynamic json) {
    firmId = json['firmId'];
    mobileNo = json['mobileNo'];
    firmName = json['firmName'];
    sapVendorId = json['sapVendorId'];
    loginPassword = json['loginPassword'];
    blockListed = json['blockListed'];
    insertDate = json['insertDate'];
    createdIpAddress = json['createdIpAddress'];
    createdEmpId = json['createdEmpId'];
    supplierName = json['supplierName'];
  }

  num? firmId;
  String? mobileNo;
  String? firmName;
  String? sapVendorId;
  String? loginPassword;
  String? blockListed;
  String? insertDate;
  String? createdIpAddress;
  String? createdEmpId;
  String? supplierName;

  PoleManufacturingFirmEntityByFirmId copyWith({
    num? firmId,
    String? mobileNo,
    String? firmName,
    String? sapVendorId,
    String? loginPassword,
    String? blockListed,
    String? insertDate,
    String? createdIpAddress,
    String? createdEmpId,
    String? supplierName,
  }) =>
      PoleManufacturingFirmEntityByFirmId(
        firmId: firmId ?? this.firmId,
        mobileNo: mobileNo ?? this.mobileNo,
        firmName: firmName ?? this.firmName,
        sapVendorId: sapVendorId ?? this.sapVendorId,
        loginPassword: loginPassword ?? this.loginPassword,
        blockListed: blockListed ?? this.blockListed,
        insertDate: insertDate ?? this.insertDate,
        createdIpAddress: createdIpAddress ?? this.createdIpAddress,
        createdEmpId: createdEmpId ?? this.createdEmpId,
        supplierName: supplierName ?? this.supplierName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firmId'] = firmId;
    map['mobileNo'] = mobileNo;
    map['firmName'] = firmName;
    map['sapVendorId'] = sapVendorId;
    map['loginPassword'] = loginPassword;
    map['blockListed'] = blockListed;
    map['insertDate'] = insertDate;
    map['createdIpAddress'] = createdIpAddress;
    map['createdEmpId'] = createdEmpId;
    map['supplierName'] = supplierName;
    return map;
  }
}

EmployeeMasterEntityByForm13IssuedEmpId
    employeeMasterEntityByForm13IssuedEmpIdFromJson(String str) =>
        EmployeeMasterEntityByForm13IssuedEmpId.fromJson(json.decode(str));

String employeeMasterEntityByForm13IssuedEmpIdToJson(
        EmployeeMasterEntityByForm13IssuedEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByForm13IssuedEmpId {
  EmployeeMasterEntityByForm13IssuedEmpId({
    this.empId,
    this.epfAcno,
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

  EmployeeMasterEntityByForm13IssuedEmpId.fromJson(dynamic json) {
    empId = json['empId'];
    epfAcno = json['epfAcno'];
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

  EmployeeMasterEntityByForm13IssuedEmpId copyWith({
    String? empId,
    String? epfAcno,
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
      EmployeeMasterEntityByForm13IssuedEmpId(
        empId: empId ?? this.empId,
        epfAcno: epfAcno ?? this.epfAcno,
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

PolePurchaseOrdersEntityByPurchaseOrderNo
    polePurchaseOrdersEntityByPurchaseOrderNoFromJson(String str) =>
        PolePurchaseOrdersEntityByPurchaseOrderNo.fromJson(json.decode(str));

String polePurchaseOrdersEntityByPurchaseOrderNoToJson(
        PolePurchaseOrdersEntityByPurchaseOrderNo data) =>
    json.encode(data.toJson());

class PolePurchaseOrdersEntityByPurchaseOrderNo {
  PolePurchaseOrdersEntityByPurchaseOrderNo({
    this.purchaseOrderNo,
    this.poleManufactureId,
    this.financialYear,
    this.circleId,
    this.polesQuantity,
    this.readyQuantity,
    this.balanceQuantity,
    this.underInspection,
    this.poleType,
    this.poDescription,
    this.insertDate,
    this.empId,
    this.poStatus,
    this.empName,
    this.empDesignation,
    this.empDesignationCode,
    this.empSectionId,
    this.dispatchedQty,
    this.deliveredQty,
    this.verifiedQty,
    this.diIssuedQty,
    this.form13IssuedQty,
    this.empWing,
    this.poleManufacturingFirmEntityByFirmId,
    this.employeeMasterEntityByEmpId,
  });

  PolePurchaseOrdersEntityByPurchaseOrderNo.fromJson(dynamic json) {
    purchaseOrderNo = json['purchaseOrderNo'];
    poleManufactureId = json['poleManufactureId'];
    financialYear = json['financialYear'];
    circleId = json['circleId'];
    polesQuantity = json['polesQuantity'];
    readyQuantity = json['readyQuantity'];
    balanceQuantity = json['balanceQuantity'];
    underInspection = json['underInspection'];
    poleType = json['poleType'];
    poDescription = json['poDescription'];
    insertDate = json['insertDate'];
    empId = json['empId'];
    poStatus = json['poStatus'];
    empName = json['empName'];
    empDesignation = json['empDesignation'];
    empDesignationCode = json['empDesignationCode'];
    empSectionId = json['empSectionId'];
    dispatchedQty = json['dispatchedQty'];
    deliveredQty = json['deliveredQty'];
    verifiedQty = json['verifiedQty'];
    diIssuedQty = json['diIssuedQty'];
    form13IssuedQty = json['form13IssuedQty'];
    empWing = json['empWing'];
    poleManufacturingFirmEntityByFirmId =
        json['poleManufacturingFirmEntityByFirmId'] != null
            ? PoleManufacturingFirmEntityByFirmId.fromJson(
                json['poleManufacturingFirmEntityByFirmId'])
            : null;
    employeeMasterEntityByEmpId = json['employeeMasterEntityByEmpId'] != null
        ? EmployeeMasterEntityByEmpId.fromJson(
            json['employeeMasterEntityByEmpId'])
        : null;
  }

  String? purchaseOrderNo;
  num? poleManufactureId;
  String? financialYear;
  num? circleId;
  num? polesQuantity;
  num? readyQuantity;
  num? balanceQuantity;
  num? underInspection;
  String? poleType;
  String? poDescription;
  String? insertDate;
  String? empId;
  String? poStatus;
  String? empName;
  String? empDesignation;
  num? empDesignationCode;
  String? empSectionId;
  num? dispatchedQty;
  num? deliveredQty;
  num? verifiedQty;
  num? diIssuedQty;
  num? form13IssuedQty;
  String? empWing;
  PoleManufacturingFirmEntityByFirmId? poleManufacturingFirmEntityByFirmId;
  EmployeeMasterEntityByEmpId? employeeMasterEntityByEmpId;

  PolePurchaseOrdersEntityByPurchaseOrderNo copyWith({
    String? purchaseOrderNo,
    num? poleManufactureId,
    String? financialYear,
    num? circleId,
    num? polesQuantity,
    num? readyQuantity,
    num? balanceQuantity,
    num? underInspection,
    String? poleType,
    String? poDescription,
    String? insertDate,
    String? empId,
    String? poStatus,
    String? empName,
    String? empDesignation,
    num? empDesignationCode,
    String? empSectionId,
    num? dispatchedQty,
    num? deliveredQty,
    num? verifiedQty,
    num? diIssuedQty,
    num? form13IssuedQty,
    String? empWing,
    PoleManufacturingFirmEntityByFirmId? poleManufacturingFirmEntityByFirmId,
    EmployeeMasterEntityByEmpId? employeeMasterEntityByEmpId,
  }) =>
      PolePurchaseOrdersEntityByPurchaseOrderNo(
        purchaseOrderNo: purchaseOrderNo ?? this.purchaseOrderNo,
        poleManufactureId: poleManufactureId ?? this.poleManufactureId,
        financialYear: financialYear ?? this.financialYear,
        circleId: circleId ?? this.circleId,
        polesQuantity: polesQuantity ?? this.polesQuantity,
        readyQuantity: readyQuantity ?? this.readyQuantity,
        balanceQuantity: balanceQuantity ?? this.balanceQuantity,
        underInspection: underInspection ?? this.underInspection,
        poleType: poleType ?? this.poleType,
        poDescription: poDescription ?? this.poDescription,
        insertDate: insertDate ?? this.insertDate,
        empId: empId ?? this.empId,
        poStatus: poStatus ?? this.poStatus,
        empName: empName ?? this.empName,
        empDesignation: empDesignation ?? this.empDesignation,
        empDesignationCode: empDesignationCode ?? this.empDesignationCode,
        empSectionId: empSectionId ?? this.empSectionId,
        dispatchedQty: dispatchedQty ?? this.dispatchedQty,
        deliveredQty: deliveredQty ?? this.deliveredQty,
        verifiedQty: verifiedQty ?? this.verifiedQty,
        diIssuedQty: diIssuedQty ?? this.diIssuedQty,
        form13IssuedQty: form13IssuedQty ?? this.form13IssuedQty,
        empWing: empWing ?? this.empWing,
        poleManufacturingFirmEntityByFirmId:
            poleManufacturingFirmEntityByFirmId ??
                this.poleManufacturingFirmEntityByFirmId,
        employeeMasterEntityByEmpId:
            employeeMasterEntityByEmpId ?? this.employeeMasterEntityByEmpId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['purchaseOrderNo'] = purchaseOrderNo;
    map['poleManufactureId'] = poleManufactureId;
    map['financialYear'] = financialYear;
    map['circleId'] = circleId;
    map['polesQuantity'] = polesQuantity;
    map['readyQuantity'] = readyQuantity;
    map['balanceQuantity'] = balanceQuantity;
    map['underInspection'] = underInspection;
    map['poleType'] = poleType;
    map['poDescription'] = poDescription;
    map['insertDate'] = insertDate;
    map['empId'] = empId;
    map['poStatus'] = poStatus;
    map['empName'] = empName;
    map['empDesignation'] = empDesignation;
    map['empDesignationCode'] = empDesignationCode;
    map['empSectionId'] = empSectionId;
    map['dispatchedQty'] = dispatchedQty;
    map['deliveredQty'] = deliveredQty;
    map['verifiedQty'] = verifiedQty;
    map['diIssuedQty'] = diIssuedQty;
    map['form13IssuedQty'] = form13IssuedQty;
    map['empWing'] = empWing;
    if (poleManufacturingFirmEntityByFirmId != null) {
      map['poleManufacturingFirmEntityByFirmId'] =
          poleManufacturingFirmEntityByFirmId?.toJson();
    }
    if (employeeMasterEntityByEmpId != null) {
      map['employeeMasterEntityByEmpId'] =
          employeeMasterEntityByEmpId?.toJson();
    }
    return map;
  }
}

EmployeeMasterEntityByEmpId employeeMasterEntityByEmpIdFromJson(String str) =>
    EmployeeMasterEntityByEmpId.fromJson(json.decode(str));

String employeeMasterEntityByEmpIdToJson(EmployeeMasterEntityByEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByEmpId {
  EmployeeMasterEntityByEmpId({
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

  EmployeeMasterEntityByEmpId.fromJson(dynamic json) {
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

  EmployeeMasterEntityByEmpId copyWith({
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
      EmployeeMasterEntityByEmpId(
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

// PoleManufacturingFirmEntityByFirmId poleManufacturingFirmEntityByFirmIdFromJson(
//         String str) =>
//     PoleManufacturingFirmEntityByFirmId.fromJson(json.decode(str));
//
// String poleManufacturingFirmEntityByFirmIdToJson(
//         PoleManufacturingFirmEntityByFirmId data) =>
//     json.encode(data.toJson());
//
// class PoleManufacturingFirmEntityByFirmId {
//   PoleManufacturingFirmEntityByFirmId({
//     this.firmId,
//     this.mobileNo,
//     this.firmName,
//     this.sapVendorId,
//     this.loginPassword,
//     this.blockListed,
//     this.insertDate,
//     this.createdIpAddress,
//     this.createdEmpId,
//     this.supplierName,
//   });
//
//   PoleManufacturingFirmEntityByFirmId.fromJson(dynamic json) {
//     firmId = json['firmId'];
//     mobileNo = json['mobileNo'];
//     firmName = json['firmName'];
//     sapVendorId = json['sapVendorId'];
//     loginPassword = json['loginPassword'];
//     blockListed = json['blockListed'];
//     insertDate = json['insertDate'];
//     createdIpAddress = json['createdIpAddress'];
//     createdEmpId = json['createdEmpId'];
//     supplierName = json['supplierName'];
//   }
//
//   num? firmId;
//   String? mobileNo;
//   String? firmName;
//   String? sapVendorId;
//   String? loginPassword;
//   String? blockListed;
//   String? insertDate;
//   String? createdIpAddress;
//   String? createdEmpId;
//   String? supplierName;
//
//   PoleManufacturingFirmEntityByFirmId copyWith({
//     num? firmId,
//     String? mobileNo,
//     String? firmName,
//     String? sapVendorId,
//     String? loginPassword,
//     String? blockListed,
//     String? insertDate,
//     String? createdIpAddress,
//     String? createdEmpId,
//     String? supplierName,
//   }) =>
//       PoleManufacturingFirmEntityByFirmId(
//         firmId: firmId ?? this.firmId,
//         mobileNo: mobileNo ?? this.mobileNo,
//         firmName: firmName ?? this.firmName,
//         sapVendorId: sapVendorId ?? this.sapVendorId,
//         loginPassword: loginPassword ?? this.loginPassword,
//         blockListed: blockListed ?? this.blockListed,
//         insertDate: insertDate ?? this.insertDate,
//         createdIpAddress: createdIpAddress ?? this.createdIpAddress,
//         createdEmpId: createdEmpId ?? this.createdEmpId,
//         supplierName: supplierName ?? this.supplierName,
//       );
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['firmId'] = firmId;
//     map['mobileNo'] = mobileNo;
//     map['firmName'] = firmName;
//     map['sapVendorId'] = sapVendorId;
//     map['loginPassword'] = loginPassword;
//     map['blockListed'] = blockListed;
//     map['insertDate'] = insertDate;
//     map['createdIpAddress'] = createdIpAddress;
//     map['createdEmpId'] = createdEmpId;
//     map['supplierName'] = supplierName;
//     return map;
//   }
// }

EmployeeMasterEntityByDiAdeEmpId employeeMasterEntityByDiAdeEmpIdFromJson(
        String str) =>
    EmployeeMasterEntityByDiAdeEmpId.fromJson(json.decode(str));

String employeeMasterEntityByDiAdeEmpIdToJson(
        EmployeeMasterEntityByDiAdeEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByDiAdeEmpId {
  EmployeeMasterEntityByDiAdeEmpId({
    this.empId,
    this.epfAcno,
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

  EmployeeMasterEntityByDiAdeEmpId.fromJson(dynamic json) {
    empId = json['empId'];
    epfAcno = json['epfAcno'];
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

  EmployeeMasterEntityByDiAdeEmpId copyWith({
    String? empId,
    String? epfAcno,
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
      EmployeeMasterEntityByDiAdeEmpId(
        empId: empId ?? this.empId,
        epfAcno: epfAcno ?? this.epfAcno,
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
