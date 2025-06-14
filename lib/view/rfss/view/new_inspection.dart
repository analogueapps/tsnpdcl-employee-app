import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/rfss/viewmodel/new_inspection_viewmodel.dart';

class NewInspection extends StatelessWidget {
  static const id = Routes.openNewInspection;
  const NewInspection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            GlobalConstants.newInspection,
            style:  TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: ChangeNotifierProvider(
    create: (_) => NewInspectionViewmodel(context: context),
    child: Consumer<NewInspectionViewmodel>(
    builder: (context, viewModel, child) {
      return  Padding(
          padding: const EdgeInsets.all(12.0),
          child: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              :ListView.builder(
    itemCount: viewModel.dtrStructureIndexList.length,
    itemBuilder: (context, index) {
      final item = viewModel.dtrStructureIndexList[index];
      return  InkWell(
          onTap: (){
            print("structureCode: ${item.structureCode??""}");
            viewModel.openDtrDefectSheet(item.structureCode??"", item.distributionCode??"");
          },
          child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(item.structureCode?? "N/A"),
      SizedBox(height: doubleTwenty,
      child: Align(
      alignment: Alignment.centerRight, child: Text(item.maintenanceCount.toString()),),),
      Row(
      children: [
      const Text("Last Maintenance Date:"),
      Text(item.lastMaintainedDate??"N/A", style: const TextStyle(color: Colors.red),
      textAlign: TextAlign.end,),
      ],
      ),
        const Divider(color: Colors.black,),
      ]
          ),
      );
      }
          )
      );
    }
    ),
    ),
                );
              }
  }
