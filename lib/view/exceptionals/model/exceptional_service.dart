import 'dart:convert';

ExceptionalService exceptionalServiceFromJson(String str) =>
    ExceptionalService.fromJson(json.decode(str));

String exceptionalServiceToJson(ExceptionalService data) =>
    json.encode(data.toJson());

class ExceptionalService {
  ExceptionalService({
    this.uscno,
    this.consumerName,
    this.cat,
    this.lat,
    this.lng,
    this.exceptionalCount,
    this.phone,
    this.address,
    this.sectionCode,
    this.eroCode,
    this.exceptionalType,
    this.scno,
    this.distCode,
    this.searchString,
  });

  ExceptionalService.fromJson(dynamic json) {
    uscno = json['uscno'];
    consumerName = json['consumerName'];
    cat = json['cat'];
    lat = json['lat'];
    lng = json['lng'];
    exceptionalCount = json['exceptionalCount'];
    phone = json['phone'];
    address = json['address'];
    sectionCode = json['sectionCode'];
    eroCode = json['eroCode'];
    exceptionalType = json['exceptionalType'];
    scno = json['scno'];
    distCode = json['distCode'];
    searchString = json['searchString'];
  }

  num? uscno;
  String? consumerName;
  String? cat;
  String? lat;
  String? lng;
  num? exceptionalCount;
  String? phone;
  String? address;
  String? sectionCode;
  String? eroCode;
  String? exceptionalType;
  String? scno;
  String? distCode;
  String? searchString;

  ExceptionalService copyWith({
    num? uscno,
    String? consumerName,
    String? cat,
    String? lat,
    String? lng,
    num? exceptionalCount,
    String? phone,
    String? address,
    String? sectionCode,
    String? eroCode,
    String? exceptionalType,
    String? scno,
    String? distCode,
    String? searchString,
  }) =>
      ExceptionalService(
        uscno: uscno ?? this.uscno,
        consumerName: consumerName ?? this.consumerName,
        cat: cat ?? this.cat,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        exceptionalCount: exceptionalCount ?? this.exceptionalCount,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        sectionCode: sectionCode ?? this.sectionCode,
        eroCode: eroCode ?? this.eroCode,
        exceptionalType: exceptionalType ?? this.exceptionalType,
        scno: scno ?? this.scno,
        distCode: distCode ?? this.distCode,
        searchString: searchString ?? this.searchString,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uscno'] = uscno;
    map['consumerName'] = consumerName;
    map['cat'] = cat;
    map['lat'] = lat;
    map['lng'] = lng;
    map['exceptionalCount'] = exceptionalCount;
    map['phone'] = phone;
    map['address'] = address;
    map['sectionCode'] = sectionCode;
    map['eroCode'] = eroCode;
    map['exceptionalType'] = exceptionalType;
    map['scno'] = scno;
    map['distCode'] = distCode;
    map['searchString'] = searchString;
    return map;
  }
}
