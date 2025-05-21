import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/pole_11kv_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
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
          "11KV Feeder Proposal".toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => Pole11kvViewmodel(context: context, args: args),
        child: Consumer<Pole11kvViewmodel>(
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

                          Row(
                            children: [
                              checkbox(
                                context,
                                "Source Pole Not Mapped",
                                viewModel.selectedPole,
                                viewModel.setSelectedPole,
                                true,
                              ),
                              checkbox(
                                context,
                                "Origin Pole",
                                viewModel.selectedPole,
                                viewModel.setSelectedPole,
                                true,
                              ),
                            ],
                          ),

                          Visibility(
                            visible: viewModel.selectedPole == null,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              const Text('Previous Pole Num.'),
                              DropdownButton<PoleFeederEntity>(
                                isExpanded: true,
                                hint: const Text("Select an option"),
                                value: viewModel.selectedPoleFeeder,
                                items: viewModel.poleFeederList
                                    .map((item) => DropdownMenuItem<PoleFeederEntity>(
                                          value: item,
                                          child: Text(item.poleNum??""),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  viewModel.onListPoleFeederChange(value);
                                },
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Tapping from previous pole"),

                          checkbox(
                            context,
                            "Straight Tapping",
                            viewModel.selectedTappingPole,
                            viewModel.setSelectedTappingPole,
                            viewModel.selectedPole != "Origin Pole",
                          ),
                          checkbox(
                            context,
                            "Left Tapping",
                            viewModel.selectedTappingPole,
                            viewModel.setSelectedTappingPole,
                            viewModel.selectedPole != "Origin Pole",
                          ),
                          checkbox(
                            context,
                            "Right Tapping",
                            viewModel.selectedTappingPole,
                            viewModel.setSelectedTappingPole,
                            viewModel.selectedPole != "Origin Pole",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Pole Number"),
                          TextFormField(
                              // maxLines: null,
                              // minLines: 5,
                              controller: viewModel.poleNumber,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                // hintText: "Type here...",
                                border: OutlineInputBorder(),
                                alignLabelWithHint: true,
                              ),
                            ),
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
                                    "RS joist",
                                    viewModel.selectedFirstGroup.contains("RS joist") ? "RS joist" : null,
                                    (val) => viewModel.toggleFirstGroup(val),
                                    true,
                                    ),
                                    checkbox(
                                      context,
                                      "PSSC Pole",
                                      viewModel.selectedFirstGroup
                                                  .contains("PSSC Pole")
                                          ? "PSSC Pole"
                                          : null,
                                      (val) => viewModel.toggleFirstGroup(val),
                                      isTrue,
                                    ),
                                    checkbox(
                                      context,
                                      "Tower",
                                      viewModel.selectedFirstGroup
                                                  .contains("Tower")
                                          ? "Tower"
                                          : null,
                                      (val) => viewModel.toggleFirstGroup(val),
                                      isTrue,
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
                                      "Joist",
                                      viewModel.selectedSecondGroup
                                                  .contains("Joist")
                                          ? "Joist"
                                          : null,
                                      (val) => viewModel.toggleSecondGroup(val),
                                      viewModel.isSecondGroupEnabled,
                                    ),
                                    checkbox(
                                      context,
                                      "Rail Pole",
                                      viewModel.selectedSecondGroup
                                                  .contains("Rail Pole")
                                          ? "Rail Pole"
                                          : null,
                                      (val) => viewModel.toggleSecondGroup(val),
                                      viewModel.isSecondGroupEnabled,
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
                               isTrue
                              ),
                              checkbox(
                                context,
                                "2 Circuits",
                                viewModel.selectedCircuits,
                                viewModel.setSelectedCircuits,
                               isTrue
                              ),
                              checkbox(
                                context,
                                "3 Circuits",
                                viewModel.selectedCircuits,
                                viewModel.setSelectedCircuits,
                                isTrue
                              ),
                              checkbox(
                                context,
                                "4 Circuits",
                                viewModel.selectedCircuits,
                                viewModel.setSelectedCircuits,
                                isTrue
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
                                isTrue
                              ),
                              checkbox(
                                context,
                                "Triangular",
                                viewModel.selectedFormation,
                                viewModel.setSelectedFormation,
                                isTrue
                              ),
                              checkbox(
                                context,
                                "Vertical",
                                viewModel.selectedFormation,
                                viewModel.setSelectedFormation,
                               isTrue
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
                                isTrue
                              ),
                              checkbox(
                                context,
                                "Pin Point",
                                viewModel.selectedTypePoint,
                                viewModel.setSelectedTypePoint,
                                isTrue
                              ),
                              checkbox(
                                context,
                                "End Point",
                                viewModel.selectedTypePoint,
                                viewModel.setSelectedTypePoint,
                                isTrue
                              ),
                            ],
                          ),
                          // //
                          const Text("Any Crossing?"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row for "None", "33KV Line", "11KV Line"
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
                                          "Transmission Lines",
                                          viewModel.selectedCrossings,
                                          (bool? checked) {
                                            viewModel.setSelectedCrossings(
                                                "Transmission Lines");
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

                          const Text("Connected Load"),
                          Row(
                            children: [
                              checkbox(
                                context,
                                "No Load",
                                viewModel.selectedConnected,
                                viewModel.setSelectedConnected,
                                true,
                              ),
                              checkbox(
                                context,
                                "DTR",
                                viewModel.selectedConnected,
                                viewModel.setSelectedConnected,
                                true,
                              ),
                            ],
                          ),
                          //
                          Visibility(
                            visible: viewModel.selectedConnected=="DTR",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const Text("Enter DTR Structure"),
                          TextFormField(
                              maxLines: 1,
                              controller: viewModel.dtrStructure,
                              keyboardType: TextInputType.text,
                            ),
                          const SizedBox(height: 10,),
                          const Text("Choose DTR Capacity"),
                          DropdownButton<int>(
                              isExpanded: true,
                              hint: const Text("Select an option"),
                              value: viewModel.selectedCapacityIndex,
                              items:viewModel.capacity.asMap().entries.map<DropdownMenuItem<int>>((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                return DropdownMenuItem<int>(
                                  value: index,
                                  child: Text(item.optionName),
                                );
                              }).toList(),
                            onChanged: viewModel.onListCapacitySelected,
                            ),
                          const SizedBox(height: 10,),
                          ]
                          ),
                          ),
                          const Text("Conductor Size"),
                          Row(
                            children: [
                              checkbox(
                                context,
                                "100 sq.mm",
                                viewModel.selectedConductor ,
                                viewModel.setSelectedConductor ,
                                true,
                              ),
                              checkbox(
                                context,
                                "55 sq.mm",
                                viewModel.selectedConductor ,
                                viewModel.setSelectedConductor ,
                                true,
                              ),
                              checkbox(
                                context,
                                "34 sq.mm",
                                viewModel.selectedConductor ,
                                viewModel.setSelectedConductor ,
                                true,
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
                          viewModel.distanceDisplay==isTrue&&viewModel.selectedPole==null?Text("Distance from Previous pole to your locations is ${viewModel.distanceBtnPoles} %s mtrs"): Text("Please select source pole to get distance."),

                          // viewModel.selectedPole==""?Text("Distance from source pole: ${viewModel.distance.toStringAsFixed(2)} meters"): Text(""),
                          viewModel.selectedPole==""||viewModel.selectedPole==null? const Text("Please select source to get distance", style: TextStyle(color:Colors.red)):const Text(""),
                          const SizedBox(height: 10,),
                           SizedBox(width: double.infinity,
                          child:PrimaryButton(text: "Save Pole", onPressed: (){viewModel.submitForm();}),
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
            style: TextStyle(fontSize: 12, color: enabled ? null : Colors.grey),
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
