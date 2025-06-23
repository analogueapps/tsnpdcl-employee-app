import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/meeseva_category_pending_allotment/viewmodel/category_change_detail_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_image_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryChangeRequestDetail extends StatelessWidget {
  const CategoryChangeRequestDetail({super.key, required this.data});
  final Map<String, dynamic> data;
  static const id = Routes.categoryChangeDetail;

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
                          "#${viewModel.categoryChange.regNum}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: titleSize,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${viewModel.categoryChange.consumerName}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: titleSize,
                              fontWeight: FontWeight.w700),
                        ),
                      ]),
                  actions:  [IconButton(onPressed: ()async{
                    final Uri url = Uri.parse(Apis.MEE_SEVA_MODIFY_SEVICE_DOCUMENTS_URL+viewModel.categoryChange.regNum);
                    if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                    }
                  },
                      icon: const Icon(Icons.folder_outlined, color: Colors.white,))],
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                ),
                body: viewModel.categoryChange == null
                    ? const Center(child: Text("No data found"))
                    : Stack(children: [
                  SingleChildScrollView(
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              ViewDetailedLcTileWidget(
                                  tileKey: "reg Id".toUpperCase(), tileValue: "${viewModel.categoryChange.regId}"),

                              ViewDetailedLcTileWidget(
                                  tileKey: "reeg num".toUpperCase(),
                                  tileValue: viewModel.categoryChange.regNum??""),
                              ViewDetailedLcTileWidget(
                                  tileKey: "USCNO",
                                  tileValue: viewModel.categoryChange.uscno.toString()),
                              ViewDetailedLcTileWidget(
                                  tileKey: "SCNO",
                                  tileValue: viewModel.categoryChange.scno),
                              const ViewDetailedLcHeadWidget(title: "Existing Details",),
                              ViewDetailedLcTileWidget(
                                  tileKey: "consumer name".toUpperCase(), tileValue: viewModel.categoryChange.consumerName??""),
                              ViewDetailedLcTileWidget(
                                  tileKey: "existing category".toUpperCase(),
                                  tileValue: viewModel.categoryChange.existCat??""),

                              ViewDetailedLcTileWidget(
                                  tileKey: "Existing load".toUpperCase(),
                                  tileValue: viewModel.categoryChange.existLoad.toString()),
                              const ViewDetailedLcHeadWidget(title: "Modification details"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "Request cat".toUpperCase(),
                                  tileValue: viewModel.categoryChange.reqCat??""),

                              ViewDetailedLcTileWidget(
                                  tileKey: "modification type".toUpperCase(),
                                  tileValue: viewModel.categoryChange.serviceChangeType??""),
                              const ViewDetailedLcHeadWidget(title: "address details",),
                              ViewDetailedLcTileWidget(
                                  tileKey: "distribution".toUpperCase(),
                                  tileValue: viewModel.categoryChange.distribution??"null"),

                              ViewDetailedLcTileWidget(
                                  tileKey: "applied ny name".toUpperCase(),
                                  tileValue: viewModel.categoryChange.informatName??""),

                              ViewDetailedLcTileWidget(
                                  tileKey: "door no".toUpperCase(),
                                  tileValue: viewModel.categoryChange.doorNo??""),
                              ViewDetailedLcTileWidget(
                                  tileKey: "street".toUpperCase(),
                                  tileValue: viewModel.categoryChange.street??""),
                              ViewDetailedLcTileWidget(
                                  tileKey: "area".toUpperCase(),
                                  tileValue: viewModel.categoryChange.area??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "town".toUpperCase(),
                                  tileValue: viewModel.categoryChange.town??""),
                              ViewDetailedLcTileWidget(
                                  tileKey: "mobile".toUpperCase(),
                                  tileValue: viewModel.categoryChange.mobile.toString()??""),
                              ViewDetailedLcTileWidget(
                                  tileKey: "phone".toUpperCase(),
                                  tileValue: viewModel.categoryChange.phoneNo??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "email".toUpperCase(),
                                  tileValue: viewModel.categoryChange.email??"null"),
                              const ViewDetailedLcHeadWidget(title: "Staff Details",),
                              ViewDetailedLcTileWidget(
                                  tileKey: "status".toUpperCase(),
                                  tileValue: viewModel.categoryChange.status??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "status date".toUpperCase(),
                                  tileValue: viewModel.categoryChange.statusDate??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "ae employee id".toUpperCase(),
                                  tileValue: viewModel.categoryChange.aeEmpId??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "staff employee id".toUpperCase(),
                                  tileValue: viewModel.categoryChange.lmEmpId??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "reason".toUpperCase(),
                                  tileValue: viewModel.categoryChange.reason??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "EBS reason".toUpperCase(),
                                  tileValue: viewModel.categoryChange.ebsRemarks??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "EBS status".toUpperCase(),
                                  tileValue: viewModel.categoryChange.ebsStatus??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "EBS date".toUpperCase(),
                                  tileValue: viewModel.categoryChange.ebsDate??"null"),

                              const ViewDetailedLcHeadWidget(title: "Meter particulars",),
                              ViewDetailedLcTileWidget(
                                  tileKey: "meter make".toUpperCase(),
                                  tileValue: viewModel.categoryChange.meterMake??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "meter capacity".toUpperCase(),
                                  tileValue: viewModel.categoryChange.meterCapacity??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "meter serial No".toUpperCase(),
                                  tileValue: viewModel.categoryChange.meterSlNo??"null"),
                              ViewDetailedLcTileWidget(
                                  tileKey: "meter final reading".toUpperCase(),
                                  tileValue: viewModel.categoryChange.meterFr.toString()??"null"),
                              Text("Test Report".toUpperCase()),
                              ViewDetailedLcImageWidget(imageUrl: viewModel.categoryChange.testReportPath??""),
                              const SizedBox(height: 10),
                              if(data['status']=="VERIFIED")
                                  SizedBox(width: double.infinity,child:PrimaryButton(text: "ASSIGN TO STAFF", onPressed: (){viewModel.getEmployeesOfSection(viewModel.categoryChange);}),)
                               else if(data['status']=="LM_F")
                                  SizedBox(width: double.infinity,child:PrimaryButton(text: "ACCEPT/REJECT", onPressed: (){viewModel.getMeterMakesAndCapacities();}),)
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
