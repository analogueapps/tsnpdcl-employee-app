import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/vital_service_inspection/viewmodel/vital_service_inspection_viewmodel.dart';

class VitalServiceInspectionScreen extends StatelessWidget {
  static const id = Routes.vitalServiceInspectionScreen;
  const VitalServiceInspectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            'Vital Service Inspections ',
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
            VitalServiceInspectionViewmodel(context: context),
        child: Consumer<VitalServiceInspectionViewmodel>(
            builder: (context, viewModel, child) {
              return const Text(""); //
            }),
      ),
    );
  }
}
