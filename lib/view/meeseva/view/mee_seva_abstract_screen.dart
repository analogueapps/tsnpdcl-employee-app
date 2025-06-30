import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/meeseva/viewmodel/mee_seva_abstract_viewmodel.dart';

class MeeSevaAbstractScreen extends StatelessWidget {
  static const id = Routes.meeSevaAbstractScreen;
  final Map<String, dynamic> data;

  const MeeSevaAbstractScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeeSevaAbstractViewmodel(context: context, data: data),
      child: Consumer<MeeSevaAbstractViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                data['above'] != "0"
                    ? "LM wise above ${data['above']} days abstract"
                        .toUpperCase()
                    : "Linemen wise Abstract".toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    viewModel.getData();
                  },
                ),
              ],
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.daysPendingMeesevaAbstract == null
                    ? const Center(
                        child: Text("No data founded."),
                      )
                    : ListView.builder(
                        itemCount: viewModel.list.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.list[index];

                          Map<String, dynamic> insideJsonObjects = {};
                          if (viewModel.jsonObjects.containsKey(item)) {
                            insideJsonObjects = viewModel.jsonObjects[item];
                          }
                          //print(insideJsonObjects);
                          String targetKey = '';
                          String name = '';
                          int count = 0;
                          String status = '';

                          // insideJsonObjects.forEach((key, value) {
                          //   if (key != "statusCount") {
                          //     targetKey = key;
                          //   }
                          // });
                          // //print(targetKey);
                          // // Loop through all the keys in the status object to find name and count
                          // insideJsonObjects.forEach((statusKey, statusValue) {
                          //   if (statusValue is Map && statusValue.containsKey('name') && statusValue.containsKey('count')) {
                          //     // If the statusValue has both 'name' and 'count', extract them
                          //     name = statusValue['name'];
                          //     count = statusValue['count'];
                          //     status = statusValue['status'];
                          //   }
                          // });

                          List<Map<String, dynamic>> entries = [];

                          insideJsonObjects.forEach((key, value) {
                            if (key != "statusCount" &&
                                value is Map &&
                                value.containsKey('name') &&
                                value.containsKey('count')) {
                              entries.add({
                                'name': value['name'],
                                'count': value['count'],
                                'status': value['status'],
                                'empId': key,
                              });
                            }
                          });

                          return Column(
                            children: [
                              // Section Header
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                color: const Color(0xFFEEEEEE),
                                child: SizedBox(
                                  height: doubleForty,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Text(
                                          viewModel.shortCuts.containsKey(item)
                                              ? viewModel.shortCuts[item]!
                                              : "NA",
                                          style: const TextStyle(
                                              fontSize: normalSize,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          viewModel.jsonObjects
                                                  .containsKey(item)
                                              ? viewModel.jsonObjects[item]
                                                      ['statusCount']
                                                  .toString()
                                              : "0",
                                          style: const TextStyle(
                                              fontSize: normalSize,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // List of items
                              ...entries.map((entry) {
                                return Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: doubleThirty,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Text(
                                            entry['name'],
                                            style: const TextStyle(
                                                fontSize: normalSize,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              String status = entry['status'];
                                              String empId = entry['empId'];
                                              String name = entry['name'];

                                              if (viewModel
                                                          .shortCutsToActualStatusCode[
                                                      status] ==
                                                  null) return;

                                              var argument = {
                                                "s": viewModel
                                                        .shortCutsToActualStatusCode[
                                                    status],
                                                "ncflag": "M",
                                                "lmEmp": empId,
                                                "filterLm": "filterLm",
                                                "name": name,
                                              };

                                              if (data['sc'] != null) {
                                                argument['sc'] = data['sc'];
                                              }

                                              if (viewModel.isLmAbstract &&
                                                  name ==
                                                      viewModel
                                                          .user![0].empId) {
                                                Navigation.instance.navigateTo(
                                                    Routes
                                                        .servicesAppListScreen,
                                                    args: argument);
                                              } else if (!viewModel
                                                  .isLmAbstract) {
                                                Navigation.instance.navigateTo(
                                                    Routes
                                                        .servicesAppListScreen,
                                                    args: argument);
                                              } else {
                                                AlertUtils.showSnackBar(
                                                    context,
                                                    "Operation not allowed! You can only view your applications",
                                                    isTrue);
                                              }
                                            },
                                            child: Text(
                                              entry['count'].toString(),
                                              style: const TextStyle(
                                                  fontSize: normalSize,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),

                              Divider(color: Colors.grey[200], thickness: 1.0),
                            ],
                          );
                        }),
          );
        },
      ),
    );
  }
}
