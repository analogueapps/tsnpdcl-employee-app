import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/ccc/viewModel/ccc_complaint_track_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class CccComplaintTrack extends StatelessWidget {
  static const id = Routes.complaintTrack;

  const CccComplaintTrack({super.key, required this.ticketID});

  final String ticketID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text("#$ticketID", style: const TextStyle(
            color: Colors.white,
            fontSize: titleSize,
            fontWeight: FontWeight.w700),),
        actions:  const [Icon(Icons.history, color: Colors.white,)],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
    create: (_) => CccComplaintTrackViewmodel(context: context, ticketId: ticketID),
    child: Consumer<CccComplaintTrackViewmodel>(
    builder: (context, viewModel, child) {
    return Stack(
    children:[
    ListView.builder(
    itemCount: viewModel.complaintCount.length,
    itemBuilder: (context, index) {
      final data = viewModel.complaintCount[index];
      return data == null
          ?
      const Center(child: Text("No data found")) :
      Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // Optional: to give rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(
                  0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ViewDetailedLcTileWidget(
                          tileKey: "STATUS",
                          tileValue: data.status ?? "", valueColor:  data.status=="RESOLVED"?Colors.green:Colors.redAccent,),

                      ViewDetailedLcTileWidget(
                          tileKey: "REMARKS",
                          tileValue: data.remarks ?? ""),

                      ViewDetailedLcTileWidget(
                          tileKey: "UPDATED BY",
                          tileValue: "${data.userName}(${data.userId})" ?? "NULL"),
                      ViewDetailedLcTileWidget(
                          tileKey: "UPDATED ON",
                          tileValue: data.statusUpdatedOn ?? ""),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    ),
    if (viewModel.isLoading)
    Positioned.fill(
    child: Container(
    color: Colors.black.withOpacity(0.3), // Optional: dim background
    child: const Center(
    child: CircularProgressIndicator(),
    ),
    ),
    ),
    ]

    );
    }
    ),
      ),
    );
  }
}
