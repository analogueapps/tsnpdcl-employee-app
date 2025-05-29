import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart' ;
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/check_33KV_viewmodel.dart' ;
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart' ;
import 'package:tsnpdcl_employee/widget/primary_button.dart' ;
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart' ;

class CheckMeasure33kv extends StatelessWidget {
  const CheckMeasure33kv({super.key, required this.args});
  static const id = Routes.check33kvScreen;
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "Check 33kv".toUpperCase(),
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
        create: (_)=>Check33kvViewmodel(context:context , args : args),
        child: Consumer<Check33kvViewmodel>(
            builder: (context,viewModel,child){
              return Form(
                key: viewModel.formKey,
                child:Stack(
                  children: [
                    Column(
                      children: [
                        // Fixed map
                        InkWell(
                          child: Container(
                            color: Colors.grey[200],
                            height: 200,
                            width: double.infinity,
                            child: const Center(child: Text("Google maps here")),
                          ),
                          onTap: (){
                            viewModel.showDialogueCopyPoleNum;
                          },
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
                                const Divider(color: Colors.grey,thickness: 0.2,),
                                ViewDetailedLcTileWidget(
                                  tileKey: "Feeder",
                                  tileValue: " ${args["fc"]}",
                                  valueColor: Colors.green,
                                ),


                                Column(
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
                                            viewModel.selectedPoleFeeder != null
                                                ? (viewModel.selectedPoleFeeder!.tempSeries != null &&
                                                viewModel.selectedPoleFeeder!.tempSeries!.isNotEmpty
                                                ? '${viewModel.selectedPoleFeeder!.tempSeries}-${viewModel.selectedPoleFeeder!.poleNum}'
                                                : viewModel.selectedPoleFeeder!.poleNum ?? '')
                                                : 'Tap to select',
                                          ),
                                        ),
                                      ),
                                    ]),
                                const SizedBox(height: 10,),
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
                                const Divider(color: Colors.grey,thickness: 0.2,),
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
                                            viewModel.selectedFirstGroup.contains("Tower(M+9)") ? "Tower(M+9)" : null,
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
                                            viewModel.selectedFirstGroup.contains("Tubular") ? "Tubular" : null,
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
                                            viewModel.selectedFirstGroup.contains("Tower(M+6)") ? "Tower(M+6)" : null,
                                                (val) => viewModel.toggleFirstGroup(val),
                                          ),
                                          checkbox(
                                            context,
                                            "Tower(M+12)",
                                            viewModel.selectedFirstGroup.contains("Tower(M+12)") ? "Tower(M+12)" : null,
                                                (val) => viewModel.toggleFirstGroup(val),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.grey,thickness: 0.2,),
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
                                const Divider(color: Colors.grey,thickness: 0.2,),
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
                                const Divider(color: Colors.grey,thickness: 0.2,),
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
                                const Divider(color: Colors.grey,thickness: 0.2,),
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
                                const Center(child:Text("Pole Details"),),
                                const Divider(color: Colors.grey,thickness: 0.2,),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Cross Arm", style: TextStyle(color: Colors.grey, fontSize: doubleTwelve),),
                                    Text("QTY", style: TextStyle(color: Colors.grey, fontSize: doubleTwelve),)
                                  ],),
                                Column(
                                  children: viewModel.poleItems.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final item = entry.value;
                                    return checkAndDrop(
                                      context,
                                      item.title,
                                      item.isSelected,
                                          () => viewModel.toggleSelection(index),
                                      item.selectedQty?.toString(),
                                          (newValue) => viewModel.updatePoleQtyForItem(newValue, index),
                                    );
                                  }).toList(),
                                ),
                                const Divider(color: Colors.grey,thickness: 0.2,),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Insulators", style: TextStyle(color: Colors.grey, fontSize: doubleTwelve),),
                                    Text("QTY", style: TextStyle(color: Colors.grey, fontSize: doubleTwelve),)
                                  ],),
                                Column(
                                  children: viewModel.poleInsulators.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final item = entry.value;
                                    return checkAndDrop(
                                      context,
                                      item.title,
                                      item.isSelected,
                                          () => viewModel.toggleInsulators(index),
                                      item.selectedQty?.toString(),
                                          (newValue) => viewModel.updatePoleInsulators(newValue, index),
                                    );
                                  }).toList(),
                                ),
                                const Divider(color: Colors.grey,thickness: 0.2,),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Support Type", style: TextStyle(color: Colors.grey, fontSize: doubleTwelve),),
                                    Text("QTY", style: TextStyle(color: Colors.grey, fontSize: doubleTwelve),)
                                  ],),
                                Column(
                                  children: viewModel.poleSupport.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final item = entry.value;
                                    return checkAndDrop(
                                      context,
                                      item.title,
                                      item.isSelected,
                                          () => viewModel.toggleSupport(index),
                                      item.selectedQty?.toString(),
                                          (newValue) => viewModel.updatePoleSupport(newValue, index),
                                    );
                                  }).toList(),
                                ),
                                const Divider(color: Colors.grey,thickness: 0.2,),
                                const Text("Any Crossing?"),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                      "Transmission(220KV)");
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
                                const SizedBox(height: 10,),
                                //Particulars of crossing(Optional)
                                FillTextFormField(controller: viewModel.particularsOfCrossing, labelText: "Particulars of crossing(Optional)", keyboardType: TextInputType.text),
                                const SizedBox(height: 10,),
                                const Divider(color: Colors.grey,thickness: 0.2,),
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
                                    ),checkbox(
                                      context,
                                      "HT Services",
                                      viewModel.selectedConnected,
                                      viewModel.setSelectedConnected,
                                    ),
                                  ],
                                ),
                                Visibility(
                                    visible: viewModel.selectedConnected == "Sub Station",
                                    child: Column(
                                      children: [
                                        SizedBox(height: 11,),
                                        const Divider(color: Colors.grey,thickness: 0.2,),
                                        SizedBox(height: 11,),
                                        Text('Choose Sub Station'),
                                        Container(
                                          width: double.infinity, // or fixed width
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: DropdownButton<SpinnerList>(
                                            isExpanded: true,
                                            hint: const Text("Select a substation"),
                                            value: viewModel.selectedSubstation,
                                            items: viewModel.substationList.map((substation) {
                                              return DropdownMenuItem<SpinnerList>(
                                                value: substation,
                                                child: Text(substation?.optionName ?? 'Unnamed'),
                                              );
                                            }).toList(),
                                            onChanged: (SpinnerList? newValue) {
                                              viewModel.onSubstationChange(newValue);
                                            },
                                            underline: Container(), // Remove default underline
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Visibility(
                                    visible: viewModel.selectedConnected == "HT Services",
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 11,),
                                        const Divider(color: Colors.grey,thickness: 0.2,),
                                        SizedBox(height: 11,),
                                        Text('Choose Service'),
                                        DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text("Select an option"),
                                          value: viewModel.selectedHtServiceName,
                                          items: viewModel.htServiceNames.map((item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              child: Text('${item}'),
                                            );
                                          }).toList(),
                                          onChanged: (htServiceName) {
                                            viewModel.onHtServiceChange(htServiceName);
                                          },
                                        ),
                                      ],
                                    )
                                ),

                                SizedBox(height: 11,),
                                const Divider(color: Colors.grey,thickness: 0.2,),
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
                  ],
                ) ,
              );
            }
        ),
      ),
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
    return Consumer<Check33kvViewmodel>(
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
  Widget checkbox(BuildContext context, String title, String? selected,
      void Function(String) selectedFunction, ) {
    return Consumer<Check33kvViewmodel>(
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