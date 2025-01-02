import 'dart:convert';

AllLcRequestList allLcRequestListFromJson(String str) =>
    AllLcRequestList.fromJson(json.decode(str));

String allLcRequestListToJson(AllLcRequestList data) =>
    json.encode(data.toJson());

class AllLcRequestList {
  AllLcRequestList({
    this.lcId,
    this.ssCode,
    this.fdrCode,
    this.voltage,
    this.lmEmployeeId,
    this.lmDeviceId,
    this.requestDate,
    this.expLcStartDate,
    this.expLcStartTime,
    this.expLcEndDate,
    this.expLcEndTime,
    this.expLcDuration,
    this.lcPurpose,
    this.lcPurposeCode,
    this.lmRemarks,
    this.lmAbOpenImage,
    this.lmAbOpenLat,
    this.lmAbOpenLon,
    this.lmAbImgDate,
    this.lmLocalImage,
    this.lmLocalOpenLat,
    this.lmLocalOpenLon,
    this.lmLocalImgDate,
    this.lmRemoteImage,
    this.lmRemoteOpenLat,
    this.lmRemoteOpenLon,
    this.lmRemoteImgDate,
    this.fieldStaffEmployeeId,
    this.fieldStaffDeviceId,
    this.localEarthingImage,
    this.localEarthLat,
    this.localEarthLon,
    this.localEartImgDate,
    this.localEarthingRemoveImage,
    this.localEarthRmvLat,
    this.localEarthRmvLon,
    this.localEarthRemoveImgDate,
    this.lmAbCloseImage,
    this.lmAbCloseLat,
    this.lmAbCloseLon,
    this.lmAbClsdImgDate,
    this.scadaCbRef,
    this.scadaCbOpenDate,
    this.scadaCbOpenIp,
    this.scadaCbCloseDate,
    this.scadaCbCloseIp,
    this.scadaCbOpenUser,
    this.scadaCbCloseUser,
    this.sectionId,
    this.subDivisionId,
    this.divisionId,
    this.circleId,
    this.aeEmpId,
    this.adeEmpId,
    this.lcApprovedEmpId,
    this.lcApprovedDate,
    this.lcForwardAeEmpId,
    this.lcForwardedDate,
    this.cbCloseReqEmpId,
    this.cbCloseReqDate,
    this.status,
    this.ssOpVcbOpenImage,
    this.ssOpAbswOpenImage,
    this.inLineLCStaffEntitiesByLcId,
    this.employeeMasterEntityByLcRequestedEmpId,
    this.employeeMasterEntityByLcApprovedEmpId,
    this.employeeMasterEntityByFieldStaffEmployeeId,
    this.fdrName,
    this.ssName,
    this.routeFlag,
    this.ssOpEmpId,
    this.ssOpCbOpenDate,
    this.ssOpCbOpenIp,
    this.ssOpCbCloseDate,
    this.ssOpCbCloseIp,
    this.ssOpCbOpenEmpId,
    this.ssOpCbOpenEmpName,
    this.ssOpCbCloseEmpName,
    this.ssOPCbCloseEmpId,
    this.lcRejectedAeEmpId,
    this.aeLcRejDate,
    this.lcRejAeReason,
    this.lcRejectedAdeEmpId,
    this.adeLcRejDate,
    this.lcRejAdeReason,
    this.adeLcPermitDate,
    this.lcInductionPointsEntitiesByLcId,
  });

  AllLcRequestList.fromJson(dynamic json) {
    lcId = json['lcId'];
    ssCode = json['ssCode'];
    fdrCode = json['fdrCode'];
    voltage = json['voltage'];
    lmEmployeeId = json['lmEmployeeId'];
    lmDeviceId = json['lmDeviceId'];
    requestDate = json['requestDate'];
    expLcStartDate = json['expLcStartDate'];
    expLcStartTime = json['expLcStartTime'];
    expLcEndDate = json['expLcEndDate'];
    expLcEndTime = json['expLcEndTime'];
    expLcDuration = json['expLcDuration'];
    lcPurpose = json['lcPurpose'];
    lcPurposeCode = json['lcPurposeCode'];
    lmRemarks = json['lmRemarks'];
    lmAbOpenImage = json['lmAbOpenImage'];
    lmAbOpenLat = json['lmAbOpenLat'];
    lmAbOpenLon = json['lmAbOpenLon'];
    lmAbImgDate = json['lmAbImgDate'];
    lmLocalImage = json['lmLocalImage'];
    lmLocalOpenLat = json['lmLocalOpenLat'];
    lmLocalOpenLon = json['lmLocalOpenLon'];
    lmLocalImgDate = json['lmLocalImgDate'];
    lmRemoteImage = json['lmRemoteImage'];
    lmRemoteOpenLat = json['lmRemoteOpenLat'];
    lmRemoteOpenLon = json['lmRemoteOpenLon'];
    lmRemoteImgDate = json['lmRemoteImgDate'];
    fieldStaffEmployeeId = json['fieldStaffEmployeeId'];
    fieldStaffDeviceId = json['fieldStaffDeviceId'];
    localEarthingImage = json['localEarthingImage'];
    localEarthLat = json['localEarthLat'];
    localEarthLon = json['localEarthLon'];
    localEartImgDate = json['localEartImgDate'];
    localEarthingRemoveImage = json['localEarthingRemoveImage'];
    localEarthRmvLat = json['localEarthRmvLat'];
    localEarthRmvLon = json['localEarthRmvLon'];
    localEarthRemoveImgDate = json['localEarthRemoveImgDate'];
    lmAbCloseImage = json['lmAbCloseImage'];
    lmAbCloseLat = json['lmAbCloseLat'];
    lmAbCloseLon = json['lmAbCloseLon'];
    lmAbClsdImgDate = json['lmAbClsdImgDate'];
    scadaCbRef = json['scadaCbRef'];
    scadaCbOpenDate = json['scadaCbOpenDate'];
    scadaCbOpenIp = json['scadaCbOpenIp'];
    scadaCbCloseDate = json['scadaCbCloseDate'];
    scadaCbCloseIp = json['scadaCbCloseIp'];
    scadaCbOpenUser = json['scadaCbOpenUser'];
    scadaCbCloseUser = json['scadaCbCloseUser'];
    sectionId = json['sectionId'];
    subDivisionId = json['subDivisionId'];
    divisionId = json['divisionId'];
    circleId = json['circleId'];
    aeEmpId = json['aeEmpId'];
    adeEmpId = json['adeEmpId'];
    lcApprovedEmpId = json['lcApprovedEmpId'];
    lcApprovedDate = json['lcApprovedDate'];
    lcForwardAeEmpId = json['lcForwardAeEmpId'];
    lcForwardedDate = json['lcForwardedDate'];
    cbCloseReqEmpId = json['cbCloseReqEmpId'];
    cbCloseReqDate = json['cbCloseReqDate'];
    status = json['status'];
    ssOpVcbOpenImage = json['ssOpVcbOpenImage'];
    ssOpAbswOpenImage = json['ssOpAbswOpenImage'];
    inLineLCStaffEntitiesByLcId = json['inLineLCStaffEntitiesByLcId'];
    employeeMasterEntityByLcRequestedEmpId =
        json['employeeMasterEntityByLcRequestedEmpId'];
    employeeMasterEntityByLcApprovedEmpId =
        json['employeeMasterEntityByLcApprovedEmpId'];
    employeeMasterEntityByFieldStaffEmployeeId =
        json['employeeMasterEntityByFieldStaffEmployeeId'];
    fdrName = json['fdrName'];
    ssName = json['ssName'];
    routeFlag = json['routeFlag'];
    ssOpEmpId = json['ssOpEmpId'];
    ssOpCbOpenDate = json['ssOpCbOpenDate'];
    ssOpCbOpenIp = json['ssOpCbOpenIp'];
    ssOpCbCloseDate = json['ssOpCbCloseDate'];
    ssOpCbCloseIp = json['ssOpCbCloseIp'];
    ssOpCbOpenEmpId = json['ssOpCbOpenEmpId'];
    ssOpCbOpenEmpName = json['ssOpCbOpenEmpName'];
    ssOpCbCloseEmpName = json['ssOpCbCloseEmpName'];
    ssOPCbCloseEmpId = json['ssOPCbCloseEmpId'];
    lcRejectedAeEmpId = json['lcRejectedAeEmpId'];
    aeLcRejDate = json['aeLcRejDate'];
    lcRejAeReason = json['lcRejAeReason'];
    lcRejectedAdeEmpId = json['lcRejectedAdeEmpId'];
    adeLcRejDate = json['adeLcRejDate'];
    lcRejAdeReason = json['lcRejAdeReason'];
    adeLcPermitDate = json['adeLcPermitDate'];
    lcInductionPointsEntitiesByLcId = json['lcInductionPointsEntitiesByLcId'];
  }

  String? lcId;
  String? ssCode;
  String? fdrCode;
  dynamic voltage;
  String? lmEmployeeId;
  String? lmDeviceId;
  String? requestDate;
  String? expLcStartDate;
  String? expLcStartTime;
  String? expLcEndDate;
  String? expLcEndTime;
  String? expLcDuration;
  String? lcPurpose;
  String? lcPurposeCode;
  dynamic lmRemarks;
  dynamic lmAbOpenImage;
  dynamic lmAbOpenLat;
  dynamic lmAbOpenLon;
  dynamic lmAbImgDate;
  dynamic lmLocalImage;
  dynamic lmLocalOpenLat;
  dynamic lmLocalOpenLon;
  dynamic lmLocalImgDate;
  dynamic lmRemoteImage;
  dynamic lmRemoteOpenLat;
  dynamic lmRemoteOpenLon;
  dynamic lmRemoteImgDate;
  dynamic fieldStaffEmployeeId;
  dynamic fieldStaffDeviceId;
  dynamic localEarthingImage;
  dynamic localEarthLat;
  dynamic localEarthLon;
  dynamic localEartImgDate;
  dynamic localEarthingRemoveImage;
  dynamic localEarthRmvLat;
  dynamic localEarthRmvLon;
  dynamic localEarthRemoveImgDate;
  dynamic lmAbCloseImage;
  dynamic lmAbCloseLat;
  dynamic lmAbCloseLon;
  dynamic lmAbClsdImgDate;
  dynamic scadaCbRef;
  dynamic scadaCbOpenDate;
  dynamic scadaCbOpenIp;
  dynamic scadaCbCloseDate;
  dynamic scadaCbCloseIp;
  dynamic scadaCbOpenUser;
  dynamic scadaCbCloseUser;
  String? sectionId;
  String? subDivisionId;
  String? divisionId;
  String? circleId;
  dynamic aeEmpId;
  dynamic adeEmpId;
  dynamic lcApprovedEmpId;
  dynamic lcApprovedDate;
  dynamic lcForwardAeEmpId;
  dynamic lcForwardedDate;
  dynamic cbCloseReqEmpId;
  dynamic cbCloseReqDate;
  String? status;
  dynamic ssOpVcbOpenImage;
  dynamic ssOpAbswOpenImage;
  dynamic inLineLCStaffEntitiesByLcId;
  dynamic employeeMasterEntityByLcRequestedEmpId;
  dynamic employeeMasterEntityByLcApprovedEmpId;
  dynamic employeeMasterEntityByFieldStaffEmployeeId;
  String? fdrName;
  String? ssName;
  dynamic routeFlag;
  dynamic ssOpEmpId;
  dynamic ssOpCbOpenDate;
  dynamic ssOpCbOpenIp;
  dynamic ssOpCbCloseDate;
  dynamic ssOpCbCloseIp;
  dynamic ssOpCbOpenEmpId;
  dynamic ssOpCbOpenEmpName;
  dynamic ssOpCbCloseEmpName;
  dynamic ssOPCbCloseEmpId;
  dynamic lcRejectedAeEmpId;
  dynamic aeLcRejDate;
  dynamic lcRejAeReason;
  dynamic lcRejectedAdeEmpId;
  dynamic adeLcRejDate;
  dynamic lcRejAdeReason;
  dynamic adeLcPermitDate;
  dynamic lcInductionPointsEntitiesByLcId;

  AllLcRequestList copyWith({
    String? lcId,
    String? ssCode,
    String? fdrCode,
    dynamic voltage,
    String? lmEmployeeId,
    String? lmDeviceId,
    String? requestDate,
    String? expLcStartDate,
    String? expLcStartTime,
    String? expLcEndDate,
    String? expLcEndTime,
    String? expLcDuration,
    String? lcPurpose,
    String? lcPurposeCode,
    dynamic lmRemarks,
    dynamic lmAbOpenImage,
    dynamic lmAbOpenLat,
    dynamic lmAbOpenLon,
    dynamic lmAbImgDate,
    dynamic lmLocalImage,
    dynamic lmLocalOpenLat,
    dynamic lmLocalOpenLon,
    dynamic lmLocalImgDate,
    dynamic lmRemoteImage,
    dynamic lmRemoteOpenLat,
    dynamic lmRemoteOpenLon,
    dynamic lmRemoteImgDate,
    dynamic fieldStaffEmployeeId,
    dynamic fieldStaffDeviceId,
    dynamic localEarthingImage,
    dynamic localEarthLat,
    dynamic localEarthLon,
    dynamic localEartImgDate,
    dynamic localEarthingRemoveImage,
    dynamic localEarthRmvLat,
    dynamic localEarthRmvLon,
    dynamic localEarthRemoveImgDate,
    dynamic lmAbCloseImage,
    dynamic lmAbCloseLat,
    dynamic lmAbCloseLon,
    dynamic lmAbClsdImgDate,
    dynamic scadaCbRef,
    dynamic scadaCbOpenDate,
    dynamic scadaCbOpenIp,
    dynamic scadaCbCloseDate,
    dynamic scadaCbCloseIp,
    dynamic scadaCbOpenUser,
    dynamic scadaCbCloseUser,
    String? sectionId,
    String? subDivisionId,
    String? divisionId,
    String? circleId,
    dynamic aeEmpId,
    dynamic adeEmpId,
    dynamic lcApprovedEmpId,
    dynamic lcApprovedDate,
    dynamic lcForwardAeEmpId,
    dynamic lcForwardedDate,
    dynamic cbCloseReqEmpId,
    dynamic cbCloseReqDate,
    String? status,
    dynamic ssOpVcbOpenImage,
    dynamic ssOpAbswOpenImage,
    dynamic inLineLCStaffEntitiesByLcId,
    dynamic employeeMasterEntityByLcRequestedEmpId,
    dynamic employeeMasterEntityByLcApprovedEmpId,
    dynamic employeeMasterEntityByFieldStaffEmployeeId,
    String? fdrName,
    String? ssName,
    dynamic routeFlag,
    dynamic ssOpEmpId,
    dynamic ssOpCbOpenDate,
    dynamic ssOpCbOpenIp,
    dynamic ssOpCbCloseDate,
    dynamic ssOpCbCloseIp,
    dynamic ssOpCbOpenEmpId,
    dynamic ssOpCbOpenEmpName,
    dynamic ssOpCbCloseEmpName,
    dynamic ssOPCbCloseEmpId,
    dynamic lcRejectedAeEmpId,
    dynamic aeLcRejDate,
    dynamic lcRejAeReason,
    dynamic lcRejectedAdeEmpId,
    dynamic adeLcRejDate,
    dynamic lcRejAdeReason,
    dynamic adeLcPermitDate,
    dynamic lcInductionPointsEntitiesByLcId,
  }) =>
      AllLcRequestList(
        lcId: lcId ?? this.lcId,
        ssCode: ssCode ?? this.ssCode,
        fdrCode: fdrCode ?? this.fdrCode,
        voltage: voltage ?? this.voltage,
        lmEmployeeId: lmEmployeeId ?? this.lmEmployeeId,
        lmDeviceId: lmDeviceId ?? this.lmDeviceId,
        requestDate: requestDate ?? this.requestDate,
        expLcStartDate: expLcStartDate ?? this.expLcStartDate,
        expLcStartTime: expLcStartTime ?? this.expLcStartTime,
        expLcEndDate: expLcEndDate ?? this.expLcEndDate,
        expLcEndTime: expLcEndTime ?? this.expLcEndTime,
        expLcDuration: expLcDuration ?? this.expLcDuration,
        lcPurpose: lcPurpose ?? this.lcPurpose,
        lcPurposeCode: lcPurposeCode ?? this.lcPurposeCode,
        lmRemarks: lmRemarks ?? this.lmRemarks,
        lmAbOpenImage: lmAbOpenImage ?? this.lmAbOpenImage,
        lmAbOpenLat: lmAbOpenLat ?? this.lmAbOpenLat,
        lmAbOpenLon: lmAbOpenLon ?? this.lmAbOpenLon,
        lmAbImgDate: lmAbImgDate ?? this.lmAbImgDate,
        lmLocalImage: lmLocalImage ?? this.lmLocalImage,
        lmLocalOpenLat: lmLocalOpenLat ?? this.lmLocalOpenLat,
        lmLocalOpenLon: lmLocalOpenLon ?? this.lmLocalOpenLon,
        lmLocalImgDate: lmLocalImgDate ?? this.lmLocalImgDate,
        lmRemoteImage: lmRemoteImage ?? this.lmRemoteImage,
        lmRemoteOpenLat: lmRemoteOpenLat ?? this.lmRemoteOpenLat,
        lmRemoteOpenLon: lmRemoteOpenLon ?? this.lmRemoteOpenLon,
        lmRemoteImgDate: lmRemoteImgDate ?? this.lmRemoteImgDate,
        fieldStaffEmployeeId: fieldStaffEmployeeId ?? this.fieldStaffEmployeeId,
        fieldStaffDeviceId: fieldStaffDeviceId ?? this.fieldStaffDeviceId,
        localEarthingImage: localEarthingImage ?? this.localEarthingImage,
        localEarthLat: localEarthLat ?? this.localEarthLat,
        localEarthLon: localEarthLon ?? this.localEarthLon,
        localEartImgDate: localEartImgDate ?? this.localEartImgDate,
        localEarthingRemoveImage:
            localEarthingRemoveImage ?? this.localEarthingRemoveImage,
        localEarthRmvLat: localEarthRmvLat ?? this.localEarthRmvLat,
        localEarthRmvLon: localEarthRmvLon ?? this.localEarthRmvLon,
        localEarthRemoveImgDate:
            localEarthRemoveImgDate ?? this.localEarthRemoveImgDate,
        lmAbCloseImage: lmAbCloseImage ?? this.lmAbCloseImage,
        lmAbCloseLat: lmAbCloseLat ?? this.lmAbCloseLat,
        lmAbCloseLon: lmAbCloseLon ?? this.lmAbCloseLon,
        lmAbClsdImgDate: lmAbClsdImgDate ?? this.lmAbClsdImgDate,
        scadaCbRef: scadaCbRef ?? this.scadaCbRef,
        scadaCbOpenDate: scadaCbOpenDate ?? this.scadaCbOpenDate,
        scadaCbOpenIp: scadaCbOpenIp ?? this.scadaCbOpenIp,
        scadaCbCloseDate: scadaCbCloseDate ?? this.scadaCbCloseDate,
        scadaCbCloseIp: scadaCbCloseIp ?? this.scadaCbCloseIp,
        scadaCbOpenUser: scadaCbOpenUser ?? this.scadaCbOpenUser,
        scadaCbCloseUser: scadaCbCloseUser ?? this.scadaCbCloseUser,
        sectionId: sectionId ?? this.sectionId,
        subDivisionId: subDivisionId ?? this.subDivisionId,
        divisionId: divisionId ?? this.divisionId,
        circleId: circleId ?? this.circleId,
        aeEmpId: aeEmpId ?? this.aeEmpId,
        adeEmpId: adeEmpId ?? this.adeEmpId,
        lcApprovedEmpId: lcApprovedEmpId ?? this.lcApprovedEmpId,
        lcApprovedDate: lcApprovedDate ?? this.lcApprovedDate,
        lcForwardAeEmpId: lcForwardAeEmpId ?? this.lcForwardAeEmpId,
        lcForwardedDate: lcForwardedDate ?? this.lcForwardedDate,
        cbCloseReqEmpId: cbCloseReqEmpId ?? this.cbCloseReqEmpId,
        cbCloseReqDate: cbCloseReqDate ?? this.cbCloseReqDate,
        status: status ?? this.status,
        ssOpVcbOpenImage: ssOpVcbOpenImage ?? this.ssOpVcbOpenImage,
        ssOpAbswOpenImage: ssOpAbswOpenImage ?? this.ssOpAbswOpenImage,
        inLineLCStaffEntitiesByLcId:
            inLineLCStaffEntitiesByLcId ?? this.inLineLCStaffEntitiesByLcId,
        employeeMasterEntityByLcRequestedEmpId:
            employeeMasterEntityByLcRequestedEmpId ??
                this.employeeMasterEntityByLcRequestedEmpId,
        employeeMasterEntityByLcApprovedEmpId:
            employeeMasterEntityByLcApprovedEmpId ??
                this.employeeMasterEntityByLcApprovedEmpId,
        employeeMasterEntityByFieldStaffEmployeeId:
            employeeMasterEntityByFieldStaffEmployeeId ??
                this.employeeMasterEntityByFieldStaffEmployeeId,
        fdrName: fdrName ?? this.fdrName,
        ssName: ssName ?? this.ssName,
        routeFlag: routeFlag ?? this.routeFlag,
        ssOpEmpId: ssOpEmpId ?? this.ssOpEmpId,
        ssOpCbOpenDate: ssOpCbOpenDate ?? this.ssOpCbOpenDate,
        ssOpCbOpenIp: ssOpCbOpenIp ?? this.ssOpCbOpenIp,
        ssOpCbCloseDate: ssOpCbCloseDate ?? this.ssOpCbCloseDate,
        ssOpCbCloseIp: ssOpCbCloseIp ?? this.ssOpCbCloseIp,
        ssOpCbOpenEmpId: ssOpCbOpenEmpId ?? this.ssOpCbOpenEmpId,
        ssOpCbOpenEmpName: ssOpCbOpenEmpName ?? this.ssOpCbOpenEmpName,
        ssOpCbCloseEmpName: ssOpCbCloseEmpName ?? this.ssOpCbCloseEmpName,
        ssOPCbCloseEmpId: ssOPCbCloseEmpId ?? this.ssOPCbCloseEmpId,
        lcRejectedAeEmpId: lcRejectedAeEmpId ?? this.lcRejectedAeEmpId,
        aeLcRejDate: aeLcRejDate ?? this.aeLcRejDate,
        lcRejAeReason: lcRejAeReason ?? this.lcRejAeReason,
        lcRejectedAdeEmpId: lcRejectedAdeEmpId ?? this.lcRejectedAdeEmpId,
        adeLcRejDate: adeLcRejDate ?? this.adeLcRejDate,
        lcRejAdeReason: lcRejAdeReason ?? this.lcRejAdeReason,
        adeLcPermitDate: adeLcPermitDate ?? this.adeLcPermitDate,
        lcInductionPointsEntitiesByLcId: lcInductionPointsEntitiesByLcId ??
            this.lcInductionPointsEntitiesByLcId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lcId'] = lcId;
    map['ssCode'] = ssCode;
    map['fdrCode'] = fdrCode;
    map['voltage'] = voltage;
    map['lmEmployeeId'] = lmEmployeeId;
    map['lmDeviceId'] = lmDeviceId;
    map['requestDate'] = requestDate;
    map['expLcStartDate'] = expLcStartDate;
    map['expLcStartTime'] = expLcStartTime;
    map['expLcEndDate'] = expLcEndDate;
    map['expLcEndTime'] = expLcEndTime;
    map['expLcDuration'] = expLcDuration;
    map['lcPurpose'] = lcPurpose;
    map['lcPurposeCode'] = lcPurposeCode;
    map['lmRemarks'] = lmRemarks;
    map['lmAbOpenImage'] = lmAbOpenImage;
    map['lmAbOpenLat'] = lmAbOpenLat;
    map['lmAbOpenLon'] = lmAbOpenLon;
    map['lmAbImgDate'] = lmAbImgDate;
    map['lmLocalImage'] = lmLocalImage;
    map['lmLocalOpenLat'] = lmLocalOpenLat;
    map['lmLocalOpenLon'] = lmLocalOpenLon;
    map['lmLocalImgDate'] = lmLocalImgDate;
    map['lmRemoteImage'] = lmRemoteImage;
    map['lmRemoteOpenLat'] = lmRemoteOpenLat;
    map['lmRemoteOpenLon'] = lmRemoteOpenLon;
    map['lmRemoteImgDate'] = lmRemoteImgDate;
    map['fieldStaffEmployeeId'] = fieldStaffEmployeeId;
    map['fieldStaffDeviceId'] = fieldStaffDeviceId;
    map['localEarthingImage'] = localEarthingImage;
    map['localEarthLat'] = localEarthLat;
    map['localEarthLon'] = localEarthLon;
    map['localEartImgDate'] = localEartImgDate;
    map['localEarthingRemoveImage'] = localEarthingRemoveImage;
    map['localEarthRmvLat'] = localEarthRmvLat;
    map['localEarthRmvLon'] = localEarthRmvLon;
    map['localEarthRemoveImgDate'] = localEarthRemoveImgDate;
    map['lmAbCloseImage'] = lmAbCloseImage;
    map['lmAbCloseLat'] = lmAbCloseLat;
    map['lmAbCloseLon'] = lmAbCloseLon;
    map['lmAbClsdImgDate'] = lmAbClsdImgDate;
    map['scadaCbRef'] = scadaCbRef;
    map['scadaCbOpenDate'] = scadaCbOpenDate;
    map['scadaCbOpenIp'] = scadaCbOpenIp;
    map['scadaCbCloseDate'] = scadaCbCloseDate;
    map['scadaCbCloseIp'] = scadaCbCloseIp;
    map['scadaCbOpenUser'] = scadaCbOpenUser;
    map['scadaCbCloseUser'] = scadaCbCloseUser;
    map['sectionId'] = sectionId;
    map['subDivisionId'] = subDivisionId;
    map['divisionId'] = divisionId;
    map['circleId'] = circleId;
    map['aeEmpId'] = aeEmpId;
    map['adeEmpId'] = adeEmpId;
    map['lcApprovedEmpId'] = lcApprovedEmpId;
    map['lcApprovedDate'] = lcApprovedDate;
    map['lcForwardAeEmpId'] = lcForwardAeEmpId;
    map['lcForwardedDate'] = lcForwardedDate;
    map['cbCloseReqEmpId'] = cbCloseReqEmpId;
    map['cbCloseReqDate'] = cbCloseReqDate;
    map['status'] = status;
    map['ssOpVcbOpenImage'] = ssOpVcbOpenImage;
    map['ssOpAbswOpenImage'] = ssOpAbswOpenImage;
    map['inLineLCStaffEntitiesByLcId'] = inLineLCStaffEntitiesByLcId;
    map['employeeMasterEntityByLcRequestedEmpId'] =
        employeeMasterEntityByLcRequestedEmpId;
    map['employeeMasterEntityByLcApprovedEmpId'] =
        employeeMasterEntityByLcApprovedEmpId;
    map['employeeMasterEntityByFieldStaffEmployeeId'] =
        employeeMasterEntityByFieldStaffEmployeeId;
    map['fdrName'] = fdrName;
    map['ssName'] = ssName;
    map['routeFlag'] = routeFlag;
    map['ssOpEmpId'] = ssOpEmpId;
    map['ssOpCbOpenDate'] = ssOpCbOpenDate;
    map['ssOpCbOpenIp'] = ssOpCbOpenIp;
    map['ssOpCbCloseDate'] = ssOpCbCloseDate;
    map['ssOpCbCloseIp'] = ssOpCbCloseIp;
    map['ssOpCbOpenEmpId'] = ssOpCbOpenEmpId;
    map['ssOpCbOpenEmpName'] = ssOpCbOpenEmpName;
    map['ssOpCbCloseEmpName'] = ssOpCbCloseEmpName;
    map['ssOPCbCloseEmpId'] = ssOPCbCloseEmpId;
    map['lcRejectedAeEmpId'] = lcRejectedAeEmpId;
    map['aeLcRejDate'] = aeLcRejDate;
    map['lcRejAeReason'] = lcRejAeReason;
    map['lcRejectedAdeEmpId'] = lcRejectedAdeEmpId;
    map['adeLcRejDate'] = adeLcRejDate;
    map['lcRejAdeReason'] = lcRejAdeReason;
    map['adeLcPermitDate'] = adeLcPermitDate;
    map['lcInductionPointsEntitiesByLcId'] = lcInductionPointsEntitiesByLcId;
    return map;
  }
}
