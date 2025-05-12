class FetchAllAbstract {

  final int pendingCount;
  final String areaName;
  final String areaCode;
  final int verifiedCount;
  final int totalCount;

  FetchAllAbstract({
    required this.pendingCount,
    required this.areaName,
    required this.areaCode,
    required this.verifiedCount,
    required this.totalCount
  });

  factory FetchAllAbstract.fromJson(Map<String,dynamic> json){
    return FetchAllAbstract(
        pendingCount: json['pendingCount'],
        areaName: json['areaName'],
        areaCode: json['areaCode'],
        verifiedCount: json['verifiedCount'],
        totalCount: json['totalCount']
    );
  }

  Map<String ,dynamic> toJson()=>{
    'pendingCount':pendingCount,
    'areaName':areaName,
    'areaCode':areaCode,
    'verifiedCount':verifiedCount,
    'totalCount':totalCount
  };

}