import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/createOffline_dtr_viewmodel.dart';

class CreateDtrOffline extends StatelessWidget {
  static const id = Routes.createOfflineDTR;

  const CreateDtrOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.createOfflineDTR.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
            icon: const Icon(Icons.close)
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => OfflineDtrViewmodel(context: context),
        child: Consumer<OfflineDtrViewmodel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location of DTR", style: TextStyle(color: Colors
                              .purple[300]),),
                          Wrap(
                              spacing: 10.0,
                              runSpacing: 5.0,
                              alignment: WrapAlignment.start,
                              children: [
                                Row(children: [checkbox(context, "SPM"),
                                  checkbox(context, "STORE"),
                                  checkbox(context, "STRUCTURE"),
                                ]),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: viewModel.subStationSelected=="SUB STATION",
                                    // Check if it's the selected option
                                    onChanged: (bool? newValue) {
                                      if (newValue == true) {
                                        viewModel.setSelectedSubStation("SUB STATION");
                                      } else {
                                        viewModel.setSelectedSubStation(""); // or "", depending on how you handle it
                                      }
                                    },
                                  ),
                                  Text("SUB STATION"),
                                ],
                              ),
                              ]
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
    return Consumer<OfflineDtrViewmodel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: viewModel.selectedFilter == title,
              // Check if it's the selected option
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

