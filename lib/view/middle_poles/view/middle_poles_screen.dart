import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart'; // Import dialog method
import 'package:tsnpdcl_employee/utils/general_routes.dart'; // Import Routes
import 'package:tsnpdcl_employee/view/middle_poles/viewmodel/middle_poles_viewmodel.dart';
import '../../../utils/app_constants.dart';

class MiddlePolesScreen extends StatelessWidget {
  static const id = "MiddlePolesScreen";
  const MiddlePolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.middlePoles.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: toolbarTitleSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => MiddlePolesViewModel(),
        child: Consumer<MiddlePolesViewModel>(
          builder: (context, viewModel, child) {
            return ListView.builder(
              itemCount: viewModel.menuItems.length,
              itemBuilder: (context, index) {
                final item = viewModel.menuItems[index];
                return GestureDetector(
                  onTap: () {
                    // Call the method for all items
                    viewModel.mpNewMenuItemClicked(context, item);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          item.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(height: 0.1, color: Colors.grey[200]),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}