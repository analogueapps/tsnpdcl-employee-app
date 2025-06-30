import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/pole_33kv_feeder_edit_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart'
    show ViewDetailedLcHeadWidget;
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

import '../../check_measurement_lines/model/structure_capacity_model.dart';

class Pole33kvFeederEdit extends StatelessWidget {
  static const id = Routes.pole33kvFeederMarkEditScreen;
  final Map<String, dynamic> args;

  const Pole33kvFeederEdit({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Edit Mode".toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "${args['fn']}(${args['fc']})",
            style: const TextStyle(
                color: Colors.white,
                fontSize: btnTextSize,
                fontWeight: FontWeight.w700),
          ),
        ]),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
          create: (_) =>
              Pole33kvFeederEditViewmodel(context: context, args: args),
          child: Consumer<Pole33kvFeederEditViewmodel>(
              builder: (context, viewModel, child) {
            return Form(
                key: viewModel.formKey,
                child: Stack(children: [
                  Column(children: [
                    Expanded(
                      child: GoogleMap(
                        initialCameraPosition: viewModel.cameraPosition ??
                            const CameraPosition(
                                target: LatLng(0, 0), zoom: 10),
                        polylines: viewModel.polylines,
                        markers: viewModel.markers,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: true,
                        onMapCreated: (controller) {
                          viewModel.mapController = controller;
                        },
                      ),
                    ),
                    Expanded(
                      child: viewModel.deleteOrEdit == isFalse
                          ? Container()
                          : SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 30),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const ViewDetailedLcTileWidget(
                                      tileKey: "Selected Pole",
                                      tileValue: "0000",
                                      valueColor: Colors.red,
                                    ),
                                    const SizedBox(
                                      height: doubleTen,
                                    ),
                                    const Text('Previous Pole Num.'),
                                    GestureDetector(
                                      onTap: () {
                                        viewModel.showPoleFeederDropdown();
                                      },
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                          // labelText: 'Select an option',
                                          border: OutlineInputBorder(),
                                        ),
                                        child: viewModel.poleNumber.text == ""
                                            ? Text(
                                                viewModel.selectedPoleFeeder !=
                                                        null
                                                    ? (viewModel.selectedPoleFeeder!
                                                                    .tempSeries !=
                                                                null &&
                                                            viewModel
                                                                .selectedPoleFeeder!
                                                                .tempSeries!
                                                                .isNotEmpty
                                                        ? '${viewModel.selectedPoleFeeder!.tempSeries}-${viewModel.selectedPoleFeeder!.poleNum}'
                                                        : viewModel
                                                                .selectedPoleFeeder!
                                                                .poleNum ??
                                                            '')
                                                    : 'Tap to select',
                                              )
                                            : Text(viewModel.poleNumber.text),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: doubleTen,
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
                                      height: doubleTen,
                                    ),
                                    const Text("Pole Number"),
                                    TextFormField(
                                      controller: viewModel.poleNumber,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: doubleTen,
                                    ),
                                    const Text("Pole Type"),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              checkbox(
                                                context,
                                                "Spun Pole",
                                                viewModel.selectedFirstGroup
                                                        .contains("Spun Pole")
                                                    ? "Spun Pole"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleFirstGroup(val),
                                              ),
                                              checkbox(
                                                context,
                                                "RS joist",
                                                viewModel.selectedFirstGroup
                                                        .contains("RS joist")
                                                    ? "RS joist"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleFirstGroup(val),
                                              ),
                                              checkbox(
                                                context,
                                                "PSSC Pole",
                                                viewModel.selectedFirstGroup
                                                        .contains("PSSC Pole")
                                                    ? "PSSC Pole"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleFirstGroup(val),
                                              ),
                                              checkbox(
                                                context,
                                                "Tower(M+3)",
                                                viewModel.selectedFirstGroup
                                                        .contains("Tower(M+3)")
                                                    ? "Tower(M+3)"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleFirstGroup(val),
                                              ),
                                              checkbox(
                                                context,
                                                "Tower(M+9)",
                                                viewModel.selectedFirstGroup
                                                        .contains("Tower(M+9)")
                                                    ? "Tower(M+9)"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleFirstGroup(val),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              checkbox(
                                                context,
                                                "Tubular",
                                                viewModel.selectedSecondGroup
                                                        .contains("Tubular")
                                                    ? "Tubular"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleSecondGroup(val),
                                              ),
                                              checkbox(
                                                context,
                                                "Joist",
                                                viewModel.selectedSecondGroup
                                                        .contains("Joist")
                                                    ? "Joist"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleSecondGroup(val),
                                              ),
                                              checkbox(
                                                context,
                                                "Rail Pole",
                                                viewModel.selectedSecondGroup
                                                        .contains("Rail Pole")
                                                    ? "Rail Pole"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleSecondGroup(val),
                                              ),
                                              checkbox(
                                                context,
                                                "Tower(M+6)",
                                                viewModel.selectedFirstGroup
                                                        .contains("Tower(M+6)")
                                                    ? "Tower(M+6)"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleFirstGroup(val),
                                              ),
                                              checkbox(
                                                context,
                                                "Tower(M+12)",
                                                viewModel.selectedFirstGroup
                                                        .contains("Tower(M+12)")
                                                    ? "Tower(M+12)"
                                                    : null,
                                                (val) => viewModel
                                                    .toggleFirstGroup(val),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text("Pole Height"),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: viewModel.poleHeightData
                                          .map((height) {
                                        return CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(height,
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                          value: viewModel.selectedPoleHeight ==
                                              height,
                                          onChanged: (_) => viewModel
                                              .setSelectedPoleHeight(height),
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
                                    const Text("Formation"),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                    const Text("Any Crossing?"),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: multipleCheckbox(
                                                context,
                                                "None",
                                                viewModel.selectedCrossings,
                                                (bool? checked) {
                                                  viewModel
                                                      .setSelectedCrossings(
                                                          "None");
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: multipleCheckbox(
                                                context,
                                                "33KV Line",
                                                viewModel.selectedCrossings,
                                                (bool? checked) {
                                                  viewModel
                                                      .setSelectedCrossings(
                                                          "33KV Line");
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: multipleCheckbox(
                                                context,
                                                "11KV Line",
                                                viewModel.selectedCrossings,
                                                (bool? checked) {
                                                  viewModel
                                                      .setSelectedCrossings(
                                                          "11KV Line");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 10), // Spacing

                                        // Row for remaining checkboxes in 2 columns
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      viewModel
                                                          .setSelectedCrossings(
                                                              "LT Line");
                                                    },
                                                  ),
                                                  multipleCheckbox(
                                                    context,
                                                    "Railway crossing",
                                                    viewModel.selectedCrossings,
                                                    (bool? checked) {
                                                      viewModel
                                                          .setSelectedCrossings(
                                                              "Railway crossing");
                                                    },
                                                  ),
                                                  multipleCheckbox(
                                                    context,
                                                    "Transmission(400KV)",
                                                    viewModel.selectedCrossings,
                                                    (bool? checked) {
                                                      viewModel
                                                          .setSelectedCrossings(
                                                              "Transmission(400KV)");
                                                    },
                                                  ),
                                                  multipleCheckbox(
                                                    context,
                                                    "Transmission(132KV)",
                                                    viewModel.selectedCrossings,
                                                    (bool? checked) {
                                                      viewModel
                                                          .setSelectedCrossings(
                                                              "Transmission(132KV)");
                                                    },
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
                                                      viewModel
                                                          .setSelectedCrossings(
                                                              "Road Crossing");
                                                    },
                                                  ),
                                                  multipleCheckbox(
                                                    context,
                                                    "Building Crossing",
                                                    viewModel.selectedCrossings,
                                                    (bool? checked) {
                                                      viewModel
                                                          .setSelectedCrossings(
                                                              "Building Crossing");
                                                    },
                                                  ),
                                                  multipleCheckbox(
                                                    context,
                                                    "Transmission(220KV)",
                                                    viewModel.selectedCrossings,
                                                    (bool? checked) {
                                                      viewModel
                                                          .setSelectedCrossings(
                                                              "Transmission(220KV)");
                                                    },
                                                  ),
                                                  multipleCheckbox(
                                                    context,
                                                    "Other Commun. Lines",
                                                    viewModel.selectedCrossings,
                                                    (bool? checked) {
                                                      viewModel
                                                          .setSelectedCrossings(
                                                              "Other Commnn. Lines");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    FillTextFormField(
                                        controller:
                                            viewModel.particularsOfCrossing,
                                        labelText:
                                            "Particulars of crossing(Optional)",
                                        keyboardType: TextInputType.text),
                                    const SizedBox(
                                      height: 10,
                                    ),
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
                                          "Sub Station",
                                          viewModel.selectedConnected,
                                          viewModel.setSelectedConnected,
                                        ),
                                        checkbox(
                                          context,
                                          "HT Service",
                                          viewModel.selectedConnected,
                                          viewModel.setSelectedConnected,
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 0.2,
                                    ),
                                    Visibility(
                                      visible: viewModel.selectedConnected ==
                                          "Sub Station",
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Choose Substation"),
                                            DropdownButton<String>(
                                              isExpanded: true,
                                              hint: const Text(
                                                  "Select an option"),
                                              value: viewModel
                                                  .listSubStationSelect,
                                              items: viewModel
                                                  .listSubStationItem
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item.optionCode,
                                                        child: Text(
                                                            item.optionName!),
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                viewModel
                                                    .onListSubStationItemSelect(
                                                        value);
                                              },
                                            ),
                                          ]),
                                    ),
                                    Visibility(
                                      visible: viewModel.selectedConnected ==
                                          "HT Service",
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Choose Service"),
                                            DropdownButton<String>(
                                              isExpanded: true,
                                              hint: viewModel
                                                      .htServiceList.isNotEmpty
                                                  ? const Text(
                                                      "Select an option")
                                                  : const Text(""),
                                              value: viewModel
                                                  .selectedHtServiceName,
                                              items: viewModel.htServiceList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item.optionId,
                                                        child: Text(
                                                            item.optionName),
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                viewModel
                                                    .onHtServiceChange(value);
                                              },
                                            ),
                                          ]),
                                    ),
                                    const SizedBox(height: doubleTen),
                                    const Text("Conductor Size"),
                                    Row(
                                      children: [
                                        checkbox(
                                          context,
                                          "100 sq.mm",
                                          viewModel.selectedConductor,
                                          viewModel.setSelectedConductor,
                                        ),
                                        checkbox(
                                          context,
                                          "55 sq.mm",
                                          viewModel.selectedConductor,
                                          viewModel.setSelectedConductor,
                                        ),
                                        checkbox(
                                          context,
                                          "34 sq.mm",
                                          viewModel.selectedConductor,
                                          viewModel.setSelectedConductor,
                                        ),
                                      ],
                                    ),
                                    const Text(
                                        "You are at Location coordinates"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: PrimaryButton(
                                          text: "Update Pole",
                                          onPressed:
                                              viewModel.submitCheck11KVForm),
                                    ),
                                    const ViewDetailedLcHeadWidget(
                                        title: 'Network Survey Options'),
                                  ]),
                            ),
                    ),
                  ]),
                ]));
          })),
    );
  }

  Widget checkbox(BuildContext context, String title, String? selected,
      void Function(String) selectedFunction) {
    return Consumer<Pole33kvFeederEditViewmodel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: selected == title,
              onChanged: (newValue) {
                if (newValue == true) {
                  selectedFunction(title); // only set when checked
                } else {
                  selectedFunction(""); // or null if you want to uncheck
                }
              },
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
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
  ) {
    return CheckboxListTile(
      title: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      value: selectedList.contains(label),
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
