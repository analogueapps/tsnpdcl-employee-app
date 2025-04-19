import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/viewmodel/dtr_failure_reports_viewmodel.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/viewmodel/inspection_closed_viewmodel.dart';

class ViewInspectionReports extends StatelessWidget {
  static const id = Routes.viewDTRsInspectionScreen;
  const ViewInspectionReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          "Dtr Failure Reports",
          style: TextStyle(
            color: Colors.white,
            fontSize: toolbarTitleSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ChangeNotifierProvider(
        create: (_) => InspectionClosedViewmodel(context: context, fileStatus: 'PENDING', ),
        child: Consumer<InspectionClosedViewmodel>(
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
                        ]
                    ),
                  ]
              );
            }
        ),
      ),
    );

  }
}
