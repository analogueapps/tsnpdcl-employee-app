import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/pole_tracker_selection_view_sketch_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class PoleTrackerSelectionViewSketchScreen extends StatelessWidget {
  static const id = Routes.poleTrackerSelectionViewSketchScreen;

  const PoleTrackerSelectionViewSketchScreen({
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
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) =>
            PoleTrackerSelectionViewSketchViewmodel(context: context),
        child: Consumer<PoleTrackerSelectionViewSketchViewmodel>(
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
                            "33KV LINE",
                            style: TextStyle(
                                fontSize: normalSize,
                                fontWeight: FontWeight.w500),
                          ),
                          value: viewModel.isSelected("33KV LINE"),
                          onChanged: (value) {
                            viewModel.selectCheckbox("33KV LINE");
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            "11KV LINE",
                            style: TextStyle(
                                fontSize: normalSize,
                                fontWeight: FontWeight.w500),
                          ),
                          value: viewModel.isSelected("11KV LINE"),
                          onChanged: (value) {
                            viewModel.selectCheckbox("11KV LINE");
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
                  const SizedBox(height: doubleTwenty),
                  Visibility(
                    visible: viewModel.newSketchPropEntity != null,
                    child: Column(
                      children: [
                        const Text(
                          "Proposal Description(*)",
                          style: TextStyle(
                            color: CommonColors.colorPrimary,
                          ),
                        ),
                        TextFormField(
                          //controller: widget.controller,
                          initialValue:
                              viewModel.newSketchPropEntity?.proposalDesc,
                          keyboardType: TextInputType.none,
                          enabled: isFalse,
                          maxLines: 5,
                          style: const TextStyle(
                            fontSize: titleSize,
                            fontFamily: appFontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CommonColors.colorPrimary)),
                            labelStyle: TextStyle(fontFamily: appFontFamily),
                            hintStyle: TextStyle(fontFamily: appFontFamily),
                          ),
                        ),
                        const SizedBox(height: doubleTwenty),
                        const Text(
                          "Estimate No. (If any)",
                          style: TextStyle(
                            color: CommonColors.colorPrimary,
                          ),
                        ),
                        TextFormField(
                          //controller: widget.controller,
                          initialValue:
                              viewModel.newSketchPropEntity?.estimateNo,
                          keyboardType: TextInputType.none,
                          enabled: isFalse,
                          style: const TextStyle(
                            fontSize: titleSize,
                            fontFamily: appFontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CommonColors.colorPrimary)),
                            labelStyle: TextStyle(fontFamily: appFontFamily),
                            hintStyle: TextStyle(fontFamily: appFontFamily),
                          ),
                        ),
                        const SizedBox(height: doubleTwenty),
                      ],
                    ),
                  ),
                  PrimaryButton(
                      fullWidth: isTrue,
                      text: "NEXT",
                      onPressed: () {
                        viewModel.onNextClicked();
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
