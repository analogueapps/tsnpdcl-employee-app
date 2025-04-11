class SubstationModel {
  final String cscno;
  final String newUscno;
  final String cname;
  final bool cncat;
  final String subcat;
  final int phvlt;
  final int cmdlc;
  final String status;
  final String j2SSeccode;
  final String ebsSeccode;
  final String areacode; // Field name is 'areacode'

  SubstationModel({
    required this.cscno,
    required this.newUscno,
    required this.cname,
    required this.cncat,
    required this.subcat,
    required this.phvlt,
    required this.cmdlc,
    required this.status,
    required this.j2SSeccode,
    required this.ebsSeccode,
    required this.areacode, // Use consistent naming
  });

  factory SubstationModel.fromJson(Map<String, dynamic> json) {
    return SubstationModel(
      cscno: json['cscno'] ?? '',
      newUscno: json['newUscno'] ?? '',
      cname: json['cname'] ?? '',
      cncat: json['cncat'] ?? false,
      subcat: json['subcat'] ?? '',
      phvlt: json['phvlt'] ?? 0,
      cmdlc: json['cmdlc'] ?? 0,
      status: json['status'] ?? '',
      j2SSeccode: json['j2SSeccode'] ?? '',
      ebsSeccode: json['ebsSeccode'] ?? '',
      areacode: json['areacode'] ?? '', // Match the field name
    );
  }
}
