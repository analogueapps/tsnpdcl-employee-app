import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dismantle_of_service/viewmodel/dismantle_of_service_menu_screen_viewmodel.dart';
import 'package:tsnpdcl_employee/view/wrong_billing/viewmodel/wrong_billing_menu_screen_viewmodel.dart';

class DismantleOfServiceMenuScreen extends StatelessWidget {
  static const id = Routes.dismantleOfServiceMenuScreen;
  const DismantleOfServiceMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Ero correspondence".toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "dismantle of services".toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: doubleFifteen,
                fontWeight: FontWeight.w500),
          ),
        ]),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => DismantleOfServiceMenuScreenViewmodel(),
        child: Consumer<DismantleOfServiceMenuScreenViewmodel>(
          builder: (context, viewModel, child) {
            return viewModel.dismantleService.isNotEmpty
                ? GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numThree, // Number of columns
                childAspectRatio: 1,
              ),
              itemCount: viewModel.dismantleService.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = viewModel.dismantleService[index];
                return GestureDetector(
                  onTap: () {
                    viewModel.menuItemClicked(
                        context, item.title, item.routeName);
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
