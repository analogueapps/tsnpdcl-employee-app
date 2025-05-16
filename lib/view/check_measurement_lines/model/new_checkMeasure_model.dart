class NewCheckMeasureModel {
  final int id;
  final String estimateNo;
  final String worklDesc;
  final String isDone;
  final String createdBy;
  final String insertDate;
  final String voltage;
  final String ssCode;
  final String ssName;
  final String fdrCode;
  final String fdrName;
  final String typeOfProposal;

  NewCheckMeasureModel({
    required this.id,
    required this.estimateNo,
    required this.worklDesc,
    required this.isDone,
    required this.createdBy,
    required this.insertDate,
    required this.voltage,
    required this.ssCode,
    required this.ssName,
    required this.fdrCode,
    required this.fdrName,
    required this.typeOfProposal,
  });

  factory NewCheckMeasureModel.fromJson(Map<String, dynamic> json) {
    return NewCheckMeasureModel(
      id: json['id'],
      estimateNo: json['estimateNo'],
      worklDesc: json['worklDesc'],
      isDone: json['isDone'],
      createdBy: json['createdBy'],
      insertDate: json['insertDate'],
      voltage: json['voltage'],
      ssCode: json['ssCode'],
      ssName: json['ssName'],
      fdrCode: json['fdrCode'],
      fdrName: json['fdrName'],
      typeOfProposal: json['typeOfProposal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estimateNo': estimateNo,
      'worklDesc': worklDesc,
      'isDone': isDone,
      'createdBy': createdBy,
      'insertDate': insertDate,
      'voltage': voltage,
      'ssCode': ssCode,
      'ssName': ssName,
      'fdrCode': fdrCode,
      'fdrName': fdrName,
      'typeOfProposal': typeOfProposal,
    };
  }
}
