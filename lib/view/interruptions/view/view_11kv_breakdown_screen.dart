import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/view_11kv_breakdown_viewmodel.dart';

class View11kvBreakdownScreen extends StatelessWidget {
  static const id = Routes.view11kvBreakdownScreen;
  const View11kvBreakdownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => View11kvBreakdownViewmodel(context: context),
      child: Consumer<View11kvBreakdownViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.viewBreakdowns.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: viewModel.breakdownList.isEmpty
                      ? Center(
                    child: Text(
                      "It's empty here",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: viewModel.breakdownList.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.breakdownList[index];
                      return InkWell(
                        onTap: () {
                          Navigation.instance.navigateTo(
                            Routes.detailedView11kvBreakdownScreen,
                            args: item, // Pass the entire 'item' map
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['ssCode'] ?? 'NULL',
                                    style: const TextStyle(
                                        fontSize: 16),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    // Button inside won't interfere
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      item['status'] == "OPEN"
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                    child: Text(
                                      item['status'],
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Text(item['feederCode'] ?? 'NULL'),
                              const SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  style:
                                  DefaultTextStyle.of(context)
                                      .style,
                                  children: [
                                    const TextSpan(
                                        text: "Breakdown Date: "),
                                    TextSpan(
                                      text:
                                      "${item['startDate'] ?? ''}, ${item['startTime'] ?? ''}",
                                      style: const TextStyle(
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
