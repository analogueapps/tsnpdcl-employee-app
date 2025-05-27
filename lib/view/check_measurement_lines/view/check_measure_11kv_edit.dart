import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/check_11kv_edit_viewmodel.dart';
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

}
