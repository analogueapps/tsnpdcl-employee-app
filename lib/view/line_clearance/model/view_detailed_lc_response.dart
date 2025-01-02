import 'dart:convert';

ViewDetailedLcResponse viewDetailedLcResponseFromJson(String str) =>
    ViewDetailedLcResponse.fromJson(json.decode(str));

String viewDetailedLcResponseToJson(ViewDetailedLcResponse data) =>
    json.encode(data.toJson());

class ViewDetailedLcResponse {
  ViewDetailedLcResponse({
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

  ViewDetailedLcResponse.fromJson(dynamic json) {
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
    if (json['inLineLCStaffEntitiesByLcId'] != null) {
      inLineLCStaffEntitiesByLcId = [];
      json['inLineLCStaffEntitiesByLcId'].forEach((v) {
        inLineLCStaffEntitiesByLcId
            ?.add(InLineLcStaffEntitiesByLcId.fromJson(v));
      });
    }
    employeeMasterEntityByLcRequestedEmpId =
        json['employeeMasterEntityByLcRequestedEmpId'] != null
            ? EmployeeMasterEntityByLcRequestedEmpId.fromJson(
                json['employeeMasterEntityByLcRequestedEmpId'])
            : null;
    employeeMasterEntityByLcApprovedEmpId =
        json['employeeMasterEntityByLcApprovedEmpId'] != null
            ? EmployeeMasterEntityByLcApprovedEmpId.fromJson(
                json['employeeMasterEntityByLcApprovedEmpId'])
            : null;
    employeeMasterEntityByFieldStaffEmployeeId =
        json['employeeMasterEntityByFieldStaffEmployeeId'] != null
            ? EmployeeMasterEntityByFieldStaffEmployeeId.fromJson(
                json['employeeMasterEntityByFieldStaffEmployeeId'])
            : null;
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
    if (json['lcInductionPointsEntitiesByLcId'] != null) {
      lcInductionPointsEntitiesByLcId = [];
      // json['lcInductionPointsEntitiesByLcId'].forEach((v) {
      //   lcInductionPointsEntitiesByLcId?.add(Dynamic.fromJson(v));
      // });
    }
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
  String? lmRemarks;
  String? lmAbOpenImage;
  num? lmAbOpenLat;
  num? lmAbOpenLon;
  String? lmAbImgDate;
  String? lmLocalImage;
  num? lmLocalOpenLat;
  num? lmLocalOpenLon;
  String? lmLocalImgDate;
  String? lmRemoteImage;
  num? lmRemoteOpenLat;
  num? lmRemoteOpenLon;
  String? lmRemoteImgDate;
  String? fieldStaffEmployeeId;
  String? fieldStaffDeviceId;
  String? localEarthingImage;
  num? localEarthLat;
  num? localEarthLon;
  String? localEartImgDate;
  String? localEarthingRemoveImage;
  num? localEarthRmvLat;
  num? localEarthRmvLon;
  String? localEarthRemoveImgDate;
  String? lmAbCloseImage;
  num? lmAbCloseLat;
  num? lmAbCloseLon;
  String? lmAbClsdImgDate;
  dynamic scadaCbRef;
  String? scadaCbOpenDate;
  String? scadaCbOpenIp;
  String? scadaCbCloseDate;
  String? scadaCbCloseIp;
  String? scadaCbOpenUser;
  String? scadaCbCloseUser;
  String? sectionId;
  String? subDivisionId;
  String? divisionId;
  String? circleId;
  String? aeEmpId;
  dynamic adeEmpId;
  String? lcApprovedEmpId;
  String? lcApprovedDate;
  dynamic lcForwardAeEmpId;
  dynamic lcForwardedDate;
  String? cbCloseReqEmpId;
  String? cbCloseReqDate;
  String? status;
  dynamic ssOpVcbOpenImage;
  dynamic ssOpAbswOpenImage;
  List<InLineLcStaffEntitiesByLcId>? inLineLCStaffEntitiesByLcId;
  EmployeeMasterEntityByLcRequestedEmpId?
      employeeMasterEntityByLcRequestedEmpId;
  EmployeeMasterEntityByLcApprovedEmpId? employeeMasterEntityByLcApprovedEmpId;
  EmployeeMasterEntityByFieldStaffEmployeeId?
      employeeMasterEntityByFieldStaffEmployeeId;
  dynamic fdrName;
  dynamic ssName;
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
  List<dynamic>? lcInductionPointsEntitiesByLcId;

  ViewDetailedLcResponse copyWith({
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
    String? lmRemarks,
    String? lmAbOpenImage,
    num? lmAbOpenLat,
    num? lmAbOpenLon,
    String? lmAbImgDate,
    String? lmLocalImage,
    num? lmLocalOpenLat,
    num? lmLocalOpenLon,
    String? lmLocalImgDate,
    String? lmRemoteImage,
    num? lmRemoteOpenLat,
    num? lmRemoteOpenLon,
    String? lmRemoteImgDate,
    String? fieldStaffEmployeeId,
    String? fieldStaffDeviceId,
    String? localEarthingImage,
    num? localEarthLat,
    num? localEarthLon,
    String? localEartImgDate,
    String? localEarthingRemoveImage,
    num? localEarthRmvLat,
    num? localEarthRmvLon,
    String? localEarthRemoveImgDate,
    String? lmAbCloseImage,
    num? lmAbCloseLat,
    num? lmAbCloseLon,
    String? lmAbClsdImgDate,
    dynamic scadaCbRef,
    String? scadaCbOpenDate,
    String? scadaCbOpenIp,
    String? scadaCbCloseDate,
    String? scadaCbCloseIp,
    String? scadaCbOpenUser,
    String? scadaCbCloseUser,
    String? sectionId,
    String? subDivisionId,
    String? divisionId,
    String? circleId,
    String? aeEmpId,
    dynamic adeEmpId,
    String? lcApprovedEmpId,
    String? lcApprovedDate,
    dynamic lcForwardAeEmpId,
    dynamic lcForwardedDate,
    String? cbCloseReqEmpId,
    String? cbCloseReqDate,
    String? status,
    dynamic ssOpVcbOpenImage,
    dynamic ssOpAbswOpenImage,
    List<InLineLcStaffEntitiesByLcId>? inLineLCStaffEntitiesByLcId,
    EmployeeMasterEntityByLcRequestedEmpId?
        employeeMasterEntityByLcRequestedEmpId,
    EmployeeMasterEntityByLcApprovedEmpId?
        employeeMasterEntityByLcApprovedEmpId,
    EmployeeMasterEntityByFieldStaffEmployeeId?
        employeeMasterEntityByFieldStaffEmployeeId,
    dynamic fdrName,
    dynamic ssName,
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
    List<dynamic>? lcInductionPointsEntitiesByLcId,
  }) =>
      ViewDetailedLcResponse(
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
    if (inLineLCStaffEntitiesByLcId != null) {
      map['inLineLCStaffEntitiesByLcId'] =
          inLineLCStaffEntitiesByLcId?.map((v) => v.toJson()).toList();
    }
    if (employeeMasterEntityByLcRequestedEmpId != null) {
      map['employeeMasterEntityByLcRequestedEmpId'] =
          employeeMasterEntityByLcRequestedEmpId?.toJson();
    }
    if (employeeMasterEntityByLcApprovedEmpId != null) {
      map['employeeMasterEntityByLcApprovedEmpId'] =
          employeeMasterEntityByLcApprovedEmpId?.toJson();
    }
    if (employeeMasterEntityByFieldStaffEmployeeId != null) {
      map['employeeMasterEntityByFieldStaffEmployeeId'] =
          employeeMasterEntityByFieldStaffEmployeeId?.toJson();
    }
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
    if (lcInductionPointsEntitiesByLcId != null) {
      map['lcInductionPointsEntitiesByLcId'] =
          lcInductionPointsEntitiesByLcId?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

EmployeeMasterEntityByFieldStaffEmployeeId
    employeeMasterEntityByFieldStaffEmployeeIdFromJson(String str) =>
        EmployeeMasterEntityByFieldStaffEmployeeId.fromJson(json.decode(str));

String employeeMasterEntityByFieldStaffEmployeeIdToJson(
        EmployeeMasterEntityByFieldStaffEmployeeId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByFieldStaffEmployeeId {
  EmployeeMasterEntityByFieldStaffEmployeeId({
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

  EmployeeMasterEntityByFieldStaffEmployeeId.fromJson(dynamic json) {
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

  EmployeeMasterEntityByFieldStaffEmployeeId copyWith({
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
      EmployeeMasterEntityByFieldStaffEmployeeId(
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

EmployeeMasterEntityByLcApprovedEmpId
    employeeMasterEntityByLcApprovedEmpIdFromJson(String str) =>
        EmployeeMasterEntityByLcApprovedEmpId.fromJson(json.decode(str));

String employeeMasterEntityByLcApprovedEmpIdToJson(
        EmployeeMasterEntityByLcApprovedEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByLcApprovedEmpId {
  EmployeeMasterEntityByLcApprovedEmpId({
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

  EmployeeMasterEntityByLcApprovedEmpId.fromJson(dynamic json) {
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

  EmployeeMasterEntityByLcApprovedEmpId copyWith({
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
      EmployeeMasterEntityByLcApprovedEmpId(
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

EmployeeMasterEntityByLcRequestedEmpId
    employeeMasterEntityByLcRequestedEmpIdFromJson(String str) =>
        EmployeeMasterEntityByLcRequestedEmpId.fromJson(json.decode(str));

String employeeMasterEntityByLcRequestedEmpIdToJson(
        EmployeeMasterEntityByLcRequestedEmpId data) =>
    json.encode(data.toJson());

class EmployeeMasterEntityByLcRequestedEmpId {
  EmployeeMasterEntityByLcRequestedEmpId({
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

  EmployeeMasterEntityByLcRequestedEmpId.fromJson(dynamic json) {
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
  String? empPost;
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

  EmployeeMasterEntityByLcRequestedEmpId copyWith({
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
    String? empPost,
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
      EmployeeMasterEntityByLcRequestedEmpId(
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

InLineLcStaffEntitiesByLcId inLineLcStaffEntitiesByLcIdFromJson(String str) =>
    InLineLcStaffEntitiesByLcId.fromJson(json.decode(str));

String inLineLcStaffEntitiesByLcIdToJson(InLineLcStaffEntitiesByLcId data) =>
    json.encode(data.toJson());

class InLineLcStaffEntitiesByLcId {
  InLineLcStaffEntitiesByLcId({
    this.inLineId,
    this.lcId,
    this.fieldStaffEmpId,
    this.fieldStaffEmpName,
    this.fieldStaffEmpDesignation,
    this.fieldStaffEmpDesignationCode,
    this.insertDate,
  });

  InLineLcStaffEntitiesByLcId.fromJson(dynamic json) {
    inLineId = json['inLineId'];
    lcId = json['lcId'];
    fieldStaffEmpId = json['fieldStaffEmpId'];
    fieldStaffEmpName = json['fieldStaffEmpName'];
    fieldStaffEmpDesignation = json['fieldStaffEmpDesignation'];
    fieldStaffEmpDesignationCode = json['fieldStaffEmpDesignationCode'];
    insertDate = json['insertDate'];
  }

  num? inLineId;
  String? lcId;
  String? fieldStaffEmpId;
  String? fieldStaffEmpName;
  String? fieldStaffEmpDesignation;
  String? fieldStaffEmpDesignationCode;
  String? insertDate;

  InLineLcStaffEntitiesByLcId copyWith({
    num? inLineId,
    String? lcId,
    String? fieldStaffEmpId,
    String? fieldStaffEmpName,
    String? fieldStaffEmpDesignation,
    String? fieldStaffEmpDesignationCode,
    String? insertDate,
  }) =>
      InLineLcStaffEntitiesByLcId(
        inLineId: inLineId ?? this.inLineId,
        lcId: lcId ?? this.lcId,
        fieldStaffEmpId: fieldStaffEmpId ?? this.fieldStaffEmpId,
        fieldStaffEmpName: fieldStaffEmpName ?? this.fieldStaffEmpName,
        fieldStaffEmpDesignation:
            fieldStaffEmpDesignation ?? this.fieldStaffEmpDesignation,
        fieldStaffEmpDesignationCode:
            fieldStaffEmpDesignationCode ?? this.fieldStaffEmpDesignationCode,
        insertDate: insertDate ?? this.insertDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inLineId'] = inLineId;
    map['lcId'] = lcId;
    map['fieldStaffEmpId'] = fieldStaffEmpId;
    map['fieldStaffEmpName'] = fieldStaffEmpName;
    map['fieldStaffEmpDesignation'] = fieldStaffEmpDesignation;
    map['fieldStaffEmpDesignationCode'] = fieldStaffEmpDesignationCode;
    map['insertDate'] = insertDate;
    return map;
  }
}
