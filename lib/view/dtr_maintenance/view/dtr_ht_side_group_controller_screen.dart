import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_ht_side_group_controller_viewmodel.dart';

class DtrHtSideGroupControllerScreen extends StatelessWidget {
  const DtrHtSideGroupControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => DtrHtSideGroupControllerViewmodel(context: context),
        child: Consumer<DtrHtSideGroupControllerViewmodel>(
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
                        value: AbSwitch.available,
                        groupValue: viewModel.abSwitch,
                        onChanged: (AbSwitch? value) {
                          viewModel.selectAbSwitch(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectAbSwitch(AbSwitch.available);
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
                        value: AbSwitch.notAvailable,
                        groupValue: viewModel.abSwitch,
                        onChanged: (AbSwitch? value) {
                          viewModel.selectAbSwitch(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectAbSwitch(AbSwitch.notAvailable);
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
                    visible: viewModel.abSwitch == AbSwitch.available,
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
                              value: AbSwitchType.vertical,
                              groupValue: viewModel.abSwitchType,
                              onChanged: (AbSwitchType? value) {
                                viewModel.selectAbSwitchType(value);
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.selectAbSwitchType(AbSwitchType.vertical);
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
                              value: AbSwitchType.horizontal,
                              groupValue: viewModel.abSwitchType,
                              onChanged: (AbSwitchType? value) {
                                viewModel.selectAbSwitchType(value);
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.selectAbSwitchType(AbSwitchType.horizontal);
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
                            Radio<AbSwitchStatus>(
                              value: AbSwitchStatus.good,
                              groupValue: viewModel.abSwitchStatus,
                              onChanged: (AbSwitchStatus? value) {
                                viewModel.selectAbSwitchStatus(value);
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.selectAbSwitchStatus(AbSwitchStatus.good);
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
                            Radio<AbSwitchStatus>(
                              value: AbSwitchStatus.damage,
                              groupValue: viewModel.abSwitchStatus,
                              onChanged: (AbSwitchStatus? value) {
                                viewModel.selectAbSwitchStatus(value);
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.selectAbSwitchStatus(AbSwitchStatus.damage);
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
                          visible: viewModel.abSwitchStatus == AbSwitchStatus.damage,
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
                        value: AbSwitch.available,
                        groupValue: viewModel.kv11HgFuseSet,
                        onChanged: (AbSwitch? value) {
                          viewModel.selectKv11HgFuseSet(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectKv11HgFuseSet(AbSwitch.available);
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
                        value: AbSwitch.notAvailable,
                        groupValue: viewModel.kv11HgFuseSet,
                        onChanged: (AbSwitch? value) {
                          viewModel.selectKv11HgFuseSet(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectKv11HgFuseSet(AbSwitch.notAvailable);
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
                      Radio<AbSwitchStatus>(
                        value: AbSwitchStatus.good,
                        groupValue: viewModel.hgFuseStatus,
                        onChanged: (AbSwitchStatus? value) {
                          viewModel.selectHgFuseStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHgFuseStatus(AbSwitchStatus.good);
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
                      Radio<AbSwitchStatus>(
                        value: AbSwitchStatus.damage,
                        groupValue: viewModel.hgFuseStatus,
                        onChanged: (AbSwitchStatus? value) {
                          viewModel.selectHgFuseStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHgFuseStatus(AbSwitchStatus.damage);
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
                    visible: viewModel.hgFuseStatus == AbSwitchStatus.damage,
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
                      Radio<AbSwitchStatus>(
                        value: AbSwitchStatus.good,
                        groupValue: viewModel.htBushStatus,
                        onChanged: (AbSwitchStatus? value) {
                          viewModel.selectHtBushStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHtBushStatus(AbSwitchStatus.good);
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
                      Radio<AbSwitchStatus>(
                        value: AbSwitchStatus.damage,
                        groupValue: viewModel.htBushStatus,
                        onChanged: (AbSwitchStatus? value) {
                          viewModel.selectHtBushStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHtBushStatus(AbSwitchStatus.damage);
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
                    visible: viewModel.htBushStatus == AbSwitchStatus.damage,
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
                      Radio<AbSwitchStatus>(
                        value: AbSwitchStatus.good,
                        groupValue: viewModel.htBushRodsStatus,
                        onChanged: (AbSwitchStatus? value) {
                          viewModel.selectHtBushRodsStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHtBushRodsStatus(AbSwitchStatus.good);
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
                      Radio<AbSwitchStatus>(
                        value: AbSwitchStatus.damage,
                        groupValue: viewModel.htBushRodsStatus,
                        onChanged: (AbSwitchStatus? value) {
                          viewModel.selectHtBushRodsStatus(value);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.selectHtBushRodsStatus(AbSwitchStatus.damage);
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
                    visible: viewModel.htBushRodsStatus == AbSwitchStatus.damage,
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
      ),
    );
  }
}
