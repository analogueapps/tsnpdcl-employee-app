import 'dart:convert';

PoleManufacturingFirmEntity poleManufacturingFirmEntityFromJson(String str) =>
    PoleManufacturingFirmEntity.fromJson(json.decode(str));

String poleManufacturingFirmEntityToJson(PoleManufacturingFirmEntity data) =>
    json.encode(data.toJson());

class PoleManufacturingFirmEntity {
  PoleManufacturingFirmEntity({
    this.firmId,
    this.mobileNo,
    this.firmName,
    this.sapVendorId,
    this.blockListed,
    this.insertDate,
    this.createdIpAddress,
    this.createdEmpId,
    this.supplierName,
    this.email,
  });

  PoleManufacturingFirmEntity.fromJson(dynamic json) {
    firmId = json['firmId'];
    mobileNo = json['mobileNo'];
    firmName = json['firmName'];
    sapVendorId = json['sapVendorId'];
    blockListed = json['blockListed'];
    insertDate = json['insertDate'];
    createdIpAddress = json['createdIpAddress'];
    createdEmpId = json['createdEmpId'];
    supplierName = json['supplierName'];
    email = json['email'];
  }

  num? firmId;
  String? mobileNo;
  String? firmName;
  String? sapVendorId;
  String? blockListed;
  String? insertDate;
  String? createdIpAddress;
  String? createdEmpId;
  String? supplierName;
  String? email;

  PoleManufacturingFirmEntity copyWith({
    num? firmId,
    String? mobileNo,
    String? firmName,
    String? sapVendorId,
    String? blockListed,
    String? insertDate,
    String? createdIpAddress,
    String? createdEmpId,
    String? supplierName,
    String? email,
  }) =>
      PoleManufacturingFirmEntity(
        firmId: firmId ?? this.firmId,
        mobileNo: mobileNo ?? this.mobileNo,
        firmName: firmName ?? this.firmName,
        sapVendorId: sapVendorId ?? this.sapVendorId,
        blockListed: blockListed ?? this.blockListed,
        insertDate: insertDate ?? this.insertDate,
        createdIpAddress: createdIpAddress ?? this.createdIpAddress,
        createdEmpId: createdEmpId ?? this.createdEmpId,
        supplierName: supplierName ?? this.supplierName,
        email: email ?? this.email,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firmId'] = firmId;
    map['mobileNo'] = mobileNo;
    map['firmName'] = firmName;
    map['sapVendorId'] = sapVendorId;
    map['blockListed'] = blockListed;
    map['insertDate'] = insertDate;
    map['createdIpAddress'] = createdIpAddress;
    map['createdEmpId'] = createdEmpId;
    map['supplierName'] = supplierName;
    map['email'] = email;
    return map;
  }
}
