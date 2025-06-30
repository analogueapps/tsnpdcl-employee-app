import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/schedules/models/view_schedule_model.dart';
import 'package:tsnpdcl_employee/view/schedules/viewmodel/view_detail_schedule_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailSchedules extends StatelessWidget {
  static const id = Routes.viewDetailSchedule;

  const ViewDetailSchedules({super.key, required this.data});

  final ViewScheduleModel data;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            ViewDetailScheduleViewmodel(context: context, data: data),
        child: Consumer<ViewDetailScheduleViewmodel>(
            builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "View Schedule",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "${data.tourId}-${data.itemName}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700),
                    ),
                  ]),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: data == null
                ? const Center(child: Text("No data found"))
                : Stack(children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              ViewDetailedLcTileWidget(
                                  tileKey: "SCHEDULE ID",
                                  tileValue: "${data.tourId}"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "SCHEDULED BY EMP ID",
                                  tileValue: data.aeEmpId),
                              ViewDetailedLcTileWidget(
                                  tileKey: "SCHEDULED BY EMP NAME",
                                  tileValue: data.aeName),
                              ViewDetailedLcTileWidget(
                                  tileKey: "SCHEDULED BY EMP DES",
                                  tileValue: data.aeDesignation),
                              ViewDetailedLcTileWidget(
                                  tileKey: "DATE",
                                  tileValue: data.scheduledDate),
                              ViewDetailedLcTileWidget(
                                  tileKey: "SCHEDULE TYPE",
                                  tileValue: data.aeName),
                              ViewDetailedLcTileWidget(
                                  tileKey: "CODE", tileValue: data.itemCode),
                              ViewDetailedLcTileWidget(
                                  tileKey: "NAME", tileValue: data.itemName),
                              ViewDetailedLcTileWidget(
                                  tileKey: "VOLTAGE",
                                  tileValue: data.voltage ?? "NULL"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "SCHEDULED DATE",
                                  tileValue: data.scheduledDate),
                              SizedBox(
                                width: double.infinity,
                                child: PrimaryButton(
                                    text: "ATTEND",
                                    onPressed: () {
                                      if (data.type == "SS") {
                                        viewModel.attend(
                                            data.status, data.tourId);
                                      } else if (data.type == "LINE") {
                                      } else if (data.type == "DTR") {
                                        Navigation.instance.navigateTo(
                                            Routes.dtrMaintenanceScreen);
                                      }
                                    }),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ViewDetailedLcTileWidget(
                                  tileKey: "SCHEDULED MONTH",
                                  tileValue: data.scheduledMonth),
                              ViewDetailedLcTileWidget(
                                  tileKey: "CIRCLE", tileValue: data.circle),
                              ViewDetailedLcTileWidget(
                                  tileKey: "DIVISION",
                                  tileValue: data.division),
                              ViewDetailedLcTileWidget(
                                  tileKey: "SUB DIVISION",
                                  tileValue: data.subDivision),
                              ViewDetailedLcTileWidget(
                                  tileKey: "SECTION", tileValue: data.section),
                              ViewDetailedLcTileWidget(
                                  tileKey: "INSP ADE EMP ID",
                                  tileValue: data.adeEmpId ?? "NULL"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "INSP ADE EMP NAME",
                                  tileValue: data.adeEmpName ?? "NULL"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "REMARKS BY ADE",
                                  tileValue: data.adeRemarks ?? "NULL"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "ADE REPORT DATE",
                                  tileValue: data.adeReportDate ?? "NULL"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "DE EMP ID",
                                  tileValue: data.deEmpId ?? "NULL"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "DE EMP NAME",
                                  tileValue: data.deEmpName ?? "NULL"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "DE REMARKS",
                                  tileValue: data.deRemarks ?? "NULL"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "DE REPORT DATE",
                                  tileValue: data.deReportDate ?? "NULL"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "STATUS", tileValue: data.status),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (viewModel.isLoading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black
                              .withOpacity(0.3), // Semi-transparent overlay
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                  ]),
          );
        }));
  }
}
