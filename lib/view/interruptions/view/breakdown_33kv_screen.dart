import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/breakdown_33kv_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class Breakdown33kvScreen extends StatelessWidget {
  static const id = 'Breakdown33kvScreen';

  const Breakdown33kvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Breakdown33kvViewmodel(),
      child: Consumer<Breakdown33kvViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.thirtyThreeBreakdownEntry.toUpperCase(),
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
                  const Text("SELECT BREAKDOWN DATE & TIME", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8), // Space Below Heading
                  InkWell(
                    onTap: () => viewModel.selectDateTime(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        hintText: "Select Date & Time",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        viewModel.selectedDateTime == null
                            ? "Select Date & Time"
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
                    value: viewModel.isOption1Selected,
                    onChanged: (value) => viewModel.toggleOption1(value!),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("Arranged", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    value: viewModel.isOption2Selected,
                    onChanged: (value) => viewModel.toggleOption2(value!),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("Partially Provided", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    value: viewModel.isOption3Selected,
                    onChanged: (value) => viewModel.toggleOption3(value!),
                  ),

                  const SizedBox(height: 20),

                  /// **No of Substations Affected**
                  // const Text("NO OF SUBSTATIONS AFFECTED", style: TextStyle(fontSize: 16)),
                  FillTextFormField(
                    controller: viewModel.substationsController,
                    labelText: 'Enter NO OF SUBSTATIONS AFFECTED',
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
