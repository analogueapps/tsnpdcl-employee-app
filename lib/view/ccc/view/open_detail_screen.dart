import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/ccc/model/open_model.dart';
import 'package:tsnpdcl_employee/view/ccc/viewModel/open_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';


class CCCViewDetailed extends StatelessWidget {
  static const id = Routes.openDetail;

  const CCCViewDetailed({super.key, required this.data});

  final CccOpenModel data;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => OpenViewmodel(context: context, data:data),
        child: Consumer<OpenViewmodel>(
            builder: (context, viewModel, child) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: CommonColors.colorPrimary,
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "#${data.ticketNumber}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: titleSize,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${data.consumerName}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: titleSize,
                              fontWeight: FontWeight.w700),
                        ),
                      ]),
                  actions:  [IconButton(onPressed: (){
                    Navigation.instance.navigateTo(Routes.complaintTrack, args: data.ticketNumber);
                    },
                      icon: const Icon(Icons.history, color: Colors.white,))],
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
                                tileKey: "Complaint No", tileValue: "${data.ticketNumber}"),

                            ViewDetailedLcTileWidget(
                                tileKey: "Complaint Reg Date",
                                tileValue: data.entryDate??""),
                            SizedBox(
                              width: double.infinity,
                              child:PrimaryButton(
                                  text: "UPDATE",
                                  onPressed: () {
                                    viewModel.update();
                                  }),
                            ),
                            const SizedBox(height: doubleTen,),
                            ViewDetailedLcTileWidget(
                                tileKey: "Complaint Type",
                                tileValue: data.complaintType??""),

                            const SizedBox(height: 10,),
                            ViewDetailedLcTileWidget(
                                tileKey: "Complaint Subtype", tileValue: data.complaintSubType??""),
                            ViewDetailedLcTileWidget(
                                tileKey: "USCNO",
                                tileValue: data.uscNo??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "SC No",
                                tileValue: data.scNo??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Consumer Name",
                                tileValue: data.consumerName??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Mobile No",
                                tileValue: data.mobileNo??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "H.No",
                                tileValue: data.hNo??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Address",
                                tileValue: data.address??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Landmaerk",
                                tileValue: data.landmark??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Pole NO",
                                tileValue: data.poleNumber??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Area", tileValue: data.area??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Section", tileValue: data.section??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Source",
                                tileValue: data.complaintSource??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Remarks",
                                tileValue: data.remarks??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Circle",
                                tileValue: data.circle??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Complaint Status",
                                tileValue: data.status??""),



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
                floatingActionButton: FloatingActionButton(onPressed: (){
                  viewModel.call();
                },backgroundColor: Colors.green, child: const Icon(Icons.call, color: Colors.white,),),
              );
            }));
  }


}
