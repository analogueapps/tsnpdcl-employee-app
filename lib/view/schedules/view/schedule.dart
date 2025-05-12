import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/schedules/models/ss_and_line_count_model.dart';
import 'package:tsnpdcl_employee/view/schedules/viewmodel/schedules_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';


class SchedulesScreen extends StatelessWidget {
  static const id = Routes.schedule;
  const SchedulesScreen({super.key});

  final List<ScheduleData> scheduleDataList = const [
    ScheduleData(dayNumber: '01', dayName: 'SAT', substations: '0', lines: '0', dtr: '0'),
  ];

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (_)=>ScheduleViewModel(context: context),
      child:Consumer<ScheduleViewModel>(
          builder: (context,viewModel,child){
            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: AppBar(
                title: const Text('Schedules', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),),
                backgroundColor:CommonColors.colorPrimary,
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
                  ? Center(child: CircularProgressIndicator(),)
                  : ListView.builder(
                itemCount: 31,
                itemBuilder: (context, index) {
                  // Convert index to 'day' string
                  String currentDay = (index + 1).toString().padLeft(2, '0');
                  String monthYear = viewModel.selectedMonthYear != null
                      ? '${viewModel.getMonthNumeric(viewModel.selectedMonthYear)}/${viewModel.selectedMonthYear?['year']}'
                      : DateFormat('MM/yyyy').format(DateTime.now());

                  // Default scheduleData (if not found)
                  ScheduleData scheduleData = ScheduleData(
                    dayNumber: currentDay,
                    dayName: viewModel.getWeekday('$currentDay/$monthYear'),
                    substations: '0',
                    lines: '0',
                    dtr: '0',
                  );

                  // Check if today's data exists in fetchedData
                  int dataIndex = viewModel.allDays.indexOf(currentDay);
                  if (dataIndex != -1) {
                    final dataModel = viewModel.fetchedData[dataIndex];
                    scheduleData = ScheduleData(
                      dayNumber: currentDay,
                      dayName: viewModel.getWeekday(dataModel.date),
                      substations: (dataModel.ss ?? 0).toString(),
                      lines: (dataModel.line ?? 0).toString(),
                      dtr: (dataModel.dtr ?? 0).toString(),
                      highlightLines: (int.tryParse(dataModel.line) ?? 0) != 0,
                      highlightDtr: (int.tryParse(dataModel.dtr) ?? 0) != 0,
                      highlightSs: (int.tryParse(dataModel.ss) ?? 0) != 0,
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: const Border(
                                top: BorderSide(color: Colors.grey),
                                right: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  scheduleData.dayNumber,
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  scheduleData.dayName,
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        // SUBSTATIONS
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: scheduleData.highlightSs ? Colors.yellow.shade100 : Colors.white,
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'SUBSTATIONS',
                                    style: TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    scheduleData.substations,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              String dmy="$currentDay/$monthYear";
                              Navigation.instance.navigateTo(
                                Routes.viewSchedule,
                                args: {"dt": dmy, "type": "SS"},
                              );
                              print("Done date:$currentDay/$monthYear");
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        // LINES
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5),
                                color: scheduleData.highlightLines ? Colors.yellow.shade100 : Colors.white,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'LINES',
                                    style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    scheduleData.lines,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                              onTap: () {
                                String dmy="$currentDay/$monthYear";
                                Navigation.instance.navigateTo(
                                  Routes.viewSchedule,
                                  args: {"dt":dmy , "type": "LINE"},
                                );
                                print("Done date:$currentDay/$monthYear");
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        // DTR
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5),
                                color: scheduleData.highlightDtr ? Colors.yellow.shade100 : Colors.white,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'DTR',
                                    style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    scheduleData.dtr,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              String dmy="$currentDay/$monthYear";
                              Navigation.instance.navigateTo(
                                Routes.viewSchedule,
                                args: {"dt":dmy, "type": "DTR"},
                              );
                              print("Done date:$currentDay/$monthYear");
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                    viewModel.showChooseOptionPopUp(context);
                },
                backgroundColor: Colors.pinkAccent,
                child: const Icon(Icons.add,color: Colors.white,),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            );
          }
      ),
    );
  }
}