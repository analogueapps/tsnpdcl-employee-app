import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/suppressed_units/viewmodel/suppressed_all_abstract_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';

class SuppressedAllAbstracts extends StatelessWidget {
  static const id = Routes.suppressedAllMon;
  const SuppressedAllAbstracts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Suppressed Units Insp',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700),
              ),
              Text("All Months abstract",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: normalSize,
                    fontWeight: FontWeight.w400),),
            ],
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back))),
      body: ChangeNotifierProvider(
          create: (_) => SuppressedAllAbstractViewmodel(context: context),
          child: Consumer<SuppressedAllAbstractViewmodel>(
              builder: (context, viewModel, child) {
                return Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    children: [
                      // TextField(
                      //   controller: viewModel.searchController,
                      //   decoration: const InputDecoration(
                      //       hintText: 'Find...',
                      //       prefixIcon: Icon(Icons.search_outlined)
                      //   ),
                      // ),
                      // SizedBox(height: 11,),
                      Expanded(
                        child: viewModel.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                            itemCount: viewModel.rmdServiceData.length,
                            itemBuilder: (context, index) {
                              final item = viewModel.rmdServiceData[index];
                              return InkWell(
                                onTap: ()async {
                                  // Navigation.instance.navigateTo(
                                  //   Routes.inspectServices,
                                  // );
                                  final result = await await Navigator.push(
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text('${item.areaCode} - ${item.areaName}'),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total: ${item.totalCount}',
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                        Text(
                                          'Verified: ${item.verifiedCount}',
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                        Text(
                                          'Pending: ${item.pendingCount}',
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
