import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/ltmt/viewModel/meterOM_viewModel.dart';


class LtmtMenu extends StatelessWidget {
  static const id = Routes.ltmtScreen;
  const LtmtMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeterOMViewmodel(context: context),
      child: Consumer<MeterOMViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.ltmtTitle.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigation.instance.navigateTo(Routes.metersStock); // Navigate to MetersStock
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        GlobalConstants.metersStock,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      viewModel.getLoadStaff(); // Trigger staff loading
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        GlobalConstants.metersOM,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}