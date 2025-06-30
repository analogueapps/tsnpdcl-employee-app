import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/check_measure_viewmodel.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/docket_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class DocketScreen extends StatelessWidget {
  static const id = Routes.docketScreen;
  final String ssc;
  const DocketScreen({super.key, required this.ssc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            "Select Docket",
            style: TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: ChangeNotifierProvider(
            create: (_) => DocketViewmodel(context: context, sectionID: ssc),
            child:
                Consumer<DocketViewmodel>(builder: (context, viewModel, child) {
              return Stack(children: [
                ListView.builder(
                  itemCount: viewModel.docketList.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.docketList[index];
                    final isExpanded =
                        viewModel.expandedIndexes.contains(index);

                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: viewModel.docketList.isEmpty
                            ? const Center(child: Text("No data"))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Proposal No. ${item.id}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.worklDesc ?? "",
                                    maxLines: isExpanded ? null : 3,
                                    overflow: TextOverflow.fade,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      isExpanded ? "Less" : "More",
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    " ${item.ssName}",
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      " ${item.insertDate}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.green),
                                      ),
                                      onPressed: () {
                                        viewModel.onItemSelected(item);
                                        // Navigation.instance.navigateTo(Routes.checkMeasureScreen );
                                      },
                                      child: const Text(
                                        "Select",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ),
                    );
                  },
                ),
                if (viewModel.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.0),
                      // Semi-transparent overlay
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
              ]);
            })));
  }
}
