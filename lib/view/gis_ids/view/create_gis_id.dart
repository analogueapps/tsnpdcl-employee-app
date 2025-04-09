import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/create_gis_viewmodel.dart';


class CreateGisId extends StatelessWidget {
  static const id = Routes.createGisIds;
  const CreateGisId({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateGisIdViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Create Gis Id",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
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
              return Column(
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
                          const Text('33KV Line'), // Duplicate in original; adjust label if different
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Select Circle"),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      hint: const Text('SELECT'),
                      isExpanded: true,
                      value: viewModel.selectedCircle,
                      items: viewModel.circleList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value, // Use the actual value, not circleList[0]
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        viewModel.setSelectedCircle(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Sub Station"),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      hint: const Text('SELECT'),
                      isExpanded: true,
                      value: viewModel.selectedSubStation,
                      items: viewModel.subStationList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value, // Use the actual value
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        viewModel.setSelectedSubStation(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Choose Feeder"),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      hint: const Text('SELECT'),
                      isExpanded: true,
                      value: viewModel.selectedFeeder,
                      items: viewModel.feederList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value, // Use the actual value
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        viewModel.setSelectedFeeder(value);
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
              );
            },
          ),
        ),
      ),
    );
  }
}