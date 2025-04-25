import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/add_gis_viewmodel.dart';


class AddGisPoint extends StatelessWidget {
  static const id = Routes.addGis;
  const AddGisPoint({super.key, required this.gisIndividualData, });

  final  GisSurveyData gisIndividualData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddGisPointViewModel(context:context, gisIndiData: gisIndividualData),
      child: WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title:  Text('NEW', style: const TextStyle(
            color: Colors.white,
            fontSize: toolbarTitleSize,
            fontWeight: FontWeight.w700,
          ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Consumer<AddGisPointViewModel>(
              builder: (context, viewModel, child) => IconButton(
                onPressed: viewModel.save,
                icon: const Icon(Icons.save, color: Colors.white),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<AddGisPointViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.4), // 40% of the width
                        1: FlexColumnWidth(0.6), // 60% of the width
                      },
                      children: [
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('GIS REG'),
                            ),
                            TextField(
                              controller: viewModel.gisRegController,
                              readOnly: true,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('GIS ID'),
                            ),
                            TextField(
                              controller: viewModel.gisIdController,
                              readOnly: true,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('11KV FEEDER'),
                            ),
                            TextField(
                              controller: viewModel.feederController,
                              readOnly: true,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('VOLTAGE LEVEL'),
                            ),
                            DropdownButton<String>(
                              value: viewModel.voltageLevel,
                              isExpanded: true,
                              hint: const Text('SELECT'),
                              items: viewModel.voltageItems.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                viewModel.setVoltageLevel(newValue);
                              },
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('POINT TYPE'),
                            ),
                            DropdownButton<String>(
                              value: viewModel.pointType,
                              isExpanded: true,
                              hint: const Text('SELECT'),
                              items: viewModel.pointTypeItems.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, overflow: TextOverflow.ellipsis,),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                viewModel.setPointType(newValue);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 11),
                    TextField(
                      decoration: const InputDecoration(
                        label: Text('WORK DESCRIPTION'),
                      ),
                      readOnly: true,
                      controller: viewModel.workDescriptionController,
                    ),
                    const SizedBox(height: 11),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      color: Colors.grey.shade300,
                      child: const Text(
                        'NOW PROPOSED DETAILS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 11),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // child: Image.network(
                      //   'https://via.placeholder.com/150', // Placeholder URL; replace with actual logic
                      //   fit: BoxFit.cover,
                      //   errorBuilder: (context, error, stackTrace) {
                      //     return const Center(child: Text('Image not available'));
                      //   },
                      // ),
                      child:const Icon(Icons.image, size: 50,),
                    ),
                    const SizedBox(height: 11),
                SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                      child: const Text(
                        'CAPTURE PHOTO BEFORE MAINTENANCE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                  onPressed: () => viewModel.capturePhoto(),
                ),
                ),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.4), // 40% of the width
                        1: FlexColumnWidth(0.6), // 60% of the width
                      },
                      children: [
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('LONGITUDE'),
                            ),
                            TextField(
                              controller: viewModel.longitudeController,
                              readOnly: true,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('LATITUDE'),
                            ),
                            TextField(
                              controller: viewModel.latitudeController,
                              readOnly: true,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 11),
                    TextField(
                      decoration: const InputDecoration(
                        label: Text('REMARKS(if any)'),
                      ),
                      controller: viewModel.remarksController,
                      focusNode: viewModel.remarksFocusNode,
                    ),
                    const SizedBox(height: 11),
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButton: Consumer<AddGisPointViewModel>(
          builder: (context, viewModel, child) => FloatingActionButton(
            onPressed: viewModel.requestRemarksFocus,
            child: const Icon(Icons.edit),
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      ),
    );
  }
}