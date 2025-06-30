import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/viewmodel/check_measure_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class CheckMeasureScreen extends StatelessWidget {
  static const id = Routes.checkMeasureScreen;

  const CheckMeasureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: Text(
            "Select".toUpperCase(),
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
            create: (_) => CheckMeasureViewModel(context: context),
            child: Consumer<CheckMeasureViewModel>(
                builder: (context, viewModel, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(doubleTen),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Choose Line Voltage",
                          style: TextStyle(
                            color: CommonColors.colorPrimary,
                            fontSize: titleSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: doubleTen),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: const Text(
                                  "33KV Line",
                                  style: TextStyle(
                                      fontSize: normalSize,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: viewModel.isSelected("33KV Line"),
                                onChanged: (value) {
                                  viewModel.selectCheckbox("33KV Line");
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: const Text(
                                  "11 KV Line",
                                  style: TextStyle(
                                      fontSize: normalSize,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: viewModel.isSelected("11 KV Line"),
                                onChanged: (value) {
                                  viewModel.selectCheckbox("11 KV Line");
                                },
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: doubleTen),
                            const Text(
                              "Choose Substation",
                              style: TextStyle(
                                color: CommonColors.colorPrimary,
                              ),
                            ),
                            const SizedBox(height: doubleTen),
                            DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text("Select an option"),
                              value: viewModel.listSubStationSelect,
                              items: viewModel.listSubStationItem
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.optionCode,
                                        child: Text(item.optionName!),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                viewModel.onListSubStationItemSelect(value);
                              },
                            ),
                            Text(
                              viewModel.listSubStationSelectBottom ?? "",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: extraRegularSize,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: doubleTen),
                        const Text(
                          "Choose Feeder",
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
                            viewModel.onListFeederItemSelect(value);
                          },
                        ),
                        Text(
                          viewModel.listFeederSelectBottom ?? "",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: extraRegularSize,
                          ),
                        ),
                        const SizedBox(height: doubleTen),
                        const Text(
                          "Choose Check Measure Option",
                          style: TextStyle(
                            color: CommonColors.colorPrimary,
                          ),
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Create New Check Measure Docket",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: normalSize),
                              ),
                              SizedBox(
                                height: doubleTwo,
                              ),
                              Text.rich(
                                TextSpan(
                                  text:
                                      'Choose this option if you want to create a ',
                                  style: TextStyle(fontSize: extraRegularSize),
                                  children: [
                                    TextSpan(
                                      text: 'New Check Measure Session',
                                      style: TextStyle(
                                          fontSize: extraRegularSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          value: viewModel.isPurposeSelected("NCMD"),
                          onChanged: (value) {
                            viewModel.selectPurposeCheckbox("NCMD");
                          },
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Existing Check Measure Docket",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: normalSize),
                              ),
                              SizedBox(
                                height: doubleTwo,
                              ),
                              Text.rich(
                                TextSpan(
                                  text:
                                      'Choose this option if you want to continue with the existing session',
                                  style: TextStyle(fontSize: extraRegularSize),
                                ),
                              ),
                            ],
                          ),
                          value: viewModel.isPurposeSelected("ECMD"),
                          onChanged: (value) {
                            viewModel.selectPurposeCheckbox("ECMD");
                          },
                        ),
                        const Divider(),
                        const SizedBox(height: 20),
                        const Text("Description"),
                        TextFormField(
                          maxLines: null,
                          minLines: 5,
                          readOnly:
                              viewModel.selectedPurposeCheckboxId == "NCMD"
                                  ? false
                                  : true,
                          controller: viewModel.descriptionController,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: "Type here...",
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Estimate Number"),
                        TextFormField(
                          readOnly:
                              viewModel.selectedPurposeCheckboxId == "NCMD"
                                  ? false
                                  : true,
                          controller: viewModel.estimateController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                              text: "PROCEED",
                              onPressed: () {
                                viewModel.proceed();
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              );
            })));
  }
}
