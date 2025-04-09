import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/viewmodel/report_ct_pt_viewmodel.dart';

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
            backgroundColor: Colors.blue,
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
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Select HT SC. NO.'),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                    viewModel.extractMiddlePartRevised(viewModel.selectedHTSC ?? viewModel.htscList[0]),
                    style: const TextStyle(color: Colors.green, fontSize: 12),
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
                          decoration: const InputDecoration(border: OutlineInputBorder()),
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(flex: 2, child: Text('Serial No.')),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: viewModel.serialNoController,
                          decoration: const InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(flex: 2, child: Text('Make')),
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          hint: Text(viewModel.makeList[0]),
                          value: viewModel.selectedMake,
                          items: viewModel.makeList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
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
                      const Expanded(flex: 2, child: Text('CT PT Ratio')),
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          hint: Text(viewModel.ctptRatioList[0]),
                          value: viewModel.selectedCTPTRatio,
                          items: viewModel.ctptRatioList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            viewModel.updateCTPTRatio(newValue);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(flex: 2, child: Text('Year of Manufacturing')),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: viewModel.yearController,
                          decoration: const InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {
                      viewModel.submitForm();
                    },
                    child: const Text('SUBMIT'),
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