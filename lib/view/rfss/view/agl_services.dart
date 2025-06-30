import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/rfss/model/dtrStructureEntity.dart';
import 'package:tsnpdcl_employee/view/rfss/viewmodel/agl_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class AglServices extends StatelessWidget {
  const AglServices({super.key});
  static const id = Routes.aglService;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = AglViewModel(context: context);
        viewModel.initialize();
        return viewModel;
      },
      child: Consumer<AglViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CommonColors.colorPrimary,
            title: Text(
              GlobalConstants.aglServices.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    viewModel.submitForm();
                  },
                  icon: const Icon(Icons.upload))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              // Adds spacing around the content
              child: Form(
                key: viewModel.formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.showDistributionDialog(context),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Select Distribution"),
                              DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text("Select a distribution"),
                                value: viewModel.listDistributionSelect,
                                items:
                                    viewModel.listDistributionItem.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.optionCode,
                                    child: Text(item.optionName),
                                  );
                                }).toList(),
                                onChanged: viewModel
                                        .listDistributionItem.isNotEmpty
                                    ? (value) => viewModel
                                        .onListDistributionValueChange(value)
                                    : null,
                              ),
                            ]),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            viewModel.getUnmappedServices(
                                viewModel.listDistributionSelect ?? "");
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.grey[200]),
                          ),
                          child: const Text(
                            "DOWNLOAD UNMAPPED SERVICES",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Select Structure Code"),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Select Structure"),
                        value: viewModel.selectedStructure,
                        items: viewModel.struct.map((item) {
                          return DropdownMenuItem<String>(
                            value: item, // This must be a String
                            child: Text(item ?? ""),
                          );
                        }).toList(),
                        onChanged: (value) {
                          viewModel.onListStructureSelected(value);
                        },
                      ),
                      Text(
                        viewModel.selectedStructure ?? "",
                        style: const TextStyle(color: Colors.green),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              viewModel.downloadOtherSectionDTRS();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  CommonColors.colorPrimary),
                            ),
                            child: const Text(
                              "DOWNLOAD OTHER SECTION DTRS",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("CHOOSE OPTION"),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align items properly
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: "A",
                                groupValue: viewModel.selectedOption,
                                onChanged: (value) =>
                                    viewModel.toggleOption(value!),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "Authorised AGL Services",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: "U",
                                groupValue: viewModel.selectedOption,
                                onChanged: (value) =>
                                    viewModel.toggleOption(value!),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "Un authorised AGL Services",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: "M",
                                groupValue: viewModel.selectedOption,
                                onChanged: (value) =>
                                    viewModel.toggleOption(value!),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "Metered Service(NON-AGL)",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: doubleTwenty),
                      Visibility(
                          visible: viewModel.selectedOption == "A",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Select Service No"),
                              DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text("Select Service"),
                                value: viewModel.selectedServiceNo != null
                                    ? '${viewModel.selectedServiceNo} - ${viewModel.services.firstWhere(
                                        (s) =>
                                            s['scno'] ==
                                            viewModel.selectedServiceNo,
                                        orElse: () => {'name': ''},
                                      )['name']}'
                                    : null,
                                items: viewModel.serviceDisplayItems
                                    .map((displayItem) {
                                  return DropdownMenuItem<String>(
                                    value: displayItem,
                                    child: Text(displayItem),
                                  );
                                }).toList(),
                                onChanged: viewModel.onServiceSelected,
                              ),
                            ],
                          )),
                      Visibility(
                          visible: viewModel.selectedOption == "U",
                          child: Column(
                            children: [
                              FillTextFormField(
                                  controller: viewModel.farmerName,
                                  labelText: "FARMER NAME(Optional)",
                                  keyboardType: TextInputType.text),
                              const SizedBox(
                                height: 20,
                              ),
                              FillTextFormField(
                                  controller: viewModel.connectedLoad,
                                  labelText: "CONNECTED LOAD(HP)",
                                  keyboardType: TextInputType.number)
                            ],
                          )),
                      Visibility(
                          visible: viewModel.selectedOption == "M",
                          child: FillTextFormField(
                              controller: viewModel.uscno,
                              labelText: "USCNO(NON - AGL)",
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number)),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "GPS CO-ORDINATES",
                        ),
                      ),
                      SizedBox(
                        height: doubleSixty,
                        child: viewModel.latitude != null
                            ? Column(
                                children: [
                                  Text(
                                    "LAT:${viewModel.latitude}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "LON:${viewModel.longitude}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            : const SizedBox(
                                height: 30,
                              ),
                      ),
                      const Text(
                        "Please click SAVE when you are at service location only ",
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          text: "SAVE",
                          onPressed: () {
                            viewModel.submitForm();
                          },
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      }),
    );
  }
}
