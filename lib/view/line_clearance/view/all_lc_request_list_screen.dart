import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/all_lc_request_list_viewmodel.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/line_clearance_viewmodel.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/lc_master_viewmodel.dart';

class AllLcRequestListScreen extends StatelessWidget {
  static const id = Routes.allLcRequestListScreen;
  final String status;

  const AllLcRequestListScreen({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AllLcRequestListViewModel(context: context, status: status),
      child: Consumer<AllLcRequestListViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Requested LC's".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: toolbarTitleSize,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    viewModel.allLcRequestList.isNotEmpty ? "Showing ${viewModel.allLcRequestList.length} Lc(s)" : "",
                    style: const TextStyle(fontSize: normalSize, color: Colors.grey),
                  ),
                ],
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.allLcRequestList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.separated(
              itemCount: viewModel.allLcRequestList.length,
              itemBuilder: (_, int index) => ListTile(
                title: Text(
                  viewModel.allLcRequestList[index].status!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize:
                    normalSize, // Specify a font size for better consistency
                  ),
                ),
              ),
              separatorBuilder: (_, __) => const Divider(),
            ),
          );
        },
      ),
    );
  }
}
