import 'dart:convert';

InspectionTicketEntity inspectionTicketEntityFromJson(String str) =>
    InspectionTicketEntity.fromJson(json.decode(str));

String inspectionTicketEntityToJson(InspectionTicketEntity data) =>
    json.encode(data.toJson());

class InspectionTicketEntity {
  InspectionTicketEntity({
    this.ticketId,
    this.firmId,
    this.ticketDate,
    this.ipAddress,
    this.qtyForInspection,
    this.purchaseOrderNo,
    this.purchaseOrderDescription,
    this.propInspectLat,
    this.propInspectLon,
    this.testedQuantity,
    this.failedQuantity,
    this.passedQuantity,
    this.ticketStatus,
    this.empId,
    this.inspectingOfficerByEmpId,
    this.officerAssignedBy,
    this.officerAssignedDate,
    this.scheduledDate,
    this.timeSlot,
    this.polePurchaseOrdersEntityByPurchaseOrderNo,
    this.poleManufacturingFirmEntityByFirmId,
    this.poleTestSampleEntitiesByTicketId,
    this.ticketClosedEmpName,
    this.ticketClosedEmpDes,
    this.approvedQuantity,
    this.ticketClosedEmpId,
    this.closedDate,
  });

  InspectionTicketEntity.fromJson(dynamic json) {
    ticketId = json['ticketId'];
    firmId = json['firmId'];
    ticketDate = json['ticketDate'];
    ipAddress = json['ipAddress'];
    qtyForInspection = json['qtyForInspection'];
    purchaseOrderNo = json['purchaseOrderNo'];
    purchaseOrderDescription = json['purchaseOrderDescription'];
    propInspectLat = json['propInspectLat'];
    propInspectLon = json['propInspectLon'];
    testedQuantity = json['testedQuantity'];
    failedQuantity = json['failedQuantity'];
    passedQuantity = json['passedQuantity'];
    ticketStatus = json['ticketStatus'];
    empId = json['empId'];
    inspectingOfficerByEmpId = json['inspectingOfficerByEmpId'] != null
        ? InspectingOfficerByEmpId.fromJson(json['inspectingOfficerByEmpId'])
        : null;
    officerAssignedBy = json['officerAssignedBy'];
    officerAssignedDate = json['officerAssignedDate'];
    scheduledDate = json['scheduledDate'];
    timeSlot = json['timeSlot'];
    polePurchaseOrdersEntityByPurchaseOrderNo =
        json['polePurchaseOrdersEntityByPurchaseOrderNo'] != null
            ? PolePurchaseOrdersEntityByPurchaseOrderNo.fromJson(
                json['polePurchaseOrdersEntityByPurchaseOrderNo'])
            : null;
    poleManufacturingFirmEntityByFirmId =
        json['poleManufacturingFirmEntityByFirmId'] != null
            ? PoleManufacturingFirmEntityByFirmId.fromJson(
                json['poleManufacturingFirmEntityByFirmId'])
            : null;
    if (json['poleTestSampleEntitiesByTicketId'] != null) {
      poleTestSampleEntitiesByTicketId = [];
      // json['poleTestSampleEntitiesByTicketId'].forEach((v) {
      //   poleTestSampleEntitiesByTicketId?.add(Dynamic.fromJson(v));
      // });
    }
    ticketClosedEmpName = json['ticketClosedEmpName'];
    ticketClosedEmpDes = json['ticketClosedEmpDes'];
    approvedQuantity = json['approvedQuantity'];
    ticketClosedEmpId = json['ticketClosedEmpId'];
    closedDate = json['closedDate'];
  }

  num? ticketId;
  num? firmId;
  String? ticketDate;
  String? ipAddress;
  num? qtyForInspection;
  String? purchaseOrderNo;
  String? purchaseOrderDescription;
  num? propInspectLat;
  num? propInspectLon;
  num? testedQuantity;
  num? failedQuantity;
  num? passedQuantity;
  String? ticketStatus;
  String? empId;
  InspectingOfficerByEmpId? inspectingOfficerByEmpId;
  String? officerAssignedBy;
  String? officerAssignedDate;
  String? scheduledDate;
  String? timeSlot;
  PolePurchaseOrdersEntityByPurchaseOrderNo?
      polePurchaseOrdersEntityByPurchaseOrderNo;
  PoleManufacturingFirmEntityByFirmId? poleManufacturingFirmEntityByFirmId;
  List<dynamic>? poleTestSampleEntitiesByTicketId;
  String? ticketClosedEmpName;
  String? ticketClosedEmpDes;
  num? approvedQuantity;
  String? ticketClosedEmpId;
  String? closedDate;

  InspectionTicketEntity copyWith({
    num? ticketId,
    num? firmId,
    String? ticketDate,
    String? ipAddress,
    num? qtyForInspection,
    String? purchaseOrderNo,
    String? purchaseOrderDescription,
    num? propInspectLat,
    num? propInspectLon,
    num? testedQuantity,
    num? failedQuantity,
    num? passedQuantity,
    String? ticketStatus,
    String? empId,
    InspectingOfficerByEmpId? inspectingOfficerByEmpId,
    String? officerAssignedBy,
    String? officerAssignedDate,
    String? scheduledDate,
    String? timeSlot,
    PolePurchaseOrdersEntityByPurchaseOrderNo?
        polePurchaseOrdersEntityByPurchaseOrderNo,
    PoleManufacturingFirmEntityByFirmId? poleManufacturingFirmEntityByFirmId,
    List<dynamic>? poleTestSampleEntitiesByTicketId,
    String? ticketClosedEmpName,
    String? ticketClosedEmpDes,
    num? approvedQuantity,
    String? ticketClosedEmpId,
    String? closedDate,
  }) =>
      InspectionTicketEntity(
        ticketId: ticketId ?? this.ticketId,
        firmId: firmId ?? this.firmId,
        ticketDate: ticketDate ?? this.ticketDate,
        ipAddress: ipAddress ?? this.ipAddress,
        qtyForInspection: qtyForInspection ?? this.qtyForInspection,
        purchaseOrderNo: purchaseOrderNo ?? this.purchaseOrderNo,
        purchaseOrderDescription: purchaseOrderDescription ?? this.purchaseOrderDescription,
        propInspectLat: propInspectLat ?? this.propInspectLat,
        propInspectLon: propInspectLon ?? this.propInspectLon,
        testedQuantity: testedQuantity ?? this.testedQuantity,
        failedQuantity: failedQuantity ?? this.failedQuantity,
        passedQuantity: passedQuantity ?? this.passedQuantity,
        ticketStatus: ticketStatus ?? this.ticketStatus,
        empId: empId ?? this.empId,
        inspectingOfficerByEmpId:
            inspectingOfficerByEmpId ?? this.inspectingOfficerByEmpId,
        officerAssignedBy: officerAssignedBy ?? this.officerAssignedBy,
        officerAssignedDate: officerAssignedDate ?? this.officerAssignedDate,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        timeSlot: timeSlot ?? this.timeSlot,
        polePurchaseOrdersEntityByPurchaseOrderNo:
            polePurchaseOrdersEntityByPurchaseOrderNo ??
                this.polePurchaseOrdersEntityByPurchaseOrderNo,
        poleManufacturingFirmEntityByFirmId:
            poleManufacturingFirmEntityByFirmId ??
                this.poleManufacturingFirmEntityByFirmId,
        poleTestSampleEntitiesByTicketId: poleTestSampleEntitiesByTicketId ??
            this.poleTestSampleEntitiesByTicketId,
        ticketClosedEmpName: ticketClosedEmpName ?? this.ticketClosedEmpName,
        ticketClosedEmpDes: ticketClosedEmpDes ?? this.ticketClosedEmpDes,
        approvedQuantity: approvedQuantity ?? this.approvedQuantity,
        ticketClosedEmpId: ticketClosedEmpId ?? this.ticketClosedEmpId,
        closedDate: closedDate ?? this.closedDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ticketId'] = ticketId;
    map['firmId'] = firmId;
    map['ticketDate'] = ticketDate;
    map['ipAddress'] = ipAddress;
    map['qtyForInspection'] = qtyForInspection;
    map['purchaseOrderNo'] = purchaseOrderNo;
    map['purchaseOrderDescription'] = purchaseOrderDescription;
    map['propInspectLat'] = propInspectLat;
    map['propInspectLon'] = propInspectLon;
    map['testedQuantity'] = testedQuantity;
    map['failedQuantity'] = failedQuantity;
    map['passedQuantity'] = passedQuantity;
    map['ticketStatus'] = ticketStatus;
    map['empId'] = empId;
    if (inspectingOfficerByEmpId != null) {
      map['inspectingOfficerByEmpId'] = inspectingOfficerByEmpId?.toJson();
    }
    map['officerAssignedBy'] = officerAssignedBy;
    map['officerAssignedDate'] = officerAssignedDate;
    map['scheduledDate'] = scheduledDate;
    map['timeSlot'] = timeSlot;
    if (polePurchaseOrdersEntityByPurchaseOrderNo != null) {
      map['polePurchaseOrdersEntityByPurchaseOrderNo'] =
          polePurchaseOrdersEntityByPurchaseOrderNo?.toJson();
    }
    if (poleManufacturingFirmEntityByFirmId != null) {
      map['poleManufacturingFirmEntityByFirmId'] =
          poleManufacturingFirmEntityByFirmId?.toJson();
    }
    if (poleTestSampleEntitiesByTicketId != null) {
      map['poleTestSampleEntitiesByTicketId'] =
          poleTestSampleEntitiesByTicketId?.map((v) => v.toJson()).toList();
    }
    map['ticketClosedEmpName'] = ticketClosedEmpName;
    map['ticketClosedEmpDes'] = ticketClosedEmpDes;
    map['approvedQuantity'] = approvedQuantity;
    map['ticketClosedEmpId'] = ticketClosedEmpId;
    map['closedDate'] = closedDate;
    return map;
  }
}

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
    this.diIssuedQty,
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
    diIssuedQty = json['diIssuedQty'];
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
  num? diIssuedQty;
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
    num? diIssuedQty,
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
        diIssuedQty: diIssuedQty ?? this.diIssuedQty,
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
    map['diIssuedQty'] = diIssuedQty;
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

InspectingOfficerByEmpId inspectingOfficerByEmpIdFromJson(String str) =>
    InspectingOfficerByEmpId.fromJson(json.decode(str));

String inspectingOfficerByEmpIdToJson(InspectingOfficerByEmpId data) =>
    json.encode(data.toJson());

class InspectingOfficerByEmpId {
  InspectingOfficerByEmpId({
    this.empId,
    this.empAdhaarNumber,
    this.epfAcno,
    this.epfUan,
    this.gpfAcno,
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
    this.isSsOp,
  });

  InspectingOfficerByEmpId.fromJson(dynamic json) {
    empId = json['empId'];
    empAdhaarNumber = json['empAdhaarNumber'];
    epfAcno = json['epfAcno'];
    epfUan = json['epfUan'];
    gpfAcno = json['gpfAcno'];
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
    isSsOp = json['isSsOp'];
  }

  String? empId;
  String? empAdhaarNumber;
  String? epfAcno;
  String? epfUan;
  String? gpfAcno;
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
  String? isSsOp;

  InspectingOfficerByEmpId copyWith({
    String? empId,
    String? empAdhaarNumber,
    String? epfAcno,
    String? epfUan,
    String? gpfAcno,
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
    String? isSsOp,
  }) =>
      InspectingOfficerByEmpId(
        empId: empId ?? this.empId,
        empAdhaarNumber: empAdhaarNumber ?? this.empAdhaarNumber,
        epfAcno: epfAcno ?? this.epfAcno,
        epfUan: epfUan ?? this.epfUan,
        gpfAcno: gpfAcno ?? this.gpfAcno,
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
        isSsOp: isSsOp ?? this.isSsOp,
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
    map['isSsOp'] = isSsOp;
    return map;
  }
}
