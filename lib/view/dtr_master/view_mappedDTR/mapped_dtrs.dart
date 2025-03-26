import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'map_dtr_viewmodel.dart';

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
        create: (_) => MapDtrViewMobel(),
        child: Consumer<MapDtrViewMobel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter equipment number";
                  }
                  return null;
                },
              ),
              ),
              ),
                ]
                  ),
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