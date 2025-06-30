import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/revoking_of_services/viewmodel/revoking_of_services_request_list_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';

class RevokingOfServicesRequestList extends StatelessWidget {
  const RevokingOfServicesRequestList({super.key, required this.args});

  static const id = Routes.revokeOfServicesChangeRequestList;
  final String args;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RevokingOfServicesRequestListViewmodel(
          context: context, status: args),
      child: Consumer<RevokingOfServicesRequestListViewmodel>(
          builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CommonColors.colorPrimary,
            title: Text(
              "Wrong billing complaints".toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: titleSize,
                fontWeight: FontWeight.w500,
              ),
            ),
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
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigation.instance.navigateTo(Routes.revokeOfServices);
            },
            child: Image.asset(
              Assets.electricMeter2,
              height: 30.0,
              width: 30.0,
            ),
          ),
        );
      }),
    );
  }
}
