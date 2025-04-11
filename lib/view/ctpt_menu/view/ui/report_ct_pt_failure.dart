import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/viewmodel/report_ct_pt_viewmodel.dart';
import '../../../../utils/app_constants.dart';
import '../../../../widget/primary_button.dart';

class CTFailureReportScreen extends StatelessWidget {
  static const id = Routes.reportCtPtFailure;

  const CTFailureReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CTFailureReportViewModel(context: context),
      child: Consumer<CTFailureReportViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: const Text(
                'REPORT CT/PT FAILURE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Select HT SC. NO.'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: DropdownButtonFormField<String>(
                              value: viewModel.selectedHTSC,
                              hint: Text(viewModel.htscList[0]),
                              isExpanded: true,
                              items: viewModel.htscList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                viewModel.updateHTSC(newValue);
                              },
                            ),
                          ),
                          Text(
                            viewModel.extractMiddlePartRevised(
                                viewModel.selectedHTSC ??
                                    viewModel.htscList[0]),
                            style: const TextStyle(
                                color: Colors.green, fontSize: 12),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text('Select Village'),
                          DropdownButtonFormField<String>(
                            value: viewModel.selectedVillage,
                            hint: Text(viewModel.villageList[0]),
                            items: viewModel.villageList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              viewModel.updateVillage(newValue);
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(flex: 2, child: Text('Enter M.F')),
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: viewModel.mfController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            color: Colors.grey.shade300,
                            child: const Text(
                              'NOW PROPOSED DETAILS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text('Serial No.')),
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: viewModel.serialNoController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                    'Make'), // Consider using TextOverflow.ellipsis if needed
                              ),
                              Expanded(
                                flex: 3,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  // Important for long dropdown items
                                  hint: Text(viewModel.makeList[0]),
                                  value: viewModel.selectedMake,
                                  items: viewModel.makeList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        overflow: TextOverflow
                                            .ellipsis, // Handle long text
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    viewModel.updateMake(newValue);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text('CT PT Ratio')),
                              Expanded(
                                flex: 3,
                                child: DropdownButtonFormField<String>(
                                  hint: const Text('Select CT/PT Ratio'),
                                  value: viewModel.selectedCTPTRatio != null &&
                                          viewModel.ctptRatios.contains(
                                              viewModel.selectedCTPTRatio)
                                      ? viewModel.selectedCTPTRatio
                                      : null,
                                  items:
                                      viewModel.ctptRatios.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    viewModel.updateCTPTRatio(newValue);
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text('Year of Manufacturing')),
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: viewModel.yearController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          PrimaryButton(
                            text: "SUBMIT".toUpperCase(),
                            fullWidth: isTrue,
                            onPressed: () {
                              print('SUBMIT button clicked'); // Debug
                              viewModel.saveCtPtReport();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
