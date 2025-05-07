import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailedTongTesterReadings extends StatelessWidget {
  static const id = Routes.viewDetailedTongTesterReadings;
  const ViewDetailedTongTesterReadings({super.key});

  @override
  Widget build(BuildContext context) {
    // Raw Data
    final apiData = {
      'ID': '3712',
      'DTR STRUCTURE': '12237-BALASAMUDRAM-SS-0025',
      'EQUIPMENT CODE': '120150813',
      'EMP ID': '40005541',
      'Reading Date': '01/06/2024',
      'Reading Time': '23:37',
      'R-Phase(Amps)': '101.0',
      'Y-Phase(Amps)': '79.0',
      'B-Phase(Amps)': '87.0',
      'Neutral(Amps)': '27.0',
      'Total Load(KVA)': '267.0',
      'DTR Capacity': '100KVA',
      'DTR MAKE': 'VIJAY ELECTRICAL',
      'DTR SERIAL': '386494',
      'Distribution Code': '12237',
      'Distribution Name': '12237-BALASAMUDRAM',
      'Feeder Name': 'CIRCLE OFFICE',
      'Feeder Code': '0003-01-11KV CIRCLEOFFICE',
      'Location Type': 'MUNICIPAL TOWN',
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          "#12237-BALASAMUDRAM-SS-0025",
          style: TextStyle(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w700
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              ViewDetailedLcTileWidget(tileKey: "ID", tileValue: "${apiData['ID']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "DTR STRUCTURE", tileValue: "${apiData['EQUIPMENT CODE']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "EQUIPMENT CODE", tileValue: "${apiData['EQUIPMENT CODE']}"),
              const Divider(),
              _buildButton("ENTER TONG TESTER READINGS", () {
                // Add logic for downloading D.I
              }),
              ViewDetailedLcTileWidget(tileKey: "EMP ID", tileValue: "${apiData['EMP ID']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Reading Date", tileValue: "${apiData['Reading Date']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Reading Time", tileValue: "${apiData['Reading Time']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "R-Phase(Amps)", tileValue: "${apiData['R-Phase(Amps)']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Y-Phase(Amps)", tileValue: "${apiData['Y-Phase(Amps)']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "B-Phase(Amps)", tileValue: "${apiData['B-Phase(Amps)']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Neutral(Amps)", tileValue: "${apiData['Neutral(Amps)']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Total Load(KVA)", tileValue: "${apiData['Total Load(KVA)']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "DTR Capacity", tileValue: "${apiData['DTR Capacity']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "DTR MAKE", tileValue: "${apiData['DTR MAKE']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "DTR SERIAL", tileValue: "${apiData['DTR SERIAL']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Distribution Code", tileValue: "${apiData['Distribution Code']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Distribution Name", tileValue: "${apiData['Distribution Name']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Feeder Name", tileValue: "${apiData['Feeder Name']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Feeder Code", tileValue: "${apiData['Feeder Code']}"),
              const Divider(),
              ViewDetailedLcTileWidget(tileKey: "Location Type", tileValue: "${apiData['Location Type']}"),
              const Divider(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable button widget
  Widget _buildButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CommonColors.colorPrimary,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}