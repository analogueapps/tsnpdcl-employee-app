class UploadMappedService {
  final String eroCode;
  final String sectionCode;
  final String eroSecCode;
  final String areaCode;
  final String uscno;
  final String scno;
  final String name;
  final String cat;

  UploadMappedService({
    required this.eroCode,
    required this.sectionCode,
    required this.eroSecCode,
    required this.areaCode,
    required this.uscno,
    required this.scno,
    required this.name,
    required this.cat,
  });

  factory UploadMappedService.fromJson(Map<String, dynamic> json) {
    return UploadMappedService(
      eroCode: json['eroCode'] as String? ?? '',
      sectionCode: json['sectionCode'] as String? ?? '',
      eroSecCode: json['eroSecCode'] as String? ?? '',
      areaCode: json['areaCode'] as String? ?? '',
      uscno: json['uscno'] as String? ?? '',
      scno: json['scno'] as String? ?? '',
      name: json['name'] as String? ?? '',
      cat: json['cat'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eroCode': eroCode,
      'sectionCode': sectionCode,
      'eroSecCode': eroSecCode,
      'areaCode': areaCode,
      'uscno': uscno,
      'scno': scno,
      'name': name,
      'cat': cat,
    };
  }
}




