import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/add_induction_point_viewmodel.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/pole_tracker_selection_view_sketch_viewmodel.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/view_digital_sketch_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class ViewDigitalSketchScreen extends StatelessWidget {
  static const id = Routes.viewDigitalSketchScreen;
  final Map<String, dynamic> args;

  const ViewDigitalSketchScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ViewDigitalSketchViewModel(context: context, args: args),
        child: Consumer<ViewDigitalSketchViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: CommonColors.colorPrimary,
                title: Text(
                  "View digital sketch".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      //fontSize: toolbarTitleSize,
                      fontWeight: FontWeight.w700
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                actions: [
                  Visibility(
                    visible: viewModel.digitalFeederEntityList.isNotEmpty,
                    child: Row(
                      children: [
                        Checkbox(
                          value: viewModel.showPoles,
                          onChanged: (bool? value) {
                            // setState(() {
                            //   isChecked = value ?? false;
                            // });
                            viewModel.showAndHidePole(value);
                          },
                          checkColor: Colors.white,
                          activeColor: Colors.blue,
                        ),
                        const Text(
                          "Show Poles",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(doubleTen),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.3), // Equivalent to layout_weight="0.3"
                        1: FlexColumnWidth(0.7), // Equivalent to layout_weight="0.7"
                      },
                      children: [
                        TableRow(
                          children: [
                            const Text(
                              "SubStation",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: doubleFive, bottom: doubleFive),
                              child: Text(
                                "${args['ssn']}(${args['ssc']})",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Feeder",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: doubleFive, bottom: doubleFive),
                              child: Text(
                                "${args['fn']}(${args['fc']})",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: viewModel.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : GoogleMap(
                      initialCameraPosition: viewModel.cameraPosition ?? const CameraPosition(target: LatLng(0, 0), zoom: 10),
                      polylines: viewModel.polylines,
                      markers: viewModel.markers,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: true,
                      onMapCreated: (controller) {
                        viewModel.mapController = controller;
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
    );
  }


}
