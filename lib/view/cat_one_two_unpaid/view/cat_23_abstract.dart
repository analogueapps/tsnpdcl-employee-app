import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/cat_one_two_unpaid/viewmodel/cat_23_abstract_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';

class Cat23Abstract extends StatelessWidget {
  static const id = Routes.catAbstract;
  final Map<String, dynamic> args;
  const Cat23Abstract({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cat23AbstractViewmodel(context: context, args: args),
      child: Consumer<Cat23AbstractViewmodel>(
          builder: (context, viewModel, child) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Cat2&3 unpaid Inspection',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                          viewModel.setSelectedMonthYear(result['month'] as String,
                              result['year'] as int, context);
                        }
                      },
                      child: Text(
                        viewModel.selectedMonthYear != null
                            ? '${viewModel.selectedMonthYear!['month'].toString().toUpperCase()}${viewModel.selectedMonthYear!['year']}'
                            : '${args['month']}${args['year']}',
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
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: ListView.builder(
                      itemCount: viewModel.inspectService.length,
                      itemBuilder: (context, index) {
                        final item = viewModel.inspectService[index];
                        return InkWell(
                          onTap: () {
                            print("item.areaCode: ${item.areaCode}");
                            var argument = {
                              'areaCode': item.areaCode,
                              'monthYear': viewModel.selectedMonthYear != null
                                  ? '${viewModel.selectedMonthYear!['month'].toString().toUpperCase()}${viewModel.selectedMonthYear!['year']}'
                                  : '${args['month']}${args['year']}',
                            };
                            Navigation.instance.navigateTo(
                                Routes.catConfirmList,
                                args: argument);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text('${item.areaCode} - ${item.areaName}'),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total: ${item.totalCount}',
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                  Text(
                                    'Verified: ${item.verifiedCount}',
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                  Text(
                                    'Pending: ${item.pendingCount}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      }
                  ),
                ));
          }),
    );
  }
}
