import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/lc_master_ss_list.dart';
import 'package:tsnpdcl_employee/view/ptr_feeder_loaders/viewmodel/ptr_feeder_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class PtrFeederScreen extends StatelessWidget {
  static const id = Routes.ptrFeederScreen;

  const PtrFeederScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            GlobalConstants.ptrFeederLoaders,
            style:  TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: ChangeNotifierProvider(
          create: (_) => PtrFeederViewmodel(context: context),
          child: Consumer<PtrFeederViewmodel>(
            builder: (context, viewModel, child) {
              return viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 350,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("SELECT SUBSTATION", style: TextStyle(color: Colors.red[900])),
                                        const SizedBox(height: 10),
                                        DropdownButtonFormField<String>(
                                          value: viewModel.selectedSs,
                                          hint: const Text("SELECT SUBSTATION"),
                                          isExpanded: true,
                                          items: viewModel.subStationList.map((LcMasterSsList item) {
                                            return DropdownMenuItem<String>(
                                              value: item.optionId,
                                              child: Text(item.optionName ?? ""),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            viewModel.updateSs(newValue);
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.grey[300],
                                          ),
                                          onPressed: () {
                                            viewModel.pickDateFromDateTimePicker(context);
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(Icons.calendar_month_outlined, size: 25, color: Colors.black),
                                              const SizedBox(width: 8),
                                              Text(
                                                viewModel.pickedDate == '' || viewModel.pickedDate == "null/null/null"
                                                    ? "CHOOSE DATE"
                                                    : viewModel.pickedDate,
                                                style: TextStyle(color: Colors.red[900]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text("SELECT LOAD HOURS", style: TextStyle(color: Colors.red[900])),
                                        const SizedBox(height: 10),
                                        DropdownButtonFormField<String>(
                                          value: viewModel.selectedLoadHour,
                                          hint: const Text("SELECT LOAD HOUR"),
                                          isExpanded: true,
                                          items: viewModel.loadHours.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            viewModel.selectedLoadHour = newValue;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: double.infinity,
                                          child: PrimaryButton(
                                            text: "GET DETAILS",
                                            onPressed: () {
                                              viewModel.getDetails(viewModel.selectedSs);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (viewModel.loadInAmpsModelList.isNotEmpty)
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(), // Use parent scroll
                                  shrinkWrap: true, // Important!
                                  itemCount: viewModel.loadInAmpsModelList.length,
                                  itemBuilder: (context, index) {
                                    final data = viewModel.loadInAmpsModelList[index];
                                    final ctrl = viewModel.controllers[index];

                                    return Card(
                                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                            alignment: Alignment.topRight,
                                            child:Text(data.type ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                            ),
                                            const SizedBox(height: 6),
                                            ViewDetailedLcTileWidget(
                                                tileKey: "Name", tileValue: " ${data.name ?? ''}"),
                                           const  Divider(),
                                            ViewDetailedLcTileWidget(
                                                tileKey: "Capacity", tileValue: " ${data.capacity ?? ''}"),
                                            const Divider(),
                                            const SizedBox(height: 10),
                                            _buildTextField('R Phase', ctrl.rController),
                                            _buildTextField('Y Phase', ctrl.yController),
                                            _buildTextField('B Phase', ctrl.bController),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          text: "SUBMIT",
                          onPressed: () {
                            for (int i = 0; i < viewModel.controllers.length; i++) {
                              print("Entry $i - R: ${viewModel.controllers[i].rController.text}, "
                                  "Y: ${viewModel.controllers[i].yController.text}, "
                                  "B: ${viewModel.controllers[i].bController.text}");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
    child:Row(children: [
      const SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Container(
        height: 20,
        width: 1,
        color: Colors.grey[300],
      ),
      Expanded(
        flex: 2,
        child: FillTextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          labelText: label,
        ),
      ),
    ]));
  }
}
