import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/add_induction_point_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class AddInductionPointScreen extends StatelessWidget {
  static const id = Routes.addInductionPointScreen;
  final Map<String, dynamic> args;

  const AddInductionPointScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Add Induction Point".toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700
              ),
            ),
            Text(
              args['fdrCode'],
              style: const TextStyle(fontSize: normalSize, color: Colors.grey),
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
          create: (_) => AddInductionPointViewModel(context: context),
          child: Consumer<AddInductionPointViewModel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(doubleTen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Choose Induction Source",
                      style: TextStyle(
                        color: CommonColors.colorPrimary,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: doubleTen),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "NO INDUCTION SOURCE",
                        style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
                      ),
                      value: viewModel.isSelected("NO INDUCTION SOURCE"),
                      onChanged: (value) {
                        viewModel.selectCheckbox("NO INDUCTION SOURCE");
                      },
                    ),
                    Visibility(
                      visible: viewModel.isSelected("NO INDUCTION SOURCE"),
                      child: Container(
                        padding: const EdgeInsets.all(doubleFive),
                        color: Colors.grey[200],
                        child: const Text(
                          "You have selected No induction sources for the selected 11kV feeder. Please ensure that the correct induction source is assigned before proceeding",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text(
                              "EHT LINE",
                              style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
                            ),
                            value: viewModel.isSelected("EHT LINE"),
                            onChanged: (value) {
                              viewModel.selectCheckbox("EHT LINE");
                            },
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text(
                              "33KV LINE",
                              style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
                            ),
                            value: viewModel.isSelected("33KV LINE"),
                            onChanged: (value) {
                              viewModel.selectCheckbox("33KV LINE");
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text(
                              "11KV LINE",
                              style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
                            ),
                            value: viewModel.isSelected("11KV LINE"),
                            onChanged: (value) {
                              viewModel.selectCheckbox("11KV LINE");
                            },
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text(
                              "LT LINE",
                              style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
                            ),
                            value: viewModel.isSelected("LT LINE"),
                            onChanged: (value) {
                              viewModel.selectCheckbox("LT LINE");
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Visibility(
                      visible: viewModel.isSelected("33KV LINE"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: doubleTen),
                          const Text(
                            "CHOOSE 220/132KV SS",
                            style: TextStyle(
                              color: CommonColors.colorPrimary,
                            ),
                          ),
                          const SizedBox(height: doubleTen),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select an option"),
                            value: viewModel.list132kVssSelect,
                            items: viewModel.list132kVssItem
                                .map((item) => DropdownMenuItem<String>(
                              value: item.optionCode,
                              child: Text(item.optionName!),
                            ))
                                .toList(),
                            onChanged: (value) {
                              viewModel.onList132kVssValueChange(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewModel.isSelected("33KV LINE"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: doubleTen),
                          const Text(
                            "CHOOSE FEEDER",
                            style: TextStyle(
                              color: CommonColors.colorPrimary,
                            ),
                          ),
                          const SizedBox(height: doubleTen),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select an option"),
                            value: viewModel.list33KvFeederOf132kVssSelect,
                            items: viewModel.list33KvFeederOf132kVssItem
                                .map((item) => DropdownMenuItem<String>(
                              value: item.optionCode,
                              child: Text(item.optionName!),
                            ))
                                .toList(),
                            onChanged: (value) {
                              viewModel.onList33KvFeederOf132kVssValueChange(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewModel.isSelected("11KV LINE") || viewModel.isSelected("LT LINE"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: doubleTen),
                          const Text(
                            "CHOOSE CIRCLE",
                            style: TextStyle(
                              color: CommonColors.colorPrimary,
                            ),
                          ),
                          const SizedBox(height: doubleTen),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select an option"),
                            value: viewModel.listCircleSelect,
                            items: viewModel.listCircleItem
                                .map((item) => DropdownMenuItem<String>(
                              value: item.optionCode,
                              child: Text(item.optionName!),
                            ))
                                .toList(),
                            onChanged: (value) {
                              viewModel.onListCircleValueChange(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewModel.isSelected("11KV LINE") || viewModel.isSelected("LT LINE"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: doubleTen),
                          const Text(
                            "CHOOSE 33/11KV SS",
                            style: TextStyle(
                              color: CommonColors.colorPrimary,
                            ),
                          ),
                          const SizedBox(height: doubleTen),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select an option"),
                            value: viewModel.list33kVSsOfCircleSelect,
                            items: viewModel.list33kVSsOfCircleItem
                                .map((item) => DropdownMenuItem<String>(
                              value: item.optionCode,
                              child: Text(item.optionName!),
                            ))
                                .toList(),
                            onChanged: (value) {
                              viewModel.onList33kVSsOfCircleValueChange(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewModel.isSelected("11KV LINE") || viewModel.isSelected("LT LINE"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: doubleTen),
                          const Text(
                            "CHOOSE FEEDER",
                            style: TextStyle(
                              color: CommonColors.colorPrimary,
                            ),
                          ),
                          const SizedBox(height: doubleTen),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select an option"),
                            value: viewModel.listFeederSelect,
                            items: viewModel.listFeederItem
                                .map((item) => DropdownMenuItem<String>(
                              value: item.optionCode,
                              child: Text(item.optionName!),
                            ))
                                .toList(),
                            onChanged: (value) {
                              viewModel.onListFeederValueChange(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewModel.isSelected("11KV LINE") || viewModel.isSelected("LT LINE"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: doubleTen),
                          const Text(
                            "INTERFERENCE TYPE",
                            style: TextStyle(
                              color: CommonColors.colorPrimary,
                            ),
                          ),
                          const SizedBox(height: doubleTen),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select an option"),
                            value: viewModel.listInterferenceSelect,
                            items: viewModel.listInterferenceItem
                                .map((item) => DropdownMenuItem<String>(
                              value: item.optionCode,
                              child: Text(item.optionName!),
                            ))
                                .toList(),
                            onChanged: (value) {
                              viewModel.onListInterferenceValueChange(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewModel.isSelected("LT LINE"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: doubleTen),
                          const Text(
                            "CHOOSE DTR STRUCTURE",
                            style: TextStyle(
                              color: CommonColors.colorPrimary,
                            ),
                          ),
                          const SizedBox(height: doubleTen),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select an option"),
                            value: viewModel.listDistributionSelect,
                            items: viewModel.listDistributionItem
                                .map((item) => DropdownMenuItem<String>(
                              value: item.optionCode,
                              child: Text(item.optionName!),
                            ))
                                .toList(),
                            onChanged: (value) {
                              viewModel.onListDistributionValueChange(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: doubleTwenty),
                    PrimaryButton(
                        fullWidth: isTrue,
                        text: "SAVE",
                        onPressed: () {
                          viewModel.onSaveClicked(args);
                        }
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
