import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/gis_offline_viewmodel.dart';

class GisOfflineList extends StatelessWidget {
  static const id = Routes.gisOfflineForms;
  const GisOfflineList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OfflineGisViewModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: Text(
            "Gis Pending offline list".toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          actions: const [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.upload,
                  color: Colors.white,
                ))
          ],
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Consumer<OfflineGisViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.offlineGisData.isEmpty) {
              return const Center(child: Text('No offline GIS data available'));
            }
            return ListView.builder(
              itemCount: viewModel.offlineGisData.length,
              itemBuilder: (context, index) {
                final item = viewModel.offlineGisData[index];
                return GestureDetector(
                  onTap: () {
                    Navigation.instance.navigateTo(
                      Routes.addGis,
                      args: {
                        'gis': true,
                        'gisId': item.gisId,
                        'gisReg': "GIS-00${item.regNum}",
                        't': "11KV",
                      },
                    );
                  },
                  child: ListTile(
                    title: Text('GIS ID: ${item.regNum}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Work Description: ${item.workDescription}'),
                        Text('EMP ID: ${item.empId}'),
                      ],
                    ),
                    // onTap: () {
                    //   Navigation.instance.navigateTo(Routes.addGis);
                    // },
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
