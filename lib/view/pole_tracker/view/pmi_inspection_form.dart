import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/pmi_model.dart';
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
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
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
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
              actions: [
                viewModel.readOnly != true
                    ? const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.save_outlined,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(null),
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
                ? Stack(children: [
                    ListView.builder(
                        itemCount: viewModel.rowItems.length,
                        itemBuilder: (context, index) {
                          final data = viewModel.rowItems[index];
                          return data == null
                              ? const Center(child: Text("No data found"))
                              : Column(
                                  children: [
                                    data.headerBar != null
                                        ? ViewDetailedLcHeadWidget(
                                            title: data.headerBar?.label ??
                                                "PHOTO")
                                        : const SizedBox.shrink(),
                                    data.headerBar?.label ==
                                            "BEFORE RECTIFICATION PHOTO"
                                        ? const SizedBox(
                                            height: 200,
                                            width: double.infinity,
                                            child: Icon(Icons.image),
                                          )
                                        : const Text(""),
                                    data.label != ""
                                        ? ViewDetailedLcTileWidget(
                                            tileKey: data.label ?? "",
                                            tileValue: data.value ?? "")
                                        : const Text(""),
                                    const Divider(),
                                  ],
                                );
                        }),
                    if (viewModel.isLoading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          // Optional: dim background
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                  ])
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(child: Text('DIGITAL POLE ID')),
                            Expanded(
                                child: Text(args['digitalPoleId'].toString())),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Expanded(child: Text('SCHEDULE ID')),
                            Expanded(
                                child: Text(args['scheduleId'].toString())),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Expanded(child: Text('VOLTAGE')),
                            Expanded(child: Text(args['voltage'].toString())),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Expanded(child: Text('SS CODE')),
                            Expanded(child: Text(args['ssc'])),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Expanded(child: Text('FEEDER CODE')),
                            Expanded(child: Text(args['fc'])),
                          ],
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.formControls.length,
                            itemBuilder: (context, index) {
                              final control = viewModel.formControls[index];

                              // Skip ones already handled above
                              if (control.label == "DIGITAL POLE ID" ||
                                  control.label == "SCHEDULE ID") {
                                return const SizedBox.shrink();
                              }

                              return viewModel.entryForm(control, viewModel);
                            }),
                        const SizedBox(height: 20),
                        TextField(
                          controller: viewModel.remarks,
                          decoration: const InputDecoration(
                            label: Text('REMARKS (If any)'),
                          ),
                        ),
                        const SizedBox(height: 11),
                        Container(
                          width: double.infinity,
                          height: 40,
                          color: Colors.grey.shade300,
                          child: const Align(
                            child: Text(
                              'BEFORE RECTIFICATION PHOTO',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: viewModel.capturedImage == null
                              ? const Icon(Icons.image, size: 50)
                              : Image.file(viewModel.capturedImage!,
                                  fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 11),
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            color: Colors.orange,
                            child: const Align(
                              child: Text(
                                'CAPTURE PHOTO',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () {
                            viewModel.captureImage();
                          },
                        ),
                        const SizedBox(height: 11),
                        Row(
                          children: [
                            const SizedBox(width: 3),
                            const Expanded(child: Text('BEFORE LONGITUDE')),
                            Container(height: 30, width: 1, color: Colors.grey),
                            const SizedBox(width: 3),
                            Expanded(
                              child: TextField(
                                controller: viewModel.remarks,
                                decoration:
                                    const InputDecoration(label: Text('')),
                              ),
                            ),
                          ],
                        ),
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
          ),
        );
      }),
    );
  }
}

//  Container(
//    width: double.infinity,
//    height: 40,
//    color: Colors.grey.shade300,
//    child: const Align(
//        child: Text(
//      'POLE DETAILS',
//      style: TextStyle(fontWeight: FontWeight.bold),
//    )),
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Row(
//    children: [
//      const Expanded(child: Text('POLE NUM')),
//      Expanded(
//        child: TextField(
//          controller: viewModel.poleNumber,
//          decoration: const InputDecoration(
//            label: Text('POLE NUM')
//          ),
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('POLE CONDITION')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//          child: Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedPoleCondition,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.poleConditionList
//              .map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setPoleCondition(newValue!);
//          },
//        ),
//      )),
//    ],
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Container(
//    width: double.infinity,
//    height: 40,
//    color: Colors.grey.shade300,
//    child: const Align(
//        child: Text(
//      'LINE SPAN DETAILS',
//      style: TextStyle(fontWeight: FontWeight.bold),
//    )),
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('LINE SPAN')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//          child: Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedLineSpan,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.lineSpanList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setLineSpan(newValue!);
//          },
//        ),
//      ))
//    ],
//  ),
// SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('LINE PASSING OVER')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//          child: Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedLinePassing,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items:
//              viewModel.linePassingList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setLinePassing(newValue!);
//          },
//        ),
//      ))
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(
//          child: Text('OTHER CABLES EXISTS ON POLE')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//          child: Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedCableOnPole,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items:
//              viewModel.cableOnPoleList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setCableOnPole(newValue!);
//          },
//        ),
//      )),
//    ],
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Container(
//    width: double.infinity,
//    height: 40,
//    color: Colors.grey.shade300,
//    child: const Align(
//        child: Text(
//      'STAY & STRUT CONDITION',
//      style: TextStyle(fontWeight: FontWeight.bold),
//    )),
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('STAY CONDITION')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//          child: Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedStayCondition,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.stayConditionList
//              .map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setStayCondition(newValue!);
//          },
//        ),
//      ))
//    ],
//  ),
// SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('STRUT CONDITION')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//          child: Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedStrutCondition,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.strutConditionList
//              .map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setStrutCondition(newValue!);
//          },
//        ),
//      )),
//    ],
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Container(
//    width: double.infinity,
//    height: 40,
//    color: Colors.grey.shade300,
//    child: const Align(
//        child: Text(
//      'CROSS ARM DETAILS',
//      style: TextStyle(fontWeight: FontWeight.bold),
//    )),
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('X-ARM')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//          child: Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedArm,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.xArmList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setArm(newValue!);
//          },
//        ),
//      ))
//    ],
//  ),
// SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('TOP CLEAT')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedTopCleat,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.topCleatList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setTopCleat(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('INSULATORS')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedInsulator,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items:
//              viewModel.insulatorsList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setInsulators(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(
//          child: Text('CLEARANCE FROM TREE BRANCHES')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedTreeBranchClearance,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.treeBranchClearance
//              .map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setTreeBranchClearance(newValue!);
//          },
//        ),
//      ),
//    ],
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Container(
//    width: double.infinity,
//    height: 40,
//    color: Colors.grey.shade300,
//    child: const Align(
//        child: Text(
//      'BINDING AND JUMPERING',
//      style: TextStyle(fontWeight: FontWeight.bold),
//    )),
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('PIN BINDING')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedPinBinding,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items:
//              viewModel.pinBindingList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setPinBinding(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('JUMPERING')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedJumpering,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items:
//              viewModel.jumperingList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setJumpering(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('EARTHING')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedEarthing,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.earthingList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setEarthing(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('LINE AB SWITCH')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedLineSwitch,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items:
//              viewModel.lineSwitchList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setLineSwitch(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('LINE LAs')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedLineLa,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.lineLaList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setLineLa(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('LINE CAPACITORS')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedLineCapacitor,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.lineCapacitorsList
//              .map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setLineCapacitor(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('DOUBLE/MULTI CIRCUIT')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedMultiCircuit,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.multiCircuitList
//              .map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setMultiCircuit(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Container(
//    width: double.infinity,
//    height: 40,
//    color: Colors.grey.shade300,
//    child: const Align(
//        child: Text(
//      'LINE TO LINE CROSSING',
//      style: TextStyle(fontWeight: FontWeight.bold),
//    )),
//  ),
//  const SizedBox(
//    height: 11,
//  ),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('LINE TO LINE CROSSING')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedLineToLine,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items:
//              viewModel.lineToLineList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setLineToLine(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('ROAD CROSSING')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedRoadCrossing,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.roadCrossingList
//              .map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setRoadCrossing(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(child: Text('WATER LOGGED AREA')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedWater,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.waterList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setWater(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
//  SizedBox(height: 20,),
//  Row(
//    children: [
//      const SizedBox(
//        width: 3,
//      ),
//      const Expanded(
//          child: Text('STATUS OF ADJACENT LINES')),
//
//      const SizedBox(
//        width: 3,
//      ),
//      Expanded(
//        child: DropdownButton<String>(
//          value: viewModel.selectedStatus,
//          isExpanded: true,
//          hint: Text("select".toUpperCase()),
//          items: viewModel.statusList.map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (newValue) {
//            viewModel.setStatus(newValue!);
//          },
//        ),
//      )
//    ],
//  ),
