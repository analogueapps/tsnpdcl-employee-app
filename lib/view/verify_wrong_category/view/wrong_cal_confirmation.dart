import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';

class WrongCatConfirmation extends StatelessWidget {
  static const id = Routes.wrongCatConfirmationServices;
  const WrongCatConfirmation({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: CommonColors.colorPrimary,
            title: const Text('Wrong Cat Confirmations', style: TextStyle(
                color: Colors.white,
                fontSize: titleSize,
                fontWeight: FontWeight.w700),),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            leading:
            IconButton(onPressed: () {
              Navigator.of(context).pop();
            }, icon: const Icon(Icons.arrow_back))

        ),
        body: Text("AreaWise Abstart onTap ${args['areaCode']}"),
    );
  }
}