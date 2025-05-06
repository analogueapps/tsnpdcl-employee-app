import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dlist/viewmodel/dlist_menu_viewmodel.dart';

class DlistMenuScreen extends StatelessWidget {
  static const id = Routes.dlistMenuScreen;
  const DlistMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DlistMenuViewmodel(context: context),
      child: Consumer<DlistMenuViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: CommonColors.colorPrimary,
                title: Text(
                  "Sections".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: toolbarTitleSize,
                      fontWeight: FontWeight.w700),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      viewModel.monthYearClicked();
                    },
                    child: Text(
                      viewModel.currentMonthYear.toUpperCase(),
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
                  : viewModel.dlistMetaData.isEmpty
                  ? const Center(child: Text("No Data found for selected month"))
                  : ListView.builder(
                  itemCount: viewModel.dlistMetaData.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.dlistMetaData[index];

                    return GestureDetector(
                      onTap: () {
                        Navigation.instance.navigateTo(Routes.rangeWiseDlistScreen, args: jsonEncode(item));
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: doubleTen,),
                          Row(
                            children: [
                              const SizedBox(width: doubleFive,),
                              Expanded(
                                child: Text(
                                  "${checkNull(item.ofcName)}(${checkNull(item.ofcCode)})${checkNull(item.monthYear)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                    normalSize,
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded, size: 14,),
                              const SizedBox(width: doubleFive,),
                            ],
                          ),
                          const SizedBox(height: doubleTen,),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 1,
                          ),
                        ],
                      ),
                    );
                  }
              )
          );
        },
      ),
    );
  }
}
