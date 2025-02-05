import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/view_pole_dumped_location_viewmodel.dart';

class ViewPoleDumpedLocationScreen extends StatelessWidget {
  static const id = Routes.viewPoleDumpedLocationScreen;
  final String status;

  const ViewPoleDumpedLocationScreen({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ViewPoleDumpedLocationViewmodel(context: context, status: status),
      child: Consumer<ViewPoleDumpedLocationViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    StatusConstants.getPoleDumpedLocationTitle(status).toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    viewModel.poleDumpedLocationEntityList.isNotEmpty ? "Showing ${viewModel.poleDumpedLocationEntityList.length} Indent(s)" : "No Indent(s)",
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
                : viewModel.poleDumpedLocationEntityList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.builder(
                itemCount: viewModel.poleDumpedLocationEntityList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.poleDumpedLocationEntityList[index];

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
                                        "#${checkNull(item.dispatchInstructionId.toString())}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                          normalSize,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: doubleTwenty,),
                                    Text(
                                      checkNull(item.status),
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
                                        "Date: ${formatIsoDateForDiShippingDetails(checkNull(item.dumpDate))}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                          normalSize,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: doubleTwenty,),
                                    Text(
                                      "Dumped Qty:${item.dumpedQty ?? "0"}",
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
                                Navigation.instance.navigateTo(Routes.viewDetailedPoleDumpedLocationScreen, args: jsonEncode(item));
                              },
                              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14,)
                          )
                        ],
                      ),
                      const SizedBox(height: doubleFive,),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 1,
                      ),
                    ],
                  );
                }
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     viewModel.filterFabClicked();
            //   },
            //   backgroundColor: CommonColors.colorPrimary,
            //   child: const Icon(Icons.filter_alt_outlined, color: Colors.white,),
            // ),
          );
        },
      ),
    );
  }
}
