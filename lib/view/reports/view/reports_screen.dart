import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/reports/model/bar_graph_data.dart';
import 'package:tsnpdcl_employee/view/reports/view/grouped_bar_graph_widget.dart';
import 'package:tsnpdcl_employee/view/reports/view/line_graph_widget.dart';
import 'package:tsnpdcl_employee/view/reports/viewmodel/reports_viewmodel.dart';

class ReportsScreen extends StatelessWidget {
  static const id = Routes.reportsScreen;
  final String path;

  const ReportsScreen({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportsViewmodel(context: context, path: path),
      child: Consumer<ReportsViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "Reports".toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(doubleFive),
                  child: Row(
                    children: [
                      const Text(
                        "Select Year",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: normalSize,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text("Select an option"),
                          value: viewModel.selectedYear,
                          items: viewModel.yearList.map((year) {
                            return DropdownMenuItem<String>(
                              value: year,
                              child: Text(year),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              viewModel.onListYearSelected(value),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.barGraphData.isEmpty
                          ? const Center(child: Text("No data found."))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: viewModel.barGraphData.length,
                              itemBuilder: (context, index) {
                                final graphData = viewModel.barGraphData[index];

                                if (graphData.typeOfGraph == "LINE_GRAPH") {
                                  return LineGraphWidget(graphData: graphData);
                                } else if (graphData.typeOfGraph ==
                                    "GROUPED_BAR_GRAPH") {
                                  return GroupedBarGraphWidget(
                                      graphData: graphData);
                                } else if (graphData.typeOfGraph ==
                                    "PIE_GRAPH") {
                                  return const SizedBox();
                                }
                                return null;
                              },
                            ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
