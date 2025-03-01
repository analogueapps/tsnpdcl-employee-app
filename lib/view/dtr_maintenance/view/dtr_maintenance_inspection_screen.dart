import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_ht_side_group_controller_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_ht_side_group_controller_viewmodel.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_maintenance_inspection_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class DtrMaintenanceInspectionScreen extends StatelessWidget {
  static const id = Routes.dtrMaintenanceInspectionScreen;
  final String data;

  const DtrMaintenanceInspectionScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DtrMaintenanceInspectionViewmodel(context: context, jsonResponse: data),
      child: Consumer<DtrMaintenanceInspectionViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "DTR Inspection".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    viewModel.dtrInspectionSheetEntity != null ? checkNull(viewModel.dtrInspectionSheetEntity!.structureCode) : "N/A",
                    style: const TextStyle(fontSize: normalSize, color: Colors.grey),
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
                      separatorBuilder: (_, __) => const Divider(height: doubleOne),
                      itemCount: viewModel.groupsList.length,
                      itemBuilder: (context, index) {
                        final group = viewModel.groupsList[index];
                        return GestureDetector(
                          onTap: () {
                            viewModel.selectGroup(group);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(doubleFifteen),
                            color: viewModel.selectedGroup == group
                                ? Colors.grey[300]
                                : Colors.transparent,
                            child: Text(
                                group.optionName!,
                                style: TextStyle(
                                  fontWeight: viewModel.selectedGroup == group ? FontWeight.w700 : FontWeight.w500,
                                )
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
                        flex: 1,
                        child: DtrHtSideGroupControllerScreen()
                      ),
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
                      final htSideViewModel = Provider.of<DtrHtSideGroupControllerViewmodel>(context, listen: false);
                      print(htSideViewModel.spinnerAbSwitchContactsDamagedValue);
                    }
                ),
            ),
          );
        },
      ),
    );
  }
}
