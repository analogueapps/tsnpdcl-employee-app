class UnMappedService {
  final String uscno;
  final String? digitalDtrStructureCode;
  final double? latitude;
  final double? longitude;
  final double? unAuthorisedLoadInHp;
  final String? areaCode;
  final String? authorisationFlag;
  final String? farmerName;

  UnMappedService({
    required this.uscno,
    this.digitalDtrStructureCode,
    this.latitude,
    this.longitude,
    this.unAuthorisedLoadInHp,
    this.areaCode,
    this.authorisationFlag,
    this.farmerName,
  });

  Map<String, dynamic> toMap() {
    return {
      'uscno': uscno,
      'digitalDtrStructureCode': digitalDtrStructureCode,
      'latitude': latitude,
      'longitude': longitude,
      'unAuthorisedLoadInHp': unAuthorisedLoadInHp,
      'areaCode': areaCode,
      'authorisationFlag': authorisationFlag,
      'farmerName': farmerName,
    };
  }

  factory UnMappedService.fromMap(Map<String, dynamic> map) {
    return UnMappedService(
      uscno: map['uscno'] as String,
      digitalDtrStructureCode: map['digitalDtrStructureCode'] as String?,
      latitude: map['latitude'] as double?,
      longitude: map['longitude'] as double?,
      unAuthorisedLoadInHp: map['unAuthorisedLoadInHp'] as double?,
      areaCode: map['areaCode'] as String?,
      authorisationFlag: map['authorisationFlag'] as String?,
      farmerName: map['farmerName'] as String?,
    );
  }
}

class Option {
  final String optionCode;

  Option({required this.optionCode});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      optionCode: json['optionCode'] as String? ?? '',
    );
  }
}