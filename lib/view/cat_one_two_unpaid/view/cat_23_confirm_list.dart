import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/cat_one_two_unpaid/viewmodel/cat_23_confirm_list_viewmodel.dart';

class Cat23ConfirmList extends StatelessWidget {
  static const id = Routes.catConfirmList;
  const Cat23ConfirmList({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            'Cat2&3 unpaid Inspection',
            style: TextStyle(
                color: Colors.white,
                fontSize: titleSize,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back))),
      body: ChangeNotifierProvider(
        create: (_) =>
            Cat23ConfirmListViewmodel(context: context, args: args),
        child: Consumer<Cat23ConfirmListViewmodel>(
            builder: (context, viewModel, child) {
              return viewModel.isLoading
              ? const Center(
              child: CircularProgressIndicator(),
    )
        : Padding(
    padding: const EdgeInsets.all(11.0),
    child: ListView.builder(
    itemCount: viewModel.catList.length,
    itemBuilder: (context, index) {
              final item = viewModel.catList[index];
              return InkWell(
              onTap: () {
              Navigation.instance.navigateTo(
              Routes.catListDetail,
              args: jsonEncode(item));
              },
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Text("Name: ${item.name}"),
                        Text(item.filedobservFlag=="Y"?"VERIFIED":"PENDING", style: const TextStyle(color: Colors.red, fontSize: 14),)
                        ]
                      ),
                      const SizedBox(height: doubleFive,),
                      Text("USCNO: ${item.uan}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize:16),),
                      Text("SCNO: ${item.scno}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize:16),),
                      const SizedBox(height: doubleFive,),
                      Text("Verified By: ${item.empid}"),
                      Text("Verified Date & Time: ${item.datetime}", style: TextStyle(color:Colors.green[800]),)
                    ]
                    ),
                  ),
                ),
              );
              }
    ),
              );
            }
            ),
      ),
    );
  }
}
