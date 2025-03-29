import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/saidi_saifi_calculator_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class SaidiSaifiCalculatorScreen extends StatelessWidget {
  static const id = "SaidiSaifiCalculatorScreen";

  const SaidiSaifiCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SaidiSaifiCalculatorViewmodel(),
      child: Consumer<SaidiSaifiCalculatorViewmodel>(
        builder: (context, viewmodel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.saidiSaifiCalculator.toUpperCase(),
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
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "SAIDI SAIFI CALCULATOR",
                      style: TextStyle(fontSize: extraTitleSize),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Select Month
                  const Text("Select Month", style: TextStyle(fontSize: titleSize)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(CommonColors.textFieldColor),
                        shape: WidgetStateProperty.all(
                          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                      ),
                      child: const Text('TAP HERE', style: TextStyle(color: Colors.black)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Select Substation
                  const Text("Select Substation", style: TextStyle(fontSize: titleSize)),
                  const SizedBox(height: 10),

                  // Standard Dropdown Button
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    hint: const Text("SELECT"),
                    value: viewmodel.selectedSubstation,
                    items: viewmodel.substations.map((substation) {
                      return DropdownMenuItem<String>(
                        value: substation.name,
                        child: Text(substation.name),
                      );
                    }).toList(),
                    onChanged: (selectedSubstation) {
                      viewmodel.setSelectedSubstation(selectedSubstation);
                    },
                  ),

                  const SizedBox(height: 20),
                  const Text("ENTER INTERRUPTION DETAILS"),
                  const SizedBox(height: 8),

                  Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Content Rows
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text("CIRCLE OFFICE"),
                        ),
                        const SizedBox(height: 10),
                        _reusableLastRow("INTERRUPTION TYPE", "NO OF INTERRUPTIONS", "DURATION IN MINUTES"),
                        _reusableLastRow("EL", "form field", "form field"),
                        _reusableLastRow("OL", "form field", "form field"),
                        _reusableLastRow("EL & OL", "form field", "form field"),
                        _reusableLastRow("L.C", "form field", "form field"),
                        _reusableLastRow("Break Down", "form field", "form field"),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Calculate Button
                  PrimaryButton(text: "CALCULATE", onPressed: () {}, fullWidth: true),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _reusableLastRow(String label, String value, String value2) {
    bool isFormField1 = value.toLowerCase() == "form field";
    bool isFormField2 = value2.toLowerCase() == "form field";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),

          // Separator Line (Shown only if there are no form fields)
          if (!isFormField1)
            Container(
              width: 1,
              height: 50,
              margin: const EdgeInsets.all(10),
              color: const Color(0xffcfcdcd),
            ),

          Expanded(
            child: isFormField1
                ? const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              ),
            )
                : Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 10),
          // Separator Line (Shown only if there are no form fields)
          if (!isFormField2)
            Container(
              width: 1,
              height: 50,
              margin: const EdgeInsets.all(10),
              color: const Color(0xffcfcdcd),
            ),

          Expanded(
            child: isFormField2
                ? const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              ),
            )
                : Text(
              value2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
