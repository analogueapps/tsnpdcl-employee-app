import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/check_11kv_edit_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';
class CheckMeasure11kvEdit extends StatelessWidget {
  const CheckMeasure11kvEdit({super.key, required this.args});

  static const id = Routes.check11kvScreenEdit;
  final Map<String, dynamic> args;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "11kv feeder mapping".toUpperCase(),
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
        create: (_) => Check11kvEditViewmodel(context: context, args: args),
        child: Consumer<Check11kvEditViewmodel>(
            builder: (context, viewModel, child) {
              return Form(key: viewModel.formKey,
                child:  Stack(children: [
                  Column(
                      children: [
                // Fixed map
                        GestureDetector(
                onTap: (){
                  viewModel.onClickOfMap();
                },
                child:Container(
                color: Colors.grey[200],
                  height: 200,
                  width: double.infinity,
                  child: const Center(child: Text("Google maps here")),
                ),
              ),

                  Expanded(
                      child: viewModel.deleteOrEdit==isFalse?
                      Container():
                      SingleChildScrollView(
                        padding:const EdgeInsets.only(
              right: 10, left: 10, bottom: 30),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewDetailedLcTileWidget(
                  tileKey: "SubStation",
                  tileValue: " ${args["ssc"]}",
                  valueColor: Colors.red,
                ),
                SizedBox(height: doubleTen,),
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
               const SizedBox(height: doubleTen,),

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
                checkbox(
                  context,
                  "Is Extension Pole?",
                  viewModel.isExtensionSelected,
                  viewModel.setSelectedExtension,
                ),

                SizedBox(height: doubleTen,),
                const Text("Pole Number"),
                TextFormField(
                  // maxLines: null,
                  // minLines: 5,
                  controller: viewModel.poleNumber,
                  keyboardType: TextInputType.text,
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
                            "Spun Pole",
                            viewModel.selectedFirstGroup.contains("Spun Pole") ? "Spun Pole" : null,
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
                                .contains("Tower(M+3)")
                                ? "Tower(M+3)"
                                : null,
                                (val) => viewModel.toggleFirstGroup(val),
                          ),
                          checkbox(
                            context,
                            "Tower(M+9)",
                            viewModel.selectedFirstGroup
                                .contains("Tower(M+9)")
                                ? "Tower(M+9)"
                                : null,
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
                            viewModel.selectedSecondGroup
                                .contains("Tubular")
                                ? "Tubular"
                                : null,
                                (val) => viewModel.toggleSecondGroup(val),
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
                            viewModel.selectedFirstGroup
                                .contains("Tower(M+6)")
                                ? "Tower(M+6)"
                                : null,
                                (val) => viewModel.toggleFirstGroup(val),
                          ),
                          checkbox(
                            context,
                            "Tower(M+12)",
                            viewModel.selectedFirstGroup
                                .contains("Tower(M+12)")
                                ? "Tower(M+12)"
                                : null,
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
                              ),
                              multipleCheckbox(
                                context,
                                "Railway crossing",
                                viewModel.selectedCrossings,
                                    (bool? checked) {
                                  viewModel.setSelectedCrossings(
                                      "Railway crossing");
                                },
                              ),
                              multipleCheckbox(
                                context,
                                "Transmission(400KV)",
                                viewModel.selectedCrossings,
                                    (bool? checked) {
                                  viewModel.setSelectedCrossings(
                                      "Transmission(400KV)");
                                },
                              ),
                              multipleCheckbox(
                                context,
                                "Transmission(132KV)",
                                viewModel.selectedCrossings,
                                    (bool? checked) {
                                  viewModel.setSelectedCrossings(
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
                                  viewModel.setSelectedCrossings(
                                      "Road Crossing");
                                },
                              ),
                              multipleCheckbox(
                                context,
                                "Building Crossing",
                                viewModel.selectedCrossings,
                                    (bool? checked) {
                                  viewModel.setSelectedCrossings(
                                      "Building Crossing");
                                },
                              ), multipleCheckbox(
                                context,
                                "Transmission(220KV)",
                                viewModel.selectedCrossings,
                                    (bool? checked) {
                                  viewModel.setSelectedCrossings(
                                      "Transmission(220KV)");
                                },
                              ),
                              multipleCheckbox(
                                context,
                                "Other Common Lines",
                                viewModel.selectedCrossings,
                                    (bool? checked) {
                                  viewModel.setSelectedCrossings(
                                      "Other Common Lines");
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                FillTextFormField(controller: viewModel.particularsOfCrossing, labelText: "Particulars of crossing(Optional)", keyboardType: TextInputType.text),
                const SizedBox(height: 10,),

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
              const SizedBox(height: doubleTen,),
              Text("Select structure code".toUpperCase()),
              DropdownButton<String>(
              value: viewModel.selectedCode,
              hint: Text('Select Structure Code'),
              isExpanded: true,
              items: viewModel.structureCodes.map((code) {
              return DropdownMenuItem(
              value: code,
              child: Text(code),
              );
              }).toList(),
              onChanged: (value) {
              viewModel.selectedCode = value;
              },
              ),
               const Text("Didn't find the Structure code?", style: TextStyle(color:Colors.red, fontWeight: FontWeight.bold),),
                const SizedBox(height: doubleTen,),
                Align(alignment: Alignment.bottomRight,child:SizedBox(width: 150,child: PrimaryButton(onPressed: (){Navigation.instance.navigateTo(
                  Routes.createOnlineDTR,
                );
                  }, text: 'ADD DTR',),),
                ),

                const SizedBox(height: doubleTen),
                const Text("Conductor Size"),
                checkbox(
                  context,
                  "AB Cable",
                  viewModel.abCableSelected ,
                  viewModel.setSelectedabCable ,
                ),
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

                Container(color:Colors.brown[200], child:const Center(child: Text("System Strength Details",style: TextStyle(fontSize: toolbarTitleSize),))),
                const SizedBox(height: doubleTen,),
                Text("Pole Status"),
                multipleCheckbox(
                  context,
                  "Broken",
                  viewModel.selectedPoleStatus,
                      (bool? checked) {
                    viewModel.setSelectedPoleStatus(
                        "Broken");
                  },
                ),
                multipleCheckbox(
                  context,
                  "Leaned",
                  viewModel.selectedPoleStatus,
                      (bool? checked) {
                    viewModel.setSelectedPoleStatus(
                        "Leaned");
                  },
                ),
                multipleCheckbox(
                  context,
                  "Pole Replacement with 9.1Mtr with \n T-Raiser(Road Crossing)",
                  viewModel.selectedPoleStatus,
                      (bool? checked) {
                    viewModel.setSelectedPoleStatus(
                        "Pole Replacement with 9.1Mtr with \n T-Raiser(Road Crossing)");
                  },
                ) ,
                multipleCheckbox(
                  context,
                  "Rusted",
                  viewModel.selectedPoleStatus,
                      (bool? checked) {
                    viewModel.setSelectedPoleStatus(
                        "Rusted");
                  },
                ),
                SizedBox(height: doubleTen,),
                Text("Conductor Status"),
                Row(children: [

                Expanded(
                  child: multipleCheckbox(
                    context,
                    "Damaged",
                    viewModel.selectedConductorStatus,
                        (bool? checked) {
                      viewModel.setSelectedConductorStatus(
                          "Damaged");
                    },
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
                  ),
                ),
                ]
                ),

                ///Change function and selected values from here
                const SizedBox(height: doubleTen,),
                const Text("Middle Poles Required?"),
                Row(children: [
                  Expanded(
                    child: multipleCheckbox(
                      context,
                      "9.1 Mtr. Pole",
                      viewModel.selectedConductorStatus,
                          (bool? checked) {
                        viewModel.setSelectedConductorStatus(
                            "9.1 Mtr. Pole");
                      },
                    ),
                  ),
                  Expanded(
                    child: multipleCheckbox(
                      context,
                      "8.0 Mtr. Pole",
                      viewModel.selectedConductorStatus,
                          (bool? checked) {
                        viewModel.setSelectedConductorStatus(
                            "8.0 Mtr. Pole");
                      },
                    ),
                  ),
                ]
                ),
                SizedBox(height: doubleTen,),
                Text("Stud/Stay Required?"),
                Row(children: [

                  Expanded(
                    child: multipleCheckbox(
                      context,
                      "Stay Set",
                      viewModel.selectedConductorStatus,
                          (bool? checked) {
                        viewModel.setSelectedConductorStatus(
                            "Stay Set");
                      },
                    ),
                  ),
                  Expanded(
                    child: multipleCheckbox(
                      context,
                      "Stud Pole",
                      viewModel.selectedConductorStatus,
                          (bool? checked) {
                        viewModel.setSelectedConductorStatus(
                            "Stud Pole");
                      },
                    ),
                  ),
                ]
                ),
                ///Insulators/Discs Required? need to do
                SizedBox(height: doubleTen,),
                Text("Cross Arm Status?"),
                Row(children: [

                  Expanded(
                    child: multipleCheckbox(
                      context,
                      "Good",
                      viewModel.selectedConductorStatus,
                          (bool? checked) {
                        viewModel.setSelectedConductorStatus(
                            "Good");
                      },
                    ),
                  ),
                  Expanded(
                    child: multipleCheckbox(
                      context,
                      "Bad",
                      viewModel.selectedConductorStatus,
                          (bool? checked) {
                        viewModel.setSelectedConductorStatus(
                            "Bad");
                      },
                    ),
                  ),
                ]
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
                          ),


                         multipleCheckbox(
                            context,
                            "Yes, But bad condition",
                            viewModel.selectedABSwitch,
                                (bool? checked) {
                              viewModel.setSelectedABSwitch(
                                  "Yes, But bad condition");
                            },
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
                        ),


                        multipleCheckbox(
                          context,
                          "Yes, But bad condition",
                          viewModel.selectedLTFuse,
                              (bool? checked) {
                            viewModel.setSelectedLTFuse(
                                "Yes, But bad condition");
                          },
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
                        ),


                        multipleCheckbox(
                          context,
                          "Yes, But bad condition",
                          viewModel.selectedHTFuse,
                              (bool? checked) {
                            viewModel.setSelectedHTFuse(
                                "Yes, But bad condition");
                          },
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
                        ),


                        multipleCheckbox(
                          context,
                          "Yes, But bad condition",
                          viewModel.selectedDTRPlinth,
                              (bool? checked) {
                            viewModel.setSelectedDTRPlinth(
                                "Yes, But bad condition");
                          },
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
                    ),
                  ),
                ]
                ),
                const Text('Remarks'),
                TextField(
                  controller: viewModel.remarks,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),

                const Text("You are at Location coordinates"),
                const SizedBox(height: 10,),
                SizedBox(width: double.infinity,
                  child:PrimaryButton(text: "Update Pole", onPressed: viewModel.submitCheck11KVForm),
                ),
              ]
              ),
                      ),

                  ),
                      ]
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
                ]
                ),
              );
            }
        ),
      ),
    );
  }

  Widget checkbox(BuildContext context, String title, String? selected,
      void Function(String) selectedFunction) {
    return Consumer<Check11kvEditViewmodel>(
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
              style:const TextStyle(fontSize: 12),
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
      onChanged:  onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

}
