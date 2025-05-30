import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/check_11KV_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class CheckMeasure11kv extends StatelessWidget {
  const CheckMeasure11kv({super.key, required this.args});

  static const id = Routes.check11kvScreen;
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => Check11kvViewmodel(context: context, args: args),
        child: Consumer<Check11kvViewmodel>(
          builder: (context, viewModel, child) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: CommonColors.colorPrimary,
                  title: Text(
                    "Check Measurement".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: toolbarTitleSize,
                        fontWeight: FontWeight.w700),
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          var argument = {
                            'ssc': viewModel.ssc,
                            'ssn': viewModel.ssn,
                            'fc': viewModel.feederCode,
                            'fn': viewModel.feederName,
                          };
                          Navigation.instance.navigateTo(
                              Routes.check11kvScreenEdit,
                              args: argument);
                        },
                        child: const Text(
                          "EDIT",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: btnTextSize,
                              fontWeight: FontWeight.w700),
                        )),
                  ],
                ),
                body: Form(
                  key: viewModel.formKey,
                  child: Stack(children: [
                    Column(
                      children: [
                        // Fixed map
                        Container(
                          color: Colors.grey[200],
                          height: 200,
                          width: double.infinity,
                          // child: const Center(child: Text("Google maps here")),
                          child:viewModel.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : GoogleMap(
                            onMapCreated: viewModel.onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: viewModel.center,
                              zoom: 11.0,
                            ),
                          ),
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
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                ),
                                ViewDetailedLcTileWidget(
                                  tileKey: "Feeder",
                                  tileValue: " ${args["fc"]}",
                                  valueColor: Colors.green,
                                ),

                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Previous Pole Num.'),
                                      GestureDetector(
                                        onTap: () {
                                          viewModel.selectMapOrList();
                                        },
                                        child: InputDecorator(
                                          decoration: const InputDecoration(
                                            // labelText: 'Select an option',
                                            border: OutlineInputBorder(),
                                          ),
                                          child: Text(
                                            viewModel.selectedPoleFeeder != null
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
                                          ),
                                        ),
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
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                ),
                                // TextFormField(
                                //   controller: viewModel.poleNumber,
                                //   keyboardType: TextInputType.multiline,
                                //   decoration: const InputDecoration(
                                //     border: OutlineInputBorder(),
                                //     alignLabelWithHint: true,
                                //   ),
                                // ),
                                const SizedBox(
                                  height: doubleTen,
                                ),
                                const Text("Pole Type"),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            (val) =>
                                                viewModel.toggleFirstGroup(val),
                                          ),
                                          checkbox(
                                            context,
                                            "RS joist",
                                            viewModel.selectedFirstGroup
                                                    .contains("RS joist")
                                                ? "RS joist"
                                                : null,
                                            (val) =>
                                                viewModel.toggleFirstGroup(val),
                                          ),
                                          checkbox(
                                            context,
                                            "PSSC Pole",
                                            viewModel.selectedFirstGroup
                                                    .contains("PSSC Pole")
                                                ? "PSSC Pole"
                                                : null,
                                            (val) =>
                                                viewModel.toggleFirstGroup(val),
                                          ),
                                          checkbox(
                                            context,
                                            "Tower(M+3)",
                                            viewModel.selectedFirstGroup
                                                    .contains("Tower(M+3)")
                                                ? "Tower(M+3)"
                                                : null,
                                            (val) =>
                                                viewModel.toggleFirstGroup(val),
                                          ),
                                          checkbox(
                                            context,
                                            "Tower(M+9)",
                                            viewModel.selectedFirstGroup
                                                    .contains("Tower(M+9)")
                                                ? "Tower(M+9)"
                                                : null,
                                            (val) =>
                                                viewModel.toggleFirstGroup(val),
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
                                            viewModel.selectedFirstGroup
                                                    .contains("Tubular")
                                                ? "Tubular"
                                                : null,
                                            (val) =>
                                                viewModel.toggleFirstGroup(val),
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
                                            (val) =>
                                                viewModel.toggleFirstGroup(val),
                                          ),
                                          checkbox(
                                            context,
                                            "Tower(M+12)",
                                            viewModel.selectedFirstGroup
                                                    .contains("Tower(M+12)")
                                                ? "Tower(M+12)"
                                                : null,
                                            (val) =>
                                                viewModel.toggleFirstGroup(val),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                ),
                                const Text("Pole Height"),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      viewModel.poleHeightData.map((height) {
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(height,
                                          style: const TextStyle(fontSize: 12)),
                                      value: viewModel.selectedPoleHeight ==
                                          height,
                                      onChanged: (_) => viewModel
                                          .setSelectedPoleHeight(height),
                                    );
                                  }).toList(),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
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
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
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
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
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
                                const Center(
                                  child: Text("Pole Details"),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Cross Arm",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: doubleTwelve),
                                    ),
                                    Text(
                                      "QTY",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: doubleTwelve),
                                    )
                                  ],
                                ),
                                Column(
                                  children: viewModel.poleItems
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final index = entry.key;
                                    final item = entry.value;
                                    return checkAndDrop(
                                      context,
                                      item.title,
                                      item.isSelected,
                                      () => viewModel.toggleSelection(index),
                                      item.selectedQty?.toString(),
                                      (newValue) =>
                                          viewModel.updatePoleQtyForItem(
                                              newValue, index),
                                    );
                                  }).toList(),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Insulators",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: doubleTwelve),
                                    ),
                                    Text(
                                      "QTY",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: doubleTwelve),
                                    )
                                  ],
                                ),
                                Column(
                                  children: viewModel.poleInsulators
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final index = entry.key;
                                    final item = entry.value;
                                    return checkAndDrop(
                                      context,
                                      item.title,
                                      item.isSelected,
                                      () => viewModel.toggleInsulators(index),
                                      item.selectedQty?.toString(),
                                      (newValue) =>
                                          viewModel.updatePoleInsulators(
                                              newValue, index),
                                    );
                                  }).toList(),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Support Type",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: doubleTwelve),
                                    ),
                                    Text(
                                      "QTY",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: doubleTwelve),
                                    )
                                  ],
                                ),
                                Column(
                                  children: viewModel.poleSupport
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final index = entry.key;
                                    final item = entry.value;
                                    return checkAndDrop(
                                      context,
                                      item.title,
                                      item.isSelected,
                                      () => viewModel.toggleSupport(index),
                                      item.selectedQty?.toString(),
                                      (newValue) => viewModel.updatePoleSupport(
                                          newValue, index),
                                    );
                                  }).toList(),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                ),
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
                                              viewModel
                                                  .setSelectedCrossings("None");
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
                                              viewModel.setSelectedCrossings(
                                                  "33KV Line");
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
                                              viewModel.setSelectedCrossings(
                                                  "11KV Line");
                                            },
                                            true,
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
                                                true,
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
                                                  viewModel
                                                      .setSelectedCrossings(
                                                          "Road Crossing");
                                                },
                                                true,
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
                                                true,
                                              ),
                                              multipleCheckbox(
                                                context,
                                                "Transmission(220KV)",
                                                viewModel.selectedCrossings,
                                                (bool? checked) {
                                                  viewModel.setSelectedCrossings(
                                                      "Transmission(220KV)");
                                                },
                                                true,
                                              ),
                                              multipleCheckbox(
                                                context,
                                                "Other Common Lines",
                                                viewModel.selectedCrossings,
                                                (bool? checked) {
                                                  viewModel
                                                      .setSelectedCrossings(
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
                                const SizedBox(
                                  height: 10,
                                ),
                                //Particulars of crossing(Optional)
                                FillTextFormField(
                                    controller: viewModel.particularsOfCrossing,
                                    labelText:
                                        "Particulars of crossing(Optional)",
                                    keyboardType: TextInputType.text),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
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
                                      "DTR",
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
                                  visible:
                                      viewModel.selectedConnected == "DTR" ||
                                          viewModel.selectedConnected == null,
                                  child: Column(children: [
                                    const Center(
                                      child: Text("Structure Details"),
                                    ),
                                    FillTextFormField(
                                      labelText: "Structure Code",
                                      controller: viewModel.structureCode,
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    FillTextFormField(
                                      labelText: "Equipment Code",
                                      controller: viewModel.equipmentCode,
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(
                                      height: doubleFifty,
                                      child: Center(
                                        child: Text("DTR Details"),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "DTR Phase",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              DropdownButton<String>(
                                                isExpanded: true,
                                                value:
                                                    viewModel.selectedDtrPhase,
                                                hint: Text("Select"),
                                                items: viewModel.dtrPhase
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) =>
                                                    viewModel
                                                        .onListDtrPhaseSelected(
                                                            newValue),
                                              ),
                                            ],
                                          ),
                                        ),

                                        ///Something wrong is happening here for both capacity and make after selecting the value the value is not changing after sometime i click again it is updating
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "DTR Capacity",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              DropdownButton<int>(
                                                isExpanded: true,
                                                hint: const Text(
                                                    "Select an option"),
                                                value: viewModel
                                                    .selectedCapacityIndex,
                                                items: viewModel.capacity
                                                    .asMap()
                                                    .entries
                                                    .map<DropdownMenuItem<int>>(
                                                        (entry) {
                                                  final index = entry.key;
                                                  final item = entry.value;
                                                  return DropdownMenuItem<int>(
                                                    value: index,
                                                    child:
                                                        Text(item.optionName),
                                                  );
                                                }).toList(),
                                                onChanged: viewModel
                                                    .onListCapacitySelected,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: doubleTwenty,
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'DTR Make',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          DropdownButton<int>(
                                            isExpanded: true,
                                            hint:
                                                const Text("Select an option"),
                                            value: viewModel.selectedMakeIndex,
                                            items: viewModel.make
                                                .asMap()
                                                .entries
                                                .map<DropdownMenuItem<int>>(
                                                    (entry) {
                                              final index = entry.key;
                                              final item = entry.value;
                                              return DropdownMenuItem<int>(
                                                value: index,
                                                child: Text(item.optionName),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              viewModel
                                                  .onListMakeSelected(value);
                                            },
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: doubleTwenty,
                                    ),
                                    FillTextFormField(
                                        controller: viewModel.dtrSlNo,
                                        labelText: "DTR Sl.No",
                                        keyboardType: TextInputType.text),
                                    const SizedBox(
                                      height: doubleTwenty,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Year Of Manufacturing",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text("Select"),
                                          value: viewModel.selectedYear,
                                          items: viewModel.yearList.map((year) {
                                            return DropdownMenuItem<String>(
                                              value: year,
                                              child: Text(year),
                                            );
                                          }).toList(),
                                          onChanged: (value) => viewModel
                                              .onListYearSelected(value),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: doubleForty,
                                      child: Center(
                                          child: Text("Support Material")),
                                    ),
                                    Column(
                                      children:
                                          viewModel.dropdownTitles.map((title) {
                                        return textDropDown(
                                          title,
                                          viewModel.smSelectedMap[title],
                                          viewModel.supportQty,
                                          (newValue) =>
                                              viewModel.updateSupportQty(
                                                  newValue, title),
                                        );
                                      }).toList(),
                                    ),
                                    textDropDown(
                                      "LT Distribution box",
                                      viewModel.selectedLTDistribution,
                                      viewModel.lTDistributionBox,
                                      (newValue) =>
                                          viewModel.onListLTSelected(newValue),
                                    ),
                                    Row(children: [
                                      const Expanded(
                                          child: const Text("Plint Type")),
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          value: viewModel.selectedpLintType,
                                          hint: Text("Select"),
                                          isExpanded: true,
                                          items: viewModel.pLintType
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) => viewModel
                                              .onListPLintSelected(newValue),
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(height: doubleTwenty),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Earthing Type"),
                                                DropdownButtonFormField<String>(
                                                  value: viewModel
                                                      .selectedEarthingType,
                                                  hint: Text("Select"),
                                                  isExpanded: true,
                                                  items: viewModel.earthingType
                                                      .map((String value) {
                                                    final stringValue =
                                                        value.toString();
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: stringValue,
                                                      child: Text(stringValue),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newValue) =>
                                                      viewModel
                                                          .onListEarthingType(
                                                              newValue),
                                                ),
                                              ]),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("No Of Earth Pits"),
                                                DropdownButtonFormField<String>(
                                                  value: viewModel
                                                      .selectedEarthPits,
                                                  hint: Text("Select"),
                                                  isExpanded: true,
                                                  items: viewModel.noOfEarthPits
                                                      .map((int value) {
                                                    final stringValue =
                                                        value.toString();
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: stringValue,
                                                      child: Text(stringValue),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newValue) =>
                                                      viewModel.onListEarthPits(
                                                          newValue),
                                                )
                                              ]),
                                        ),
                                      ],
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

                                const Text("You are at Location coordinates"),
                                Text(
                                  "Location Accuracy: ${viewModel.totalAccuracy?.toStringAsFixed(1) ?? "--"} mts / 15.0 mts",
                                  style: TextStyle(
                                    color:
                                        (viewModel.totalAccuracy ?? 100) < 15.0
                                            ? Colors.green
                                            : Colors.pinkAccent,
                                  ),
                                ),
                                Text(
                                  "Lat: ${viewModel.latitude?.toStringAsFixed(5) ?? "--"}\n"
                                  "Lon: ${viewModel.longitude?.toStringAsFixed(5) ?? "--"}\n",
                                  style: const TextStyle(
                                    color: CommonColors.colorPrimary,
                                  ),
                                ),
                                // viewModel.distanceDisplay==isTrue&&viewModel.selectedPole==null?Text("Distance from Previous pole to your locations is ${viewModel.distanceBtnPoles} %s mtrs"): const Text("Please select source  pole to get distance.", style: TextStyle(color:Colors.red),),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: PrimaryButton(
                                      text: "Save Pole",
                                      onPressed: viewModel.submitCheck11KVForm),
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
                ));
          },
        ));
  }

  Widget checkbox(
    BuildContext context,
    String title,
    String? selected,
    void Function(String) selectedFunction,
  ) {
    return Consumer<Check11kvViewmodel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                value: selected == title,
                onChanged: (newValue) {
                  selectedFunction(title);
                }),
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

  Widget checkAndDrop(
    BuildContext context,
    String title,
    bool isSelected,
    VoidCallback onCheckboxToggle,
    String? dropValue,
    ValueChanged<String?> onDropdownChanged,
  ) {
    return Consumer<Check11kvViewmodel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(title, style: const TextStyle(fontSize: 12)),
                value: isSelected,
                onChanged: (_) => onCheckboxToggle(),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: dropValue,
                hint: Text("Select"),
                isExpanded: true,
                items: viewModel.poleQty.map((int value) {
                  final stringValue = value.toString();
                  return DropdownMenuItem<String>(
                    value: stringValue,
                    child: Text(stringValue),
                  );
                }).toList(),
                onChanged: onDropdownChanged,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget textDropDown(
    String title,
    String? selectedValue,
    List<int> smQty,
    ValueChanged<String?> onDropdownChanged,
  ) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title)),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedValue,
              hint: Text("Select"),
              isExpanded: true,
              items: smQty.map((int value) {
                final stringValue = value.toString();
                return DropdownMenuItem<String>(
                  value: stringValue,
                  child: Text(stringValue),
                );
              }).toList(),
              onChanged: onDropdownChanged,
            ),
          )
        ],
      ),
      const SizedBox(height: doubleTwenty)
    ]);
  }
}
