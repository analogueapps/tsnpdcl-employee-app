import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class TongTesterReadingsScreen extends StatelessWidget {
  static const id = Routes.tongTesterReadingsScreen;

  const TongTesterReadingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Static values for testing
    final apiData = {
      'Equipment Code': '120150813',
      'Structure Code': '12237-BALASAMUDRAM-SS-0025',
      'Section': '402911201',
      'yph': "Yph: 79.0",
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          "OVERLOAD DTRs LIST",
          style: TextStyle(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigation.instance.navigateTo(Routes.viewDetailedTongTesterReadings);
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              // Optional: to give rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  // Shadow color with some transparency
                  blurRadius: 8,
                  // The spread radius
                  offset: const Offset(0, 4), // The position of the shadow (horizontal, vertical)
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                // Content Row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  // To remove extra space in the Row
                  children: [
                    Expanded(
                      // Ensures the text takes up available space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "01/06/2024 23:37",
                              style: TextStyle(
                                color: CommonColors.deepBlue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ViewDetailedLcTileWidget(
                              tileKey: "Equipment Code",
                              tileValue: "${apiData['Equipment Code']}"),
                          const Divider(),
                          ViewDetailedLcTileWidget(
                              tileKey: "Structure Code",
                              tileValue: "${apiData['Structure Code']}"),
                          const Divider(),
                          ViewDetailedLcTileWidget(
                              tileKey: "Section",
                              tileValue: "${apiData['Section']}"),
                          const Divider(),
                          _reusableLastRow("Rph: 101.0", "${apiData['yph']}",
                              "Bph: 87.0", "Bph: 87.0"),
                        ],
                      ),
                    ),
                    // IconButton with no space between it and the text
                    IconButton(
                      onPressed: () {
                        // Add your navigation logic here
                        Navigation.instance
                            .navigateTo(Routes.viewDetailedTongTesterReadings);
                      },
                      icon:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                      padding:
                          EdgeInsets.zero, // Ensures there is no extra padding
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //reusable last row
  Widget _reusableLastRow(
      String label, String value, String value2, String value3) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 4, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: CommonColors.deepRed,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: const Color(0xffcfcdcd),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CommonColors.colorSecondary,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: const Color(0xffcfcdcd),
          ),
          Expanded(
            child: Text(
              value2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CommonColors.colorPrimary,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: const Color(0xffcfcdcd),
          ),
          Expanded(
            child: Text(
              value3,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: normalSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
