import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_request_indent_entity.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/forward_or_reject_indent_dialog_viewmodel.dart';

class ForwardOrRejectIndentDialog extends StatelessWidget {
  final PoleRequestIndentEntity poleRequestIndentEntity;
  final Function(PoleRequestIndentEntity poleRequestIndentEntity) onActionTaken;

  const ForwardOrRejectIndentDialog({
    super.key,
    required this.poleRequestIndentEntity,
    required this.onActionTaken,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "FORWARD OR REJECT INDENT".toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ForwardOrRejectIndentDialogViewModel(
            context: context, poleRequestIndentEntity: poleRequestIndentEntity),
        child: Consumer<ForwardOrRejectIndentDialogViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(doubleTen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Choose Option",
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: doubleTen),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Forward Indent",
                            style: TextStyle(
                                fontSize: normalSize,
                                fontWeight: FontWeight.w500),
                          ),
                          value: viewModel.isSelected("Forward Indent"),
                          onChanged: (value) {
                            viewModel.selectCheckbox("Forward Indent");
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Reject Indent",
                            style: TextStyle(
                                fontSize: normalSize,
                                fontWeight: FontWeight.w500),
                          ),
                          value: viewModel.isSelected("Reject Indent"),
                          onChanged: (value) {
                            viewModel.selectCheckbox("Reject Indent");
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(0.7),
                      1: FlexColumnWidth(0.3),
                    },
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: doubleEight),
                            child: Text(
                              "Indent Quantity",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: doubleEight),
                              child: Text(
                                checkNull(viewModel
                                    .poleRequestIndentEntity.requestedQty
                                    .toString()),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: doubleEight),
                            child: Text(
                              "Balance Quantity",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: doubleEight),
                              child: Text(
                                checkNull(viewModel
                                    .poleRequestIndentEntity.balanceQty
                                    .toString()),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: doubleEight),
                            child: Text(
                              "AE/OD Recommended Qty",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: doubleEight),
                              child: Text(
                                checkNull(viewModel
                                    .poleRequestIndentEntity.aeOdRecommendedQty
                                    .toString()),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  const Text(
                    "Financial Year",
                  ),
                  const SizedBox(height: doubleTen),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("Select an option"),
                    value: viewModel.fysSelect,
                    items: viewModel.fys
                        .map((item) => DropdownMenuItem<String>(
                              value: item.optionCode,
                              child: Text(item.optionName!),
                            ))
                        .toList(),
                    onChanged: (value) {
                      viewModel.onListFysValueChange(value);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
