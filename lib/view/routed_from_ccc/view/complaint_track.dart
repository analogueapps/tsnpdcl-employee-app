import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/routed_from_ccc/viewmodel/complaint_track_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class DetailComplaintTrack extends StatelessWidget {
  static const id = Routes.detailComplaintTrack;
   DetailComplaintTrack({super.key, required this.arg});
final String arg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "#${arg}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: toolbarTitleSize,
            fontWeight: FontWeight.w700,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body:ChangeNotifierProvider(
        create: (_) => ComplaintTackViewModel(context: context, ticketId: arg),
        child: Consumer<ComplaintTackViewModel>(
            builder: (context, viewModel, child) {
              return Stack(
                  children:[
                    ListView.builder(
                        itemCount: viewModel.complaintTrack.length,
                        itemBuilder: (context, index) {
                          final data = viewModel.complaintTrack[index];
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
