import 'package:flutter/cupertino.dart';

class IndividualFailureReportViewModel extends ChangeNotifier {
  final BuildContext context;
  bool isLoading = false;

  final FailureReport report = FailureReport(
    regNo: '400024',
    htScNo: 'WLU190',
    village: 'NAKKALAGUTTA',
    serviceName: 'M/S IDEAL DEVELOPERS',
    circle: 'HANAMKONDA',
    division: 'HANAMKONDA TOWN',
    subDivision: 'HANAMKONDA',
    sectionCode: '402911201',
    section: 'NAKKALUGTTA',
    make: 'L&T',
    serialNo: 'serialno1',
    mf: '123',
    ctPtRatio: '200/1-1',
    yearManufactured: '2019',
    status: 'AE_REP',
    remarks: '',
    reportDate: 'Mon Apr 07 10:33:48 IST 2025',
    reportMonthYear: 'Apr2025',
    reportedAeEmpId: '70000000',
    adeOpConfirmedDate: '',
  );

  IndividualFailureReportViewModel({required this.context});

  void onFolderPressed() {
    // Add folder action logic here
  }
}

class FailureReport {
  final String regNo;
  final String htScNo;
  final String village;
  final String serviceName;
  final String circle;
  final String division;
  final String subDivision;
  final String sectionCode;
  final String section;
  final String make;
  final String serialNo;
  final String mf;
  final String ctPtRatio;
  final String yearManufactured;
  final String status;
  final String remarks;
  final String reportDate;
  final String reportMonthYear;
  final String reportedAeEmpId;
  final String adeOpConfirmedDate;

  FailureReport({
    required this.regNo,
    required this.htScNo,
    required this.village,
    required this.serviceName,
    required this.circle,
    required this.division,
    required this.subDivision,
    required this.sectionCode,
    required this.section,
    required this.make,
    required this.serialNo,
    required this.mf,
    required this.ctPtRatio,
    required this.yearManufactured,
    required this.status,
    required this.remarks,
    required this.reportDate,
    required this.reportMonthYear,
    required this.reportedAeEmpId,
    required this.adeOpConfirmedDate,
  });
}