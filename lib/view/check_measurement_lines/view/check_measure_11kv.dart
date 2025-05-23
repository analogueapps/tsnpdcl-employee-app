import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/check_11KV_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class CheckMeasure11kv extends StatelessWidget {
  const CheckMeasure11kv({super.key, required this.args});
  static const id = Routes.check11kvScreen;
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "Check 11kv".toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => Check11kvViewmodel(context: context, args: args),
        child: Consumer<Check11kvViewmodel>(
          builder: (context, viewModel, child) {
            return Form(key:viewModel.formKey,
              child:   Stack(children: [
                Column(
                  children: [
                    // Fixed map
                    Container(
                      color: Colors.grey[200],
                      height: 200,
                      width: double.infinity,
                      child: const Center(child: Text("Google maps here")),
                    ),

                    // Fixed switch
                    SwitchListTile(
                      tileColor: Colors.grey[300],
                      title: const Text('Follow Me'),
                      value: viewModel.followSwitch,
                      onChanged: (value) {
                        viewModel.followMe = value;
                      },
                    ),

                    // Scrollable area
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ViewDetailedLcTileWidget(
                              tileKey: "SubStation",
                              tileValue: " ${args["ssc"]}",
                              valueColor: Colors.green,
                            ),
                            ViewDetailedLcTileWidget(
                              tileKey: "Feeder",
                              tileValue: " ${args["fc"]}",
                              valueColor: Colors.green,
                            ),


                             Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Previous Pole Num.'),
                                    DropdownButton<PoleFeederEntity>(
                                      isExpanded: true,
                                      hint: const Text("Select an option"),
                                      value: viewModel.selectedPoleFeeder,
                                      items: viewModel.poleFeederList
                                          .map((item) {
                                        final displayText = item.tempSeries != null && item.tempSeries!.isNotEmpty
                                            ? '${item.tempSeries}-${item.poleNum}'
                                            : item.poleNum ?? '';
                                        return DropdownMenuItem<PoleFeederEntity>(
                                          value: item,
                                          child: Text(displayText),
                                        );
                                      })
                                          .toList(),
                                      onChanged: (value) {
                                        viewModel.onListPoleFeederChange(value);
                                      },
                                    ),
                                  ]),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Tapping from previous pole"),

                            checkbox(
                              context,
                              "Straight Tapping",
                              viewModel.selectedTappingPole,
                              viewModel.setSelectedTappingPole,
                            ),
                            checkbox(
                              context,
                              "Left Tapping",
                              viewModel.selectedTappingPole,
                              viewModel.setSelectedTappingPole,
                            ),
                            checkbox(
                              context,
                              "Right Tapping",
                              viewModel.selectedTappingPole,
                              viewModel.setSelectedTappingPole,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(" Generated Pole Num"),
                            // TextFormField(
                            //   controller: viewModel.poleNumber,
                            //   keyboardType: TextInputType.multiline,
                            //   decoration: const InputDecoration(
                            //     border: OutlineInputBorder(),
                            //     alignLabelWithHint: true,
                            //   ),
                            // ),
                            const SizedBox(height: doubleTen,),
                            const Text("Pole Type"),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      checkbox(
                                        context,
                                        "Spun Pole",
                                        viewModel.selectedFirstGroup.contains("RS joist") ? "RS joist" : null,
                                            (val) => viewModel.toggleFirstGroup(val),
                                      ),
                                      checkbox(
                                        context,
                                        "RS joist",
                                        viewModel.selectedFirstGroup.contains("RS joist") ? "RS joist" : null,
                                            (val) => viewModel.toggleFirstGroup(val),
                                      ),
                                      checkbox(
                                        context,
                                        "PSSC Pole",
                                        viewModel.selectedFirstGroup
                                            .contains("PSSC Pole")
                                            ? "PSSC Pole"
                                            : null,
                                            (val) => viewModel.toggleFirstGroup(val),
                                      ),
                                      checkbox(
                                        context,
                                        "Tower(M+3)",
                                        viewModel.selectedFirstGroup
                                            .contains("Tower")
                                            ? "Tower"
                                            : null,
                                            (val) => viewModel.toggleFirstGroup(val),
                                      ),
                                      checkbox(
                                        context,
                                        "Tower(M+9)",
                                        viewModel.selectedFirstGroup.contains("RS joist") ? "RS joist" : null,
                                            (val) => viewModel.toggleFirstGroup(val),
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      checkbox(
                                        context,
                                        "Tubular",
                                        viewModel.selectedFirstGroup.contains("RS joist") ? "RS joist" : null,
                                            (val) => viewModel.toggleFirstGroup(val),
                                      ),
                                      checkbox(
                                        context,
                                        "Joist",
                                        viewModel.selectedSecondGroup
                                            .contains("Joist")
                                            ? "Joist"
                                            : null,
                                            (val) => viewModel.toggleSecondGroup(val),
                                      ),
                                      checkbox(
                                        context,
                                        "Rail Pole",
                                        viewModel.selectedSecondGroup
                                            .contains("Rail Pole")
                                            ? "Rail Pole"
                                            : null,
                                            (val) => viewModel.toggleSecondGroup(val),
                                      ),
                                      checkbox(
                                        context,
                                        "Tower(M+6)",
                                        viewModel.selectedFirstGroup.contains("RS joist") ? "RS joist" : null,
                                            (val) => viewModel.toggleFirstGroup(val),
                                      ),
                                      checkbox(
                                        context,
                                        "Tower(M+12)",
                                        viewModel.selectedFirstGroup.contains("RS joist") ? "RS joist" : null,
                                            (val) => viewModel.toggleFirstGroup(val),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Text("Pole Height"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: viewModel.poleHeightData.map((height) {
                                return CheckboxListTile(
                                  controlAffinity:
                                  ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(height,
                                      style: const TextStyle(fontSize: 12)),
                                  value: viewModel.selectedPoleHeight == height,
                                  onChanged: (_) =>
                                      viewModel.setSelectedPoleHeight(height),
                                );
                              }).toList(),
                            ),
                            const Text("No.of Circuits on pole"),
                            Column(
                              children: [
                                checkbox(
                                    context,
                                    "1 Circuit",
                                    viewModel.selectedCircuits,
                                    viewModel.setSelectedCircuits,
                                ),
                                checkbox(
                                    context,
                                    "2 Circuits",
                                    viewModel.selectedCircuits,
                                    viewModel.setSelectedCircuits,
                                ),
                                checkbox(
                                    context,
                                    "3 Circuits",
                                    viewModel.selectedCircuits,
                                    viewModel.setSelectedCircuits,
                                ),
                                checkbox(
                                    context,
                                    "4 Circuits",
                                    viewModel.selectedCircuits,
                                    viewModel.setSelectedCircuits,
                                ),
                              ],
                            ),
                            // // //
                            const Text("Formation"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                checkbox(
                                    context,
                                    "Horizontal",
                                    viewModel.selectedFormation,
                                    viewModel.setSelectedFormation,
                                ),
                                checkbox(
                                    context,
                                    "Triangular",
                                    viewModel.selectedFormation,
                                    viewModel.setSelectedFormation,
                                ),
                                checkbox(
                                    context,
                                    "Vertical",
                                    viewModel.selectedFormation,
                                    viewModel.setSelectedFormation,
                                ),
                              ],
                            ),
                            // // //
                            const Text("Type of point"),
                            Column(
                              children: [
                                checkbox(
                                    context,
                                    "Cut Point",
                                    viewModel.selectedTypePoint,
                                    viewModel.setSelectedTypePoint,
                                ),
                                checkbox(
                                    context,
                                    "Pin Point",
                                    viewModel.selectedTypePoint,
                                    viewModel.setSelectedTypePoint,
                                ),
                                checkbox(
                                    context,
                                    "End Point",
                                    viewModel.selectedTypePoint,
                                    viewModel.setSelectedTypePoint,
                                ),
                              ],
                            ),
                            // // Pole Details here [v cross Arm, Horiz. Cross Arm, Channel Cross Arm, Side Arm]
                            // // Insulators[Pin Insulators, Disc, Shackles,
                            // // Support Type[Stud Pole, Stay Set]
                            const Text("Any Crossing?"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [
                                    Expanded(
                                      child: multipleCheckbox(
                                        context,
                                        "None",
                                        viewModel.selectedCrossings,
                                            (bool? checked) {
                                          viewModel.setSelectedCrossings("None");
                                        },
                                        true,
                                      ),
                                    ),
                                    Expanded(
                                      child: multipleCheckbox(
                                        context,
                                        "33KV Line",
                                        viewModel.selectedCrossings,
                                            (bool? checked) {
                                          viewModel
                                              .setSelectedCrossings("33KV Line");
                                        },
                                        true,
                                      ),
                                    ),
                                    Expanded(
                                      child: multipleCheckbox(
                                        context,
                                        "11KV Line",
                                        viewModel.selectedCrossings,
                                            (bool? checked) {
                                          viewModel
                                              .setSelectedCrossings("11KV Line");
                                        },
                                        true,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10), // Spacing

                                // Row for remaining checkboxes in 2 columns
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          multipleCheckbox(
                                            context,
                                            "LT Line",
                                            viewModel.selectedCrossings,
                                                (bool? checked) {
                                              viewModel.setSelectedCrossings(
                                                  "LT Line");
                                            },
                                            true,
                                          ),
                                          multipleCheckbox(
                                            context,
                                            "Railway crossing",
                                            viewModel.selectedCrossings,
                                                (bool? checked) {
                                              viewModel.setSelectedCrossings(
                                                  "Railway crossing");
                                            },
                                            true,
                                          ),
                                          multipleCheckbox(
                                            context,
                                            "Transmission(400KV)",
                                            viewModel.selectedCrossings,
                                                (bool? checked) {
                                              viewModel.setSelectedCrossings(
                                                  "Transmission(400KV)");
                                            },
                                            true,
                                          ),
                                          multipleCheckbox(
                                            context,
                                            "Transmission(132KV)",
                                            viewModel.selectedCrossings,
                                                (bool? checked) {
                                              viewModel.setSelectedCrossings(
                                                  "Transmission(132KV)");
                                            },
                                            true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          multipleCheckbox(
                                            context,
                                            "Road Crossing",
                                            viewModel.selectedCrossings,
                                                (bool? checked) {
                                              viewModel.setSelectedCrossings(
                                                  "Road Crossing");
                                            },
                                            true,
                                          ),
                                          multipleCheckbox(
                                            context,
                                            "Building Crossing",
                                            viewModel.selectedCrossings,
                                                (bool? checked) {
                                              viewModel.setSelectedCrossings(
                                                  "Building Crossing");
                                            },
                                            true,
                                          ),
                                          multipleCheckbox(
                                            context,
                                            "Transmission(220KV)",
                                            viewModel.selectedCrossings,
                                                (bool? checked) {
                                              viewModel.setSelectedCrossings(
                                                  "Transmission(220KV");
                                            },
                                            true,
                                          ),
                                          multipleCheckbox(
                                            context,
                                            "Other Common Lines",
                                            viewModel.selectedCrossings,
                                                (bool? checked) {
                                              viewModel.setSelectedCrossings(
                                                  "Other Common Lines");
                                            },
                                            true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //Particulars of crossing(Optional)
                            const Text("Connected Load"),
                            Row(
                              children: [
                                checkbox(
                                  context,
                                  "No Load",
                                  viewModel.selectedConnected,
                                  viewModel.setSelectedConnected,
                                ),
                                checkbox(
                                  context,
                                  "DTR",
                                  viewModel.selectedConnected,
                                  viewModel.setSelectedConnected,
                                ),
                              ],
                            ),
                            // //Structure Details[Structure Code, Equipment Code]
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     const Text("Substation Code"),
                            //     const SizedBox(width: 50,),
                            //     SizedBox( width: 150,
                            //       child:TextFormField(
                            //         maxLines: 1,
                            //         controller: viewModel.subStationCapacity,
                            //         keyboardType: TextInputType.text,
                            //         decoration: const InputDecoration(
                            //           hintText:"2X5MVA",
                            //           border: OutlineInputBorder(),
                            //           alignLabelWithHint: true,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            // //DTR(Details): DTR Phase, DTR Capacity
                            //DTR Make
                            //DTR Sl.No
                            //Year Of Manufacture


                            // //Support Material
                            //Tilting Type AB Switch
                            //Horizontal Type AB Swith
                            //HG Fuse Set
                            //LT Distribution box
                            //Plint Type
                            //Earthing Type, No.of earth pits
                            const Text("Conductor Size"),
                            Row(
                              children: [
                                checkbox(
                                  context,
                                  "100 sq.mm",
                                  viewModel.selectedConductor ,
                                  viewModel.setSelectedConductor ,
                                ),
                                checkbox(
                                  context,
                                  "55 sq.mm",
                                  viewModel.selectedConductor ,
                                  viewModel.setSelectedConductor ,
                                ),
                                checkbox(
                                  context,
                                  "34 sq.mm",
                                  viewModel.selectedConductor ,
                                  viewModel.setSelectedConductor ,
                                ),
                              ],
                            ),

                            const Text("You are at Location coordinates"),
                            Text("Location Accuracy: ${viewModel.totalAccuracy?.toStringAsFixed(1) ?? "--"} mts / 15.0 mts", style:  TextStyle(
                              color: (viewModel.totalAccuracy ?? 100) < 15.0
                                  ? Colors.green
                                  : Colors.pinkAccent,
                            ),),
                            Text(
                              "Lat: ${viewModel.latitude?.toStringAsFixed(5) ?? "--"}\n"
                                  "Lon: ${viewModel.longitude?.toStringAsFixed(5) ?? "--"}\n",

                              style: const TextStyle(
                                color: CommonColors.colorPrimary,
                              ),
                            ),
                            // viewModel.distanceDisplay==isTrue&&viewModel.selectedPole==null?Text("Distance from Previous pole to your locations is ${viewModel.distanceBtnPoles} %s mtrs"): const Text("Please select source  pole to get distance.", style: TextStyle(color:Colors.red),),
                            const SizedBox(height: 10,),
                            SizedBox(width: double.infinity,
                              child:PrimaryButton(text: "Save Pole", onPressed: viewModel.submit33KVForm),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (viewModel.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ]),
            );
          },
        ),
      ),
    );
  }
  Widget checkbox(BuildContext context, String title, String? selected,
      void Function(String) selectedFunction, ) {
    return Consumer<Check11kvViewmodel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: selected == title,
              onChanged: (newValue ) {
                  selectedFunction(title);
                }
            ),
            Text(
              title,
              style: const TextStyle(fontSize:12 ),
            ),
            const SizedBox(
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
      void Function(bool?) onChanged,
      bool isEnabled,
      ) {
    return CheckboxListTile(
      title: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      value: selectedList.contains(label),
      onChanged: isEnabled ? onChanged : null,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}