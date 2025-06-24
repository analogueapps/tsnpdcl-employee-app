import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/routed_from_ccc/viewmodel/ccc_complaints_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class CccComplaints extends StatelessWidget {
  static const id = Routes.routeCCC;
  const CccComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title:  const Text(
        "CCC Complaints",
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
    create: (_) => CccComplaintsViewmodel(context: context),
    child: Consumer<CccComplaintsViewmodel>(
    builder: (context, viewModel, child) {
      return Stack(
          children:[
            ListView.builder(
                itemCount: viewModel.complaintData.length,
                itemBuilder: (context, index) {
                  final data = viewModel.complaintData[index];
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("#${data.cccComplaintId}", style: const TextStyle(color: CommonColors.colorPrimary),),
                                      ViewDetailedLcTileWidget(
                                          tileKey: "Section",
                                          tileValue: data.cccComplaintId),
                                      const Divider(),
                                      ViewDetailedLcTileWidget(
                                          tileKey: "Complaint No",
                                          tileValue: "${data.complaintType}/${data.subComplaintType}"),
                                      const Divider(),
                                      ViewDetailedLcTileWidget(
                                          tileKey: "USC No",
                                          tileValue:data.uscNo),
                                      const Divider(),
                                      ViewDetailedLcTileWidget(
                                          tileKey: "Consumer Name",
                                          tileValue:data.consPhone),
                                      const Divider(),
                                      ViewDetailedLcTileWidget(
                                          tileKey: "Complaint Type",
                                          tileValue:data.consName),

                                    ],
                                  ),
                                ),
                                // IconButton with no space between it and the text
                                IconButton(
                                  onPressed: () {
                                    viewModel.complaintDialog(context,data.subComplaintType,data.cccComplaintId, data.uscNo );
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
