import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/verify_wrong_category/viewmodel/wrong_cat_confirmation_viewmodel.dart';

class WrongCatConfirmation extends StatelessWidget {
  static const id = Routes.wrongCatConfirmationServices;
  const WrongCatConfirmation({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            'Wrong Cat Confirmations',
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
            WrongCatConfirmationViewmodel(context: context, args: args),
        child: Consumer<WrongCatConfirmationViewmodel>(
            builder: (context, viewModel, child) {
          return const Text(""); //
        }),
      ),
    );
  }
}
