import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/routed_from_ccc/viewmodel/view_detail_complaint_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailComplaint extends StatelessWidget {
  static const id = Routes.viewDetailComplaint;
  const ViewDetailComplaint({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ViewDetailComplaintViewmodel(context: context, args: args),
      child: Consumer<ViewDetailComplaintViewmodel>(
          builder: (context, viewModel, child) {
            return Scaffold(
        appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
        "#${args['ticketId']}",
        style: const TextStyle(
        color: Colors.white,
        fontSize: toolbarTitleSize,
        fontWeight: FontWeight.w700,
    ),
    ),
            viewModel.complaintDetailsList.isNotEmpty?Text(
              viewModel.complaintDetailsList[0].consumerName??"",
        style: const TextStyle(
        color: Colors.white,
        fontSize: doubleFifteen,
        fontWeight: FontWeight.w300,
    ),
    ):const SizedBox.shrink(),
    ]
        ),
          actions:  [IconButton(onPressed: (){
            Navigation.instance.navigateTo(Routes.detailComplaintTrack, args: args['ticketId']);
          },
              icon: const Icon(Icons.history, color: Colors.white,))],
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    ),
    body:  viewModel.complaintDetailsList.isEmpty
        ? const Center(child: CircularProgressIndicator()) // 🔄 show loading
        :
      SingleChildScrollView(
        child:Padding(padding:EdgeInsets.all(16),
          child:Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                ViewDetailedLcTileWidget(
                    tileKey: "Complaint No", tileValue: "${viewModel.complaintDetailsList[0].ticketNumber}"),
                  const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Complaint Reg Date",
                    tileValue: viewModel.complaintDetailsList[0].entryDate??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Complaint Type",
                    tileValue: viewModel.complaintDetailsList[0].complaintType??""),

                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Complaint Subtype", tileValue: viewModel.complaintDetailsList[0].complaintSubType??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "USCNO",
                    tileValue: viewModel.complaintDetailsList[0].uscNo??""),
                const Divider(),

                ViewDetailedLcTileWidget(
                    tileKey: "SC No",
                    tileValue: viewModel.complaintDetailsList[0].scNo??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Consumer Name",
                    tileValue: viewModel.complaintDetailsList[0].consumerName??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Mobile No",
                    tileValue: viewModel.complaintDetailsList[0].mobileNo??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "H.No",
                    tileValue: viewModel.complaintDetailsList[0].hNo??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Address",
                    tileValue: viewModel.complaintDetailsList[0].address??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Landmaerk",
                    tileValue: viewModel.complaintDetailsList[0].landmark??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Pole NO",
                    tileValue: viewModel.complaintDetailsList[0].poleNumber??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Area", tileValue: viewModel.complaintDetailsList[0].area??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Section", tileValue: viewModel.complaintDetailsList[0].section??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Source",
                    tileValue: viewModel.complaintDetailsList[0].complaintSource??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Remarks",
                    tileValue: viewModel.complaintDetailsList[0].remarks??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Circle",
                    tileValue: viewModel.complaintDetailsList[0].circle??""),
                const Divider(),
                ViewDetailedLcTileWidget(
                    tileKey: "Complaint Status",
                    tileValue: viewModel.complaintDetailsList[0].status??""),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    floatingActionButton:  FloatingActionButton(onPressed: (){
      viewModel.call();
    },backgroundColor: Colors.green, child: const Icon(Icons.call, color: Colors.white,),),
    );
    }
    ),
    );
  }
}
