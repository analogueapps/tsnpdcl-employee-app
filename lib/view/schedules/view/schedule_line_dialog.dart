import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/schedules/viewmodel/schedule_line_viewmodel.dart';

Widget buildRow(String label, Widget child) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child:
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      Container(width: 1, height: 30, color: Colors.grey.shade400),
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: child,
        ),
      ),
    ],
  );
}

Widget checkBoxData(String? data, bool isSelected, Function(bool?) onChanged) {
  return Column(
    children: [
      Row(
        children: [
          Checkbox(value: isSelected, onChanged: onChanged),
          const SizedBox(width: 10),
          Text(data ?? ""),
        ],
      ),
      const Divider(color: Colors.grey, thickness: 1),
    ],
  );
}

void showScheduleLineMaintencePopUp(
    BuildContext context, Map<String, dynamic>? my) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
            create: (_) =>
                ScheduleLineViewmodel(context: context, monthYear: my),
            child: Consumer<ScheduleLineViewmodel>(
                builder: (context, viewModel, child) {
              return WillPopScope(
                  // onWillPop: () async {
                  //   return viewModel.isLocationGranted;
                  // },
                  onWillPop: null,
                  child: StatefulBuilder(builder: (context, setState) {
                    return viewModel.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Form(
                            key: viewModel.formKey,
                            child: AlertDialog(
                              titlePadding: EdgeInsets.zero,
                              title: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                                child: Container(
                                  color: CommonColors.colorPrimary,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.0),
                                    child: Center(
                                        child: Text(
                                      'SCHEDULE 11KV LINE MAINTENANCE',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                                  ),
                                ),
                              ),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildRow(
                                          "Select SS",
                                          DropdownButton<String>(
                                            value: viewModel.selectedSS,
                                            isExpanded: true,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize:
                                                  14, // 👈 Set your desired font size here
                                            ),
                                            items: viewModel.ssOptions
                                                .map((ssName) {
                                              return DropdownMenuItem<String>(
                                                value: ssName,
                                                child: Text(
                                                  ssName,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              viewModel.selectedSS = newValue!;
                                              viewModel.notifyListeners();
                                            },
                                          )),
                                      Divider(
                                          color: Colors.grey.shade400,
                                          thickness: 1),
                                      buildRow(
                                          "SS Code",
                                          Text(viewModel.ssCode,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.redAccent))),
                                      Divider(
                                          color: Colors.grey.shade400,
                                          thickness: 1),
                                      buildRow(
                                          "SS Name",
                                          Text(viewModel.ssName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent))),
                                      Divider(
                                          color: Colors.grey.shade400,
                                          thickness: 1),
                                      buildRow(
                                          "Section",
                                          Text(viewModel.section,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent))),
                                      Divider(
                                        color: Colors.grey.shade400,
                                        thickness: 1,
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      const Text(
                                        'CHOOSE 11KV FEEDERS',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Column(
                                        children: viewModel.feederList.isEmpty
                                            ? [
                                                const Center(
                                                    child:
                                                        Text("No data found"))
                                              ]
                                            : viewModel.feederList
                                                .map((report) {
                                                final feederCode =
                                                    report.optionId ?? "";
                                                final feederName =
                                                    report.optionName ?? "";

                                                final isSelected = viewModel
                                                    .selectedFeeders
                                                    .any(
                                                  (item) =>
                                                      item["feederCode"] ==
                                                      feederCode,
                                                );

                                                return checkBoxData(
                                                  feederName,
                                                  isSelected,
                                                  (bool? newValue) {
                                                    setState(() {
                                                      if (newValue == true) {
                                                        viewModel
                                                            .selectedFeeders
                                                            .add({
                                                          "feederCode":
                                                              feederCode,
                                                          "feederName":
                                                              feederName,
                                                        });
                                                      } else {
                                                        viewModel
                                                            .selectedFeeders
                                                            .removeWhere(
                                                          (item) =>
                                                              item[
                                                                  "feederCode"] ==
                                                              feederCode,
                                                        );
                                                      }
                                                    });
                                                  },
                                                );
                                              }).toList(),
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      const Text(
                                        'Select Schedule Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              final DateTime today =
                                                  DateTime.now();
                                              final DateTime maxDate =
                                                  today.add(const Duration(
                                                      days:
                                                          30)); // 30 days from today

                                              final DateTime? picked =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: today,
                                                lastDate: maxDate,
                                              );

                                              if (picked != null &&
                                                  picked !=
                                                      viewModel.selectedDate) {
                                                setState(() {
                                                  viewModel.selectedDate =
                                                      picked;
                                                });
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(Icons
                                                    .calendar_month_outlined),
                                                const SizedBox(
                                                  width: doubleTen,
                                                ),
                                                Text(
                                                  viewModel.selectedDate != null
                                                      ? DateFormat('dd/MM/yyyy')
                                                          .format(viewModel
                                                              .selectedDate!)
                                                      : "CHOOSE DATE",
                                                  style: const TextStyle(
                                                    color: CommonColors
                                                        .colorPrimary,
                                                    fontSize: normalSize,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey[100],
                                                  foregroundColor: Colors.black,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('CANCEL')),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.black,
                                                ),
                                                onPressed: () {
                                                  viewModel.submitForm(context);
                                                },
                                                child: const Text('OK')),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  }));
            }));
      });
}
