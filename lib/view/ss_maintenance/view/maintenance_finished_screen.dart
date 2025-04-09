import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/viewmodel/maintenance_finished_viewmodel.dart';

class MaintenanceFinishedScreen extends StatefulWidget {
  static const id = Routes.maintenanceFinishedScreen;
  const MaintenanceFinishedScreen({super.key});

  @override
  State<MaintenanceFinishedScreen> createState() => _MaintenanceFinishedScreenState();
}

class _MaintenanceFinishedScreenState extends State<MaintenanceFinishedScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.maintenanceCompleted.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ChangeNotifierProvider(
        create: (_) => MaintenanceFinishedViewmodel(context: context),
        child: Consumer<MaintenanceFinishedViewmodel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Search...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      viewModel.filterItems(value);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: viewModel.maintenanceItems.isEmpty
                        ? const Center(child: Text("No results found"))
                        : ListView.separated(
                      itemCount: viewModel.maintenanceItems.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = viewModel.maintenanceItems[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item["id"]!),
                            const SizedBox(height: 5),
                            Text(
                              item["name"]!,
                              style: const TextStyle(fontSize: extraTitleSize),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Date: ${item["date"]}",
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}