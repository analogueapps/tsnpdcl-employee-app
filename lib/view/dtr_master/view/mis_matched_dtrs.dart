import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/mis_matched_viewmodel.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/general_routes.dart';
import '../../../utils/global_constants.dart';

class MisMatchedDtr extends StatelessWidget {
  static const id = Routes.misMatched;
  const MisMatchedDtr({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MisMatchedViewModel(context: context),
        child:
            Consumer<MisMatchedViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: const Text(
                GlobalConstants.missMatchedDtr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.misMatchedStockEntityList.length,
                    itemBuilder: (context, index) {
                      if (viewModel.misMatchedStockEntityList.isEmpty) {
                        return const Center(
                            child: Text("No meter data available"));
                      }

                      final misMatched =
                          viewModel.misMatchedStockEntityList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            //use ListTitle here
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(misMatched.sapEquipmentCode ?? "N/A"),
                              Text(misMatched.structureCode ?? "N/A",
                                  style: const TextStyle(color: Colors.grey)),
                              Text(
                                misMatched.statusRemarks ?? "N/A",
                                style: const TextStyle(color: Colors.redAccent),
                                textAlign: TextAlign.end,
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      );
                    }),
          );
        }));
  }
}
