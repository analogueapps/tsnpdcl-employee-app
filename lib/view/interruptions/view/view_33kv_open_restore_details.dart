import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/view_33kv_open_restore_details_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';

class View33kvOpenRestoreDetails extends StatelessWidget {
  static const id = Routes.view33kvOpenRestoreDetails;
  final Map<String, dynamic> data;

  const View33kvOpenRestoreDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => View33kvOpenRestoreDetailsViewmodel(data),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: Text(
            GlobalConstants.thirtyThreeBreakdownEntry.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Consumer<View33kvOpenRestoreDetailsViewmodel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReadOnlyField("SELECT SUBSTATION", viewModel.substation),
                  _buildReadOnlyField("SELECT FEEDER", viewModel.feeder),
                  _buildReadOnlyField("BREAK DOWN START TIME", viewModel.breakdownStartTime),
                  _buildCheckbox("ALTERNATIVELY SUPPLY ARRANGED", ["Not Arranged", "Arranged", "Partially Provided"], viewModel),
                  FillTextFormField(
                    controller: TextEditingController(text: viewModel.noOfSSAffected.toString()),
                    labelText: "NO OF SUBSTATIONS AFFECTED",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  _buildRadioButtons(viewModel),
                  Visibility(
                    visible: viewModel.isRestored,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDateTimeField("SUPPLY RESTORED DATE & TIME", viewModel.supplyRestoredDate, viewModel, context),
                        const SizedBox(height: 10),
                        _buildTextField("NO OF POLES DAMAGED", viewModel.polesDamagedController),
                        const SizedBox(height: 16),
                        _buildTextField("NO OF TOWERS DAMAGED", viewModel.towersDamagedController),
                        const SizedBox(height: 16),
                        _buildTextField("CONDUCTOR DAMAGED (KM)", viewModel.conductorDamagedController),
                        const SizedBox(height: 16),
                        _buildDropdown("BREAKDOWN REASON", viewModel.selectedBreakdownReason, viewModel),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          text: "SUBMIT",
                          onPressed: () {
                            viewModel.submitData(context, );
                          },
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          initialValue: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDateTimeField(
      String label, String date, View33kvOpenRestoreDetailsViewmodel viewModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          controller: TextEditingController(text: date),
          decoration: InputDecoration(
            labelText: "DD-MM-YYYY HH:MM", // Label in uppercase as requested
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          onTap: () => viewModel.selectDateTime(context),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, View33kvOpenRestoreDetailsViewmodel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value.isNotEmpty ? value : null,
          decoration: InputDecoration(
            labelText: "SELECT",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          onChanged: (selectedValue) {
            viewModel.setBreakdownReason(selectedValue!);
          },
          items: viewModel.breakdownReasons
              .map((reason) => DropdownMenuItem(value: reason, child: Text(reason)))
              .toList(),
        ),
        if (viewModel.showOtherReasonField) ...[
          const SizedBox(height: 10),
          TextFormField(
            controller: viewModel.otherReasonController,
            decoration: InputDecoration(
              labelText: "ENTER OTHER REASON",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCheckbox(String label, List<String> options, View33kvOpenRestoreDetailsViewmodel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        for (var option in options)
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(option, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            value: option == "Not Arranged",
            onChanged: null, // Disable checkboxes
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildRadioButtons(View33kvOpenRestoreDetailsViewmodel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("SUPPLY POSITION", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildRadioOption("Restored", viewModel),
            _buildRadioOption("Not Restored", viewModel),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(String label, View33kvOpenRestoreDetailsViewmodel viewModel) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: label,
            groupValue: viewModel.selectedSupplyPosition,
            onChanged: (value) => viewModel.setSupplyPosition(value!),
          ),
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
