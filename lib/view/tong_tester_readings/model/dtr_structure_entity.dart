class DTRStructureEntity {
  final String? structureCode;
  final String? equipmentCode;

  DTRStructureEntity({this.structureCode, this.equipmentCode,});

  factory DTRStructureEntity.fromJson(Map<String, dynamic> json) {
    return DTRStructureEntity(
      structureCode: json['structureCode'] as String?,
      equipmentCode: json['equipmentCode']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'structureCode': structureCode,
      'equipmentCode':equipmentCode
    };
  }
}
