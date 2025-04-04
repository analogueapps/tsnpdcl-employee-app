import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';
import '../../../utils/app_constants.dart';

class DetailedView33kvBreakdownScreen extends StatelessWidget {
  static const id = Routes.detailedView33kvBreakdownScreen;
  final Map<String, dynamic> data;

  const DetailedView33kvBreakdownScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.viewBreakdown.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 10),
          ViewDetailedLcTileWidget(
              tileKey: "Id", tileValue: data['reportId'].toString()),
          const Divider(),
          ViewDetailedLcTileWidget(
            tileKey: "BD REPORT DATE",
            tileValue: "${data['startDate']} ${data['startTime']}",
          ),
          const Divider(),
          ViewDetailedLcTileWidget(
              tileKey: "SS NAME", tileValue: data['ssName'].toString()),
          const Divider(),
          ViewDetailedLcTileWidget(
              tileKey: "FEEDER NAME", tileValue: data['feederName'].toString()),
          const Divider(),
          ViewDetailedLcTileWidget(
              tileKey: "BREAKDOWN START DATE",
              tileValue: data['startDate'].toString()),
          const Divider(),
          ViewDetailedLcTileWidget(
              tileKey: "START TIME", tileValue: data['startTime'].toString()),
          const Divider(),
          ViewDetailedLcTileWidget(
              tileKey: "ALTERNATIVE SUPPLY",
              tileValue: data['alternativeSupply'].toString()),
          const Divider(),
          ViewDetailedLcTileWidget(
              tileKey: "NO OF SUBSTATIONS AFFECTED",
              tileValue: data['noOfSSAffected'].toString()),
          const Divider(),

          /// VISIBILITY
          Visibility(
              visible: data['status'] == "CLOSED",
              child: Column(// Wrap the widgets inside a child
                  children: [
                ViewDetailedLcTileWidget(
                    tileKey: "SUPPLY RESTORED DATE",
                    tileValue: data['endDate'].toString()),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "SUPPLY RESTORED TIME",
                    tileValue: data['endTime'].toString()),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "NO OF POLES DAMAGED",
                    tileValue: data['polesDamaged'].toString()),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "NO OF TOWERS DAMAGE(KM)",
                    tileValue: data['towersDamaged'].toString()),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "CONDUCTOR DAMAGED",
                    tileValue: data['conductorDamagedInKm'].toString()),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "BREAKDOWN REASON",
                    tileValue: data['reason'].toString()),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "OTHER REASON",
                    tileValue: data['otherReason'].toString()),
                const Divider(),
                ViewDetailedLcTileWidget(
                  tileKey: "SUPPLY RESTORE REPORTED DATE",
                  tileValue: "${data['endDate']} ${data['endTime']}",
                ),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "STATUS", tileValue: data['status'].toString()),
                const Divider(),
              ])),
          Visibility(
              visible: data['status'] == "OPEN",
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: doubleTwenty, vertical: doubleTen),
                child: PrimaryButton(
                    text: "FURNISH SUPPLY RESTORE DETAILS".toUpperCase(),
                    fullWidth: isTrue,
                    onPressed: () {
                      Navigation.instance.navigateTo(Routes.view33kvOpenRestoreDetails, args: data);
                    }),
              ))
        ]),
      ),
    );
  }
}
