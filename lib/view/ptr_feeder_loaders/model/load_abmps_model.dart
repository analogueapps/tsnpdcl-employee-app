class LoadInAmpsModel {
  String? type;
  String? capacity;
  String? name;
  String? sapCode;
  String? ssCode;
  double? rPhaseCurrent;
  double? yPhaseCurrent;
  double? bPhaseCurrent;

  LoadInAmpsModel({
    this.type,
    this.capacity,
    this.name,
    this.sapCode,
    this.ssCode,
    this.rPhaseCurrent,
    this.yPhaseCurrent,
    this.bPhaseCurrent,
  });


  factory LoadInAmpsModel.fromJson(Map<String, dynamic> json) {
    return LoadInAmpsModel(
      type: json['type'],
      capacity: json['capacity'],
      name: json['name'],
      sapCode: json['sapCode'],
      ssCode: json['ssCode'],
      rPhaseCurrent: (json['rPhaseCurrent'] as num?)?.toDouble(),
      yPhaseCurrent: (json['yPhaseCurrent'] as num?)?.toDouble(),
      bPhaseCurrent: (json['bPhaseCurrent'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'capacity': capacity,
      'name': name,
      'sapCode': sapCode,
      'ssCode': ssCode,
      'rPhaseCurrent': rPhaseCurrent,
      'yPhaseCurrent': yPhaseCurrent,
      'bPhaseCurrent': bPhaseCurrent,
    };
  }
}
