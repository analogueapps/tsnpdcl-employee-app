import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/pole_11kv_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class Pole11kvFeeder extends StatelessWidget {
  const Pole11kvFeeder({super.key, required this.args});

  static const id = Routes.pole11kvScreen;
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "Pole 11kv".toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
    //   body: ChangeNotifierProvider(
    // create: (_) => Pole11kvViewmodel(context: context, args: args),
    // child:
    // Consumer<Pole11kvViewmodel>(builder: (context, viewModel, child) {
    //   return  Column(
    //     children: [
    //       // Non-scrollable area
    //       Container(
    //         color: Colors.grey[200],
    //         height: 200,
    //         width: double.infinity,
    //         child: const Center(child: Text("Google maps here")),
    //       ),
    //       SwitchListTile(
    //         tileColor: Colors.grey[300],
    //         title: const Text('Follow Me'),
    //         value: viewModel.followSwitch,
    //         onChanged: (value) {
    //           viewModel.followMe = value;
    //         },
    //       ),
    //       // Scrollable area
    //       Expanded(
    //         child: Stack(
    //           children: [
    //             SingleChildScrollView(
    //               padding: const EdgeInsets.all(10),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //
    //                   ViewDetailedLcTileWidget(
    //                     tileKey: "SubStation",
    //                     tileValue: " ${args["ssc"]}",
    //                     valueColor: Colors.green,
    //                   ),
    //                   ViewDetailedLcTileWidget(
    //                     tileKey: "Feeder",
    //                     tileValue: " ${args["fc"]}",
    //                     valueColor: Colors.green,
    //                   ),
    //                   Row(
    //                     children: [
    //                       checkbox(
    //                           context,
    //                           "Source Pole Not Mapped",
    //                           viewModel.selectedPole,
    //                           viewModel.setSelectedPole,
    //                           true),
    //                       checkbox(
    //                           context,
    //                           "Origin Pole",
    //                           viewModel.selectedPole,
    //                           viewModel.setSelectedPole,
    //                           true),
    //                     ],
    //                   ),
    //                   const Text('Previous Pole Num.'),
    //                   Visibility(
    //                     visible: viewModel.selectedPole == null,
    //                     child: DropdownButton<String>(
    //                       isExpanded: true,
    //                       hint: const Text("Select an option"),
    //                       value: viewModel.poleFeederSelected,
    //                       items: viewModel.poleFeederList
    //                           .map((item) =>
    //                           DropdownMenuItem<String>(
    //                             value: item.poleNum,
    //                             child: Text(item.poleNum!),
    //                           ))
    //                           .toList(),
    //                       onChanged: (value) {
    //                         viewModel.onListPoleFeederChange(value);
    //                       },
    //                     ),
    //                   ),
    //                   const SizedBox(height: 10),
    //                   const Text("Tapping from previous pole"),
    //                   checkbox(
    //                     context,
    //                     "Straight Tapping",
    //                     viewModel.selectedPreviousPole,
    //                     viewModel.setSelectedPreviousPole,
    //                     viewModel.selectedPole != "Origin Pole",
    //                   ),
    //                   checkbox(
    //                     context,
    //                     "Left Tapping",
    //                     viewModel.selectedPreviousPole,
    //                     viewModel.setSelectedPreviousPole,
    //                     viewModel.selectedPole != "Origin Pole",
    //                   ),
    //                   checkbox(
    //                     context,
    //                     "Right Tapping",
    //                     viewModel.selectedPreviousPole,
    //                     viewModel.setSelectedPreviousPole,
    //                     viewModel.selectedPole != "Origin Pole",
    //                   ),
    //                   const Text("Pole Number"),
    //                   TextFormField(
    //                     maxLines: null,
    //                     minLines: 5,
    //                     controller: viewModel.poleNumber,
    //                     keyboardType: TextInputType.multiline,
    //                     decoration: const InputDecoration(
    //                       hintText: "Type here...",
    //                       border: OutlineInputBorder(),
    //                       alignLabelWithHint: true,
    //                     ),
    //                   ),
    //                   Text("Pole Type"),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           multipleCheckbox(
    //                             context,
    //                             "RS joist",
    //                             viewModel.selectedPoleTypes,
    //                                 () =>
    //                                 viewModel.toggleSelectedPoleType(
    //                                     "RS joist"),
    //                             viewModel.selectedPoleTypes.contains(
    //                                 "RS joist") ||
    //                                 viewModel.selectedPoleTypes.length < 2,
    //                           ),
    //                           multipleCheckbox(
    //                             context,
    //                             "PSSC Pole",
    //                             viewModel.selectedPoleTypes,
    //                                 () =>
    //                                 viewModel.toggleSelectedPoleType(
    //                                     "PSSC Pole"),
    //                             viewModel.selectedPoleTypes.contains(
    //                                 "PSSC Pole") ||
    //                                 viewModel.selectedPoleTypes.length < 2,
    //                           ),
    //                           multipleCheckbox(
    //                             context,
    //                             "Tower",
    //                             viewModel.selectedPoleTypes,
    //                                 () =>
    //                                 viewModel.toggleSelectedPoleType("Tower"),
    //                             viewModel.selectedPoleTypes.contains("Tower") ||
    //                                 viewModel.selectedPoleTypes.length < 2,
    //                           ),
    //                         ],
    //                       ),
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           multipleCheckbox(
    //                             context,
    //                             "Joist",
    //                             viewModel.selectedPoleTypes,
    //                                 () =>
    //                                 viewModel.toggleSelectedPoleType("Joist"),
    //                             viewModel.selectedPoleTypes.contains("Joist") ||
    //                                 viewModel.selectedPoleTypes.length < 2,
    //                           ),
    //                           multipleCheckbox(
    //                             context,
    //                             "Rail Pole",
    //                             viewModel.selectedPoleTypes,
    //                                 () =>
    //                                 viewModel.toggleSelectedPoleType(
    //                                     "Rail Pole"),
    //                             viewModel.selectedPoleTypes.length < 2 ||
    //                                 viewModel.selectedPoleTypes.contains(
    //                                     "Rail Pole"),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                   const Text("Pole Height"),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: viewModel.poleHeightData.map((height) {
    //                       return RadioListTile<String>(
    //                         title: Text(height),
    //                         value: height,
    //                         groupValue: viewModel.selectedPoleHeight,
    //                         onChanged: (value) {
    //                           viewModel.setSelectedPoleHeight(value!);
    //                         },
    //                       );
    //                     }).toList(),
    //                   ),
    //                   const Text("No.of Circuits on pole"),
    //                   Column(children: [
    //                     checkbox(
    //                       context,
    //                       "1 Circuit",
    //                       viewModel.selectedPreviousPole,
    //                       viewModel.setSelectedPreviousPole,
    //                       viewModel.selectedPole != "Origin Pole",
    //                     ),
    //                     checkbox(
    //                       context,
    //                       "2 Circuits",
    //                       viewModel.selectedPreviousPole,
    //                       viewModel.setSelectedPreviousPole,
    //                       viewModel.selectedPole != "Origin Pole",
    //                     ), checkbox(
    //                       context,
    //                       "3 Circuits",
    //                       viewModel.selectedPreviousPole,
    //                       viewModel.setSelectedPreviousPole,
    //                       viewModel.selectedPole != "Origin Pole",
    //                     ),
    //                     checkbox(
    //                       context,
    //                       "4 Circuits",
    //                       viewModel.selectedPreviousPole,
    //                       viewModel.setSelectedPreviousPole,
    //                       viewModel.selectedPole != "Origin Pole",
    //                     ),
    //                   ],),
    //
    //                   Text("Formation"),
    //                   Column(
    //                     children: [
    //                       checkbox(
    //                         context,
    //                         "Horizontal",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ),
    //                       checkbox(
    //                         context,
    //                         "Triangular",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ), checkbox(
    //                         context,
    //                         "Vertical",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ),
    //                     ],
    //                   ),
    //
    //                   const Text("Type of point"),
    //                   Column(
    //                     children: [
    //                       checkbox(
    //                         context,
    //                         "Cut Point",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ),
    //                       checkbox(
    //                         context,
    //                         "Pin Point",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ), checkbox(
    //                         context,
    //                         "End Point",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ),
    //                     ],
    //                   ),
    //
    //                   const Text("Any Crossing?"),
    //                   Column(
    //                     children: [
    //                       Row(children: [
    //                         checkbox(
    //                           context,
    //                           "None",
    //                           viewModel.selectedPreviousPole,
    //                           viewModel.setSelectedPreviousPole,
    //                           viewModel.selectedPole != "Origin Pole",
    //                         ),
    //                         checkbox(
    //                           context,
    //                           "33KV Line",
    //                           viewModel.selectedPreviousPole,
    //                           viewModel.setSelectedPreviousPole,
    //                           viewModel.selectedPole != "Origin Pole",
    //                         ),
    //                         checkbox(
    //                           context,
    //                           "11kv Line",
    //                           viewModel.selectedPreviousPole,
    //                           viewModel.setSelectedPreviousPole,
    //                           viewModel.selectedPole != "Origin Pole",
    //                         ),
    //                       ],),
    //                       checkbox(
    //                         context,
    //                         "LT Line",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ),
    //                       checkbox(
    //                         context,
    //                         "Railway crossing",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ),
    //                       checkbox(
    //                         context,
    //                         "Transmission Lines",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ), checkbox(
    //                         context,
    //                         "Road Crossing",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ), checkbox(
    //                         context,
    //                         "Building Crossing",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ), checkbox(
    //                         context,
    //                         "Other Common Lines",
    //                         viewModel.selectedPreviousPole,
    //                         viewModel.setSelectedPreviousPole,
    //                         viewModel.selectedPole != "Origin Pole",
    //                       ),
    //                     ],
    //                   ),
    //                   Row(
    //                     children: [
    //                       checkbox(
    //                           context,
    //                           "No Load",
    //                           viewModel.selectedPole,
    //                           viewModel.setSelectedPole,
    //                           true),
    //                       checkbox(
    //                           context,
    //                           "DTR",
    //                           viewModel.selectedPole,
    //                           viewModel.setSelectedPole,
    //                           true),
    //                     ],
    //                   ),
    //
    //
    //                   // Text(
    //                   //   "Location Accuracy : ${location.accuracy.toStringAsFixed(1)} mts / $MINIMUM_GPS_ACCURACY_REQUIRED mts",
    //                   // )
    //
    //                   Text("Lat: ${viewModel.latitude}"),
    //                   Text("Lon: ${viewModel.longitude}"),
    //                   // viewModel.selectedPole==""? const Text("Please selct source to get distance"): Text("Distance from Previous pole to your locations is %s mtrs ${distance calculate here }")
    //                 ],
    //               ),
    //             ),
    //             if (viewModel.isLoading)
    //               Positioned.fill(
    //                 child: Container(
    //                   color: Colors.black.withOpacity(0.2),
    //                   child: const Center(
    //                     child: CircularProgressIndicator(),
    //                   ),
    //                 ),
    //               ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   );
    // }
    // ),
    // ),
    );
    }
  }
  Widget checkbox(BuildContext context, String title, String? selected,
      void Function(String) selectedFunction, bool enabled) {
    return Consumer<Pole11kvViewmodel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: selected == title,
              onChanged: enabled
                  ? (bool? newValue) {
                      if (newValue == true) {
                        selectedFunction(title);
                      }
                    }
                  : null,
            ),
            Text(
              title,
              style:
                  TextStyle(fontSize: 12, color: enabled ? null : Colors.grey),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        );
      },
    );
  }

  Widget multipleCheckbox(
      BuildContext context,
      String label,
      List<String> selectedList,
      VoidCallback onChanged,
      bool isEnabled,
      ) {
    return CheckboxListTile(
      title: Text(label),
      value: selectedList.contains(label),
      onChanged: isEnabled ? (_) => onChanged() : null,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

