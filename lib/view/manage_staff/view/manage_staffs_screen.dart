import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/manage_staff/viewmodel/manage_staffs_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class ManageStaffsScreen extends StatelessWidget {
  static const id = Routes.manageStaffsScreen;
  const ManageStaffsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ManageStaffsViewmodel(context: context),
      child: Consumer<ManageStaffsViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "Manage Staff".toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.allStaffsList.isEmpty
                ? const Center(child: Text("You don't have any staff under your section. Please click 'Add Staff' to add staff under your section"),)
                : ListView.builder(
                itemCount: viewModel.allStaffsList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.allStaffsList[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: doubleFive,),
                      Padding(
                        padding: const EdgeInsets.only(left: doubleTen, right: doubleTen),
                        child: Text(
                          checkNull(item.employeeId),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize:
                            normalSize,
                          ),
                        ),
                      ),
                      const SizedBox(height: doubleFive,),
                      Padding(
                        padding: const EdgeInsets.only(left: doubleTen, right: doubleTen),
                        child: Text(
                          checkNull(item.name),
                          style:  TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize:
                              normalSize,
                              color: Colors.grey[600]
                          ),
                        ),
                      ),
                      const SizedBox(height: doubleFive,),
                      Padding(
                        padding: const EdgeInsets.only(left: doubleTen, right: doubleTen),
                        child: Text(
                          checkNull(item.personalPhone),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize:
                              normalSize,
                              color: Colors.grey[500]
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: doubleTen, right: doubleTen),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () async {
                              await showAlertActionDialog(
                                context: context,
                                title: "Remove Employee?",
                                message: "Do you want to remove ${item.name}(${item.designation}) from your section staff?",
                                okLabel: "Delete",
                                onPressed: () {
                                  viewModel.removeStaff(item);
                                },
                              );
                            },
                            child: Text("Remove".toUpperCase(), style: const TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 1,
                      ),
                    ],
                  );
                }
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(doubleTwenty),
              child: PrimaryButton(
                  text: "Add Staff".toUpperCase(),
                  fullWidth: isTrue,
                  onPressed: () {
                    Navigation.instance.navigateTo(Routes.addEmployeeScreen);
                  }
              ),
            ),
          );
        },
      ),
    );
  }
}
