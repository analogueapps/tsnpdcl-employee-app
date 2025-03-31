import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/rfss/viewmodel/rfss_viewmodel.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/viewmodel/ss_maintenance_viewmodel.dart';
import '../../../utils/app_constants.dart';

class SsMaintenanceScreen extends StatelessWidget {
  static const id = "SsMaintenanceScreen";
  const SsMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.ssMaintenance.toUpperCase(),
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
        create: (_) => SsMaintenanceViewModel(), // Use ViewModel
        child: Consumer<SsMaintenanceViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.ssMaintenanceMenuItems.isNotEmpty
                ? GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                childAspectRatio: 1,
              ),
              itemCount: viewModel.ssMaintenanceMenuItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = viewModel.ssMaintenanceMenuItems[index];
                return GestureDetector(
                  onTap: () {
                    viewModel.menuItemClicked(context, item.title, item.routeName);
                    // Handle the item click (navigation or other actions)
                    // Navigation.instance.navigateTo(item.routeName);
                    print('${item.title} clicked');
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
                      const SizedBox(height: 8), // Add spacing between the image and text
                      Text(
                        item.title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: regularTextSize, // Specify a font size for better consistency
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
                : const Expanded(
              child: Center(
                child: Text("No menu found."),
              ),
            );
          },
        ),
      ),
    );
  }
}
