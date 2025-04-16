import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/rfss/viewmodel/download_struct_viewmodel.dart';

class DownloadStructuresScreen extends StatelessWidget {
  const DownloadStructuresScreen({super.key});
  static const id = Routes.downloadStructures;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
        GlobalConstants.downloadStructures.toUpperCase(),
    style: const TextStyle(
    color: Colors.white,
    fontSize: toolbarTitleSize,
    fontWeight: FontWeight.w700),
    ),
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    ),
    body:ChangeNotifierProvider(
    create: (_) => DownloadStructureViewModel(context: context),
    child: Consumer<DownloadStructureViewModel>(
    builder: (context, viewModel, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please select the Substation and feeder to download the feeder wise"
                  " DTR structures data even if the DTR structure does not pertain to your section"
                  " so that you can map your services to other/neighbor section structure codes.",
              style: TextStyle(color: Colors.red, fontSize: doubleThirteen),),
            const SizedBox(height: 20,),
            const Text(
              "Choose Substation",
              style: TextStyle(
                color: CommonColors.colorPrimary,
              ),
            ),
            const SizedBox(height: doubleTen),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select an option"),
              value: viewModel.list33kVSsOfCircleSelect,
              items: viewModel.list33kVSsOfCircleItem
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item.optionCode,
                    child: Text(item.optionName!),
                  ))
                  .toList(),
              onChanged: (value) {
                viewModel.onList33kVSsOfCircleValueChange(value);
              },
            ),
            Text(
              viewModel.list33kVSsOfCircleSelect ?? "",
              style: const TextStyle(
                color: Colors.green,
                fontSize: extraRegularSize,
              ),
            ),
            const SizedBox(height: 10,),
            const Text(
              "CHOOSE FEEDER",
              style: TextStyle(
                color: CommonColors.colorPrimary,
              ),
            ),
            const SizedBox(height: doubleTen),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select an option"),
              value: viewModel.listFeederSelect,
              items: viewModel.listFeederItem
                  .map((item) => DropdownMenuItem<String>(
                value: item.optionCode,
                child: Text(item.optionName!),
              ))
                  .toList(),
              onChanged: (value) {
                viewModel.onListFeederValueChange(value);
              },
            ),
            Text(
              viewModel.listFeederSelect ?? "",
              style: const TextStyle(
                color: Colors.green,
                fontSize: extraRegularSize,
              ),
            ),
          ],
        ),
      );
    }
    ),
    ),
    ) ;
  }
}
