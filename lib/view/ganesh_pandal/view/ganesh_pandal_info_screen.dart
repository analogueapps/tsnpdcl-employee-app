import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class GaneshPandalInfoScreen extends StatelessWidget {
  static const id = Routes.ganeshPandalInfoScreen;
  const GaneshPandalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.ganeshPandalInfoTitle.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(doubleTwenty),
            child: TextField(
              //controller: viewModel.searchController,
              // onChanged: (query) {
              //   Provider.of<UniversalDashboardViewModel>(context,
              //       listen: false)
              //       .filterItems(query);
              // },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  filled: isTrue,
                  fillColor: CommonColors.textFieldColor,
                  border: Assets.squareInputBorder(),
                  enabledBorder: Assets.squareInputBorder(),
                  focusedBorder: Assets.squareFocusBorder(),
                  hintText: "Search...",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // if (viewModel.searchController.text.isNotEmpty) {
                      //   viewModel.searchController.clear();
                      //   FocusScope.of(context).unfocus();
                      //   // Trigger the onChanged logic with an empty string
                      //   Provider.of<UniversalDashboardViewModel>(
                      //       context,
                      //       listen: false)
                      //       .filterItems("");
                      // }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(doubleTen),
                      child: Container(
                        width: doubleTwentyFour,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(doubleEight),
                          color: CommonColors.colorPrimary,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )),
              style: const TextStyle(
                fontSize: titleSize,
                fontFamily: appFontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(doubleTwenty),
        child: PrimaryButton(
            text: "Enter new pandal information".toUpperCase(),
            fullWidth: isTrue,
            onPressed: () {
              Navigation.instance.navigateTo(Routes.ganeshPandalInformationScreen);
            }
        ),
      ),
    );
  }
}
