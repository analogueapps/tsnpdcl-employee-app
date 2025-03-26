import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/view_dispatch_instructions_viewmodel.dart';

class ViewDispatchInstructionsScreen extends StatelessWidget {
  static const id = Routes.viewDispatchInstructionsScreen;

  const ViewDispatchInstructionsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ViewDispatchInstructionsViewModel(context: context),
      child: Consumer<ViewDispatchInstructionsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "View Dispatch Instructions".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    viewModel.poleDispatchInstructionList.isNotEmpty ? "Showing ${viewModel.poleDispatchInstructionList.length} D.I(s)" : "No D.I(s)",
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
                : viewModel.poleDispatchInstructionList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.builder(
                itemCount: viewModel.poleDispatchInstructionList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.poleDispatchInstructionList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigation.instance.navigateTo(Routes.viewDetailedDiTabsScreen, args: jsonEncode(item));
                    },
                    child: Column(
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
                                        checkNull(item.diStatus),
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
                                          checkNull(item.purchaseOrderNo),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                            normalSize,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: doubleTwenty,),
                                      Text(
                                        "Qty:${item.qtyToBeDispatched ?? "0"}",
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
                                  Navigation.instance.navigateTo(Routes.viewDetailedDiTabsScreen, args: jsonEncode(item));
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
                    ),
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
