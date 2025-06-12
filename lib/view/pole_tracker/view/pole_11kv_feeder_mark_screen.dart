import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/structure_capacity_model.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/pole_11kv_feeder_mark_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class Pole11kvFeederMarkScreen extends StatelessWidget {
  static const id = Routes.pole11kvFeederMarkScreen;
  final Map<String, dynamic> args;

  const Pole11kvFeederMarkScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          Pole11kvFeederMarkViewmodel(context: context, args: args),
      child: Consumer<Pole11kvFeederMarkViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "11KV Feeder Mapping".toUpperCase(),
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
                    child: Text(
                      "Edit".toUpperCase(),
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

                    //   GestureDetector(
                    //   onTap: (){
                    //     viewModel.poleSelectedOnMap();
                    //   },
                    //     child:Text("Google Maps"),
                    // ),
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
                            Visibility(
                              visible: viewModel.poleID == "",
                              child: Row(
                                children: [
                                  checkbox(
                                    context,
                                    "Origin Pole",
                                    viewModel.selectedPole,
                                    viewModel.setSelectedPole,
                                    true,
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: viewModel.selectedPole == null,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          viewModel.poleFeederSelected ??
                                              'Tap to select',
                                        ),
                                      ),
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
                            checkbox(
                              context,
                              "Is Extension Pole?",
                              viewModel.isExtensionSelected,
                              viewModel.setSelectedExtension,
                              viewModel.selectedPole != "Origin Pole",
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const SizedBox(
                              height: 10,
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
                                        true,
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
                                        true,
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
                                        isTrue,
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
                                        isTrue,
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
                                        isTrue,
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
                                        isTrue,
                                      ),
                                      checkbox(
                                        context,
                                        "Joist",
                                        viewModel.selectedFirstGroup
                                                .contains("Joist")
                                            ? "Joist"
                                            : null,
                                        (val) =>
                                            viewModel.toggleFirstGroup(val),
                                        isTrue,
                                      ),
                                      checkbox(
                                        context,
                                        "Rail Pole",
                                        viewModel.selectedFirstGroup
                                                .contains("Rail Pole")
                                            ? "Rail Pole"
                                            : null,
                                        (val) =>
                                            viewModel.toggleFirstGroup(val),
                                        isTrue,
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
                                        isTrue,
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
                                        isTrue,
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
                                    isTrue),
                                checkbox(
                                    context,
                                    "2 Circuits",
                                    viewModel.selectedCircuits,
                                    viewModel.setSelectedCircuits,
                                    isTrue),
                                checkbox(
                                    context,
                                    "3 Circuits",
                                    viewModel.selectedCircuits,
                                    viewModel.setSelectedCircuits,
                                    isTrue),
                                checkbox(
                                    context,
                                    "4 Circuits",
                                    viewModel.selectedCircuits,
                                    viewModel.setSelectedCircuits,
                                    isTrue),
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const Text("Formation"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                checkbox(
                                    context,
                                    "Horizontal",
                                    viewModel.selectedFormation,
                                    viewModel.setSelectedFormation,
                                    isTrue),
                                checkbox(
                                    context,
                                    "Triangular",
                                    viewModel.selectedFormation,
                                    viewModel.setSelectedFormation,
                                    isTrue),
                                checkbox(
                                    context,
                                    "Vertical",
                                    viewModel.selectedFormation,
                                    viewModel.setSelectedFormation,
                                    isTrue),
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const Text("Type of point"),
                            Column(
                              children: [
                                checkbox(
                                    context,
                                    "Cut Point",
                                    viewModel.selectedTypePoint,
                                    viewModel.setSelectedTypePoint,
                                    isTrue),
                                checkbox(
                                    context,
                                    "Pin Point",
                                    viewModel.selectedTypePoint,
                                    viewModel.setSelectedTypePoint,
                                    isTrue),
                                checkbox(
                                    context,
                                    "End Point",
                                    viewModel.selectedTypePoint,
                                    viewModel.setSelectedTypePoint,
                                    isTrue),
                              ],
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
                                                  "Transmission(220KV)");
                                            },
                                            true,
                                          ),
                                          multipleCheckbox(
                                            context,
                                            "Other Commun. Lines",
                                            viewModel.selectedCrossings,
                                            (bool? checked) {
                                              viewModel.setSelectedCrossings(
                                                  "Other Commun. Lines");
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
                            TextFormField(
                              controller: viewModel.particularsOfCrossing,
                              decoration: const InputDecoration(
                                // labelText: "Enter remarks here",
                                hintText: "Particulars of crossing(Optional)",
                                border: OutlineInputBorder(),
                                alignLabelWithHint: true,
                              ),
                            ),
                            const SizedBox(
                              height: doubleTen,
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

                            const SizedBox(height: doubleTen,),
                            Visibility(
                              visible:viewModel.selectedConnected=="DTR" ,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Select structure code".toUpperCase()),
                                    DropdownButton<Option>(
                                      value: viewModel.selectedCode,
                                      hint: Text('Select Structure Code'),
                                      isExpanded: true,
                                      items: viewModel.structureCodes.map((option) {
                                        return DropdownMenuItem<Option>(
                                          value: option,
                                          child: Text(option.code),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        viewModel.setSelectedDtr (value!);
                                      },
                                    ),
                                    const Text("Didn't find the Structure code?", style: TextStyle(color:Colors.red, fontWeight: FontWeight.bold),),
                                    const SizedBox(height: doubleTen,),
                                    Align(alignment: Alignment.bottomRight,child:SizedBox(width: 150,child: PrimaryButton(onPressed: (){Navigation.instance.navigateTo(
                                      Routes.createOnlineDTR,
                                    );
                                    }, text: 'ADD DTR',),),
                                    ),
                                  ]
                              ),
                            ),

                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const Text("Conductor Size"),
                            checkbox(
                              context,
                              "AB Cable",
                              viewModel.abCableSelected ,
                              viewModel.setSelectedabCable ,
                              isTrue
                            ),
                            Row(
                              children: [
                                checkbox(
                                  context,
                                  "100 sq.mm",
                                  viewModel.selectedConductor,
                                  viewModel.setSelectedConductor,
                                  true,
                                ),
                                checkbox(
                                  context,
                                  "55 sq.mm",
                                  viewModel.selectedConductor,
                                  viewModel.setSelectedConductor,
                                  true,
                                ),
                                checkbox(
                                  context,
                                  "34 sq.mm",
                                  viewModel.selectedConductor,
                                  viewModel.setSelectedConductor,
                                  true,
                                ),
                              ],
                            ),
                            Container(
                                color: Colors.brown[200],
                                child: const Center(
                                    child: Text(
                                  "System Strength Details",
                                  style: TextStyle(fontSize: toolbarTitleSize),
                                ))),
                            const SizedBox(
                              height: doubleTen,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const Text("Pole Status"),
                            multipleCheckbox(
                              context,
                              "Broken",
                              viewModel.selectedPoleStatus,
                              (bool? checked) {
                                viewModel.setSelectedPoleStatus("Broken");
                              },
                              isTrue,
                            ),
                            multipleCheckbox(
                              context,
                              "Leaned",
                              viewModel.selectedPoleStatus,
                              (bool? checked) {
                                viewModel.setSelectedPoleStatus("Leaned");
                              },
                              isTrue,
                            ),
                            multipleCheckbox(
                              context,
                              "Pole Replacement with 9.1Mtr with \n T-Raiser(Road Crossing)",
                              viewModel.selectedPoleStatus,
                              (bool? checked) {
                                viewModel.setSelectedPoleStatus(
                                    "Pole Replacement with 9.1Mtr with \n T-Raiser(Road Crossing)");
                              },
                              isTrue,
                            ),
                            multipleCheckbox(
                              context,
                              "Rusted",
                              viewModel.selectedPoleStatus,
                              (bool? checked) {
                                viewModel.setSelectedPoleStatus("Rusted");
                              },
                              isTrue,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const SizedBox(
                              height: doubleTen,
                            ),
                            const Text("Conductor Status"),
                            Row(children: [
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Damaged",
                                  viewModel.selectedConductorStatus,
                                  (bool? checked) {
                                    viewModel
                                        .setSelectedConductorStatus("Damaged");
                                  },
                                  isTrue,
                                ),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Restring required",
                                  viewModel.selectedConductorStatus,
                                  (bool? checked) {
                                    viewModel.setSelectedConductorStatus(
                                        "Restring required");
                                  },
                                  isTrue,
                                ),
                              ),
                            ]),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const SizedBox(
                              height: doubleTen,
                            ),
                            const Text("Middle Poles Required?"),
                            Row(children: [
                              Expanded(
                                child: multipleCheckbox(
                                    context,
                                    "9.1 Mtr. Pole",
                                    viewModel.selectedMiddlePolesRequired,
                                    (bool? checked) {
                                  viewModel.setSelectedMiddlePolesRequired(
                                      "9.1 Mtr. Pole");
                                }, isTrue),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                    context,
                                    "8.0 Mtr. Pole",
                                    viewModel.selectedMiddlePolesRequired,
                                    (bool? checked) {
                                  viewModel.setSelectedMiddlePolesRequired(
                                      "8.0 Mtr. Pole");
                                }, isTrue),
                              ),
                            ]),
                            SizedBox(
                              height: doubleTen,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                           const  Text("Stud/Stay Required?"),
                            Row(children: [
                              Expanded(
                                child: multipleCheckbox(context, "Stay Set",
                                    viewModel.selectedStudStayRequired,
                                    (bool? checked) {
                                  viewModel
                                      .setSelectedStudStayRequired("Stay Set");
                                }, isTrue),
                              ),
                              Expanded(
                                child: multipleCheckbox(context, "Stud Pole",
                                    viewModel.selectedStudStayRequired,
                                    (bool? checked) {
                                  viewModel
                                      .setSelectedStudStayRequired("Stud Pole");
                                }, isTrue),
                              ),
                            ]),
                            const SizedBox(
                              height: doubleTen,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const Text("Insulators/Discs Required?"),
                            Row(children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Type",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      DropdownButtonFormField<String>(
                                        value:
                                            viewModel.selectedInsulatorDiscType,
                                        hint: const Text("Select"),
                                        isExpanded: true,
                                        items: viewModel.insulatorDiscType
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) => viewModel
                                            .onListInsulatorDiscType(newValue),
                                      ),
                                    ]),
                              ),
                              const SizedBox(width: doubleTen),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.2,
                              ),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Qty",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      DropdownButtonFormField<String>(
                                        value:
                                            viewModel.selectedInsulatorDiscQty,
                                        hint: const Text("Select"),
                                        isExpanded: true,
                                        items: viewModel.insulatorDiscQty
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          viewModel
                                              .onListInsulatorDiscType(
                                              newValue);
                                        }
                                      ),
                                    ]),
                              ),
                            ]),
                            const SizedBox(
                              height: doubleTen,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const Text("Cross Arm Status?"),
                            Row(children: [
                              Expanded(
                                child: multipleCheckbox(context, "Good",
                                    viewModel.selectedCrossArmStatus,
                                    (bool? checked) {
                                  viewModel.setSelectedCrossArmStatus("Good");
                                }, isTrue),
                              ),
                              Expanded(
                                child: multipleCheckbox(context, "Bad",
                                    viewModel.selectedCrossArmStatus,
                                    (bool? checked) {
                                  viewModel.setSelectedCrossArmStatus("Bad");
                                }, isTrue),
                              ),
                            ]),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const SizedBox(
                              height: doubleTen,
                            ),
                            Container(color:Colors.brown[200], child:const Center(child: Text("DTR Details",style: TextStyle(fontSize: toolbarTitleSize),))),
                            const SizedBox(height: doubleTen,),
                            const  Text("AB Switch Exists?"),
                            Row(children: [

                              Expanded(
                                child: Column(
                                  children: [

                                    multipleCheckbox(
                                      context,
                                      "NO",
                                      viewModel.selectedABSwitch,
                                          (bool? checked) {
                                        viewModel.setSelectedABSwitch(
                                            "NO");
                                      },
                                      isTrue,
                                    ),


                                    multipleCheckbox(
                                      context,
                                      "Yes, But bad condition",
                                      viewModel.selectedABSwitch,
                                          (bool? checked) {
                                        viewModel.setSelectedABSwitch(
                                            "Yes, But bad condition");
                                      },
                                      isTrue,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Yes(Good Condition)",
                                  viewModel.selectedABSwitch,
                                      (bool? checked) {
                                    viewModel.setSelectedABSwitch(
                                        "Yes(Good Condition)");
                                  },
                                  isTrue,
                                ),
                              ),
                            ]
                            ),

                            const SizedBox(height: doubleTen,),
                            const  Text("LT Fuse Set Exists?"),
                            Row(children: [

                              Expanded(
                                child: Column(
                                  children: [

                                    multipleCheckbox(
                                      context,
                                      "NO",
                                      viewModel.selectedLTFuse,
                                          (bool? checked) {
                                        viewModel.setSelectedLTFuse(
                                            "NO");
                                      },
                                      isTrue,
                                    ),


                                    multipleCheckbox(
                                      context,
                                      "Yes, But bad condition",
                                      viewModel.selectedLTFuse,
                                          (bool? checked) {
                                        viewModel.setSelectedLTFuse(
                                            "Yes, But bad condition");
                                      },
                                      isTrue,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Yes(Good Condition)",
                                  viewModel.selectedLTFuse,
                                      (bool? checked) {
                                    viewModel.setSelectedLTFuse(
                                        "Yes(Good Condition)");
                                  },
                                  isTrue,
                                ),
                              ),
                            ]
                            ),

                            const SizedBox(height: doubleTen,),
                            const  Text("HT Fuse Set Exists?"),
                            Row(children: [

                              Expanded(
                                child: Column(
                                  children: [

                                    multipleCheckbox(
                                      context,
                                      "NO",
                                      viewModel.selectedHTFuse,
                                          (bool? checked) {
                                        viewModel.setSelectedHTFuse(
                                            "NO");
                                      },
                                      isTrue,
                                    ),


                                    multipleCheckbox(
                                      context,
                                      "Yes, But bad condition",
                                      viewModel.selectedHTFuse,
                                          (bool? checked) {
                                        viewModel.setSelectedHTFuse(
                                            "Yes, But bad condition");
                                      },
                                      isTrue,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Yes(Good Condition)",
                                  viewModel.selectedHTFuse,
                                      (bool? checked) {
                                    viewModel.setSelectedHTFuse(
                                        "Yes(Good Condition)");
                                  },
                                  isTrue,
                                ),
                              ),
                            ]
                            ),

                            const SizedBox(height: doubleTen,),
                            const  Text("DTR Plinth Exists?"),
                            Row(children: [

                              Expanded(
                                child: Column(
                                  children: [

                                    multipleCheckbox(
                                      context,
                                      "NO",
                                      viewModel.selectedDTRPlinth,
                                          (bool? checked) {
                                        viewModel.setSelectedDTRPlinth(
                                            "NO");
                                      },
                                      isTrue,
                                    ),


                                    multipleCheckbox(
                                      context,
                                      "Yes, But bad condition",
                                      viewModel.selectedDTRPlinth,
                                          (bool? checked) {
                                        viewModel.setSelectedDTRPlinth(
                                            "Yes, But bad condition");
                                      },
                                      isTrue,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Yes(Good Condition)",
                                  viewModel.selectedDTRPlinth,
                                      (bool? checked) {
                                    viewModel.setSelectedDTRPlinth(
                                        "Yes(Good Condition)");
                                  },
                                  isTrue,
                                ),
                              ),
                            ]
                            ),

                            const SizedBox(height: doubleTen,),
                            const  Text("DTR Earthing"),
                            Row(children: [

                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "G.I Earthing",
                                  viewModel.selectedDTREarth,
                                      (bool? checked) {
                                    viewModel.setSelectedDTREarth(
                                        "G.I Earthing");
                                  },
                                  isTrue,
                                ),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Flat",
                                  viewModel.selectedDTREarth,
                                      (bool? checked) {
                                    viewModel.setSelectedDTREarth(
                                        "Flat");
                                  },
                                  isTrue,
                                ),
                              ),
                            ]
                            ),

                            const SizedBox(height: doubleTen,),
                            const  Text("Earth Pipe Status"),
                            Row(children: [

                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Good",
                                  viewModel.selectedEarthPipe,
                                      (bool? checked) {
                                    viewModel.setSelectedEarthPipe(
                                        "Good");
                                  },
                                  isTrue,
                                ),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Bad",
                                  viewModel.selectedEarthPipe,
                                      (bool? checked) {
                                    viewModel.setSelectedEarthPipe(
                                        "Bad");
                                  },
                                  isTrue,
                                ),
                              ),
                            ]
                            ),

                            const SizedBox(height: doubleTen,),
                            const  Text("Bi - Metalic Clamps Exists"),
                            Row(children: [

                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Yes",
                                  viewModel.selectedBiMetalic,
                                      (bool? checked) {
                                    viewModel.setSelectedBiMetalic(
                                        "Yes");
                                  },
                                  isTrue,
                                ),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "No",
                                  viewModel.selectedBiMetalic,
                                      (bool? checked) {
                                    viewModel.setSelectedBiMetalic(
                                        "No");
                                  },
                                  isTrue,
                                ),
                              ),
                            ]
                            ),

                            const SizedBox(height: doubleTen,),
                            const  Text("Lightening Arrestors Exists?"),
                            Row(children: [

                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "Yes",
                                  viewModel.selectedLighteningArr,
                                      (bool? checked) {
                                    viewModel.setSelectedLighteningArr(
                                        "Yes");
                                  },
                                  isTrue,
                                ),
                              ),
                              Expanded(
                                child: multipleCheckbox(
                                  context,
                                  "No",
                                  viewModel.selectedLighteningArr,
                                      (bool? checked) {
                                    viewModel.setSelectedLighteningArr(
                                        "No");
                                  },
                                  isTrue,
                                ),
                              ),
                            ]
                            ),
                            const Text(
                              "REMARKS",
                            ),
                            TextFormField(
                              maxLines: null,
                              minLines: 5,
                              controller: viewModel.remarksController,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                // labelText: "Enter remarks here",
                                hintText: "Type here...",
                                border: OutlineInputBorder(),
                                alignLabelWithHint: true,
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            const Text("You are at Location coordinates"),
                            Text(
                              "Location Accuracy: ${viewModel.totalAccuracy?.toStringAsFixed(1) ?? "--"} mts / 15.0 mts",
                              style: TextStyle(
                                color: (viewModel.totalAccuracy ?? 100) < 15.0
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
                            viewModel.distanceDisplay == isTrue &&
                                    viewModel.selectedPole == null
                                ? Text(
                                    "Distance from Previous pole to your locations is ${viewModel.distanceBtnPoles} %s mtrs")
                                : const Text(
                                    "Please select source  pole to get distance.",
                                    style: TextStyle(color: Colors.red),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                color: Colors.grey[200],
                                height: 50,
                                child: const Center(
                                    child: Text(
                                  "Network Survey Options",
                                  style: TextStyle(fontSize: doubleFifteen),
                                ))),
                            const SizedBox(
                              height: doubleTen,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                  text: "Save Pole",
                                  onPressed: viewModel.submit33KVForm),
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
            ),
          );
        },
      ),
    );
  }
}

Widget checkbox(BuildContext context, String title, String? selected,
    void Function(String) selectedFunction, bool enabled) {
  return Consumer<Pole11kvFeederMarkViewmodel>(
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
