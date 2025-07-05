import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/cat_one_two_unpaid/viewmodel/cat_23_confirm_list_viewmodel.dart';
import 'package:tsnpdcl_employee/view/suppressed_units/viewmodel/suppressed_confirm_list_viewmodel.dart';

class SuppressedConfirmList extends StatelessWidget {
  static const id = Routes.suppressedConfirmList;
  const SuppressedConfirmList({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            'Suppressed Units Insp',
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
            SuppressedConfirmListViewmodel(context: context, args: args),
        child: Consumer<SuppressedConfirmListViewmodel>(
            builder: (context, viewModel, child) {
              return const Text(""); //
            }),
      ),
    );
  }
}
