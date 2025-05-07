// lib/features/online_collection/model/online_collection_model.dart
class BillDetails {
  final Map<String, String> details;
  final String rcAmount;
  final String acdAmount;
  final String totalAmount;

  BillDetails({
    required this.details,
    required this.rcAmount,
    required this.acdAmount,
    required this.totalAmount,
  });

  factory BillDetails.fromBillFetchModel(BillFetchModel model) {
    return BillDetails(
      details: {
        "NAME": model.name,
        "USCNO": model.uscno,
        "SCNO": model.scno,
        "BILL DATE": model.billDate,
        "DUE DATE": model.billDueDate,
        "DISCO. DATE": model.billDisconnectionDate,
        "CC AMT": model.currentMonthDemand,
        "ARR AMT": model.arrearAmount,
        "ACD AMT": model.acdAmountDue,
        "TOTAL BILL AMT": model.billTotalAmount,
      },
      rcAmount: '0.00', // You'll need to get this from API or calculate
      acdAmount: model.acdAmountDue,
      totalAmount: model.billTotalAmount,
    );
  }
}

class BillFetchModel {
  final String scno;
  final String uscno;
  final String name;
  final String billDate;
  final String billDisconnectionDate;
  final String billDueDate;
  final String acdAmountDue;
  final String arrearAmount;
  final String currentMonthDemand;
  final String billTotalAmount;
  final String nextPR;
  final String customerCategory;
  final String eroCode;
  final String eroName;
  final String secName;
  final String areaCode;
  final String area;

  BillFetchModel({
    required this.scno,
    required this.uscno,
    required this.name,
    required this.billDate,
    required this.billDisconnectionDate,
    required this.billDueDate,
    required this.acdAmountDue,
    required this.arrearAmount,
    required this.currentMonthDemand,
    required this.billTotalAmount,
    required this.nextPR,
    required this.customerCategory,
    required this.eroCode,
    required this.eroName,
    required this.secName,
    required this.areaCode,
    required this.area,
  });

  factory BillFetchModel.fromJson(Map<String, dynamic> json) {
    return BillFetchModel(
      scno: json['scno'] ?? '',
      uscno: json['uscno'] ?? '',
      name: json['name'] ?? '',
      billDate: json['billDate'] ?? '',
      billDisconnectionDate: json['billDisconnectionDate'] ?? '',
      billDueDate: json['billDueDate'] ?? '',
      acdAmountDue: json['acdAmountDue'] ?? '0.00',
      arrearAmount: json['arrearAmount'] ?? '0.00',
      currentMonthDemand: json['currentMonthDemand'] ?? '0.00',
      billTotalAmount: json['billTotalAmount'] ?? '0.00',
      nextPR: json['nextPR'] ?? '',
      customerCategory: json['customerCategory'] ?? '',
      eroCode: json['eroCode'] ?? '',
      eroName: json['eroName'] ?? '',
      secName: json['secName'] ?? '',
      areaCode: json['areaCode'] ?? '',
      area: json['area'] ?? '',
    );
  }
}