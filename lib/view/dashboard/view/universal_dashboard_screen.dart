import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/url_constants.dart';
import 'package:tsnpdcl_employee/view/dashboard/viewmodel/universal_dashboard_viewmodel.dart';

class UniversalDashboardScreen extends StatefulWidget {
  static const id = Routes.universalDashboardScreen;
  const UniversalDashboardScreen({super.key});

  @override
  State<UniversalDashboardScreen> createState() => _UniversalDashboardScreenState();
}

class _UniversalDashboardScreenState extends State<UniversalDashboardScreen> {
  //final FocusNode _focusNode = FocusNode();
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        const maxDuration = Duration(seconds: millisecondsTwo);
        final isWarning =
            lastPressed == null || now.difference(lastPressed!) > maxDuration;

        if (isWarning) {
          lastPressed = DateTime.now();
          final snackBar = SnackBar(
            content: const Text(clickExitToLeave),
            backgroundColor: Colors.black87,
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(doubleTen)),
            ),
            action: SnackBarAction(
              label: exit,
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            duration: const Duration(seconds: millisecondsTwo),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return isFalse;
        } else {
          return isTrue;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            GlobalConstants.dashboardName,
            style: TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        drawer: ChangeNotifierProvider(
          create: (_) => UniversalDashboardViewModel(),
          child: Consumer<UniversalDashboardViewModel>(
            builder: (context, viewModel, child) {
              return Drawer(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Removes the curved corners
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration:
                      const BoxDecoration(color: CommonColors.colorPrimary),
                      accountName: Text(
                          viewModel.npdclUser != null ? "${viewModel.npdclUser!.empName}(${viewModel.npdclUser!.designation}/${viewModel.npdclUser!.secMasterEntity!.section})".toUpperCase() : appName.toUpperCase()
                      ),
                      accountEmail: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              viewModel.npdclUser != null ? "EMP ID:${viewModel.npdclUser!.empId}|SEC.ID:${viewModel.npdclUser!.secMasterEntity!.sectionId}".toUpperCase() : appName.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.grey
                            ),
                          ),
                          Text(
                              viewModel.npdclUser != null ? "Ph:${viewModel.npdclUser!.personalMobileNo}" : appName.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                      currentAccountPicture: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape
                              .rectangle, // Set to rectangle (square in this case)
                          image: DecorationImage(
                            image: AssetImage("assets/icons/icon.png"),
                            fit: BoxFit.cover, // Cover the area with the image
                          ),
                        ),
                      ),
                      currentAccountPictureSize: const Size(50, 50),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text(GlobalConstants.logoutTitle),
                      onTap: () {
                        Navigator.pop(context);
                        viewModel.menuItemClicked(context, GlobalConstants.logoutTitle, "");
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        body: ChangeNotifierProvider(
          create: (_) => UniversalDashboardViewModel(),
          child: Consumer<UniversalDashboardViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  Material(
                    color: Colors.white,
                    elevation: doubleFour, // Elevation for the shadow
                    child: Padding(
                      padding: const EdgeInsets.all(doubleTwenty),
                      child: TextField(
                        //focusNode: _focusNode,
                        controller: viewModel.searchController,
                        onChanged: (query) {
                          Provider.of<UniversalDashboardViewModel>(context,
                              listen: false)
                              .filterItems(query);
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: isTrue,
                            fillColor: CommonColors.textFieldColor,
                            border: Assets.squareInputBorder(),
                            enabledBorder: Assets.squareInputBorder(),
                            focusedBorder: Assets.squareFocusBorder(),
                            hintText: "Search Menu...",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                if (viewModel.searchController.text.isNotEmpty) {
                                  viewModel.searchController.clear();
                                  FocusScope.of(context).unfocus();
                                  // Trigger the onChanged logic with an empty string
                                  Provider.of<UniversalDashboardViewModel>(
                                      context,
                                      listen: false)
                                      .filterItems("");
                                }
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
                            )
                        ),
                        style: const TextStyle(
                          fontSize: titleSize,
                          fontFamily: appFontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: doubleTen,
                  ),
                  viewModel.filteredItems.isNotEmpty
                      ? Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numThree, // Number of columns
                        childAspectRatio: 1,
                      ),
                      itemCount: viewModel.filteredItems.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = viewModel.filteredItems[index];
                        return GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            viewModel.menuItemClicked(context, item.title, item.routeName);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                  child: Image.asset(
                                    item.imageAsset,
                                    height: 40.0,
                                    width: 40.0,
                                    filterQuality: FilterQuality.low,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height:
                                  doubleEight), // Add spacing between the image and text
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
                    ),
                  )
                      : const Expanded(
                      child: Center(
                        child: Text("No menu matches your search."),
                      ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
