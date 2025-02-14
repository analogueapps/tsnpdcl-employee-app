import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_master_list_viewmodel.dart';

class DtrMasterListScreen extends StatelessWidget {
  static const id = Routes.dtrMasterListScreen;
  const DtrMasterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DtrMasterListViewmodel(context: context),
      child: Consumer<DtrMasterListViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "Assign DTR Inspection".toUpperCase(),
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
                : viewModel.dtrStructureIndexList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.builder(
                itemCount: viewModel.dtrStructureIndexList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.dtrStructureIndexList[index];

                  return GestureDetector(
                    onTap: () {
                      viewModel.containerClicked(item);
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
                                          checkNull(item.structureCode),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                            normalSize,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: doubleFive,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: doubleTen,),
                                      const Text(
                                        "Last Maintenance Date: ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: regularTextSize,
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      Text(
                                        checkNull(item.lastMaintainedDate),
                                        style: TextStyle(
                                          color: checkNull(item.lastMaintainedDate) != "NEVER" ? CommonColors.successGreen : CommonColors.deepRed,
                                            fontSize: regularTextSize,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Text(
                              item.maintenanceCount.toString() ?? "0",
                              style: const TextStyle(
                                fontSize: extraRegularSize,
                                fontWeight: FontWeight.w900
                              ),
                            ),
                            const SizedBox(width: doubleTen,),
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
