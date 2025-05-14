import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/view_firms_viewmodel.dart';

class ViewFirmsScreen extends StatelessWidget {
  static const id = Routes.viewFirmsScreen;

  const ViewFirmsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ViewFirmsViewmodel(context: context),
      child: Consumer<ViewFirmsViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pole Suppliers".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    viewModel.poleManufacturingFirmList.isNotEmpty ? "Showing ${viewModel.poleManufacturingFirmList.length} Firm(s)" : "No Firm(s)",
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
                : viewModel.poleManufacturingFirmList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.builder(
                itemCount: viewModel.poleManufacturingFirmList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.poleManufacturingFirmList[index];
                  return GestureDetector(
                    onTap: () {
                      //Navigation.instance.navigateTo(Routes.viewDetailedDiTabsScreen, args: jsonEncode(item));
                      viewModel.filterFabClicked(jsonEncode(item));
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: doubleFive,),
                        Padding(
                          padding: const EdgeInsets.all(doubleFive),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      checkNull(item.firmName),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                        normalSize,
                                      ),
                                    ),
                                    const SizedBox(height: doubleTen,),
                                    Text(
                                      checkNull(item.supplierName),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueGrey,
                                        fontSize: extraRegularSize,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    const SizedBox(height: doubleFive,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                checkNull(item.mobileNo),
                                                style: const TextStyle(
                                                  color: CommonColors.colorPrimary,
                                                  fontSize:
                                                  normalSize,
                                                ),
                                              ),
                                              const SizedBox(width: doubleFive,),
                                              Text(
                                                checkNull(item.email),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: regularTextSize,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: doubleTen,),
                                        const Text(
                                          "ACTIVE",
                                          style: TextStyle(
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
                viewModel.filterFabClicked("new");
              },
              backgroundColor: CommonColors.colorPrimary,
              child: const Icon(Icons.add, color: Colors.white,),
            ),
          );
        },
      ),
    );
  }
}
