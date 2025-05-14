import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/ccc/viewModel/ccc_dashboard_viewmodel.dart';

class CCCDashboardScreen extends StatelessWidget {
  static const id = Routes.cccDashboard;

  const CCCDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            "CCC Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: ChangeNotifierProvider(
            create: (_) => CccDashboardViewmodel(context: context),
            child: Consumer<CccDashboardViewmodel>(
                builder: (context, viewModel, child) {
              return Stack(children: [
                ListView.builder(
                    itemCount: viewModel.itemsCount.length,
                    itemBuilder: (context, index) {
                      final data = viewModel.itemsCount[index];
                      return data == null
                          ? const Center(child: Text("No data found"))
                          :Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigation.instance.navigateTo(
                                Routes.cccORICB,
                                args: {"status": "1", "name": "Open"},
                              );
                            },
                            child: card(Colors.red, "Open", data.open.toString()),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigation.instance.navigateTo(
                                Routes.cccORICB,
                                args: {"status": "4", "name": "Reopen"},
                              );
                            },
                            child: card(Colors.yellow, "Reopen", data.reOpen.toString()),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigation.instance.navigateTo(
                                Routes.cccORICB,
                                args: {"status": "3", "name": "InProgress"},
                              );
                            },
                            child: card(Colors.deepOrangeAccent, "In Progress", data.inProgress.toString()),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigation.instance.navigateTo(
                                Routes.cccORICB,
                                args: {"status": "5", "name": "Closed"},
                              );
                            },
                            child: card(Colors.green, "Closed", data.resolved.toString()),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigation.instance.navigateTo(
                                Routes.cccORICB,
                                args: {"status": "-1", "name": "Beyond Resolution Time"},
                              );
                            },
                            child: card(Colors.red, "BRT", "-"),
                          ),
                        ],
                      );
                    }),
                if (viewModel.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.0),
                      // Semi-transparent overlay
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ]);
            })));
  }

  Widget card(Color value, String text, String count) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // Optional: to give rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 10),
        child: Row(children: [
          Container(
            color: value,
            width: 5,
            height: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              text,
              style: const TextStyle(fontSize: doubleTwenty),
            ),
            Text(
              count,
              style: const TextStyle(
                  fontSize: doubleEighteen, color: Colors.blueAccent),
            )
          ]),
        ]),
        );
  }
}

