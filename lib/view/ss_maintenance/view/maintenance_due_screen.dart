import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/viewmodel/maintenance_due_viewmodel.dart';

class MaintenanceDueScreen extends StatelessWidget {
  static const id = Routes.maintenanceDueScreen;
  const MaintenanceDueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.maintenanceDue.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ChangeNotifierProvider(
    create: (_) => MaintenanceDueViewModel(context: context), // Use ViewModel
    child: Consumer<MaintenanceDueViewModel>(
    builder: (context, viewModel, child) {
    return Column(
    children: [
    // Search Bar
    const Padding(
    padding: EdgeInsets.all(16.0),
    child: TextField(
    decoration: InputDecoration(
    hintText: "Search...",
    prefixIcon: Icon(Icons.search),
    filled: true,
    fillColor: Colors.white,
    ),
    ),
    ),
    // Centered "It's empty here" text
      Expanded(
        child: viewModel.maintenanceItems.isEmpty
            ? const Center(child: Text("No Data found"))
            :  Padding(
      padding: const EdgeInsets.all(16.0),
      child:ListView.separated(
            itemCount: viewModel.maintenanceItems.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = viewModel.maintenanceItems[index];
              return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("#${viewModel.maintenanceItems[index]
                        .maintenanceId}", style: const TextStyle(
                        fontSize: doubleTwelve),),
                    const SizedBox(height: 5),
                    Text( //ssCode
                      viewModel.maintenanceItems[index].ssCode!,
                      style: const TextStyle(
                          fontSize: doubleFourteen),
                    ),
                    const SizedBox(height: 5),
                    Text( //inspectedDate
                      "Date: ${viewModel.maintenanceItems[index]
                          .inspectedDate}",
                      style: const TextStyle(color: Colors.green,
                          fontSize: doubleTwelve),
                    ),
                  ],
              );
            }
        ),
        ),
      ),
    ]
    );
    }
    ),
      ),
    );
  }
}
