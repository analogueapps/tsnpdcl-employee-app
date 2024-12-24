import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';

class GaneshPandalInformationScreen extends StatelessWidget {
  static const id = Routes.ganeshPandalInformationScreen;
  const GaneshPandalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
            "Pandal information".toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
            fontSize: toolbarTitleSize,
            fontWeight: FontWeight.w700
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}
