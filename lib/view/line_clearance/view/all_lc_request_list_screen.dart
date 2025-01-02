import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/all_lc_request_list_viewmodel.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/line_clearance_viewmodel.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/lc_master_viewmodel.dart';

class AllLcRequestListScreen extends StatelessWidget {
  static const id = Routes.allLcRequestListScreen;
  final String status;

  const AllLcRequestListScreen({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AllLcRequestListViewModel(context: context, status: status),
      child: Consumer<AllLcRequestListViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Requested LC's".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: toolbarTitleSize,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    viewModel.allLcRequestList.isNotEmpty ? "Showing ${viewModel.allLcRequestList.length} Lc(s)" : "No Ls(s)",
                    style: const TextStyle(fontSize: normalSize, color: Colors.grey),
                  ),
                ],
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.allLcRequestList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.builder(
                itemCount: viewModel.allLcRequestList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.allLcRequestList[index];

                  return Column(
                    children: [
                      const SizedBox(height: doubleFive,),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: doubleTen,),
                                    Expanded(
                                      child: Text(
                                        "#${item.lcId} FDR:${item.fdrCode}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                          normalSize,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: doubleTwenty,),
                                    Text(
                                      StatusConstants.getStatusMeaning(item.status!),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                        fontSize: regularTextSize,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: doubleFive,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: doubleTen,),
                                    Expanded(
                                      child: Text(
                                        "Req. Date:${formatIsoDateForLcRequested(item.requestDate ?? "")}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                          normalSize,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: doubleTwenty,),
                                    Text(
                                      "${item.lcPurpose}",
                                      style: const TextStyle(
                                        color: CommonColors.colorPrimary,
                                        fontSize: regularTextSize,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigation.instance.navigateTo(Routes.viewDetailedLcScreen, args: item.lcId);
                              },
                              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14,)
                          )
                        ],
                      ),
                      const SizedBox(height: doubleTen,),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 1,
                      ),
                    ],
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
