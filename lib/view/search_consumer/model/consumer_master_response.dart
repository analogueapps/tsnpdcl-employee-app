import 'dart:convert';

ConsumerMasterResponse consumerMasterResponseFromJson(String str) =>
    ConsumerMasterResponse.fromJson(json.decode(str));

String consumerMasterResponseToJson(ConsumerMasterResponse data) =>
    json.encode(data.toJson());

class ConsumerMasterResponse {
  ConsumerMasterResponse({
    this.accStatus,
    this.address,
    this.cat,
    this.consumerName,
    this.erono,
    this.errorCause,
    this.latitude,
    this.load,
    this.longitude,
    this.mobileNo,
    this.poleNo,
    this.scno,
    this.status,
    this.subcat,
  });

  ConsumerMasterResponse.fromJson(dynamic json) {
    accStatus = json['accStatus'];
    address = json['address'];
    cat = json['cat'];
    consumerName = json['consumerName'];
    erono = json['erono'];
    errorCause = json['errorCause'];
    latitude = json['latitude'];
    load = json['load'];
    longitude = json['longitude'];
    mobileNo = json['mobileNo'];
    poleNo = json['poleNo'];
    scno = json['scno'];
    status = json['status'];
    subcat = json['subcat'];
  }

  String? accStatus;
  String? address;
  String? cat;
  String? consumerName;
  String? erono;
  String? errorCause;
  String? latitude;
  String? load;
  String? longitude;
  String? mobileNo;
  String? poleNo;
  String? scno;
  String? status;
  String? subcat;

  ConsumerMasterResponse copyWith({
    String? accStatus,
    String? address,
    String? cat,
    String? consumerName,
    String? erono,
    String? errorCause,
    String? latitude,
    String? load,
    String? longitude,
    String? mobileNo,
    String? poleNo,
    String? scno,
    String? status,
    String? subcat,
  }) =>
      ConsumerMasterResponse(
        accStatus: accStatus ?? this.accStatus,
        address: address ?? this.address,
        cat: cat ?? this.cat,
        consumerName: consumerName ?? this.consumerName,
        erono: erono ?? this.erono,
        errorCause: errorCause ?? this.errorCause,
        latitude: latitude ?? this.latitude,
        load: load ?? this.load,
        longitude: longitude ?? this.longitude,
        mobileNo: mobileNo ?? this.mobileNo,
        poleNo: poleNo ?? this.poleNo,
        scno: scno ?? this.scno,
        status: status ?? this.status,
        subcat: subcat ?? this.subcat,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accStatus'] = accStatus;
    map['address'] = address;
    map['cat'] = cat;
    map['consumerName'] = consumerName;
    map['erono'] = erono;
    map['errorCause'] = errorCause;
    map['latitude'] = latitude;
    map['load'] = load;
    map['longitude'] = longitude;
    map['mobileNo'] = mobileNo;
    map['poleNo'] = poleNo;
    map['scno'] = scno;
    map['status'] = status;
    map['subcat'] = subcat;
    return map;
  }
}
