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
  static const id = Routes.pendingListScreen;
  const PendingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PendingListViewModel(context: context, status: "p", ),
        child: Consumer<PendingListViewModel>(
        builder: (context, viewModel, child) {
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
                          ? '${viewModel
                          .selectedMonthYear!['month']} ${viewModel
                          .selectedMonthYear!['year']}'
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
              body: GestureDetector(
                onTap: () {
                  Navigation.instance.navigateTo(
                      Routes.viewDetailedPendingListScreen);
                },
                child: Container(
                  margin: const EdgeInsets.all(14),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Survey Id: 31125",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                      Text(
                        "Survey",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      Text(
                        "Survey - LatA 17.4446414, LonA 78.3843504",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      Text(
                        "EMP ID: 70000000|Section: NAKKALAGUTTA",
                        style: TextStyle(
                          fontSize: 16,
                        ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "01 Apr 2025 03:22",
                            style: TextStyle(color: Colors.blue),
                          ),
                          Text(
                            "PENDING",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                ),
              )
          );
        }
        ),
        );
  }

}
