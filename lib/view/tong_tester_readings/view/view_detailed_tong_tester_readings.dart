import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/overload_dtr_list_model.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

import '../viewmodel/overload_dtr_list_viewmodel.dart';

class ViewDetailedTongTesterReadings extends StatelessWidget {
  static const id = Routes.viewDetailedTongTesterReadings;

  const ViewDetailedTongTesterReadings({super.key, required this.data});

  final OverloadDtrListModel data;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => OverloadDtrListViewmodel(context: context),
        child: Consumer<OverloadDtrListViewmodel>(
            builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  "#${data.dtrStructureCode}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "${data.equipmentCode}",
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
                        child:Padding(padding:EdgeInsets.all(16),
                        child:Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          ViewDetailedLcTileWidget(
                              tileKey: "ID", tileValue: "${data.recordId}"),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "DTR STRUCTURE",
                              tileValue: data.dtrStructureCode),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "EQUIPMENT CODE",
                              tileValue: data.equipmentCode),
                          
                          SizedBox(
                            width: double.infinity,
                          child:PrimaryButton(
                              text: "ENTER TONG TESTER READINGS",
                              onPressed: () {
                                Navigation.instance.navigateTo(Routes.tongTesterReadingsScreen);
                              }),
                          ),
                          const SizedBox(height: 10,),
                          ViewDetailedLcTileWidget(
                              tileKey: "EMP ID", tileValue: data.empId),
                          ViewDetailedLcTileWidget(
                              tileKey: "Reading Date",
                              tileValue: data.readingDate),
                         
                          ViewDetailedLcTileWidget(
                              tileKey: "Reading Time",
                              tileValue: data.readingTime),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "R-Phase(Amps)",
                              tileValue: data.ir.toString()),
                         
                          ViewDetailedLcTileWidget(
                              tileKey: "Y-Phase(Amps)",
                              tileValue: data.iy.toString()),
                         
                          ViewDetailedLcTileWidget(
                              tileKey: "B-Phase(Amps)",
                              tileValue: data.ib.toString()),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "Neutral(Amps)",
                              tileValue: data.iNeutral.toString()),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "Total Load(KVA)",
                              tileValue: data.totalLoadKva.toString()),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "DTR Capacity",
                              tileValue: data.dtrCapacity),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "DTR MAKE", tileValue: data.dtrMake),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "DTR SERIAL", tileValue: data.dtrSerial),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "Distribution Code",
                              tileValue: data.distCode),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "Distribution Name",
                              tileValue: data.distName),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "Feeder Name",
                              tileValue: data.feederName),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "Feeder Code",
                              tileValue: data.feedderCode),
                          
                          ViewDetailedLcTileWidget(
                              tileKey: "Location Type",
                              tileValue: data.locationType),
                          
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    ),
                    ),
              if (viewModel.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3), // Semi-transparent overlay
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
