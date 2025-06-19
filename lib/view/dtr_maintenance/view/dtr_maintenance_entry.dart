import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_ht_maintenance_entry.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_ht_maintenance_entry_viewmodel.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_maintenance_entry_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class DtrMaintenanceEntry extends StatelessWidget {
  static const id = Routes.dtrMaintenanceEntry;
  final String data;

  const DtrMaintenanceEntry({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DtrMaintenanceEntryViewmodel(
          context: context, jsonResponse: data),
      child: Consumer<DtrMaintenanceEntryViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "DTR Maintenance Entry".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    viewModel.dtrInspectionSheetEntity != null
                        ? checkNull(
                        viewModel.dtrInspectionSheetEntity!.structureCode)
                        : "N/A",
                    style: const TextStyle(
                        fontSize: normalSize, color: Colors.grey),
                  ),
                ],
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: double.infinity,
                    child: ListView.separated(
                      separatorBuilder: (_, __) =>
                      const Divider(height: doubleOne),
                      itemCount: viewModel.groupsList.length,
                      itemBuilder: (context, index) {
                        final group = viewModel.groupsList[index];
                        final isSelected = viewModel.selectedGroup == group;

                        // final bool showTick = viewModel.maintenanceCheckMap[group.optionId]?.call() ?? false;
                        return GestureDetector(
                          onTap: () {
                            viewModel.selectGroup(group);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(doubleFifteen),
                            color: isSelected ? Colors.grey[300] : Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    group.optionName!,
                                    style: TextStyle(
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    ),
                                  ),
                                ),
                                // if (showTick) const Icon(Icons.check, color: Colors.green),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: doubleOne,
                  color: Colors.grey,
                  height: double.infinity,
                ),
                 Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Flexible(
                          flex: 1, child: DtrHtMaintenanceEntry(data: data,selectedOption:viewModel.selectedGroup!.optionId,)),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(doubleTwenty),
              child: PrimaryButton(
                  text: "Submit".toUpperCase(),
                  fullWidth: isTrue,
                  onPressed: () {
                    final htSideViewModel =
                    Provider.of<DtrHtMaintenanceEntryViewmodel>(context,
                        listen: false);
                    final result = htSideViewModel
                        .methodToCallOnSubmitDtrHtSideGroupControllerScreen(
                        context, isTrue);
                    if (result) {
                      htSideViewModel.getData();
                    }
                  }
              ),
            ),
          );
        },
      ),
    );
  }
}

