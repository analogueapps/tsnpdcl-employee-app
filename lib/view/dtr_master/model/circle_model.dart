import 'dart:convert';

class Circle {
  final String circleId;
  final String circleName;
  final String circleCode;

  Circle(this.circleId, this.circleName, {this.circleCode = ''});

  String getCircleCode() {
    return circleCode ?? circleId;
  }

  String getCircleId() {
    return circleId != null ? circleId : circleCode;
  }

  String getCircleName() {
    return circleName;
  }
}

MeterStockEntity meterStockEntityFromJson(String str) =>
    MeterStockEntity.fromJson(json.decode(str));

String meterStockEntityToJson(MeterStockEntity data) =>
    json.encode(data.toJson());

class MeterStockEntity {
  MeterStockEntity({
    this.meterCapacity,
    this.meterType,
    this.meterTrackId,
    this.make,
    this.meterNo,
    this.opDate,
    this.newMeterId,

  });

  MeterStockEntity.fromJson(dynamic json) {
    try {
      meterCapacity = json['meterCapacity']?.toString();
      meterType = json['meterType']?.toString();

      // Handle meterTrackId which might come as String or num
      if (json['meterTrackId'] != null) {
        meterTrackId = json['meterTrackId'] is String
            ? num.tryParse(json['meterTrackId'])
            : json['meterTrackId'] as num?;
      }

      make = json['make']?.toString();

      // Handle meterNo which might come as String or num
      if (json['meterNo'] != null) {
        meterNo = json['meterNo'] is String
            ? num.tryParse(json['meterNo'])
            : json['meterNo'] as num?;
      }

      opDate = json['opDate']?.toString();
      newMeterId = json['newMeterId']?.toString();
    } catch (e) {
      print("Error parsing MeterStockEntity: $e");
      throw FormatException("Invalid meter data format");
    }
  }

  String? meterCapacity;
  String? meterType;
  num? meterTrackId;
  String? make;
  num? meterNo;
  String? opDate;
  String? newMeterId;
  String? poleHeight;


  MeterStockEntity copyWith({

    String? meterCapacity,
    String? meterType,
    num? meterTrackId,
    String? make,
    num? meterNo,
    String? opDate,
    String? newMeterId,

  }) =>
      MeterStockEntity(

        meterCapacity: meterCapacity ?? this.meterCapacity,
        meterType: meterType ?? this.meterType,
        meterTrackId: meterTrackId ?? this.meterTrackId,
        make: make ?? this.make,
        meterNo: meterNo ?? this.meterNo,
        opDate: opDate ?? this.opDate,
        newMeterId: newMeterId ?? this.newMeterId,

      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['meterCapacity'] = meterCapacity;
    map['meterType'] = meterType;
    map['meterTrackId'] = meterTrackId;
    map['make'] = make;
    map['meterNo'] = meterNo;
    map['opDate'] = opDate;
    map['newMeterId'] = newMeterId;

    return map;
  }
}

