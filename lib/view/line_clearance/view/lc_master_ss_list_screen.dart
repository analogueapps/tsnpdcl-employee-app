import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/lc_master_viewmodel.dart';

class LcMasterSsListScreen extends StatelessWidget {
  static const id = Routes.lcMasterSsListScreen;
  const LcMasterSsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "33/11kv sub station list".toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => LcMasterViewmodel(
            context: context, entry: "LcMasterSsListScreen", ssCode: "-1"),
        child: Consumer<LcMasterViewmodel>(
          builder: (context, viewModel, child) {
            return viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.lcMasterSsList.isEmpty
                    ? const Center(
                        child: Text("No SS Section founded."),
                      )
                    : ListView.separated(
                        itemCount: viewModel.lcMasterSsList.length,
                        itemBuilder: (_, int index) => ListTile(
                          title: Text(
                            viewModel.lcMasterSsList[index].optionName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize:
                                  normalSize, // Specify a font size for better consistency
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right_outlined,
                            size: 24.0,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            var argument = {
                              'ssCode':
                                  viewModel.lcMasterSsList[index].optionId!,
                              'ssName':
                                  viewModel.lcMasterSsList[index].optionName!
                            };
                            Navigation.instance.navigateTo(
                                Routes.lcMasterFeederListScreen,
                                args: argument);
                          },
                        ),
                        separatorBuilder: (_, __) => const Divider(height: 1),
                      );
          },
        ),
      ),
    );
  }
}
