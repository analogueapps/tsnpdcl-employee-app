import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';

class CheckMeasure11kv extends StatelessWidget {
  const CheckMeasure11kv({super.key, required this.args});
  static const id = Routes.check11kvScreen;
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "Check 11kv".toUpperCase(),
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
      body: Center(child: Text("check 11kv ${args['d']}")),
    );
  }
}