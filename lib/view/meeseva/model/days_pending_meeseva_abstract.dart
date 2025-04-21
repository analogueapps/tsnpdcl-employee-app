// To parse this JSON data, do
//
//     final daysPendingMeesevaAbstract = daysPendingMeesevaAbstractFromJson(jsonString);

import 'dart:convert';

DaysPendingMeesevaAbstract daysPendingMeesevaAbstractFromJson(String str) => DaysPendingMeesevaAbstract.fromJson(json.decode(str));

String daysPendingMeesevaAbstractToJson(DaysPendingMeesevaAbstract data) => json.encode(data.toJson());

class DaysPendingMeesevaAbstract {
  AdeInt? adeInt;
  AdeInt? sc;
  AdeInt? us;
  AdeInt? pfc;
  AdeInt? lmf;
  Aef? aenf;
  AdeInt? nc;
  Aef? aef;

  DaysPendingMeesevaAbstract({
    this.adeInt,
    this.sc,
    this.us,
    this.pfc,
    this.lmf,
    this.aenf,
    this.nc,
    this.aef,
  });

  DaysPendingMeesevaAbstract copyWith({
    AdeInt? adeInt,
    AdeInt? sc,
    AdeInt? us,
    AdeInt? pfc,
    AdeInt? lmf,
    Aef? aenf,
    AdeInt? nc,
    Aef? aef,
  }) =>
      DaysPendingMeesevaAbstract(
        adeInt: adeInt ?? this.adeInt,
        sc: sc ?? this.sc,
        us: us ?? this.us,
        pfc: pfc ?? this.pfc,
        lmf: lmf ?? this.lmf,
        aenf: aenf ?? this.aenf,
        nc: nc ?? this.nc,
        aef: aef ?? this.aef,
      );

  factory DaysPendingMeesevaAbstract.fromJson(Map<String, dynamic> json) => DaysPendingMeesevaAbstract(
    adeInt: json["ADE_INT"] == null ? null : AdeInt.fromJson(json["ADE_INT"]),
    sc: json["SC"] == null ? null : AdeInt.fromJson(json["SC"]),
    us: json["US"] == null ? null : AdeInt.fromJson(json["US"]),
    pfc: json["PFC"] == null ? null : AdeInt.fromJson(json["PFC"]),
    lmf: json["LMF"] == null ? null : AdeInt.fromJson(json["LMF"]),
    aenf: json["AENF"] == null ? null : Aef.fromJson(json["AENF"]),
    nc: json["NC"] == null ? null : AdeInt.fromJson(json["NC"]),
    aef: json["AEF"] == null ? null : Aef.fromJson(json["AEF"]),
  );

  Map<String, dynamic> toJson() => {
    "ADE_INT": adeInt?.toJson(),
    "SC": sc?.toJson(),
    "US": us?.toJson(),
    "PFC": pfc?.toJson(),
    "LMF": lmf?.toJson(),
    "AENF": aenf?.toJson(),
    "NC": nc?.toJson(),
    "AEF": aef?.toJson(),
  };
}

class AdeInt {
  Ae? ae;
  int? statusCount;

  AdeInt({
    this.ae,
    this.statusCount,
  });

  AdeInt copyWith({
    Ae? ae,
    int? statusCount,
  }) =>
      AdeInt(
        ae: ae ?? this.ae,
        statusCount: statusCount ?? this.statusCount,
      );

  factory AdeInt.fromJson(Map<String, dynamic> json) => AdeInt(
    ae: json["AE"] == null ? null : Ae.fromJson(json["AE"]),
    statusCount: json["statusCount"],
  );

  Map<String, dynamic> toJson() => {
    "AE": ae?.toJson(),
    "statusCount": statusCount,
  };
}

class Ae {
  int? count;
  String? status;
  String? name;

  Ae({
    this.count,
    this.status,
    this.name,
  });

  Ae copyWith({
    int? count,
    String? status,
    String? name,
  }) =>
      Ae(
        count: count ?? this.count,
        status: status ?? this.status,
        name: name ?? this.name,
      );

  factory Ae.fromJson(Map<String, dynamic> json) => Ae(
    count: json["count"],
    status: json["status"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "status": status,
    "name": name,
  };
}

class Aef {
  int? statusCount;
  Ae? adeOp;

  Aef({
    this.statusCount,
    this.adeOp,
  });

  Aef copyWith({
    int? statusCount,
    Ae? adeOp,
  }) =>
      Aef(
        statusCount: statusCount ?? this.statusCount,
        adeOp: adeOp ?? this.adeOp,
      );

  factory Aef.fromJson(Map<String, dynamic> json) => Aef(
    statusCount: json["statusCount"],
    adeOp: json["ADE/OP"] == null ? null : Ae.fromJson(json["ADE/OP"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCount": statusCount,
    "ADE/OP": adeOp?.toJson(),
  };
}
