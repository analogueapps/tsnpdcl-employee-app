import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/category_pending_allotment/model/category_change_request_model.dart';
import 'package:tsnpdcl_employee/view/category_pending_allotment/viewmodel/category_change_detail_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class CategoryChangeRequestDetail extends StatelessWidget {
  const CategoryChangeRequestDetail({super.key, required this.data});
  final CategoryChangeRequestModel data;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CategoryChangeDetailViewmodel(context: context, data:data),
        child: Consumer<CategoryChangeDetailViewmodel>(
            builder: (context, viewModel, child) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: CommonColors.colorPrimary,
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "#${data.regNum}",
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
                    // Navigation.instance.navigateTo(Routes.complaintTrack, args: data.ticketNumber);
                  },
                      icon: const Icon(Icons.folder_outlined, color: Colors.white,))],
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
                                tileKey: "reg Id".toUpperCase(), tileValue: "${data.regId}"),

                            ViewDetailedLcTileWidget(
                                tileKey: "reeg num".toUpperCase(),
                                tileValue: data.regNum??""),
                            ViewDetailedLcTileWidget(
                                tileKey: "USCNO",
                                tileValue: data.uscno.toString()),
                            ViewDetailedLcTileWidget(
                                tileKey: "SCNO",
                                tileValue: data.scno),
                            const ViewDetailedLcHeadWidget(title: "Existing Details",),
                            ViewDetailedLcTileWidget(
                                tileKey: "consumer name".toUpperCase(), tileValue: data.consumerName??""),
                            ViewDetailedLcTileWidget(
                                tileKey: "existing category".toUpperCase(),
                                tileValue: data.existCat??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "Existing load".toUpperCase(),
                                tileValue: data.existLoad.toString()),
                            const ViewDetailedLcHeadWidget(title: "Modification details"),
                            ViewDetailedLcTileWidget(
                                tileKey: "Request cat".toUpperCase(),
                                tileValue: data.reqCat??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "modification type".toUpperCase(),
                                tileValue: data.serviceChangeType??""),
                            const ViewDetailedLcHeadWidget(title: "address details",),
                            ViewDetailedLcTileWidget(
                                tileKey: "distribution".toUpperCase(),
                                tileValue: data.distribution??""),

                            ViewDetailedLcTileWidget(
                                tileKey: "applied ny name".toUpperCase(),
                                tileValue: data.informatName??""),

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
                  // viewModel.call();
                },backgroundColor: Colors.green, child: const Icon(Icons.call, color: Colors.white,),),
              );
            }));
  }
}
