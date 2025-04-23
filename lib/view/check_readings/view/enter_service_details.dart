import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';
import 'package:tsnpdcl_employee/view/check_readings/viewmodel/enter_services_details_viewmodel.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/feeder_model.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class EnterServiceDetails extends StatelessWidget {
  static const id = Routes.enterServicesScreen;

  const EnterServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => EnterServicesDetailsViewmodel(context: context),
        child: Consumer<EnterServicesDetailsViewmodel>(
            builder: (context, viewModel, child) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Check Readings', style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: CommonColors.colorPrimary,
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                body:SingleChildScrollView(
              child:Padding(
                  padding: const EdgeInsets.all(11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Enter Service Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Select Circle',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Select"),
                        value: viewModel.selectedCircle,
                        items: viewModel.circle.map<DropdownMenuItem<String>>((Circle item) {
                          return DropdownMenuItem<String>(
                            value: item.circleId,
                            child: Text(item.circleName),
                          );
                        }).toList(),
                        onChanged: (String? value) => viewModel.onListCircleSelected(value),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Select ERO',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // DropdownButton<String>(
                      //   isExpanded: true,
                      //   hint: const Text("Select"),
                      //   value: viewModel.selectedEro,
                      //   items: viewModel.eroList.map<DropdownMenuItem<String>>((EroModel item) {
                      //     return DropdownMenuItem<String>(
                      //       value: item.optionId,
                      //       child: Text(item.optionName ?? ''),
                      //     );
                      //   }).toList(),
                      //   onChanged: (String? value) => viewModel.onSelectedERO(value),
                      // ),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Select ERO"),
                        value: viewModel.selectedEro,
                        items: viewModel.eroList.map((ero) {
                          return DropdownMenuItem<String>(
                            value: ero.optionId,
                            child: Text(ero.optionName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            viewModel.onSelectedERO(value);
                          }
                        },
                      ),

                      const SizedBox(height: 15),
                      const Text('SCNO'),
                      TextField(
                        controller: viewModel.scNoController,
                      ),

                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          '-- OR --',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text('USCNO'),
                      TextField(
                        controller: viewModel.uscNoController,
                      ),

                      PrimaryButton(
                        text: "FIND SERVICE",
                        onPressed: () {
                        },
                        fullWidth: true,
                      ),
                    ],
                  ),
                ),
                ),
              );
            }
        )
    );
  }
}