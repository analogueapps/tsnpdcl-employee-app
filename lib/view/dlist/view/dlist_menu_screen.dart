import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dlist/viewmodel/dlist_menu_viewmodel.dart';

class DlistMenuScreen extends StatelessWidget {
  static const id = Routes.dlistMenuScreen;
  const DlistMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DlistMenuViewmodel(context: context),
      child: Consumer<DlistMenuViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: CommonColors.colorPrimary,
                title: Text(
                  "Sections".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: toolbarTitleSize,
                      fontWeight: FontWeight.w700),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              body: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox()
          );
        },
      ),
    );
  }
}
