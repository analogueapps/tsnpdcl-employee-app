import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/general_routes.dart';
import '../viewModel/meterStock_viewModel.dart';

class MetersStock extends StatelessWidget {
  static const id = Routes.metersStock;
  const MetersStock({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeterStockViewmodel(context: context),
      child: Consumer<MeterStockViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: CommonColors.colorPrimary,
                title: const Text(
                  "Meters Stock",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: toolbarTitleSize,
                      fontWeight: FontWeight.w700),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                actions: [
                  Visibility(
                    visible: viewModel.checkedCount != 0,
                    child: TextButton(
                      onPressed: () {
                        viewModel.getLoadStaff();
                      },
                      child: Text(
                        "${viewModel.checkedCount}/${viewModel.meterStockEntityList.length} ALLOT?",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              body: viewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator()) // Show loader
                  : SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.meterStockEntityList.length,
                        itemBuilder: (context, index) {
                          if (viewModel.meterStockEntityList.isEmpty) {
                            return const Center(
                                child: Text("No meter data available"));
                          }

                          final meter = viewModel.meterStockEntityList[index];
                          final isChecked =
                              viewModel.selectedMeters.contains(meter);
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      onChanged: (bool? newValue) {
                                        if (newValue != null) {
                                          viewModel.toggleMeterSelection(
                                              meter, newValue);
                                        }
                                      },
                                    ),
                                    Text(meter.meterNo?.toString() ?? "N/A"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 50),
                                    Text(
                                        "${meter.make ?? 'N/A'}, ${meter.meterType ?? 'N/A'}, ${meter.meterCapacity ?? 'N/A'}"),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    meter.opDate ?? "N/A",
                                    style: const TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                const Divider(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  viewModel.showMeterDialog(context);
                },
                backgroundColor: CommonColors.pink,
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ));
        },
      ),
    );
  }
}
