import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/rfss/viewmodel/non_agl_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';


class NonAglServices extends StatelessWidget {
  static const id = Routes.nonAglService;

  const NonAglServices({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = NonAglViewModel(context: context);
        viewModel.initialize();
        return viewModel;
      },
      child: Consumer<NonAglViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: CommonColors.colorPrimary,
                  title: Text(
                    GlobalConstants.nonAGLService.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: toolbarTitleSize,
                        fontWeight: FontWeight.w700),
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  actions: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.upload))
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  // Adds spacing around the content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          // onTap: () => viewModel.showSubstationDialog(context, viewModel),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Select Distribution"),
                              DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text("Select"),
                                value: viewModel.selectedDistribution,
                                items: viewModel.distri.map((SubstationModel item) {
                                  return DropdownMenuItem<String>(
                                    value: item.optionCode,
                                    child: Text(item.optionName),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    final selectedItem = viewModel.distri.firstWhere(
                                          (item) => item.optionCode == value,
                                    );
                                    viewModel.onListDistributionSelected(value);
                                  }
                                },
                              )
                          //     Container(
                          //   height: 50,
                          //   width: double.infinity,
                          //   padding: const EdgeInsets.symmetric(horizontal: 12),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     // color: CommonColors.textFieldColor,
                          //     borderRadius: BorderRadius.circular(8),
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         viewModel.selectedDistribution ?? "Select ",
                          //         style: const TextStyle(color: Colors.black),
                          //       ),
                          //       const Icon(
                          //         Icons.arrow_drop_down,
                          //         color: Colors.black,
                          //         size: 24,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          ]
                          ),
                        ),
                        Center(
                        child: TextButton(
                            onPressed: (){},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                          ),
                            child: const Text("DOWNLOAD UNMAPPED SERVICES", style: TextStyle(color:Colors.black),),
                        ),
                        ),
                        const SizedBox(height: 5,),
                        const Text("Select Structure Code"),
                        // DropdownButton<String>(
                        //   isExpanded: true,
                        //   hint: const Text(""),
                        //   value: viewModel.selectedStructure,
                        //   items: viewModel.struct.map((item) {
                        //     return DropdownMenuItem<String>(
                        //       value: item,
                        //       child: Text(item),
                        //     );
                        //   }).toList(),
                        //   onChanged: (value) => viewModel.onListStructureSelected(value),
                        // ),
                        Text(viewModel.selectedStructure??"", style: const TextStyle(color: Colors.green),),

                      ]
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Ensure proper spacing
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              text: "SEARCH SERVICE",
                              onPressed: () {
                                // viewModel.submitForm();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PrimaryButton(
                              text: "SAVE",
                              onPressed: () {
                                // viewModel.submitForm();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            );
          }
      ),
    );
  }

}
