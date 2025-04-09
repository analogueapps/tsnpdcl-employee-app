class DTRStructureEntity {
  final String? structureCode;

  DTRStructureEntity({this.structureCode});

  factory DTRStructureEntity.fromJson(Map<String, dynamic> json) {
    return DTRStructureEntity(
      structureCode: json['structureCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'structureCode': structureCode,
    };
  }
}
