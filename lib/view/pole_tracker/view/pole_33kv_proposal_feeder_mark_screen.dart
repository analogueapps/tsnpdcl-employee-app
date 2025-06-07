import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';

class Pole33kvProposalFeederMarkScreen extends StatelessWidget {
  static const id = Routes.pole33kvProposalFeederMarkScreen;
  final Map<String, dynamic> args;

  const Pole33kvProposalFeederMarkScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
        "Select".toUpperCase(),
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
    body:Text(""),
    );

  }
}
//Should do
