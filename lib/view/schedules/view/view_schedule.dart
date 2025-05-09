import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/schedules/viewmodel/view_schedule_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewSchedule extends StatelessWidget {
  static const id = Routes.viewSchedule;
  const ViewSchedule({super.key, required this.dt, required this.type});
  final DateTime dt;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Column(
            children: [
              Text(
                "OVER LOAD DTRs LIST",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Showing I(N)>20Amps",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700),
              ),
            ]
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ViewScheduleViewmodel(context: context, selectedDate: dt, type: type),
        child: Consumer<ViewScheduleViewmodel>(
            builder: (context, viewModel, child) {
              return  Stack(
                  children: [
                    ListView.builder(
                        itemCount: viewModel.scheduleItems.length,
                        itemBuilder: (context, index) {
                          final data = viewModel.scheduleItems[index];
                          return data == null
                              ?
                          const Center(child: Text("No data found")) :

                          GestureDetector(
                            onTap: () {
                              // Navigation.instance.navigateTo(Routes.viewDetailedTongTesterReadings,args: data,);
                              // print("passing data: $data");
                            },
                            child:
                            Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                // Optional: to give rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(
                                        0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                "${data.tourId.toString()}${data.scheduledDate}",
                                                style: const TextStyle(
                                                  color: CommonColors.deepBlue,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            ViewDetailedLcTileWidget(
                                                tileKey: "",
                                                tileValue: data.itemName),

                                            ViewDetailedLcTileWidget(
                                                tileKey: "SEC",
                                                tileValue: data.section),

                                            ViewDetailedLcTileWidget(
                                                tileKey: "STATUS",
                                                tileValue:data.status),
                                          ],
                                        ),
                                      ),
                                      // IconButton with no space between it and the text
                                      IconButton(
                                        onPressed: () {
                                          // Add your navigation logic here
                                          // Navigation.instance
                                          //     .navigateTo(Routes.viewDetailedTongTesterReadings, args: data,);
                                          // print("icon on tap: $data");
                                        },
                                        icon:
                                        const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                                        padding:
                                        EdgeInsets.zero, // Ensures there is no extra padding
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                    if (viewModel.isLoading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.0), // Semi-transparent overlay
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                  ]
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CommonColors.colorPrimary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () {
          Navigation.instance.navigateTo(Routes.tongTesterReadingsScreen);
        },
        child:  Image.asset(Assets.tongTesterReadings,height: 30,),
      ),
    );

  }
}
