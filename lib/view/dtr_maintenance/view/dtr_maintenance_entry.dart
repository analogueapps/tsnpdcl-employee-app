import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
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
      create: (_) =>
          DtrMaintenanceEntryViewmodel(context: context, jsonResponse: data),
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
                            color: isSelected
                                ? Colors.grey[300]
                                : Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    group.optionName!,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
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
                          flex: 1,
                          child: DtrHtMaintenanceEntry(
                            data: data,
                            selectedOption: viewModel.selectedGroup!.optionId,
                          )),
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
                    viewModel.handleLocationIconClick();
                    imageDialog(context, viewModel);
                  }),
            ),
          );
        },
      ),
    );
  }
}

void imageDialog(BuildContext context, DtrMaintenanceEntryViewmodel viewModel) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          title: Container(
            width: double.infinity,
            color: CommonColors.colorPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Capture after maintenance DTR structure photo".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),
          content: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: viewModel.photoPath.isEmpty
                    ? const Center(child: Icon(Icons.image, size: 50))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: Image.network(
                            Apis.NPDCL_STORAGE_SERVER_IP + viewModel.photoPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  viewModel.capturePhoto();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
                ),
                child: const Text(
                  "CAPTURE IMAGE",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("LC NO:"),
                  Text(""), // Replace with actual LC No
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("LAT:"),
                  Text(""), // Replace with actual LAT
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("LON:"),
                  Text(""), // Replace with actual LON
                ],
              ),
              const Divider(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // viewModel.longitude = "";
                // viewModel.latitude = "";
                // notifyListeners();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: CommonColors.colorPrimary,
              ),
              child: const Text(
                "CANCEL",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                if (viewModel.latitude.isEmpty && viewModel.longitude.isEmpty) {
                  showAlertDialog(context,
                      "Please wait until we capture your location and please make sure you turn on your location.");
                } else {
                  print("In else block");
                }
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[300]), // Replace with logic
              child: const Text(
                "SUBMIT",
                style: TextStyle(color: CommonColors.colorPrimary),
              ),
            ),
          ],
        );
      });
}
