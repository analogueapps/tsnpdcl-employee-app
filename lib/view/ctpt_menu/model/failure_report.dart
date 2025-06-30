import 'dart:convert';

FailureReportModel failureReportFromJson(String str) =>
    FailureReportModel.fromJson(json.decode(str));

String failureReportToJson(FailureReportModel data) =>
    json.encode(data.toJson());

class FailureReportModel {
  FailureReportModel({
    required this.data, // Store all API data in a Map
  }) {
    // Extract required fields for UI compatibility
    regNo = data['reportId']?.toString();
    village = data['section']?.toString();
    scNo = data['htScno']?.toString();
    date = data['reportDate']?.toString();
    status = data['status']?.toString();
    cName = data['cName']?.toString();
  }

  // Store the full API response
  final Map<String, dynamic> data;

  // Fields required by your UI (kept for compatibility)
  String? regNo;
  String? village;
  String? scNo;
  String? date;
  String? status;
  String? cName;

  factory FailureReportModel.fromJson(dynamic json) {
    try {
      return FailureReportModel(
        data: Map<String, dynamic>.from(json), // Store the entire JSON object
      );
    } catch (e) {
      print("Error parsing FailureReport: $e");
      throw const FormatException("Invalid failure report data format");
    }
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from(data); // Return the full data map
  }

  @override
  String toString() {
    // Display all data in the map for debugging
    return 'FailureReportModel(${data.entries.map((e) => '${e.key}: ${e.value}').join(', ')})';
  }
}
