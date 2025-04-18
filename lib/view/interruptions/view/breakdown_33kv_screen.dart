import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/breakdown_33kv_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class Breakdown33kvScreen extends StatelessWidget {
  static const id = Routes.breakdown33kvScreen;

  const Breakdown33kvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Breakdown33kvViewmodel(context: context),
      child: Consumer<Breakdown33kvViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.thirtyThreeBreakdownEntry.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("SELECT SUBSTATION",
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text("Select a Substation"),
                          value: viewModel.selectedSubstation,
                          items: viewModel.substations.map((substation) {
                            return DropdownMenuItem<String>(
                              value: substation.optionName,
                              child: Text(substation.optionName ?? "N/A"),
                            );
                          }).toList(),
                          onChanged: (selectedSubstation) {
                            viewModel.setSelectedSubstation(selectedSubstation);
                          },
                        ),
                        // In Breakdown33kvScreen widget, modify the Feeder dropdown section:
                        const SizedBox(height: 20),
                        const Text("SELECT FEEDER",
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text("Select Feeder"),
                          value: viewModel.selectedFeeder,
                          items: viewModel.feeders.map((feeder) {
                            return DropdownMenuItem<String>(
                              value: feeder.optionName,
                              child: Text(feeder.optionName ?? "N/A"),
                            );
                          }).toList(),
                          onChanged: viewModel.selectedSubstation == null
                              ? null
                              : (selectedFeeder) {
                                  viewModel.setSelectedFeeder(selectedFeeder);
                                },
                        ),
                        const SizedBox(height: 20),
                        const Text("BREAK DOWN START TIME",
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => viewModel.selectDateTime(),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              hintText: "DD/MM/YYYY HH:MM",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                            child: Text(
                              viewModel.selectedDateTime == null
                                  ? "DD/MM/YYYY HH:MM"
                                  : viewModel.formatDateTime(
                                      viewModel.selectedDateTime!),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("ALTERNATIVELY SUPPLY ARRANGED",
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text("Not Arranged",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          value:
                              viewModel.selectedSupplyOption == "Not Arranged",
                          onChanged: (value) {
                            viewModel.setSupplyOption(
                                value == true ? "Not Arranged" : null);
                          },
                        ),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text("Arranged",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          value: viewModel.selectedSupplyOption == "Arranged",
                          onChanged: (value) {
                            viewModel.setSupplyOption(
                                value == true ? "Arranged" : null);
                          },
                        ),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text("Partially Provided",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          value: viewModel.selectedSupplyOption ==
                              "Partially Provided",
                          onChanged: (value) {
                            viewModel.setSupplyOption(
                                value == true ? "Partially Provided" : null);
                          },
                        ),
                        const SizedBox(height: 20),
                        FillTextFormField(
                          controller: viewModel.substationsController,
                          labelText: 'Enter NO OF SUBSTATIONS AFFECTED',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          text: "SUBMIT",
                          onPressed: () {
                            viewModel.submitData();
                          },
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
