

import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';

class MeterMakeAndCapacityModel {
  List<EroModel> meterMakesList;
  List<EroModel> meterCapacityList;
  List<EroModel> rejectReasons;

  MeterMakeAndCapacityModel({
    this.meterMakesList = const [],
    this.meterCapacityList = const [],
    this.rejectReasons = const [],
  });

  factory MeterMakeAndCapacityModel.fromJson(Map<String, dynamic> json) {
    return MeterMakeAndCapacityModel(
      meterMakesList: (json['meterMakesList'] as List<dynamic>?)
          ?.map((e) => EroModel.fromJson(e))
          .toList() ??
          [],
      meterCapacityList: (json['meterCapacityList'] as List<dynamic>?)
          ?.map((e) => EroModel.fromJson(e))
          .toList() ??
          [],
      rejectReasons: (json['rejectReasons'] as List<dynamic>?)
          ?.map((e) => EroModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meterMakesList': meterMakesList.map((e) => e.toJson()).toList(),
      'meterCapacityList': meterCapacityList.map((e) => e.toJson()).toList(),
      'rejectReasons': rejectReasons.map((e) => e.toJson()).toList(),
    };
  }
}
