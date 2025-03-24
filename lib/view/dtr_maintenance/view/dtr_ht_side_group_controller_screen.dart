import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/ht_side_group_model.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_ht_side_group_controller_viewmodel.dart';

class DtrHtSideGroupControllerScreen extends StatelessWidget {
  const DtrHtSideGroupControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Consumer<DtrHtSideGroupControllerViewmodel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(doubleFive),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                    child: Text(
                      "AB SWITCH",
                      style: TextStyle(
                        fontSize: doubleThirteen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Radio<AbSwitch>(
                        value: AbSwitch.Available,
                        groupValue: viewModel.abSwitch,
                        onChanged: (AbSwitch? value) {
                          viewModel.selectAbSwitch(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectAbSwitch(AbSwitch.Available);
                        },
                        child: const Text(
                          "Available",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<AbSwitch>(
                        value: AbSwitch.NotAvailable,
                        groupValue: viewModel.abSwitch,
                        onChanged: (AbSwitch? value) {
                          viewModel.selectAbSwitch(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectAbSwitch(AbSwitch.NotAvailable);
                        },
                        child: const Text(
                          "Not Available",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  Visibility(
                    visible: viewModel.abSwitch == AbSwitch.Available,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                          child: Text(
                            "AB Switch Type",
                            style: TextStyle(
                              fontSize: doubleThirteen,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Radio<AbSwitchType>(
                              value: AbSwitchType.Vertical,
                              groupValue: viewModel.abSwitchType,
                              onChanged: (AbSwitchType? value) {
                                viewModel.selectAbSwitchType(value);
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.selectAbSwitchType(AbSwitchType.Vertical);
                              },
                              child: const Text(
                                "Vertical",
                                style: TextStyle(
                                  fontSize: doubleThirteen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio<AbSwitchType>(
                              value: AbSwitchType.Horizontal,
                              groupValue: viewModel.abSwitchType,
                              onChanged: (AbSwitchType? value) {
                                viewModel.selectAbSwitchType(value);
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.selectAbSwitchType(AbSwitchType.Horizontal);
                              },
                              child: const Text(
                                "Horizontal",
                                style: TextStyle(
                                  fontSize: doubleThirteen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                          child: Text(
                            "AB Switch Status",
                            style: TextStyle(
                              fontSize: doubleThirteen,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Radio<Status>(
                              value: Status.Good,
                              groupValue: viewModel.abSwitchStatus,
                              onChanged: (Status? value) {
                                viewModel.selectAbSwitchStatus(value);
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.selectAbSwitchStatus(Status.Good);
                              },
                              child: const Text(
                                "Good",
                                style: TextStyle(
                                  fontSize: doubleThirteen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio<Status>(
                              value: Status.Damaged,
                              groupValue: viewModel.abSwitchStatus,
                              onChanged: (Status? value) {
                                viewModel.selectAbSwitchStatus(value);
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.selectAbSwitchStatus(Status.Damaged);
                              },
                              child: const Text(
                                "Damaged/Not Working",
                                style: TextStyle(
                                  fontSize: doubleThirteen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        Visibility(
                          visible: viewModel.abSwitchStatus == Status.Damaged,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                                child: Text(
                                  "Damaged Components",
                                  style: TextStyle(
                                    fontSize: doubleThirteen,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    flex: numThree,
                                    child: Text(
                                      "Contacts Damaged",
                                      style: TextStyle(
                                        fontSize: doubleThirteen,
                                        color: CommonColors.deepRed,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: doubleFive,),
                                  Expanded(
                                    flex: numTwo,
                                    child: DropdownButton<String>(
                                      value: viewModel.spinnerAbSwitchContactsDamagedValue,
                                      hint: const Text("SELECT"),
                                      items: viewModel.spinnerAbSwitchContactsDamaged!.options.map((option) {
                                        return DropdownMenuItem<String>(
                                          value: option.optionId,
                                          child: Text(option.optionName!),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        viewModel.spinnerAbSwitchContactsDamagedValueSelected(value);
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    flex: numThree,
                                    child: Text(
                                      "Brass Strip/Copper pig tail damaged",
                                      style: TextStyle(
                                        fontSize: doubleThirteen,
                                        color: CommonColors.deepRed,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: doubleFive,),
                                  Expanded(
                                    flex: numTwo,
                                    child: DropdownButton<String>(
                                      value: viewModel.spinnerAbSwitchPigTailDamagedValue,
                                      hint: const Text("SELECT"),
                                      items: viewModel.spinnerAbSwitchPigTailDamaged!.options.map((option) {
                                        return DropdownMenuItem<String>(
                                          value: option.optionId,
                                          child: Text(option.optionName!),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        viewModel.spinnerAbSwitchPigTailDamagedValueSelected(value);
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    flex: numThree,
                                    child: Text(
                                      "Nylon bush damaged",
                                      style: TextStyle(
                                        fontSize: doubleThirteen,
                                        color: CommonColors.deepRed,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: doubleFive,),
                                  Expanded(
                                    flex: numTwo,
                                    child: DropdownButton<String>(
                                      value: viewModel.spinnerAbSwitchNylonBushesDamagedValue,
                                      hint: const Text("SELECT"),
                                      items: viewModel.spinnerAbSwitchNylonBushesDamaged!.options.map((option) {
                                        return DropdownMenuItem<String>(
                                          value: option.optionId,
                                          child: Text(option.optionName!),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        viewModel.spinnerAbSwitchNylonBushesDamagedValueSelected(value);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: CommonColors.colorPrimary,
                    thickness: doubleOne,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                    child: Text(
                      "11 KV HG FUSE SET",
                      style: TextStyle(
                        fontSize: doubleThirteen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Radio<AbSwitch>(
                        value: AbSwitch.Available,
                        groupValue: viewModel.kv11HgFuseSet,
                        onChanged: (AbSwitch? value) {
                          viewModel.selectKv11HgFuseSet(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectKv11HgFuseSet(AbSwitch.Available);
                        },
                        child: const Text(
                          "Available",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<AbSwitch>(
                        value: AbSwitch.NotAvailable,
                        groupValue: viewModel.kv11HgFuseSet,
                        onChanged: (AbSwitch? value) {
                          viewModel.selectKv11HgFuseSet(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectKv11HgFuseSet(AbSwitch.NotAvailable);
                        },
                        child: const Text(
                          "Not Available",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                    child: Text(
                      "HG Fuse set Status",
                      style: TextStyle(
                        fontSize: doubleThirteen,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Radio<Status>(
                        value: Status.Good,
                        groupValue: viewModel.hgFuseStatus,
                        onChanged: (Status? value) {
                          viewModel.selectHgFuseStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHgFuseStatus(Status.Good);
                        },
                        child: const Text(
                          "Good",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<Status>(
                        value: Status.Damaged,
                        groupValue: viewModel.hgFuseStatus,
                        onChanged: (Status? value) {
                          viewModel.selectHgFuseStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHgFuseStatus(Status.Damaged);
                        },
                        child: const Text(
                          "Damaged",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: viewModel.hgFuseStatus == Status.Damaged,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                          child: Text(
                            "Damaged Components",
                            style: TextStyle(
                              fontSize: doubleThirteen,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: numThree,
                              child: Text(
                                "Horns to be replaced",
                                style: TextStyle(
                                  fontSize: doubleThirteen,
                                  color: CommonColors.deepRed,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: doubleFive,),
                            Expanded(
                              flex: numTwo,
                              child: DropdownButton<String>(
                                value: viewModel.spinner11HgFsHornsToReplacedValue,
                                hint: const Text("SELECT"),
                                items: viewModel.spinner11HgFsHornsToReplaced!.options.map((option) {
                                  return DropdownMenuItem<String>(
                                    value: option.optionId,
                                    child: Text(option.optionName!),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  viewModel.spinner11HgFsHornsToReplacedValueSelected(value);
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: numThree,
                              child: Text(
                                "Gap is not correct",
                                style: TextStyle(
                                  fontSize: doubleThirteen,
                                  color: CommonColors.deepRed,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: doubleFive,),
                            Expanded(
                              flex: numTwo,
                              child: DropdownButton<String>(
                                value: viewModel.spinner11HgFsGapNotCorrectValue,
                                hint: const Text("SELECT"),
                                items: viewModel.spinner11HgFsGapNotCorrect!.options.map((option) {
                                  return DropdownMenuItem<String>(
                                    value: option.optionId,
                                    child: Text(option.optionName!),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  viewModel.spinner11HgFsGapNotCorrectValueSelected(value);
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: numThree,
                              child: Text(
                                "Post type insulators damaged",
                                style: TextStyle(
                                  fontSize: doubleThirteen,
                                  color: CommonColors.deepRed,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: doubleFive,),
                            Expanded(
                              flex: numTwo,
                              child: DropdownButton<String>(
                                value: viewModel.spinner11HgFsPostTypeInsulatorsDamagedValue,
                                hint: const Text("SELECT"),
                                items: viewModel.spinner11HgFsPostTypeInsulatorsDamaged!.options.map((option) {
                                  return DropdownMenuItem<String>(
                                    value: option.optionId,
                                    child: Text(option.optionName!),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  viewModel.spinner11HgFsPostTypeInsulatorsDamagedValueSelected(value);
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: CommonColors.colorPrimary,
                    thickness: doubleOne,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                    child: Text(
                      "HT BUSHES",
                      style: TextStyle(
                        fontSize: doubleThirteen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                    child: Text(
                      "HT Bush Status",
                      style: TextStyle(
                        fontSize: doubleThirteen,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Radio<Status>(
                        value: Status.Good,
                        groupValue: viewModel.htBushStatus,
                        onChanged: (Status? value) {
                          viewModel.selectHtBushStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHtBushStatus(Status.Good);
                        },
                        child: const Text(
                          "Good",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<Status>(
                        value: Status.Damaged,
                        groupValue: viewModel.htBushStatus,
                        onChanged: (Status? value) {
                          viewModel.selectHtBushStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHtBushStatus(Status.Damaged);
                        },
                        child: const Text(
                          "Damaged",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: viewModel.htBushStatus == Status.Damaged,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                          child: Text(
                            "Damaged Components",
                            style: TextStyle(
                              fontSize: doubleThirteen,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: numThree,
                              child: Text(
                                "HT Bush Damaged Qty",
                                style: TextStyle(
                                  fontSize: doubleThirteen,
                                  color: CommonColors.deepRed,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: doubleFive,),
                            Expanded(
                              flex: numTwo,
                              child: DropdownButton<String>(
                                value: viewModel.spinnerHtBushDamagedQtyValue,
                                hint: const Text("SELECT"),
                                items: viewModel.spinnerHtBushDamagedQty!.options.map((option) {
                                  return DropdownMenuItem<String>(
                                    value: option.optionId,
                                    child: Text(option.optionName!),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  viewModel.spinnerHtBushDamagedQtyValueSelected(value);
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: CommonColors.colorPrimary,
                    thickness: doubleOne,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                    child: Text(
                      "HT BUSH RODS",
                      style: TextStyle(
                        fontSize: doubleThirteen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                    child: Text(
                      "HT Bush Rods Status",
                      style: TextStyle(
                        fontSize: doubleThirteen,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Radio<Status>(
                        value: Status.Good,
                        groupValue: viewModel.htBushRodsStatus,
                        onChanged: (Status? value) {
                          viewModel.selectHtBushRodsStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHtBushRodsStatus(Status.Good);
                        },
                        child: const Text(
                          "Good",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<Status>(
                        value: Status.Damaged,
                        groupValue: viewModel.htBushRodsStatus,
                        onChanged: (Status? value) {
                          viewModel.selectHtBushRodsStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHtBushRodsStatus(Status.Damaged);
                        },
                        child: const Text(
                          "Damaged",
                          style: TextStyle(
                            fontSize: doubleThirteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: viewModel.htBushRodsStatus == Status.Damaged,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: doubleFive, bottom: doubleFive),
                          child: Text(
                            "Damaged Components",
                            style: TextStyle(
                              fontSize: doubleThirteen,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: numThree,
                              child: Text(
                                "HT Bush Rods Damaged Qty",
                                style: TextStyle(
                                  fontSize: doubleThirteen,
                                  color: CommonColors.deepRed,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: doubleFive,),
                            Expanded(
                              flex: numTwo,
                              child: DropdownButton<String>(
                                value: viewModel.spinnerHtBushRodsDamagedQtyValue,
                                hint: const Text("SELECT"),
                                items: viewModel.spinnerHtBushRodsDamagedQty!.options.map((option) {
                                  return DropdownMenuItem<String>(
                                    value: option.optionId,
                                    child: Text(option.optionName!),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  viewModel.spinnerHtBushRodsDamagedQtyValueSelected(value);
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: doubleTwenty,),
                ],
              ),
            );
          },
        ),
    );
  }
}
