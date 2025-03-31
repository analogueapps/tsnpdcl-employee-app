import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/breakdown_11kv_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class Breakdown11kvScreen extends StatelessWidget {
  static const id = 'Breakdown11kvScreen';

  const Breakdown11kvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Breakdown11kvViewmodel(),
      child: Consumer<Breakdown11kvViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.elevenBreakdownEntry.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Select Substation**
                  const Text("SELECT SUBSTATION", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8), // Space Below Heading
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("Select a Substation"),
                    value: viewModel.selectedSubstation,
                    items: viewModel.substations.map((substation) {
                      return DropdownMenuItem<String>(
                        value: substation.name,
                        child: Text(substation.name),
                      );
                    }).toList(),
                    onChanged: (selectedSubstation) {
                      viewModel.setSelectedSubstation(selectedSubstation);
                    },
                  ),

                  const SizedBox(height: 20), // Extra Space

                  /// **Select Feeder (Separate Model)**
                  const Text("SELECT FEEDER", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8), // Space Below Heading
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("Select Feeder"),
                    value: viewModel.selectedFeeder,
                    items: viewModel.feeders.map((feeder) {
                      return DropdownMenuItem<String>(
                        value: feeder.name,
                        child: Text(feeder.name),
                      );
                    }).toList(),
                    onChanged: (selectedFeeder) {
                      viewModel.setSelectedFeeder(selectedFeeder);
                    },
                  ),

                  const SizedBox(height: 20), // Extra Space

                  /// **Select Breakdown Date & Time**
                  const Text("BREAK DOWN START TIME", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8), // Space Below Heading
                  InkWell(
                    onTap: () => viewModel.selectDateTime(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        hintText: "DD/MM/YYYY HH:MM",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        viewModel.selectedDateTime == null
                            ? "DD/MM/YYYY HH:MM"
                            : viewModel.formatDateTime(viewModel.selectedDateTime!),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// **Alternative Supply Arrangement (Checkboxes)**
                  const Text("ALTERNATIVELY SUPPLY ARRANGED", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8), // Space Below Heading
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("Not Arranged", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    value: viewModel.selectedSupplyOption == "Not Arranged",
                    onChanged: (value) {
                      viewModel.setSupplyOption(value == true ? "Not Arranged" : null);
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("Arranged", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    value: viewModel.selectedSupplyOption == "Arranged",
                    onChanged: (value) {
                      viewModel.setSupplyOption(value == true ? "Arranged" : null);
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("Partially Provided", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    value: viewModel.selectedSupplyOption == "Partially Provided",
                    onChanged: (value) {
                      viewModel.setSupplyOption(value == true ? "Partially Provided" : null);
                    },
                  ),

                  const SizedBox(height: 20),

                  /// **No of Substations Affected**
                  // const Text("NO OF SUBSTATIONS AFFECTED", style: TextStyle(fontSize: 16)),
                  FillTextFormField(
                    controller: viewModel.substationsController,
                    labelText: 'Enter NO OF VILLAGES AFFECTED',
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 20),

                  /// **Submit Button**
                  PrimaryButton(text: "SUBMIT", onPressed: (){}, fullWidth: true,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
