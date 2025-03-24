import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/viewmodel/ctpt_menu_viewmodel.dart';

class CtptMenuScreen extends StatelessWidget {
  static const id = Routes.ctptMenuScreen;
  const CtptMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          "CTPT Menu",
          style: TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CtptMenuViewModel(),
        child: Consumer<CtptMenuViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.ctptMenuItems.isNotEmpty
                ? Expanded(
              child: ListView.separated(
                itemCount: viewModel.ctptMenuItems.length,
                itemBuilder: (_, int index) => ListTile(
                  title: Text(
                      viewModel.ctptMenuItems[index].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize:
                      normalSize, // Specify a font size for better consistency
                    ),
                  ),
                  onTap: () {
                    // Navigator.pushNamed(
                    //     context, viewModel.ctptMenuItems[index].routeName);
                    Navigation.instance.navigateTo(viewModel.ctptMenuItems[index].routeName);
                  },
                ),
                separatorBuilder: (_, __) => const Divider(height: 1),
              ),
            )
                : const Expanded(
                child: Center(
                  child: Text("No menu founded."),
                ));
          },
        ),
      ),
    );
  }
}
