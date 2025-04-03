import 'dart:convert';

LoadStaffEntity loadStaffEntityFromJson(String str) =>
    LoadStaffEntity.fromJson(json.decode(str));

String loadStaffEntityToJson(LoadStaffEntity data) =>
    json.encode(data.toJson());

class LoadStaffEntity {
  LoadStaffEntity({
    this.employeeId,
    this.name,
    this.designationCode,
    this.designation,
    this.sectionCode,
    this.ofcCode,
    this.wing,
    this.personalPhone,
    this.smartLogin,
    this.ofcType,

  });

  LoadStaffEntity.fromJson(dynamic json) {
    try {
      employeeId = json['employeeId']?.toString();
      name = json['name']?.toString();

      // Handle designationCode which might come as String or num
      if (json['designationCode'] != null) {
        designationCode = json['designationCode']?.toString();
      }

      designation = json['designation']?.toString();

      // Handle sectionCode which might come as String or num
      if (json['sectionCode'] != null) {
        sectionCode = json['sectionCode']?.toString();
      }

      ofcCode = json['ofcCode']?.toString();
      wing = json['wing']?.toString();
      personalPhone = json['personalPhone']?.toString();
      smartLogin = json['smartLogin']?.toString();
      ofcType = json['ofcType']?.toString();
    } catch (e) {
      print("Error parsing LoadStaffEntity: $e");
      throw FormatException("Invalid meter data format");
    }
  }

  String? employeeId;
  String? name;
  String? designationCode;
  String? designation;
  String? sectionCode;
  String? ofcCode;
  String? newMeterId;
  String? wing;
  String? personalPhone;
  String? smartLogin;
  String? ofcType;


  LoadStaffEntity copyWith({

    String? employeeId,
    String? name,
    String? designationCode,
    String? designation,
    String? sectionCode,
    String? ofcCode,
    String? wing,
    String? personalPhone,
    String? smartLogin,
    String? ofcType,

  }) =>
      LoadStaffEntity(

        employeeId: employeeId ?? this.employeeId,
        name: name ?? this.name,
        designationCode: designationCode ?? this.designationCode,
        designation: designation ?? this.designation,
        sectionCode: sectionCode ?? this.sectionCode,
        ofcCode: ofcCode ?? this.ofcCode,
        wing: wing ?? this.wing,
        personalPhone: personalPhone ?? this.personalPhone,
        smartLogin: smartLogin ?? this.smartLogin,
        ofcType: ofcType ?? this.ofcType,

      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['employeeId'] = employeeId;
    map['name'] = name;
    map['designationCode'] = designationCode;
    map['designation'] = designation;
    map['sectionCode'] = sectionCode;
    map['ofcCode'] = ofcCode;
    map['wing'] = wing;
    map['personalPhone'] = personalPhone;
    map['smartLogin'] = smartLogin;
    map['ofcType'] = ofcType;

    return map;
  }
}
