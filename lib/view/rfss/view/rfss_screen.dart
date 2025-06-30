import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/rfss/viewmodel/rfss_viewmodel.dart';

class RfssScreen extends StatelessWidget {
  static const id = Routes.rfssScreen;
  const RfssScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.rfssMenu.toUpperCase(),
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
        create: (_) => RfssViewModel(),
        child: Consumer<RfssViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.rfssMenuItems.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numThree, // Number of columns
                      childAspectRatio: 1,
                    ),
                    itemCount: viewModel.rfssMenuItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = viewModel.rfssMenuItems[index];
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          // viewModel.rfssMenuItemClicked(context, item.title);
                          // Navigation.instance.navigateTo(item.routeName!);
                          viewModel.rfssMenuItemClicked(context, item.title);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16.0),
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
