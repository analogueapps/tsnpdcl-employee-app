import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';

class DtrFailureReporting extends StatelessWidget {
  static const id = Routes.viewFailureReports;
  const DtrFailureReporting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("View failure Reports"),),
    );
  }
}
