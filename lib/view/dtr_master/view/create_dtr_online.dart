import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/createOnline_dtr_viewmodel.dart';

class CreateDtrOnline extends StatelessWidget {
  static const id= Routes.createOnlineDTR;
  const CreateDtrOnline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
        GlobalConstants.createOnlineDTR.toUpperCase(),
        style: const TextStyle(
        color: Colors.white,
        fontSize: toolbarTitleSize,
        fontWeight: FontWeight.w700),
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: const Icon(Icons.close)
        ),
        iconTheme: const IconThemeData(
        color: Colors.white,
        ),
          actions: const [
            TextButton(onPressed: null,
                child: Text("UPDATE DTR MAKES", style: TextStyle(color: Colors.white),))
          ],
    ),
    body: ChangeNotifierProvider(
    create: (_) => OnlineDtrViewmodel(context:context),
    child: Consumer<OnlineDtrViewmodel>(
    builder: (context, viewModel, child) {
    return SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(16),
      child:Form(
      key: viewModel.formKey,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location of DTR", style: TextStyle(color: Colors.purple[300]),),
      Wrap(
      spacing: 10.0,
      runSpacing: 5.0,
      alignment: WrapAlignment.start,
      children: [
      checkbox(context, "STRUCTURE"),
      checkbox(context, "SUB STATION"),
      Container(
        height: 50,
        color:Colors.grey[200],
        child: Center(child:Text(
          "DTR Structure Details",
          style: TextStyle(color: Colors.purple[300]
          ),
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
                    items: viewModel.distributions.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) => viewModel.onListDistriSelected(value),
                  ),
                ]
            ),
          ),
        )
      ],
      ),
      ]
      ),
      ),
      ),
    );
    }
    ),
    ),
    );
  }
  Widget checkbox(BuildContext context, String title) {
    return Consumer<OnlineDtrViewmodel>(
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
