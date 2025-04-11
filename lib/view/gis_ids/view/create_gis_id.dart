import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/create_gis_viewmodel.dart';

//CreateGisIdActivity
class CreateGisId extends StatelessWidget {
  static const id = Routes.createGisIds;
  const CreateGisId({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateGisIdViewModel(context: context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            "Create Gis Id",
            style:  TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            tooltip: 'Cancel',
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(11),
          child: Consumer<CreateGisIdViewModel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text('Choose Line Voltage'),

                  Row(
              children: [
              Row(
              children: [
              Checkbox(
              value: viewModel.is33KVLine1,
              onChanged: (value) {
              viewModel.toggle33KVLine1(value);
              },
              ),
              const SizedBox(width: 5),
              const Text('33KV Line'),
              ],
              ),
              Row(
              children: [
              Checkbox(
              value: viewModel.is33KVLine2,
              onChanged: (value) {
              viewModel.toggle33KVLine2(value);
              },
              ),
              const SizedBox(width: 5),
              const Text('11KV Line'),
              ],
              ),
              ],
              ),
                  const SizedBox(height: 10),
                  const Text("Select Circle"),
                  SizedBox(
                    width: double.infinity,
                    child:  DropdownButton<String>(
                      isExpanded: true,
                      hint:  const Text("Select"),
                      value: viewModel.selectedCircle,
                      items: viewModel.circle.map<DropdownMenuItem<String>>((Circle item) {
                        return DropdownMenuItem<String>(
                          value: item.circleId,
                          child: Text(item.circleName),
                        );
                      }).toList(),
                      onChanged: (String? value) => viewModel.onListCircleSelected(value),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Sub Station", style: TextStyle(
                    color: CommonColors.colorPrimary,
                  ),),

                  const SizedBox(height: doubleTen),
              DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select an option"),
              value: viewModel.selectedStation, // Maps to _selectedSubStation
              items: viewModel.stations // Maps to _stations
                  .map((item) => DropdownMenuItem<String>(
              value: item.optionCode,
              child: Text(item.optionName ?? ''),
              ))
                  .toList(),
              onChanged: (value) {
              viewModel.onStationSelected(value); // Calls the selection handler
              },
              ),
                  const SizedBox(height: 10),
                  const Text("Choose Feeder"),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      hint: const Text('SELECT'),
                      isExpanded: true,
                      value: viewModel.selectedFeeder,
                      items:  viewModel.feeder // Maps to _stations
                          .map((item) => DropdownMenuItem<String>(
                        value: item.optionCode,
                        child: Text(item.optionName ?? ''),
                      ))
                          .toList(),
                      onChanged: (value) {
                        viewModel.onListFeederSelected(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Land Mark'),
                  TextField(
                    controller: viewModel.landMarkController,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Work Description'),
                  TextField(
                    controller: viewModel.workDescriptionController,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.submit();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text('SUBMIT'),
                    ),
                  ),
                ],
              ),
              );
            },
          ),
        ),
      ),
    );
  }
}