import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/add_induction_point_viewmodel.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/pole_tracker_selection_view_sketch_viewmodel.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/pole_tracker_selection_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class PoleTrackerSelectionScreen extends StatelessWidget {
  static const id = Routes.poleTrackerSelectionScreen;

  const PoleTrackerSelectionScreen({
    super.key,
  });

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
              fontWeight: FontWeight.w700
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => PoleTrackerSelectionViewModel(context: context),
        child: Consumer<PoleTrackerSelectionViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(doubleTen),
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
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            "33KV Line",
                            style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
                          ),
                          value: viewModel.isSelected("33KV Line"),
                          onChanged: (value) {
                            viewModel.selectCheckbox("33KV Line");
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            "11 KV Line",
                            style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
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
                  const Divider(),
                  const Text(
                    "Choose Purpose(*)",
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
                          "New Feeder Proposal",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: normalSize),
                        ),
                        SizedBox(height: doubleTwo,),
                        Text.rich(
                          TextSpan(
                            text: 'Choose this option if you want to create a ',
                            style: TextStyle(fontSize: extraRegularSize),
                            children: [
                              TextSpan(
                                text: 'New/Extension Line Proposal',
                                style: TextStyle(fontSize: extraRegularSize, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' sketch',
                                style: TextStyle(fontSize: extraRegularSize),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    value: viewModel.isPurposeSelected("NFP"),
                    onChanged: (value) {
                      viewModel.selectPurposeCheckbox("NFP");
                    },
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Line Extension Work",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: normalSize),
                        ),
                        SizedBox(height: doubleTwo,),
                        Text.rich(
                          TextSpan(
                            text: 'Choose this option for Line extension proposal on Existing Line',
                            style: TextStyle(fontSize: extraRegularSize),
                          ),
                        ),
                      ],
                    ),
                    value: viewModel.isPurposeSelected("LEW"),
                    onChanged: (value) {
                      viewModel.selectPurposeCheckbox("LEW");
                    },
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Digital Existing Feeder",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: normalSize),
                        ),
                        SizedBox(height: doubleTwo,),
                        Text.rich(
                          TextSpan(
                            text: 'Choose this option if you want to digitise the ',
                            style: TextStyle(fontSize: extraRegularSize),
                            children: [
                              TextSpan(
                                text: 'Existing Feeder',
                                style: TextStyle(fontSize: extraRegularSize, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    value: viewModel.isPurposeSelected("DEF"),
                    onChanged: (value) {
                      viewModel.selectPurposeCheckbox("DEF");
                    },
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                  Visibility(
                    visible: viewModel.isPurposeSelected("NFP") || viewModel.isPurposeSelected("LEW"),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: doubleTen),
                        const Divider(),
                        const Text(
                          "Choose Proposal Option",
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
                                "Create New Proposal",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: normalSize),
                              ),
                              SizedBox(height: doubleTwo,),
                              Text(
                                'Choose this option if you want to create New Proposal Now',
                                style: TextStyle(fontSize: extraRegularSize),
                              ),
                            ],
                          ),
                          value: viewModel.isProposalSelected("CNP"),
                          onChanged: (value) {
                            viewModel.selectProposalCheckbox("CNP");
                          },
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Existing Proposal",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: normalSize),
                              ),
                              SizedBox(height: doubleTwo,),
                              Text(
                                'Choose this option if you want to modify the sketch under existing proposal',
                                style: TextStyle(fontSize: extraRegularSize),
                              ),
                            ],
                          ),
                          value: viewModel.isProposalSelected("EP"),
                          onChanged: (value) {
                            viewModel.selectProposalCheckbox("EP");
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewModel.newSketchPropEntity != null || viewModel.isProposalSelected("CNP") || viewModel.isProposalSelected("EP"),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: doubleTen),
                        const Divider(),
                        const SizedBox(height: doubleTen),
                        const Text(
                          "Proposal Description(*)",
                        ),
                        TextFormField(
                          controller: viewModel.descriptionController,
                          enabled: viewModel.isProposalSelected("CNP"),
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CommonColors.colorPrimary
                                )
                            ),
                            labelStyle: TextStyle(fontFamily: appFontFamily),
                            hintStyle: TextStyle(fontFamily: appFontFamily),
                          ),
                        ),
                        const SizedBox(height: doubleTwenty),
                        const Text(
                          "Estimate No. (If any)",
                        ),
                        TextFormField(
                          controller: viewModel.estimateController,
                          enabled: viewModel.isProposalSelected("CNP"),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CommonColors.colorPrimary
                                )
                            ),
                            labelStyle: TextStyle(fontFamily: appFontFamily),

                            hintStyle: TextStyle(fontFamily: appFontFamily),
                          ),
                        ),
                        const SizedBox(height: doubleFive),
                      ],
                    ),
                  ),
                  const SizedBox(height: doubleFive,),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      "Restrict duplicate pole numbers",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: normalSize),
                    ),
                    value: viewModel.duplicate,
                    onChanged: (value) {
                      viewModel.duplicateCheck(value);
                    },
                  ),
                  const SizedBox(height: doubleFive,),
                  PrimaryButton(
                      fullWidth: isTrue,
                      text: "DIGITIZE NOW",
                      onPressed: () {
                        viewModel.onDigitizeClicked();
                      }
                  ),
                  const SizedBox(height: doubleTen,),
                  PrimaryButton(
                      fullWidth: isTrue,
                      buttonColor: CommonColors.colorSecondary,
                      text: "SAVE FOR OFFLINE",
                      onPressed: () {
                        //viewModel.onNextClicked();
                      }
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
