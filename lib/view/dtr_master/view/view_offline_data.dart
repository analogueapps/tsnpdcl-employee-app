import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

class ViewOfflineData extends StatelessWidget {
  static const id = Routes.offlineData;
  const ViewOfflineData({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
        GlobalConstants.viewOfflineData.toUpperCase(),
    style: const TextStyle(
    color: Colors.white,
    fontSize: toolbarTitleSize,
    fontWeight: FontWeight.w700),
    ),
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    ),
    body: Container(),
        floatingActionButton:FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: CommonColors.pink,
          child: const Icon(Icons.add, color: Colors.white
          ),
        ),
    );
  }
}
