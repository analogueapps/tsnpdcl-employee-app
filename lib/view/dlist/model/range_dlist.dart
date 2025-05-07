import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart' hide Cluster, ClusterManager;
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';


RangeDlist rangeDlistFromJson(String str) =>
    RangeDlist.fromJson(json.decode(str));

String rangeDlistToJson(RangeDlist data) => json.encode(data.toJson());

class RangeDlist {
  RangeDlist({
    this.monthYearOfcCodeRangeCode,
    this.dlistEntityRealmList,
  });

  RangeDlist.fromJson(dynamic json) {
    monthYearOfcCodeRangeCode = json['monthYearOfcCodeRangeCode'];
    if (json['dlistEntityRealmList'] != null) {
      dlistEntityRealmList = [];
      json['dlistEntityRealmList'].forEach((v) {
        dlistEntityRealmList?.add(DlistEntityRealmList.fromJson(v));
      });
    }
  }

  String? monthYearOfcCodeRangeCode;
  List<DlistEntityRealmList>? dlistEntityRealmList;

  RangeDlist copyWith({
    String? monthYearOfcCodeRangeCode,
    List<DlistEntityRealmList>? dlistEntityRealmList,
  }) =>
      RangeDlist(
        monthYearOfcCodeRangeCode:
            monthYearOfcCodeRangeCode ?? this.monthYearOfcCodeRangeCode,
        dlistEntityRealmList: dlistEntityRealmList ?? this.dlistEntityRealmList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['monthYearOfcCodeRangeCode'] = monthYearOfcCodeRangeCode;
    if (dlistEntityRealmList != null) {
      map['dlistEntityRealmList'] =
          dlistEntityRealmList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

DlistEntityRealmList dlistEntityRealmListFromJson(String str) =>
    DlistEntityRealmList.fromJson(json.decode(str));

String dlistEntityRealmListToJson(DlistEntityRealmList data) =>
    json.encode(data.toJson());

// class DlistEntityRealmList {
//   DlistEntityRealmList({
//     this.sno,
//     this.circleId,
//     this.circle,
//     this.divisionId,
//     this.division,
//     this.subDivisionId,
//     this.subDivision,
//     this.j2SSection,
//     this.ctseccd,
//     this.ctareacd,
//     this.secname,
//     this.areaname,
//     this.type,
//     this.dlscno,
//     this.dluan,
//     this.ctname,
//     this.ctadd2,
//     this.dlcat,
//     this.ctcycle,
//     this.ctsocialgroup,
//     this.dlstat,
//     this.ctpoleno,
//     this.discdt,
//     this.curdem,
//     this.sdbalamt,
//     this.lastpddt,
//     this.arrears,
//     this.dlamt,
//     this.ctphone,
//     this.latLong,
//     this.dlFlag,
//     this.dlmonyr,
//     this.searchString,
//     this.erocode,
//   });
//
//   DlistEntityRealmList.fromJson(dynamic json) {
//     sno = json['sno'];
//     circleId = json['circleId'];
//     circle = json['circle'];
//     divisionId = json['divisionId'];
//     division = json['division'];
//     subDivisionId = json['subDivisionId'];
//     subDivision = json['subDivision'];
//     j2SSection = json['j2SSection'];
//     ctseccd = json['ctseccd'];
//     ctareacd = json['ctareacd'];
//     secname = json['secname'];
//     areaname = json['areaname'];
//     type = json['type'];
//     dlscno = json['dlscno'];
//     dluan = json['dluan'];
//     ctname = json['ctname'];
//     ctadd2 = json['ctadd2'];
//     dlcat = json['dlcat'];
//     ctcycle = json['ctcycle'];
//     ctsocialgroup = json['ctsocialgroup'];
//     dlstat = json['dlstat'];
//     ctpoleno = json['ctpoleno'];
//     discdt = json['discdt'];
//     curdem = json['curdem'];
//     sdbalamt = json['sdbalamt'];
//     lastpddt = json['lastpddt'];
//     arrears = json['arrears'];
//     dlamt = json['dlamt'];
//     ctphone = json['ctphone'];
//     latLong = json['latLong'];
//     dlFlag = json['dlFlag'];
//     dlmonyr = json['dlmonyr'];
//     searchString = json['searchString'];
//     erocode = json['erocode'];
//   }
//
//   num? sno;
//   String? circleId;
//   String? circle;
//   String? divisionId;
//   String? division;
//   String? subDivisionId;
//   String? subDivision;
//   String? j2SSection;
//   String? ctseccd;
//   String? ctareacd;
//   String? secname;
//   String? areaname;
//   String? type;
//   String? dlscno;
//   num? dluan;
//   String? ctname;
//   String? ctadd2;
//   num? dlcat;
//   String? ctcycle;
//   String? ctsocialgroup;
//   String? dlstat;
//   String? ctpoleno;
//   String? discdt;
//   num? curdem;
//   num? sdbalamt;
//   String? lastpddt;
//   num? arrears;
//   num? dlamt;
//   num? ctphone;
//   String? latLong;
//   String? dlFlag;
//   String? dlmonyr;
//   String? searchString;
//   num? erocode;
//
//   DlistEntityRealmList copyWith({
//     num? sno,
//     String? circleId,
//     String? circle,
//     String? divisionId,
//     String? division,
//     String? subDivisionId,
//     String? subDivision,
//     String? j2SSection,
//     String? ctseccd,
//     String? ctareacd,
//     String? secname,
//     String? areaname,
//     String? type,
//     String? dlscno,
//     num? dluan,
//     String? ctname,
//     String? ctadd2,
//     num? dlcat,
//     String? ctcycle,
//     String? ctsocialgroup,
//     String? dlstat,
//     String? ctpoleno,
//     String? discdt,
//     num? curdem,
//     num? sdbalamt,
//     String? lastpddt,
//     num? arrears,
//     num? dlamt,
//     num? ctphone,
//     String? latLong,
//     String? dlFlag,
//     String? dlmonyr,
//     String? searchString,
//     num? erocode,
//   }) =>
//       DlistEntityRealmList(
//         sno: sno ?? this.sno,
//         circleId: circleId ?? this.circleId,
//         circle: circle ?? this.circle,
//         divisionId: divisionId ?? this.divisionId,
//         division: division ?? this.division,
//         subDivisionId: subDivisionId ?? this.subDivisionId,
//         subDivision: subDivision ?? this.subDivision,
//         j2SSection: j2SSection ?? this.j2SSection,
//         ctseccd: ctseccd ?? this.ctseccd,
//         ctareacd: ctareacd ?? this.ctareacd,
//         secname: secname ?? this.secname,
//         areaname: areaname ?? this.areaname,
//         type: type ?? this.type,
//         dlscno: dlscno ?? this.dlscno,
//         dluan: dluan ?? this.dluan,
//         ctname: ctname ?? this.ctname,
//         ctadd2: ctadd2 ?? this.ctadd2,
//         dlcat: dlcat ?? this.dlcat,
//         ctcycle: ctcycle ?? this.ctcycle,
//         ctsocialgroup: ctsocialgroup ?? this.ctsocialgroup,
//         dlstat: dlstat ?? this.dlstat,
//         ctpoleno: ctpoleno ?? this.ctpoleno,
//         discdt: discdt ?? this.discdt,
//         curdem: curdem ?? this.curdem,
//         sdbalamt: sdbalamt ?? this.sdbalamt,
//         lastpddt: lastpddt ?? this.lastpddt,
//         arrears: arrears ?? this.arrears,
//         dlamt: dlamt ?? this.dlamt,
//         ctphone: ctphone ?? this.ctphone,
//         latLong: latLong ?? this.latLong,
//         dlFlag: dlFlag ?? this.dlFlag,
//         dlmonyr: dlmonyr ?? this.dlmonyr,
//         searchString: searchString ?? this.searchString,
//         erocode: erocode ?? this.erocode,
//       );
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['sno'] = sno;
//     map['circleId'] = circleId;
//     map['circle'] = circle;
//     map['divisionId'] = divisionId;
//     map['division'] = division;
//     map['subDivisionId'] = subDivisionId;
//     map['subDivision'] = subDivision;
//     map['j2SSection'] = j2SSection;
//     map['ctseccd'] = ctseccd;
//     map['ctareacd'] = ctareacd;
//     map['secname'] = secname;
//     map['areaname'] = areaname;
//     map['type'] = type;
//     map['dlscno'] = dlscno;
//     map['dluan'] = dluan;
//     map['ctname'] = ctname;
//     map['ctadd2'] = ctadd2;
//     map['dlcat'] = dlcat;
//     map['ctcycle'] = ctcycle;
//     map['ctsocialgroup'] = ctsocialgroup;
//     map['dlstat'] = dlstat;
//     map['ctpoleno'] = ctpoleno;
//     map['discdt'] = discdt;
//     map['curdem'] = curdem;
//     map['sdbalamt'] = sdbalamt;
//     map['lastpddt'] = lastpddt;
//     map['arrears'] = arrears;
//     map['dlamt'] = dlamt;
//     map['ctphone'] = ctphone;
//     map['latLong'] = latLong;
//     map['dlFlag'] = dlFlag;
//     map['dlmonyr'] = dlmonyr;
//     map['searchString'] = searchString;
//     map['erocode'] = erocode;
//     return map;
//   }
// }

class DlistEntityRealmList with ClusterItem {
  DlistEntityRealmList({
    this.sno,
    this.circleId,
    this.circle,
    this.divisionId,
    this.division,
    this.subDivisionId,
    this.subDivision,
    this.j2SSection,
    this.ctseccd,
    this.ctareacd,
    this.secname,
    this.areaname,
    this.type,
    this.dlscno,
    this.dluan,
    this.ctname,
    this.ctadd2,
    this.dlcat,
    this.ctcycle,
    this.ctsocialgroup,
    this.dlstat,
    this.ctpoleno,
    this.discdt,
    this.curdem,
    this.sdbalamt,
    this.lastpddt,
    this.arrears,
    this.dlamt,
    this.ctphone,
    this.latLong,
    this.dlFlag,
    this.dlmonyr,
    this.searchString,
    this.erocode,
  });

  num? sno;
  String? circleId;
  String? circle;
  String? divisionId;
  String? division;
  String? subDivisionId;
  String? subDivision;
  String? j2SSection;
  String? ctseccd;
  String? ctareacd;
  String? secname;
  String? areaname;
  String? type;
  String? dlscno;
  num? dluan;
  String? ctname;
  String? ctadd2;
  num? dlcat;
  String? ctcycle;
  String? ctsocialgroup;
  String? dlstat;
  String? ctpoleno;
  String? discdt;
  num? curdem;
  num? sdbalamt;
  String? lastpddt;
  num? arrears;
  num? dlamt;
  num? ctphone;
  String? latLong;
  String? dlFlag;
  String? dlmonyr;
  String? searchString;
  num? erocode;

  factory DlistEntityRealmList.fromJson(Map<String, dynamic> json) {
    return DlistEntityRealmList(
      sno: json['sno'],
      circleId: json['circleId'],
      circle: json['circle'],
      divisionId: json['divisionId'],
      division: json['division'],
      subDivisionId: json['subDivisionId'],
      subDivision: json['subDivision'],
      j2SSection: json['j2SSection'],
      ctseccd: json['ctseccd'],
      ctareacd: json['ctareacd'],
      secname: json['secname'],
      areaname: json['areaname'],
      type: json['type'],
      dlscno: json['dlscno'],
      dluan: json['dluan'],
      ctname: json['ctname'],
      ctadd2: json['ctadd2'],
      dlcat: json['dlcat'],
      ctcycle: json['ctcycle'],
      ctsocialgroup: json['ctsocialgroup'],
      dlstat: json['dlstat'],
      ctpoleno: json['ctpoleno'],
      discdt: json['discdt'],
      curdem: json['curdem'],
      sdbalamt: json['sdbalamt'],
      lastpddt: json['lastpddt'],
      arrears: json['arrears'],
      dlamt: json['dlamt'],
      ctphone: json['ctphone'],
      latLong: json['latLong'],
      dlFlag: json['dlFlag'],
      dlmonyr: json['dlmonyr'],
      searchString: json['searchString'],
      erocode: json['erocode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sno': sno,
      'circleId': circleId,
      'circle': circle,
      'divisionId': divisionId,
      'division': division,
      'subDivisionId': subDivisionId,
      'subDivision': subDivision,
      'j2SSection': j2SSection,
      'ctseccd': ctseccd,
      'ctareacd': ctareacd,
      'secname': secname,
      'areaname': areaname,
      'type': type,
      'dlscno': dlscno,
      'dluan': dluan,
      'ctname': ctname,
      'ctadd2': ctadd2,
      'dlcat': dlcat,
      'ctcycle': ctcycle,
      'ctsocialgroup': ctsocialgroup,
      'dlstat': dlstat,
      'ctpoleno': ctpoleno,
      'discdt': discdt,
      'curdem': curdem,
      'sdbalamt': sdbalamt,
      'lastpddt': lastpddt,
      'arrears': arrears,
      'dlamt': dlamt,
      'ctphone': ctphone,
      'latLong': latLong,
      'dlFlag': dlFlag,
      'dlmonyr': dlmonyr,
      'searchString': searchString,
      'erocode': erocode,
    };
  }

  DlistEntityRealmList copyWith({
    num? sno,
    String? circleId,
    String? circle,
    String? divisionId,
    String? division,
    String? subDivisionId,
    String? subDivision,
    String? j2SSection,
    String? ctseccd,
    String? ctareacd,
    String? secname,
    String? areaname,
    String? type,
    String? dlscno,
    num? dluan,
    String? ctname,
    String? ctadd2,
    num? dlcat,
    String? ctcycle,
    String? ctsocialgroup,
    String? dlstat,
    String? ctpoleno,
    String? discdt,
    num? curdem,
    num? sdbalamt,
    String? lastpddt,
    num? arrears,
    num? dlamt,
    num? ctphone,
    String? latLong,
    String? dlFlag,
    String? dlmonyr,
    String? searchString,
    num? erocode,
  }) {
    return DlistEntityRealmList(
      sno: sno ?? this.sno,
      circleId: circleId ?? this.circleId,
      circle: circle ?? this.circle,
      divisionId: divisionId ?? this.divisionId,
      division: division ?? this.division,
      subDivisionId: subDivisionId ?? this.subDivisionId,
      subDivision: subDivision ?? this.subDivision,
      j2SSection: j2SSection ?? this.j2SSection,
      ctseccd: ctseccd ?? this.ctseccd,
      ctareacd: ctareacd ?? this.ctareacd,
      secname: secname ?? this.secname,
      areaname: areaname ?? this.areaname,
      type: type ?? this.type,
      dlscno: dlscno ?? this.dlscno,
      dluan: dluan ?? this.dluan,
      ctname: ctname ?? this.ctname,
      ctadd2: ctadd2 ?? this.ctadd2,
      dlcat: dlcat ?? this.dlcat,
      ctcycle: ctcycle ?? this.ctcycle,
      ctsocialgroup: ctsocialgroup ?? this.ctsocialgroup,
      dlstat: dlstat ?? this.dlstat,
      ctpoleno: ctpoleno ?? this.ctpoleno,
      discdt: discdt ?? this.discdt,
      curdem: curdem ?? this.curdem,
      sdbalamt: sdbalamt ?? this.sdbalamt,
      lastpddt: lastpddt ?? this.lastpddt,
      arrears: arrears ?? this.arrears,
      dlamt: dlamt ?? this.dlamt,
      ctphone: ctphone ?? this.ctphone,
      latLong: latLong ?? this.latLong,
      dlFlag: dlFlag ?? this.dlFlag,
      dlmonyr: dlmonyr ?? this.dlmonyr,
      searchString: searchString ?? this.searchString,
      erocode: erocode ?? this.erocode,
    );
  }

  @override
  LatLng get location {
    if (latLong == null || !latLong!.contains(',')) {
      return const LatLng(0.0, 0.0);
    }

    try {
      final parts = latLong!.split(',');
      if (parts.length != 2) return const LatLng(0.0, 0.0);

      double parseCoord(String value) {
        value = value.trim().toUpperCase();
        final isNegative = value.contains('S') || value.contains('W');
        final cleaned = value.replaceAll(RegExp(r'[NSEW]'), '');
        final num = double.parse(cleaned);
        return isNegative ? -num : num;
      }

      final lat = parseCoord(parts[0]);
      final lng = parseCoord(parts[1]);

      return LatLng(lat, lng);
    } catch (e) {
      return const LatLng(0.0, 0.0);
    }
  }
}
