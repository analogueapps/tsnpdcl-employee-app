import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/gis_ids_viewmodel.dart';

class GISIDsScreen extends StatelessWidget {
  static const id = Routes.viewGisIdsScreen;
  const GISIDsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          "GIS IDs",
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body:  ChangeNotifierProvider(
    create: (_) => GISIDsViewModel(context: context),
    child: Consumer<GISIDsViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
              children: [
                Column(
          children: [
          Padding(
          padding: const EdgeInsets.all(10),
    child: TextField(
    controller: viewModel.searchController,
    decoration: const InputDecoration(
    prefixIcon: Icon(Icons.search),
    labelText: 'Search..',
    ),
    ),
    ),
    Expanded(
    child: Padding(
    padding: const EdgeInsets.all(10),
    child: ListView.builder(
    itemCount: viewModel.gisData.length,
    itemBuilder: (context, index) {
    final item = viewModel.gisData[index];
    return Column(
    children: [
    InkWell(
    onTap: () {
    // print("gisId:${item.gisId} ");
      Navigation.instance.navigateTo(Routes.gisIndividual, args: item.gisId);

    },
    child: SizedBox(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'GIS ID: ${item.regNum}', // Using regNum as the display ID
    style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    Text('Work Description: ${item.workDescription}'),
    Text('EMP ID: ${item.empId}'),
    ],
    ),
    ),
    ),
    Align(
    alignment: Alignment.bottomRight,
    child: Row(children:[
      ElevatedButton(
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey.shade200,
    foregroundColor: Colors.black,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
    ),
    ),
    onPressed: () {
    viewModel.saveForOffline(item.regNum!);
    },
    child: const Text('SAVE FOR OFFLINE'),
    ),
     const SizedBox(
        width: 10,
      ),
      Visibility(
      visible:item.sapUploadFlag=="F",
      child:
      ElevatedButton(
      style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
      ),
      ),
      onPressed: () {
      viewModel.postGisIDtoSAP(item.gisId!);
      },
      child: const Text('POST TO SAP', style:TextStyle(color: Colors.white),),
      ),
      ),
      ]
    ),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Divider(color: Colors.grey.shade400),
    ),
    ],
    );
    },
    ),
    ),
    ),
    ],
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
    },
    ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: (){
          Navigation.instance.navigateTo(Routes.createGisIds);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}