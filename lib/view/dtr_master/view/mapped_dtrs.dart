import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/pdms/model/option.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import '../viewmodel/map_dtr_viewmodel.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';


class MappedDtr extends StatelessWidget{
  static const id= Routes.mappedDtrScreen;
  const MappedDtr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.viewMappedDTR.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => MapDtrViewMobel(context:context),
        child: Consumer<MapDtrViewMobel>(
            builder: (context, viewModel, child) {
              return Stack(
                children: [
               SingleChildScrollView(
                  child:Padding(padding: const EdgeInsets.only(left:10, right: 10),
                  child:Form(
                  key: viewModel.formKey,
                  child:Column(
                    children: [
                    Wrap(
                    spacing: 10.0,
                    runSpacing: 5.0,
                    alignment: WrapAlignment.start,
                    children: [
                      const Row(
                          children: [
                            Text("Select Filter Option"),
                          ]
                      ),
                      checkbox(context, "Feeder wise"),
                      checkbox(context, "Distribution wise"),
                      checkbox(context, "Equipment/Structure search"),
                      const Divider(),
                    ],
                  ),
                  Visibility(
                  visible: viewModel.selectedFilter == "Equipment/Structure search",
                  child:Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child:FillTextFormField(
                    controller: viewModel.equipNoORStructCode,
                    labelText: 'Enter Equipment No/Structure Code',
                    keyboardType: TextInputType.number,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "Please enter equipment number";
                    //   }
                    //   return null;
                    // },
                  ),
                  ),
                  ),
                      Visibility(
                        visible: viewModel.selectedFilter == "Distribution wise",
                        child:Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            const Text("Select Distribution", style: TextStyle(fontSize:15),),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select "),
                            value: viewModel.selectedDistribution,
                            items: viewModel.distributions.map((SubstationModel item) {
                              return DropdownMenuItem<String>(
                                value: item.optionCode,
                                child: Text(item.optionName),
                              );
                            }).toList(),
                            onChanged: (value) => viewModel.onListDistriSelected(value),
                          ),
                            ]
                          ),
                        ),
                      ),

                      Visibility(
                        visible: viewModel.selectedFilter == "Feeder wise",
                        child:Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                          child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Select Circle",
                                  style: TextStyle(fontSize: 15),
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
                                const SizedBox(height: 5,),
                                const Text("Sub Station", style: TextStyle(fontSize: 15)),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select"),
                            value: viewModel.selectedStation,
                            items: viewModel.stations.map((SubstationModel item) {
                              return DropdownMenuItem<String>(
                                value: item.optionCode,
                                child: Text(item.optionName),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                viewModel.onStationSelected(value);
                              }
                            },
                          ),
                                const SizedBox(height: 5,),
                                const Text("Choose Feeder", style: TextStyle(fontSize:15),),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text("Select"),
                                  value: viewModel.selectedFeeder,
                                  items: viewModel.feeder.map((SubstationModel item) {
                                    return DropdownMenuItem<String>(
                                      value: item.optionCode, // Using optionCode as the value
                                      child: Text(item.optionName), // Showing optionName in the dropdown
                                    );
                                  }).toList(),
                                  onChanged: (value) => viewModel.onStationSelected(value),
                                ),
                              ]
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                            text: "SEARCH",
                            onPressed: () {
                              viewModel.submitForm();
                            }
                        ),
                      ),
                ]
                  ),
                  ),
                  ),
              ),
                  if (viewModel.isLoading)
                    Positioned.fill(
                      child:  Container(
                          color: Colors.black.withOpacity(0.3),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ),
              ]
              );
            }
        ),
      ),

    );
  }
  Widget checkbox(BuildContext context, String title) {
    return Consumer<MapDtrViewMobel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: viewModel.selectedFilter == title, // Check if it's the selected option
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  viewModel.setSelectedFilter(title); // Update ViewModel
                }
              },
            ),
            Text(title),
          ],
        );
      },
    );
  }
  }