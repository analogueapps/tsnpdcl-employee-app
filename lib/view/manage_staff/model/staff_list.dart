import 'dart:convert';

StaffList staffListFromJson(String str) => StaffList.fromJson(json.decode(str));

String staffListToJson(StaffList data) => json.encode(data.toJson());

class StaffList {
  StaffList({
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

  StaffList.fromJson(dynamic json) {
    employeeId = json['employeeId'];
    name = json['name'];
    designationCode = json['designationCode'];
    designation = json['designation'];
    sectionCode = json['sectionCode'];
    ofcCode = json['ofcCode'];
    wing = json['wing'];
    personalPhone = json['personalPhone'];
    smartLogin = json['smartLogin'];
    ofcType = json['ofcType'];
  }

  String? employeeId;
  String? name;
  num? designationCode;
  String? designation;
  String? sectionCode;
  String? ofcCode;
  String? wing;
  String? personalPhone;
  String? smartLogin;
  String? ofcType;

  StaffList copyWith({
    String? employeeId,
    String? name,
    num? designationCode,
    String? designation,
    String? sectionCode,
    String? ofcCode,
    String? wing,
    String? personalPhone,
    String? smartLogin,
    String? ofcType,
  }) =>
      StaffList(
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
