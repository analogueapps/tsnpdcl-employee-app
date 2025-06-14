import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/viewModel/view_ct_pt_viewModel.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';

class FailureReportedList extends StatelessWidget {
  static const id = Routes.viewCtPtReportList;

  const FailureReportedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FailureReportedListViewModel(context: context),
      child: Consumer<FailureReportedListViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Failure Reported List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              backgroundColor: CommonColors.colorPrimary,
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                TextButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MonthYearSelector(),
                      ),
                    );
                    if (result != null && result is Map) {
                      viewModel.setSelectedMonthYear(
                        result['month'] as String,
                        result['year'] as int,
                        context,
                      );
                    }
                  },
                  child: Text(
                    viewModel.selectedMonthYear != null
                        ? '${viewModel.selectedMonthYear!['month']} ${viewModel.selectedMonthYear!['year']}'
                        : 'SELECT MONTH/YEAR',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: viewModel.failureReports.length,
            itemBuilder: (context, index) {
              if (viewModel.failureReports.isEmpty) {
                return const Center(child: Text("No data found"));
              } else {
                final report = viewModel.failureReports[index];
                print("ctpt responsee: $report");
                return InkWell(
                  onTap: () {
                    Navigation.instance.navigateTo(
                      Routes.viewDetailedCtptReport,
                      args: report,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reg No. ${report.data['reportId'] ?? 'N/A'}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              report.data['section'] ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CommonColors.colorPrimary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'SC No. ${report.data['htScno'] ?? 'N/A'} \n ${report.data['cName'] != null && report.data['cName']!.isNotEmpty ? '(${report.data['cName']})' : ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: doubleTen,),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              report.data['reportDate'] ?? 'N/A',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              report.data['status'] ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: Colors.grey, thickness: 1),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          );
        },
      ),
    );
  }
}
