import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/line_clearance_viewmodel.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/lc_master_viewmodel.dart';

class LcMasterFeederListScreen extends StatelessWidget {
  static const id = Routes.lcMasterFeederListScreen;
  final Map<String, dynamic> args;

  const LcMasterFeederListScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "11KV Feeders List".toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700
              ),
            ),
            Text(
              args['ssCode'],
              style: const TextStyle(fontSize: normalSize, color: Colors.grey),
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => LcMasterViewmodel(context: context, entry: "LcMasterFeederListScreen", ssCode: args['ssCode']),
        child: Consumer<LcMasterViewmodel>(
          builder: (context, viewModel, child) {
            return viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.lcMasterFeederList.isEmpty
                ? const Center(child: Text("No Feeder List Section founded."),)
                : ListView.separated(
              itemCount: viewModel.lcMasterFeederList.length,
              itemBuilder: (_, int index) => ListTile(
                title: Text(
                  viewModel.lcMasterFeederList[index].optionName!,
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
                    'ssCode': args['ssCode'],
                    'ssName': args['ssName'],
                    'fdrCode': viewModel.lcMasterFeederList[index].optionId!,
                    'fdrName': viewModel.lcMasterFeederList[index].optionName!,
                  };
                  Navigation.instance.navigateTo(Routes.feederInductionListScreen, args: argument);
                },
              ),
              separatorBuilder: (_, __) => const Divider(),
            );
          },
        ),
      ),
    );
  }
}
