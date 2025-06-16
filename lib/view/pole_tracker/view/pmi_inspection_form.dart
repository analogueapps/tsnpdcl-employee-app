import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/pmi_inspection_form_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class PmiInspectionForm extends StatelessWidget {
  const PmiInspectionForm({super.key, required this.args});

  static const id = Routes.pmiInspectionForm;
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PmiInspectionFormViewmodel(context: context, args: args),
      child: Consumer<PmiInspectionFormViewmodel>(
          builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CommonColors.colorPrimary,
            title: Text(
              "pmi entry form".toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            actions: [
              viewModel.readOnly
                  ? const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.save_outlined,
                        color: Colors.white,
                      ),
                    )
                  : Icon(null),
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.folder_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: viewModel.readOnly
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('DIGITAL POLE ID')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('9756486'))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('SCHEDULE ID')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('0'))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('PMI ID')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('0'))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('SS CODE')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('11KV'))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('SS CODE')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('0019-33KV SS-AREPALLY'))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('FEEDER CODE')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('0019-01-11KV LAMENSION'))
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'POLE DETAILS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('POLE NUM')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: TextField(
                              controller: viewModel.remarks,
                              decoration: const InputDecoration(
                                label: Text('POLE NUM')
                              ),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('POLE CONDITION')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                              child: Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedPoleCondition,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.poleConditionList
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setPoleCondition(newValue!);
                              },
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'LINE SPAN DETAILS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE SPAN')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                              child: Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedLineSpan,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.lineSpanList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setLineSpan(newValue!);
                              },
                            ),
                          ))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE PASSING OVER')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                              child: Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedLinePassing,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items:
                                  viewModel.linePassingList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setLinePassing(newValue!);
                              },
                            ),
                          ))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(
                              child: Text('OTHER CABLES EXISTS ON POLE')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                              child: Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedCableOnPole,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items:
                                  viewModel.cableOnPoleList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setCableOnPole(newValue!);
                              },
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'STAY & STRUT CONDITION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('STAY CONDITION')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                              child: Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedStayCondition,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.stayConditionList
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setStayCondition(newValue!);
                              },
                            ),
                          ))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('STRUT CONDITION')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                              child: Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedStrutCondition,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.strutConditionList
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setStrutCondition(newValue!);
                              },
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'CROSS ARM DETAILS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('X-ARM')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                              child: Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedArm,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.xArmList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setArm(newValue!);
                              },
                            ),
                          ))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('TOP CLEAT')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedTopCleat,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.topCleatList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setTopCleat(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('INSULATORS')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedInsulator,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items:
                                  viewModel.insulatorsList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setInsulators(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(
                              child: Text('CLEARANCE FROM TREE BRANCHES')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedTreeBranchClearance,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.treeBranchClearance
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setTreeBranchClearance(newValue!);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'BINDING AND JUMPERING',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('PIN BINDING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedPinBinding,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items:
                                  viewModel.pinBindingList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setPinBinding(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('JUMPERING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedJumpering,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items:
                                  viewModel.jumperingList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setJumpering(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('EARTHING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedEarthing,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.earthingList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setEarthing(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE AB SWITCH')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedLineSwitch,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items:
                                  viewModel.lineSwitchList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setLineSwitch(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE LAs')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedLineLa,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.lineLaList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setLineLa(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE CAPACITORS')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedLineCapacitor,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.lineCapacitorsList
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setLineCapacitor(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('DOUBLE/MULTI CIRCUIT')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedMultiCircuit,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.multiCircuitList
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setMultiCircuit(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'LINE TO LINE CROSSING',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE TO LINE CROSSING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedLineToLine,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items:
                                  viewModel.lineToLineList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setLineToLine(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('ROAD CROSSING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedRoadCrossing,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.roadCrossingList
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setRoadCrossing(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('WATER LOGGED AREA')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedWater,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.waterList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setWater(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(
                              child: Text('STATUS OF ADJACENT LINES')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: viewModel.selectedStatus,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: viewModel.statusList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.setStatus(newValue!);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      TextField(
                        controller: viewModel.remarks,
                        decoration: const InputDecoration(
                            label: Text('REMARKS (If any)')
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'BEFORE RECTIFICATION PHOTO',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: viewModel.capturedImage == null
                            ? const Icon(Icons.image, size: 50)
                            : Image.file(
                          viewModel.capturedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          color: Colors.orange,
                          child: const Align(
                              child: Text(
                                'CAPTURE PHOTO',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        onTap: (){
                          viewModel.captureImage();
                        },
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(
                              child: Text('BEFORE LONGITUDE')),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: TextField(
                              controller: viewModel.remarks,
                              decoration: const InputDecoration(
                                  label: Text('')
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(
                              child: Text('BEFORE LONGITUDE')),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: TextField(
                              controller: viewModel.remarks,
                              decoration: const InputDecoration(
                                  label: Text('')
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('DIGITAL POLE ID')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('9756486'))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('SCHEDULE ID')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('0'))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('PMI ID')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('0'))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('SS CODE')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('11KV'))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('SS CODE')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('0019-33KV SS-AREPALLY'))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('FEEDER CODE')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('0019-01-11KV LAMENSION'))
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'INSPECTED BY DETAILS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('EMP ID')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('OFFICER NAME')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('DESIGNATION')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('DATE OF INSPECTION')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('')),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'POLE DETAILS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('POLE NUM')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('POLE CONDITION')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('')),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'LINE SPAN DETAILS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE SPAN')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE PASSING OVER')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(
                              child: Text('OTHER CABLES EXISTS ON POLE')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('')),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'STAY & STRUT CONDITION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('STAY CONDITION')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('STRUT CONDITION')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('')),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'CROSS ARM DETAILS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('X-ARM')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('TOP CLEAT')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('INSULATORS')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(
                              child: Text('CLEARANCE FROM TREE BRANCHES')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('')),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'BINDING AND JUMPERING',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('PIN BINDING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('JUMPERING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('EARTHING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE AB SWITCH')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE LAs')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE CAPACITORS')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('')),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('DOUBLE/MULTI CIRCUIT')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('')),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'LINE TO LINE CROSSING',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('LINE TO LINE CROSSING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('ROAD CROSSING')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('WATER LOGGED AREA')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text(''))
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(
                              child: Text('STATUS OF ADJACENT LINES')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('')),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('REMARKS')),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Expanded(child: Text('')),
                        ],
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.grey.shade300,
                        child: const Align(
                            child: Text(
                          'BEFORE RECTIFICATION PHOTO',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: Icon(Icons.image),
                      ),
                      const SizedBox(
                        height: 11,
                      ),

                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('BEFORE RECTIFICATION'))
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: viewModel.changeReadOnlyStatus,
            backgroundColor: Colors.pinkAccent,
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }
}

// Form(
// child: Column(
// children: viewModel.formControls.map((control) {
// return Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// if (control.headerBar != null)
// Container(
// color: viewModel.hexToColor(control.headerBar!.backGroundColor),
// padding: EdgeInsets.all(8.0),
// child: Text(
// control.headerBar!.label,
// style: TextStyle(
// color: viewModel.hexToColor(control.headerBar!.labelColor),
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// viewModel.buildFormField(control),
// SizedBox(height: 16.0),
// ],
// );
// }).toList(),
// ),
// ),
