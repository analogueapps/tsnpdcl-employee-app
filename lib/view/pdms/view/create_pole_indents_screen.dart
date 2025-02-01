import 'dart:convert';

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
import 'package:tsnpdcl_employee/view/pdms/viewmodel/create_pole_indents_viewmodel.dart';

class CreatePoleIndentsScreen extends StatelessWidget {
  static const id = Routes.createPoleIndentsScreen;

  const CreatePoleIndentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreatePoleIndentsViewmodel(context: context),
      child: Consumer<CreatePoleIndentsViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pole Indents".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    viewModel.createPoleIndentList.isNotEmpty ? "Showing ${viewModel.createPoleIndentList.length} Indent(s)" : "No Indent(s)",
                    style: const TextStyle(fontSize: normalSize, color: Colors.grey),
                  ),
                ],
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              actions: [
                Visibility(
                  visible: viewModel.npdclUser.wing == "operation" && viewModel.npdclUser.designationCode == 150 || viewModel.npdclUser.designationCode == 155,
                  child: TextButton(
                    onPressed: () {
                      viewModel.createActionClicked();
                    },
                    child: const Text('CREATE INDENT',style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.createPoleIndentList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.builder(
                itemCount: viewModel.createPoleIndentList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.createPoleIndentList[index];

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
                                        "#${checkNull(item.sectionId)} SEC:${checkNull(item.section)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                          normalSize,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: doubleTwenty,),
                                    Text(
                                      checkNull(item.indentStatus),
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
                                        "Date:${formatIsoDateForPdmsDetails(checkNull(item.indentDate))}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                          normalSize,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: doubleTwenty,),
                                    Text(
                                      "Indent Qty:${item.requestedQty ?? "0"}",
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
                                Navigation.instance.navigateTo(Routes.viewDetailedPoleIndentScreen, args: jsonEncode(item));
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                viewModel.filterFabClicked();
              },
              backgroundColor: CommonColors.colorPrimary,
              child: const Icon(Icons.filter_alt_outlined, color: Colors.white,),
            ),
          );
        },
      ),
    );
  }
}
