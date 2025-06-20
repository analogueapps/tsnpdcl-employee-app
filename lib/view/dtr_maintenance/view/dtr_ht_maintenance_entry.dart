import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/ht_side_group_model.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_ht_maintenance_entry_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_image_widget.dart';

class DtrHtMaintenanceEntry extends StatelessWidget {
  const DtrHtMaintenanceEntry({super.key, required this.data, required this.selectedOption});
  final String data;
  final String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => DtrHtMaintenanceEntryViewmodel( data),
        child:Consumer<DtrHtMaintenanceEntryViewmodel>(
          builder: (context, viewModel, child) {
            return  _buildGroupWidgets(selectedOption);
          },
        ),
      ),
    );
  }
}

Widget _buildGroupWidgets(String? optionId) {
  switch (optionId) {
    case "HT_SIDE":
      return  Consumer<DtrHtMaintenanceEntryViewmodel>(
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
                      onChanged: viewModel.isAbSwitchDisabled
                          ? null // disables the radio button
                          : (AbSwitch? value) {
                        viewModel.selectAbSwitch(value);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    GestureDetector(
                      onTap: viewModel.isAbSwitchDisabled
                          ? null // disables the radio button
                          : () {
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
                      onChanged: viewModel.isAbSwitchDisabled
                          ? null // disables the radio button
                          : (AbSwitch? value) {
                        viewModel.selectAbSwitch(value);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    GestureDetector(
                      onTap: viewModel.isAbSwitchDisabled
                          ? null // disables the radio button
                          : () {
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
                        padding: EdgeInsets.only(
                            top: doubleFive, bottom: doubleFive),
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
                            onChanged: viewModel.isAbSwitchTypeDisabled
                                ? null // disables the radio button
                                : (AbSwitchType? value) {
                              viewModel.selectAbSwitchType(value);
                            },
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,
                          ),
                          GestureDetector(
                            onTap: viewModel.isAbSwitchTypeDisabled
                                ? null // disables the radio button
                                : () {
                              viewModel.selectAbSwitchType(
                                  AbSwitchType.Vertical);
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
                            onChanged: viewModel.isAbSwitchTypeDisabled
                                ? null // disables the radio button
                                : (AbSwitchType? value) {
                              viewModel.selectAbSwitchType(value);
                            },
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,
                          ),
                          GestureDetector(
                            onTap: viewModel.isAbSwitchTypeDisabled
                                ? null // disables the radio button
                                : () {
                              viewModel.selectAbSwitchType(
                                  AbSwitchType.Horizontal);
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
                        padding: EdgeInsets.only(
                            top: doubleFive, bottom: doubleFive),
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
                            onChanged: viewModel.isAbSwitchStatusDisabled
                                ? null // disables the radio button
                                : (Status? value) {
                              viewModel.selectAbSwitchStatus(value);
                            },
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,
                          ),
                          GestureDetector(
                            onTap: viewModel.isAbSwitchStatusDisabled
                                ? null // disables the radio button
                                : () {
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
                            onChanged: viewModel.isAbSwitchStatusDisabled
                                ? null // disables the radio button
                                : (Status? value) {
                              viewModel.selectAbSwitchStatus(value);
                            },
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,
                          ),
                          GestureDetector(
                            onTap: viewModel.isAbSwitchStatusDisabled
                                ? null // disables the radio button
                                : () {
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
                              padding: EdgeInsets.only(
                                  top: doubleFive, bottom: doubleFive),
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
                                  flex: numTwo,
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
                                    value: viewModel
                                        .spinnerAbSwitchContactsDamagedValue,
                                    hint: const Text("SELECT"),
                                    items: viewModel
                                        .spinnerAbSwitchContactsDamaged!.options
                                        .map((option) {
                                      return DropdownMenuItem<String>(
                                        value: option.optionId,
                                        child: Text(option.optionName!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      viewModel
                                          .spinnerAbSwitchContactsDamagedValueSelected(
                                          value);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  flex: numTwo,
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
                                    value: viewModel
                                        .spinnerAbSwitchPigTailDamagedValue,
                                    hint: const Text("SELECT"),
                                    items: viewModel
                                        .spinnerAbSwitchPigTailDamaged!.options
                                        .map((option) {
                                      return DropdownMenuItem<String>(
                                        value: option.optionId,
                                        child: Text(option.optionName!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      viewModel
                                          .spinnerAbSwitchPigTailDamagedValueSelected(
                                          value);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  flex: numTwo,
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
                                    value: viewModel
                                        .spinnerAbSwitchNylonBushesDamagedValue,
                                    hint: const Text("SELECT"),
                                    items: viewModel
                                        .spinnerAbSwitchNylonBushesDamaged!
                                        .options.map((option) {
                                      return DropdownMenuItem<String>(
                                        value: option.optionId,
                                        child: Text(option.optionName!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      viewModel
                                          .spinnerAbSwitchNylonBushesDamagedValueSelected(
                                          value);
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
                      onChanged: viewModel.isKv11HgFuseSetDisabled
                          ? null // disables the radio button
                          : (AbSwitch? value) {
                        viewModel.selectKv11HgFuseSet(value);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    GestureDetector(
                      onTap: viewModel.isKv11HgFuseSetDisabled
                          ? null // disables the radio button
                          : () {
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
                      onChanged: viewModel.isKv11HgFuseSetDisabled
                          ? null // disables the radio button
                          : (AbSwitch? value) {
                        viewModel.selectKv11HgFuseSet(value);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    GestureDetector(
                      onTap: viewModel.isKv11HgFuseSetDisabled
                          ? null // disables the radio button
                          : () {
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
                      onChanged: viewModel.isHgFuseStatusDisabled
                          ? null // disables the radio button
                          : (Status? value) {
                        viewModel.selectHgFuseStatus(value);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    GestureDetector(
                      onTap: viewModel.isHgFuseStatusDisabled
                          ? null // disables the radio button
                          : () {
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
                      onChanged: viewModel.isHgFuseStatusDisabled
                          ? null // disables the radio button
                          : (Status? value) {
                        viewModel.selectHgFuseStatus(value);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    GestureDetector(
                      onTap: viewModel.isHgFuseStatusDisabled
                          ? null // disables the radio button
                          : () {
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
                        padding: EdgeInsets.only(
                            top: doubleFive, bottom: doubleFive),
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
                            flex: numTwo,
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
                              value: viewModel
                                  .spinner11HgFsHornsToReplacedValue,
                              hint: const Text("SELECT"),
                              items: viewModel.spinner11HgFsHornsToReplaced!
                                  .options.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option.optionId,
                                  child: Text(option.optionName!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                viewModel
                                    .spinner11HgFsHornsToReplacedValueSelected(
                                    value);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: numTwo,
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
                              items: viewModel.spinner11HgFsGapNotCorrect!
                                  .options.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option.optionId,
                                  child: Text(option.optionName!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                viewModel
                                    .spinner11HgFsGapNotCorrectValueSelected(
                                    value);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: numTwo,
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
                              value: viewModel
                                  .spinner11HgFsPostTypeInsulatorsDamagedValue,
                              hint: const Text("SELECT"),
                              items: viewModel
                                  .spinner11HgFsPostTypeInsulatorsDamaged!
                                  .options.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option.optionId,
                                  child: Text(option.optionName!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                viewModel
                                    .spinner11HgFsPostTypeInsulatorsDamagedValueSelected(
                                    value);
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
                        padding: EdgeInsets.only(
                            top: doubleFive, bottom: doubleFive),
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
                            flex: numTwo,
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
                              items: viewModel.spinnerHtBushDamagedQty!.options
                                  .map((option) {
                                return DropdownMenuItem<String>(
                                  value: option.optionId,
                                  child: Text(option.optionName!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                viewModel.spinnerHtBushDamagedQtyValueSelected(
                                    value);
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
                        padding: EdgeInsets.only(
                            top: doubleFive, bottom: doubleFive),
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
                            flex: numTwo,
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
                              items: viewModel.spinnerHtBushRodsDamagedQty!
                                  .options.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option.optionId,
                                  child: Text(option.optionName!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                viewModel
                                    .spinnerHtBushRodsDamagedQtyValueSelected(
                                    value);
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                ViewDetailedLcImageWidget(imageUrl: checkNull(
                    viewModel.dtrInspectionSheetEntity
                        ?.beforeMaintenanceImage)),
                const SizedBox(height: doubleTwenty,),
              ],
            ),
          );
        }
      );
      
      
      
      
      
      
      
      
      
      
      
      

    case "LT_SIDE"  :
      return Consumer<DtrHtMaintenanceEntryViewmodel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(doubleFive),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("LT BUSHES"),
                  Divider(),
                  radioGroupWidget(
                 "LT Bushes Status", Status.Good,Status.Damaged,"Good", "Damaged", viewModel.ltBushStatus, viewModel.isLtBushStatusDisabled, (value) => viewModel.selectLtBushStatus(value),
              ),
                  radioGroupWidget(
                    "LT Bushes Rods", Status.Good,Status.Damaged,"Good", "Damaged", viewModel.ltBushRodStatus, viewModel.isLtBushRodStatusDisabled, (value) => viewModel.selectLtRodBushStatus(value),
                  ),
                  // const Text("LT Bushes Status", style: TextStyle(color:Colors.grey),),
                  radioGroupWidget(
                    "LT- BI Metalic clamps ", AbSwitch.Available,AbSwitch.NotAvailable,"Available", "Not Available", viewModel.ltBiMetalicClamps, viewModel.isLtBiMetalicClampsDisabled, (value) => viewModel.selectLtBiMetalicClamps(value),
                  ),
                  radioGroupWidget(
                    "Clamps Status", Status.Good,Status.Damaged,"Good", "Damaged", viewModel.clampsStatus, viewModel.isClampsStatusDisabled, (value) => viewModel.selectClampsStatus(value),
                  ),
                  radioGroupWidget(
                    "LT Breaker", AbSwitch.Available,AbSwitch.NotAvailable,"Available", "Not Available", viewModel.ltBreaker, viewModel.isLtBreakerDisabled, (value) => viewModel.selectLtBreaker(value),
                  ),
                  radioGroupWidget(
                    "LT Breaker Status", Status.Good,Status.Damaged,"Good", "Damaged", viewModel.ltBreakerStatus, viewModel.isLtBreakerStatusDisabled, (value) => viewModel.selectLtBreakerStatus(value),
                  ),
                  radioGroupWidget(
                    "LT Fuse Set",  AbSwitch.Available,AbSwitch.NotAvailable,"Available", "Not Available", viewModel.ltFuseSet, viewModel.isLtFuseSetDisabled, (value) => viewModel.selectLtFuseSet(value),
                  ),
                  radioGroupWidget(
                    "LT Fuse Set Status",  Status.Good,Status.Damaged,"Good", "Damaged", viewModel.ltFuseSetStatus, viewModel.isLtFuseSetStatusDisabled, (value) => viewModel.selectLtFuseSetStatus(value),
                  ),
                  radioGroupWidget(
                    "LT Fuse Wire",  FuseWire.Copper,FuseWire.Aluminium,"Copper", "Aluminium", viewModel.ltFuseWire, viewModel.isLtFuseWireDisabled, (value) => viewModel.selectLtFuseWireStatus(value),
                  ),
                  radioGroupWidget(
                    "Copper fuse wire status",  WireStatus.OK,WireStatus.NotOK,"Ok", "Not Ok", viewModel.cfwStatus, viewModel.isCfwStatusDisabled, (value) => viewModel.selectCfwStatus(value),
                  ),
                  radioGroupWidget(
                    "LT PVC Cable", AbSwitch.Available,AbSwitch.NotAvailable,"Available", "Not Available", viewModel.ltPvcCable, viewModel.isLtPvcCableDisabled, (value) => viewModel.selectLtPvcCable(value),
                  ),
                  radioGroupWidget(
                    "LT PVC Cable Status", Status.Good,Status.Damaged,"Good", "Damaged", viewModel.ltPvcCableStatus, viewModel.isLtPvcCableStatusDisabled, (value) => viewModel.selectLtPvcCableStatus(value),
                  ),
                  Text("Before Maintenance Image"),
                  ViewDetailedLcImageWidget(imageUrl: checkNull(
                      viewModel.dtrInspectionSheetEntity
                          ?.beforeMaintenanceImage)),
                ],
              ),
            );
          }
      );

    case "OIL":
      return Consumer<DtrHtMaintenanceEntryViewmodel>(
  builder: (context, viewModel, child) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(doubleFive),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              radioGroupWidget(
                "Oil level".toUpperCase(), OilLevel.Ok,OilLevel.Shortage,"OK", "Shortage", viewModel.oilLevelValue, viewModel.isOilLevelDisabled, (value) => viewModel.selectOilLevelStatus(value),
              ),
              radioGroupWidget(
                "Oil leakage".toUpperCase(), OilLeak.LeakedArrested,OilLeak.NotRectified,"Leakage Arrested", "Not Rectified", viewModel.oilLeakValue, viewModel.isOilLeakDisabled, (value) => viewModel.selectOilLeakStatus(value),
              ),
              radioGroupWidget(
                "Gaskets".toUpperCase(), Gaskets.Rectified_Replaced,Gaskets.NotRectified,"Rectified/Replaced", "Not Rectified", viewModel.gasketsValue, viewModel.isGasketsDisabled, (value) => viewModel.selectGasketsStatus(value),
              ),
              radioGroupWidget(
                "Diaphragm".toUpperCase(), Gaskets.Rectified_Replaced,Gaskets.NotRectified,"Rectified/Replaced", "Not Rectified", viewModel.diaphragm, viewModel.isDiaphragmDisabled, (value) => viewModel.selectDiaphragm(value),
              ),
              radioGroupWidget(
                "Diaphragm Status".toUpperCase(), Status.Good,Status.Damaged,"Good", "Damaged", viewModel.diaphragmStatus, viewModel.isDiaphragmStatusDisabled, (value) => viewModel.selectDiaphragmStatus(value),
              ),

              const Text("Before Maintenance Image"),
              ViewDetailedLcImageWidget(imageUrl: checkNull(
                  viewModel.dtrInspectionSheetEntity
                      ?.beforeMaintenanceImage)),

            ])
    );
  }
      );

    case "EARTHING"  :
      return Consumer<DtrHtMaintenanceEntryViewmodel>(
  builder: (context, viewModel, child) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(doubleFive),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Earth pipes".toUpperCase()),
              Divider(),
              Row(
              children: [
              Row(
                children: [
                  Radio<EarthPits>(
                    value: EarthPits.one,
                    groupValue: viewModel.earthPits,
                    onChanged: viewModel.isEarthPitsDisabled ? null : (EarthPits? value){
                      viewModel.selectEarthPitsStatus(value);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  GestureDetector(
                    onTap: viewModel.isEarthPitsDisabled ? null : () { viewModel.selectEarthPitsStatus(EarthPits.one);},
                    child: const Text(
                      "1",
                      style:  TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<EarthPits>(
                    value: EarthPits.two,
                    groupValue: viewModel.earthPits,
                    onChanged: viewModel.isEarthPitsDisabled ? null : (EarthPits? value){
                      viewModel.selectEarthPitsStatus(value);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  GestureDetector(
                    onTap: viewModel.isEarthPitsDisabled ? null : () { viewModel.selectEarthPitsStatus(EarthPits.two);},
                    child: const Text(
                      "2",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

                Row(
                children: [
                  Radio<EarthPits>(
                    value: EarthPits.three,
                    groupValue: viewModel.earthPits,
                    onChanged: viewModel.isEarthPitsDisabled ? null : (EarthPits? value){
                      viewModel.selectEarthPitsStatus(value);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  GestureDetector(
                    onTap: viewModel.isEarthPitsDisabled ? null : () { viewModel.selectEarthPitsStatus(EarthPits.three);},
                    child: const Text(
                      "3",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              ]
              ),
              const Divider(),
              radioGroupWidget(
                "Earth pipes".toUpperCase(), EarthPipes.GIPipes,EarthPipes.CIPipes,"GI Pipes", "CI Pipes", viewModel.earthPips, viewModel.isEarthPipsDisabled, (value) => viewModel.selectEarthPipsStatus(value),
              ),
              radioGroupWidget(
                "Earth pipes Status".toUpperCase(), Gaskets.Rectified,Gaskets.NotRectified,"Rectified", "Not Rectified", viewModel.earthPipeStatus, viewModel.isEarthPipeStatusDisabled, (value) => viewModel.selectEarthPipeStatusStatus(value),
              ),
              radioGroupWidget(
                "Earthing".toUpperCase(), Gaskets.Rectified,Gaskets.NotRectified,"Rectified", "Not Rectified", viewModel.earthing, viewModel.isEarthingDisabled, (value) => viewModel.selectEarthingStatus(value),
              ),
              radioGroupWidget(
                "Double Earthing".toUpperCase(), AbSwitch.Available,AbSwitch.NotAvailable,"Available", "Not Available", viewModel.doubleEarthing, viewModel.isDoubleEarthingDisabled, (value) => viewModel.selectDoubleEarthingStatus(value),
              ),
              const Text("Before Maintenance Image"),
              ViewDetailedLcImageWidget(imageUrl: checkNull(
                  viewModel.dtrInspectionSheetEntity
                      ?.beforeMaintenanceImage)),
            ]
        )
    );
  }
      );

    case "LT_NETWORK"  :
      return Consumer<DtrHtMaintenanceEntryViewmodel>(
  builder: (context, viewModel, child) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(doubleFive),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              radioGroupWidget(
                "LT loose lines on dtr".toUpperCase(),
                NoLooseLine.NoLooseLines,
                NoLooseLine.LooseLines,
                "No Loose Lines",
                "Loose Lines",
                viewModel.looseLinesONDtr,
                viewModel.isLooseLinesONDtrDisabled, (value) =>
                  viewModel.selectLooseLinesONDtrStatus(value),
              ),
              radioGroupWidget(
                "LT Line tree cutting".toUpperCase(),
                LTLineTreeCutting.NotRequired,
                LTLineTreeCutting.Required,
                "Not Required",
                "Required",
                viewModel.linesTreeCutting,
                viewModel.isLinesTreeCuttingDisabled, (value) =>
                  viewModel.selectLinesTreeCuttingStatus(value),
              ),
              radioGroupWidget(
                "LT Line other rectifications".toUpperCase(),
                Gaskets.NotRectified,
                Gaskets.Rectified,
                "Not Rectified",
                "Rectified",
                viewModel.lineOtherRect,
                viewModel.isLineOtherRectDisabled, (value) =>
                  viewModel.selectLineOtherRectStatus(value),
              ),
              const Text("Before Maintenance Image"),
              ViewDetailedLcImageWidget(imageUrl: checkNull(
                  viewModel.dtrInspectionSheetEntity
                      ?.beforeMaintenanceImage)),
            ]
        )
    );
  }
  );

    case "LA"  :
      return Consumer<DtrHtMaintenanceEntryViewmodel>(
  builder: (context, viewModel, child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(doubleFive),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            radioGroupWidget(
              "Lightning arrestors".toUpperCase(),
              AbSwitch.Available,
              AbSwitch.NotAvailable,
              "Available",
              "Not Available",
              viewModel.lightingArrestors,
              viewModel.isLightingArrestorsDisabled, (value) =>
                viewModel.selectLightingArrestorsStatus(value),
            ),
            radioGroupWidget(
              "Lightning arrestors status".toUpperCase(),
              Gaskets.Rectified,
              Gaskets.NotRectified,
              "Rectified",
              "NOt Rectified",
              viewModel.lightingArrStatus,
              viewModel.isLightingArrStatusDisabled, (value) =>
                viewModel.selectLightingArrStatus(value),
            ),
          ]
      ),
    );
  }
      );

    case "DTR_LOADING"  :
      return Consumer<DtrHtMaintenanceEntryViewmodel>(
  builder: (context, viewModel, child) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(doubleFive),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DTR Loading"),
              radioGroupWidget(
                "Over Loaded?".toUpperCase(),
                DTROverLoaded.NotOverLoaded,
                DTROverLoaded.OverLoaded,
                "Not Over Loaded",
                "Over Loaded",
                viewModel.dtrOverLoaded,
                viewModel.isDtrOverLoadedDisabled, (value) =>
                  viewModel.selectDtrOverLoadedStatus(value),
              ),
            ]
        )
    );
  }
      );

    case "TONG"  :
      return Consumer<DtrHtMaintenanceEntryViewmodel>(
  builder: (context, viewModel, child) {
    return Padding(padding:const EdgeInsets.all(doubleTen),child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tong Tester Readings".toUpperCase()),
            const Divider(),
            Row(children: [
              Text("R-Phase", style: TextStyle(color:Colors.red),),
              SizedBox(width: doubleTen,),
              Expanded(child: TextField(controller: viewModel.rPhase,
                decoration: const InputDecoration(
                labelText: 'AMPS',
                border: OutlineInputBorder(),
              ),
              ),
              ),
            ],),
            SizedBox(height: doubleTen,),
            Row(children: [
              Text("Y-Phase", style: TextStyle(color:Colors.red),),
              SizedBox(width: doubleTen,),
              Expanded(child: TextField(controller: viewModel.yPhase,
                decoration: const InputDecoration(
                  labelText: 'AMPS',
                  border: OutlineInputBorder(),
                ),
              )),
            ],),
            SizedBox(height: doubleTen,),
            Row(children: [
              Text("B-Phase", style: TextStyle(color:Colors.red),),
              SizedBox(width: doubleTen,),
              Expanded(child: TextField(controller: viewModel.bPhase,
                decoration: const InputDecoration(
                  labelText: 'AMPS',
                  border: OutlineInputBorder(),
                ),
              )),
            ],),
            SizedBox(height: doubleTen,),
            Row(children: [
              Text("Neutral  ", style: TextStyle(color:Colors.red),),
              SizedBox(width: doubleTen,),
              Expanded(child: TextField(controller: viewModel.neutral,
                decoration: const InputDecoration(
                  labelText: 'AMPS',
                  border: OutlineInputBorder(),
                ),
              )),
            ],),
          ]
    ),
      );
  }
      );

    default:
      return const SizedBox();

  }
}

Widget radioGroupWidget<T>(
final String title,
final T value1,
final T value2,
final String label1,
final String label2,
final T? groupValue,
final bool isDisabled,
final void Function(T?) onChanged  ){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0), // use your `doubleFive` if defined
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13.0, // use your `doubleThirteen` if defined
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const Divider(),
      Row(
        children: [
          Radio<T>(
            value: value1,
            groupValue: groupValue,
            onChanged: isDisabled ? null : onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          GestureDetector(
            onTap: isDisabled ? null : () => onChanged(value1),
            child: Text(
              label1,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Radio<T>(
            value: value2,
            groupValue: groupValue,
            onChanged: isDisabled ? null : onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          GestureDetector(
            onTap: isDisabled ? null : () => onChanged(value2),
            child: Text(
              label2,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      const Divider(),
    ],
  );
}