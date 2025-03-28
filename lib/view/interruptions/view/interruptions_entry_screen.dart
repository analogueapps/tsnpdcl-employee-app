import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/interruptions_entry_viewmodel.dart';

class InterruptionsEntryScreen extends StatelessWidget {
  static const id = "InterruptionsEntryScreen";

  const InterruptionsEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InterruptionsEntryViewmodel(),
      child: Consumer<InterruptionsEntryViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.interruptionsEntry.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "11KV FEEDER INTERRUPTIONS",
                      style: TextStyle(
                          fontSize: extraTitleSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  /// Select Circle
                  const Text("SELECT CIRCLE", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("SELECT"),
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

                  const SizedBox(height: 20),

                  /// Select Substation
                  const Text("SELECT SUBSTATION",
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("SELECT"),
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

                  const SizedBox(height: 20),

                  /// Interruption Level
                  const Text("INTERRUPTION LEVEL",
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Feeder Radio
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: "Feeder",
                              groupValue: viewModel.selectedOption,
                              onChanged: (value) =>
                                  viewModel.toggleOption(value!),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Feeder",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // LV Radio
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: "LV",
                              groupValue: viewModel.selectedOption,
                              onChanged: (value) =>
                                  viewModel.toggleOption(value!),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "LV",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ISF Radio
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: "ISF",
                              groupValue: viewModel.selectedOption,
                              onChanged: (value) =>
                                  viewModel.toggleOption(value!),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "ISF",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Conditional Section based on selectedOption
                  if (viewModel.selectedOption == "Feeder" ||
                      viewModel.selectedOption == "ISF") ...[
                    const Text("SELECT 11KV FEEDERS",
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                  ] else if (viewModel.selectedOption == "LV") ...[
                    const Text("SELECT LV", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text("SELECT"),
                      value: viewModel.selectedLV,
                      items: const [
                        DropdownMenuItem<String>(
                          value: null,
                          child: Text("SELECT"),
                        ),
                        DropdownMenuItem<String>(
                          value: "LV1",
                          child: Text("LV1"),
                        ),
                        DropdownMenuItem<String>(
                          value: "LV2",
                          child: Text("LV2"),
                        ),
                        DropdownMenuItem<String>(
                          value: "LV3",
                          child: Text("LV3"),
                        ),
                        DropdownMenuItem<String>(
                          value: "LV4",
                          child: Text("LV4"),
                        ),
                      ],
                      onChanged: (selectedLV) {
                        viewModel.setSelectedLV(selectedLV);
                      },
                    ),
                  ],

                  const SizedBox(height: 20),

                  /// Supply Position
                  const Text("SUPPLY POSITION", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Feeder Radio
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: "Restored",
                              groupValue: viewModel.selectedSupplyPosition,
                              onChanged: (value) =>
                                  viewModel.setSupplyPosition(value),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Restored",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // LV Radio
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: "Not Restored",
                              groupValue: viewModel.selectedSupplyPosition,
                              onChanged: (value) =>
                                  viewModel.setSupplyPosition(value),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Not Restored",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Time Details
                  const Text("TIME DETAILS", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      // First Column (Start Date)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Start Date & Time",
                                style: TextStyle(fontSize: 14)),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () => viewModel.selectFromDateTime(context),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  hintText: "From Date & Time",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  suffixIcon:
                                  const Icon(Icons.calendar_today, size: 20),
                                ),
                                child: Text(
                                  viewModel.fromDateTime == null
                                      ? "DD/MM/YY HH:MM"
                                      : viewModel
                                      .formatDateTime(viewModel.fromDateTime!),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Second Column (End Date)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("End Date & Time",
                                style: TextStyle(fontSize: 14)),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () => viewModel.selectToDateTime(context),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  hintText: "To Date & Time",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  suffixIcon:
                                  const Icon(Icons.calendar_today, size: 20),
                                ),
                                child: Text(
                                  viewModel.toDateTime == null
                                      ? "DD/MM/YY HH:MM"
                                      : viewModel
                                      .formatDateTime(viewModel.toDateTime!),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Simple Calendar Field (without ViewModel)
                  const Text("DURATION", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today, size: 20),
                    ),
                    child: const Text(""),
                  ),

                  const SizedBox(height: 30),

                  /// Select Circle
                  const Text("INTERRUPTION TYPE",
                      style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("SELECT"),
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

                  const SizedBox(height: 20),
                  /// Submit Button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                        WidgetStateProperty.all(CommonColors.deepRed),
                      ),
                      child: const Text('SUBMIT',
                          style: TextStyle(color: Colors.white)),
                    ),
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