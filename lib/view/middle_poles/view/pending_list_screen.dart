import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';

class PendingListScreen extends StatelessWidget {
  static const id = "PendingListScreen";
  const PendingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              GlobalConstants.newMiddlePoles.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            const Text(
                "APR 2025",
            style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onTap: () {
          Navigation.instance.navigateTo(Routes.viewDetailedPendingListScreen);
        },
        child: Container(
          margin: const EdgeInsets.all(14),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Survey Id: 31125",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              Text(
                "Survey",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),),
              Text(
                "Survey - LatA 17.4446414, LonA 78.3843504",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),),
              Text(
                  "EMP ID: 70000000|Section: NAKKALAGUTTA",
                style: TextStyle(
                    fontSize: 16,
                ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "01 Apr 2025 03:22",
                  style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                      "PENDING",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      )
    );
  }
}
