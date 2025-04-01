import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';

class NewInspection extends StatelessWidget {
  static const id = Routes.openNewInspection;
  const NewInspection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            GlobalConstants.newInspection,
            style:  TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: const SingleChildScrollView(
                  child:Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column( //use ListTitle here
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                                Text("12248-H B COLONY-NKG-SS-0002"),
                      SizedBox(height: doubleTwenty,
                        child: Align(alignment: Alignment.centerRight,child:Text("0"),),),
                      Row(
                        children:[
                         Text("Last Maintenance Date:"),
                         Text("NEVER", style: TextStyle(color: Colors.red), textAlign: TextAlign.end,),
                         Divider(),
                      ],
                      ),
                      ]

                    ),
                  ),
        ),
                );
              }
  }
