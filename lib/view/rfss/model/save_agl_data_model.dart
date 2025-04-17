class SaveAglDataModel{
  final String uscno; // Primary key
  final String? digitalDtrStructureCode;
  final String? latitude;
  final String? longitude;
  final String? unAuthorisedLoadInHp;
  final String? areaCode;
  final String? authorisationFlag;
  final String? farmerName;

  SaveAglDataModel({
    required this.uscno,
    this.digitalDtrStructureCode,
    this.latitude,
    this.longitude,
    this.unAuthorisedLoadInHp,
    this.areaCode,
    this.authorisationFlag,
    this.farmerName,
  });

  factory SaveAglDataModel.fromJson(Map<String, dynamic> json) {
    return SaveAglDataModel(
      uscno: json['uscno'] as String,
      digitalDtrStructureCode: json['structure'] as String?,
      latitude: json['lat'] as String?,
      longitude: json['lon'] as String?,
      unAuthorisedLoadInHp: json['loadInHp'] as String?,
      areaCode: json['areaCode'] as String?,
      authorisationFlag: json['authorisationFlag'] as String?,
      farmerName: json['farmerName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uscno': uscno,
      'structure': digitalDtrStructureCode,
      'lat': latitude,
      'lon': longitude,
      'loadInHp': unAuthorisedLoadInHp,
      'areaCode': areaCode,
      'authorisationFlag': authorisationFlag,
      'farmerName': farmerName,
    };
  }

  // For dropdown display
  @override
  String toString() {
    return '$uscno - ${farmerName ?? 'No Name'}';
  }
}