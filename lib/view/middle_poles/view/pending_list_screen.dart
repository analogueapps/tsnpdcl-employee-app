import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/middle_poles/viewmodel/pending_list_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';

class PendingListScreen extends StatelessWidget {
  static const id = Routes.pendingCompletedListScreen;
  const PendingListScreen({super.key, required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PendingListViewModel(
        context: context,
        status: status,
      ),
      child:
          Consumer<PendingListViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Middle Pole List",
              style: TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
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
              :  ListView.builder(
                itemCount: viewModel.pendingAndFinishedList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.pendingAndFinishedList[index];
                  return InkWell(
                    onTap: () {
                      Navigation.instance.navigateTo(
                      Routes.viewDetailedPendingListScreen,
                      args: {
                      'surveyID': item.surveyId,
                      'status': item.status,
                      },
                      );
                    },
                    child: viewModel.pendingAndFinishedList.isEmpty?
                        Center(child: Text("No data found"),):
                    ListTile(
                      title: Text(
                        "Survey Id: ${item.surveyId}",
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.sanctionNo,
                            ),
                            Text(
                              "${item.sanctionNo} - LatA ${item.poleALat}, LonA ${item.poleALon}",
                            ),
                            Text(
                              "EMP ID:${item.surveyorId}|Section: ${item.section}",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.dateOfAbMarked,
                                ),
                                Text(
                                  item.status,
                                  style: TextStyle(
                                      color: item.status == "PENDING"
                                          ? Colors.red
                                          : Colors.green),
                                ),
                              ],
                            ),
                            const Divider(),
                          ]),
                    ),
                  );
                }),
        );
      }),
    );
  }
}
