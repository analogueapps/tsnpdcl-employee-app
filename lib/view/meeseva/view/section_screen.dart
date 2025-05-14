import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/meeseva/viewmodel/section_viewmodel.dart';

class SectionScreen extends StatelessWidget {
  static const id = Routes.sectionScreen;
  const SectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SectionViewmodel(context: context),
      child: Consumer<SectionViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "Select Section".toUpperCase(),
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
                : viewModel.sectionList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.separated(
              itemCount: viewModel.sectionList.length,
              itemBuilder: (_, int index) => ListTile(
                title: Text(
                  viewModel.sectionList[index].optionName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize:
                    normalSize, // Specify a font size for better consistency
                  ),
                ),
                onTap: () {
                  viewModel.sectionListClicked(viewModel.sectionList[index]);
                },
              ),
              separatorBuilder: (_, __) => const Divider(height: 1),
            ),
          );
        },
      ),
    );
  }
}
