import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/meeseva/viewmodel/meeseva_menu_viewmodel.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/viewmodel/online_pr_menu_viewmodel.dart';

class MeesevaMenuScreen extends StatelessWidget {
  static const id = Routes.meesevaMenuScreen;
  const MeesevaMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.meesevaTitle.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => MeesevaMenuViewModel(context: context),
        child: Consumer<MeesevaMenuViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.meesevaMenuItems.isNotEmpty
                ? GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numThree, // Number of columns
                childAspectRatio: 1,
              ),
              itemCount: viewModel.meesevaMenuItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = viewModel.meesevaMenuItems[index];
                return GestureDetector(
                  onTap: () {
                    viewModel.menuItemClicked(item.title, item.routeName);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: item.cardColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: RepaintBoundary(
                          child: Icon(
                            item.iconAsset,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                          8), // Add spacing between the image and text
                      Text(
                        item.title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize:
                          regularTextSize, // Specify a font size for better consistency
                        ),
                      ),
                    ],
                  ),
                );
              },
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
