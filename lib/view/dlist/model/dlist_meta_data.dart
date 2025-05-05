import 'dart:convert';

DlistMetaData dlistMetaDataFromJson(String str) =>
    DlistMetaData.fromJson(json.decode(str));

String dlistMetaDataToJson(DlistMetaData data) => json.encode(data.toJson());

class DlistMetaData {
  DlistMetaData({
    this.monthYearOfcCode,
    this.monthYear,
    this.ofcName,
    this.ofcCode,
    this.rangesList,
  });

  DlistMetaData.fromJson(dynamic json) {
    monthYearOfcCode = json['monthYearOfcCode'];
    monthYear = json['monthYear'];
    ofcName = json['ofcName'];
    ofcCode = json['ofcCode'];
    if (json['rangesList'] != null) {
      rangesList = [];
      json['rangesList'].forEach((v) {
        rangesList?.add(RangesList.fromJson(v));
      });
    }
  }

  String? monthYearOfcCode;
  String? monthYear;
  String? ofcName;
  String? ofcCode;
  List<RangesList>? rangesList;

  DlistMetaData copyWith({
    String? monthYearOfcCode,
    String? monthYear,
    String? ofcName,
    String? ofcCode,
    List<RangesList>? rangesList,
  }) =>
      DlistMetaData(
        monthYearOfcCode: monthYearOfcCode ?? this.monthYearOfcCode,
        monthYear: monthYear ?? this.monthYear,
        ofcName: ofcName ?? this.ofcName,
        ofcCode: ofcCode ?? this.ofcCode,
        rangesList: rangesList ?? this.rangesList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['monthYearOfcCode'] = monthYearOfcCode;
    map['monthYear'] = monthYear;
    map['ofcName'] = ofcName;
    map['ofcCode'] = ofcCode;
    if (rangesList != null) {
      map['rangesList'] = rangesList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

RangesList rangesListFromJson(String str) =>
    RangesList.fromJson(json.decode(str));

String rangesListToJson(RangesList data) => json.encode(data.toJson());

class RangesList {
  RangesList({
    this.count,
    this.rangeCode,
    this.rangeLabel,
  });

  RangesList.fromJson(dynamic json) {
    count = json['count'];
    rangeCode = json['rangeCode'];
    rangeLabel = json['rangeLabel'];
  }

  num? count;
  num? rangeCode;
  String? rangeLabel;

  RangesList copyWith({
    num? count,
    num? rangeCode,
    String? rangeLabel,
  }) =>
      RangesList(
        count: count ?? this.count,
        rangeCode: rangeCode ?? this.rangeCode,
        rangeLabel: rangeLabel ?? this.rangeLabel,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['rangeCode'] = rangeCode;
    map['rangeLabel'] = rangeLabel;
    return map;
  }
}
