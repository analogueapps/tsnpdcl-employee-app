import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';
import '../../model/failure_report.dart'; // Adjust import path

class ViewDetailedCtptReport extends StatelessWidget {
  static const id = Routes.viewDetailedCtptReport;
  final FailureReportModel data;

  const ViewDetailedCtptReport({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          'REG NO.${data.regNo ?? 'N/A'}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Report Details Section
            _buildSectionHeader("Report Details"),
            ViewDetailedLcTileWidget(
              tileKey: "Report ID",
              tileValue: data.regNo ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "SC No",
              tileValue: data.scNo ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Report Date",
              tileValue: data.date ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Status",
              tileValue: data.status ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Reported AE",
              tileValue: data.data['reportedAe']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Customer Name",
              tileValue: data.cName ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),

            // Meter Details Section
            _buildSectionHeader("Meter Details"),
            ViewDetailedLcTileWidget(
              tileKey: "Serial No",
              tileValue: data.data['serailNo']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Make",
              tileValue: data.data['make']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "CT/PT Ratio",
              tileValue: data.data['ctPtRatio']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "MF",
              tileValue: data.data['mf']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Year of Manufacturing",
              tileValue: data.data['yearOfManufacturing']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),

            // Location Details Section
            _buildSectionHeader("Location Details"),
            ViewDetailedLcTileWidget(
              tileKey: "Village/Section",
              tileValue: data.village ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Area",
              tileValue: data.data['area']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Area Code",
              tileValue: data.data['areaCode']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Circle",
              tileValue: data.data['circle']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Circle Code",
              tileValue: data.data['circleCode']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Division",
              tileValue: data.data['division']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Division Code",
              tileValue: data.data['divisionCode']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Sub Division",
              tileValue: data.data['subDivision']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Sub Division Code",
              tileValue: data.data['subDivisionCode']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Section Code",
              tileValue: data.data['sectionCode']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "J2S Section Code",
              tileValue: data.data['j2SsecCode']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "EBS Section Code",
              tileValue: data.data['ebsSeccode']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
            ViewDetailedLcTileWidget(
              tileKey: "Month/Year",
              tileValue: data.data['monthYear']?.toString() ?? 'N/A',
              valueColor: CommonColors.colorPrimary,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      color: Colors.grey[200],
      width: double.infinity,
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}