import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_inspection_list_viewmodel.dart';

class DtrInspectionListScreen extends StatelessWidget {
  static const id = Routes.dtrInspectionListScreen;
  final String status;

  const DtrInspectionListScreen({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DtrInspectionListViewmodel(context: context, type: status),
      child: Consumer<DtrInspectionListViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                StatusConstants.getDTRInspectionListScreenTitle(status).toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.dtrInspectionSheetEntityList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.builder(
                itemCount: viewModel.dtrInspectionSheetEntityList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.dtrInspectionSheetEntityList[index];

                  return GestureDetector(
                    onTap: () {
                      if(status=="inspectionDone") {
                        Navigation.instance.navigateTo(Routes
                            .dtrMaintenanceInspectionScreen, args: jsonEncode(
                            item));
                      } else if(status=="toBeMaintained"){
                        Navigation.instance.navigateTo(Routes.dtrMaintenanceEntry, args: jsonEncode(item));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: doubleFive,),
                        Container(
                          margin: const EdgeInsets.only(left: doubleTen, right: doubleTen),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "#${checkNull(item.sheetId.toString())}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: doubleTen,
                                ),
                              ),
                              Text(
                                checkNull(item.structureCode),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize:
                                  normalSize,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${checkNull(item.employeeMasterEntityByLmEmpId!.empName)}/${checkNull(item.employeeMasterEntityByLmEmpId!.designation)}",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: regularTextSize,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Text(
                                    "Date: ${formatIsoDateForDtrInspectionDetails(item.insertDate)}",
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: regularTextSize,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
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
