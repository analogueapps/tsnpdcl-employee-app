import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/ccc/viewModel/ccc_oricb_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class CccOricb extends StatelessWidget {
  static const id = Routes.cccORICB;

  const CccOricb({super.key, required this.status, required this.title});
  final String status;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CccOricbViewmodel(context: context, status: status),
      child: Consumer<CccOricbViewmodel>(builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CommonColors.colorPrimary,
            title: Text(
              title,
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
          body: Stack(children: [
            ListView.builder(
                itemCount: viewModel.openList.length,
                itemBuilder: (context, index) {
                  final data = viewModel.openList[index];
                  return data == null
                      ? const Center(child: Text("No data found"))
                      : GestureDetector(
                          onTap: () {
                            Navigation.instance.navigateTo(
                              Routes.openDetail,
                              args: data,
                            );
                            print("passing data: $data");
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              // Optional: to give rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ViewDetailedLcTileWidget(
                                              tileKey: "Section",
                                              tileValue: data.section ?? ""),
                                          ViewDetailedLcTileWidget(
                                              tileKey: "Complaint No",
                                              tileValue:
                                                  data.ticketNumber ?? "NULL"),
                                          ViewDetailedLcTileWidget(
                                              tileKey: "USC No",
                                              tileValue: data.uscNo ?? "NULL"),
                                          ViewDetailedLcTileWidget(
                                              tileKey: "Consumer Name",
                                              tileValue:
                                                  data.consumerName ?? "NULL"),
                                          ViewDetailedLcTileWidget(
                                              tileKey: "Complaint Type",
                                              tileValue:
                                                  data.complaintType ?? "NULL"),
                                          ViewDetailedLcTileWidget(
                                              tileKey: "Complaint Sub Type",
                                              tileValue:
                                                  data.complaintSubType ??
                                                      "NULL"),
                                        ],
                                      ),
                                    ),
                                    // IconButton with no space between it and the text
                                    IconButton(
                                      onPressed: () {
                                        Navigation.instance.navigateTo(
                                          Routes.openDetail,
                                          args: data,
                                        );
                                        print("icon on tap: $data");
                                      },
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14),
                                      padding: EdgeInsets
                                          .zero, // Ensures there is no extra padding
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                }),
            if (viewModel.isLoading)
              Positioned.fill(
                child: Container(
                  color:
                      Colors.black.withOpacity(0.3), // Optional: dim background
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ]),
        );
      }),
    );
  }
}
