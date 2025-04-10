import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/account_screen/viewmodel/account_screen_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class AccountScreen extends StatelessWidget {
  static const id = Routes.accountScreen;

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AccountScreenViewmodel(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: Text(
            GlobalConstants.account.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Consumer<AccountScreenViewmodel>(
          builder: (context, viewmodel, _) {
            if (viewmodel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewmodel.accountData == null) {
              return const Center(child: Text("No account data available"));
            }

            // Extract employee data from the response
            final employeeData = viewmodel.accountData!['rowList'] != null
                ? _extractEmployeeDetails(viewmodel.accountData!['rowList'])
                : {};

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Personal Details Section
                  _buildSectionHeader("Personal Details"),
                  ViewDetailedLcTileWidget(
                    tileKey: "Employee ID",
                    tileValue: employeeData['EMPLOYEE ID'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Surname",
                    tileValue: employeeData['SURNAME'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Name",
                    tileValue: employeeData['NAME'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Father Name",
                    tileValue: employeeData['FATHER NAME'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Gender",
                    tileValue: employeeData['GENDER'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Date of Birth",
                    tileValue: employeeData['DATE OF BIRTH'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Aadhar No",
                    tileValue: employeeData['AADHAR NO'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  // Office Details Section
                  _buildSectionHeader("Office Details"),
                  ViewDetailedLcTileWidget(
                    tileKey: "Date of Joining",
                    tileValue: employeeData['DATE OF JOINING'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Designation",
                    tileValue: viewmodel.accountData!['designation'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Employee Status",
                    tileValue: employeeData['EMPLOYEE STATUS'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Employee Type",
                    tileValue: employeeData['EMPLOYEE TYPE'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Personal Phone",
                    tileValue: employeeData['PERS. PH'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Office Phone",
                    tileValue: employeeData['OFFICE PH'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Smart Login",
                    tileValue: employeeData['SMART LOGIN'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Office Type",
                    tileValue: employeeData['OFFICE TYPE'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Office Code",
                    tileValue: employeeData['OFFICE CODE'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Office Name",
                    tileValue: employeeData['OFFICE NAME'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Wing",
                    tileValue: employeeData['WING'] ?? "",
                    valueColor: CommonColors.colorPrimary,
                  ),
                  Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      color: Colors.grey[200],
      width: double.infinity,
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  static Map<String, String> _extractEmployeeDetails(List<dynamic> rowList) {
    final details = <String, String>{};
    for (var row in rowList) {
      if (row['label'] != null && row['displayValue'] != null) {
        details[row['label'].toString().toUpperCase()] =
        row['displayValue'].toString().isNotEmpty
            ? row['displayValue'].toString()
            : "";
      }
    }
    return details;
  }
}
