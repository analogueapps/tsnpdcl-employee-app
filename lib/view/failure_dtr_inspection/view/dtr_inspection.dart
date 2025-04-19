import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/viewmodel/dtr_inspection_viewmodel.dart';


class ReportedDTRFailure extends StatelessWidget {
  static const id = Routes.failureDTRsInspectionScreen;

  const ReportedDTRFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RepeatedDTRFailureViewModel(context: context),
      child: Consumer<RepeatedDTRFailureViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(GlobalConstants.reportDtrFailure.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: toolbarTitleSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(viewModel.section, style: const TextStyle(
                      color: Colors.white,
                      fontSize: doubleFifteen,
                      fontWeight: FontWeight.w400,
                    ),),
                  ]
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: viewModel.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButtonFormField<String>(
                              value: viewModel.section,
                              decoration: InputDecoration(
                                labelText: "Select Section",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                              ),
                              items: viewModel.section != null
                                  ? [
                                DropdownMenuItem<String>(
                                  value: viewModel.section,
                                  child: Text(viewModel.section,
                                    style: const TextStyle(
                                        fontSize: doubleFourteen),),
                                ),
                              ]
                                  : [
                                const DropdownMenuItem<String>(
                                  value: null,
                                  child: Text("No section selected"),
                                ),
                              ],
                              onChanged: null,
                              disabledHint:
                              Text(viewModel.section ?? "No section selected"),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${viewModel.section} | ${viewModel
                                      .sectionCode}",
                                  style: TextStyle(color: Colors.green),
                                )),

                            const SizedBox(height: 20),
                            Text(
                              'SELECT FAILED STRUCTURE CODE',
                              style: TextStyle(color: Colors.red[800]),
                            ),
                            GestureDetector(
                              onTap: viewModel.structures.isEmpty
                                  ? null
                                  : () =>
                                  _showStructuresDialog(context, viewModel),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      viewModel.selectedStructureId ??
                                          "Select Structure Code",
                                      style: const TextStyle(
                                          fontSize: doubleFourteen),
                                      overflow: TextOverflow
                                          .ellipsis, // Added to prevent overflow
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                viewModel.selectedStructureId ?? "",
                                style: const TextStyle(color: Colors.green),
                              ),
                            ),
                            const SizedBox(height: 20),
                             Text(
                              'SELECT FAILED EQUIPMENT CODE',
                              style: TextStyle(color: Colors.red[800]),
                            ),
                            DropdownButtonFormField<String>(
                              value: viewModel.failedEquipmentCode,
                              items: viewModel.failedEquipmentList.map((code) {
                                return DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(code),
                                );
                              }).toList(),
                              onChanged: (value) {
                                viewModel.setFailedEquipmentCode(value);
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              hint: const Text('Select Equipment Code'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select equipment code';
                                }
                                return null;
                              },
                            ),
                              const  SizedBox(height: 380),
                             Text(
                              'ESTIMATE REQUIRED?',
                              style: TextStyle(color: Colors.red[800],
                                  fontWeight: FontWeight.w400),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: viewModel.estimateRequired ==
                                          "Yes",
                                      onChanged: (bool? value) {
                                        viewModel.toggleEstimateRequired("Yes");
                                      },
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('Yes'),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: viewModel.estimateRequired == "No",
                                      onChanged: (bool? value) {
                                        viewModel.toggleEstimateRequired("No");
                                      },
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('No'),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(thickness: 1, color: Colors.grey),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: viewModel.save,
                                child: const Text('SAVE'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (viewModel.isLoading ||
                      viewModel.isLoadingStructureDetails ||
                      viewModel.isLoadingStructures)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        // Semi-transparent overlay
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ]
            ),
          );
        },
      ),
    );
  }


  void _showStructuresDialog(BuildContext context,
      RepeatedDTRFailureViewModel viewModel) {
    final TextEditingController searchController = TextEditingController();
    String searchQuery = '';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Select Structure'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Field
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: "Search Structure",
                        hintText: "Type to search",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Structure Code List with overflow fix
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: viewModel.structures
                            .where((item) =>
                            item.optionName!
                                .toLowerCase()
                                .contains(searchQuery))
                            .length,
                        itemBuilder: (context, index) {
                          final filteredItems = viewModel.structures
                              .where((item) =>
                              item.optionName!
                                  .toLowerCase()
                                  .contains(searchQuery))
                              .toList();
                          return ListTile(
                            title: SizedBox(
                              width: 200, // Constrain width to prevent overflow
                              child: Text(
                                filteredItems[index].optionName ?? '',
                                style: const TextStyle(fontSize: doubleEleven),
                                overflow:
                                TextOverflow.ellipsis, // Handle long text
                              ),
                            ),
                            onTap: () {
                              viewModel.setSelectedStructure(
                                  filteredItems[index].optionId);
                              Navigator.pop(dialogContext);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      searchController.dispose();
    });
  }
}