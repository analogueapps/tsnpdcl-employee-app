import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/gis_ids/database/pending_offline_list_db.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';

class PendingOfflineList extends StatelessWidget {
  static const id = Routes.viewPendingOfflineForms;
  const PendingOfflineList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      IconButton(onPressed: null, icon: Icon(Icons.upload,color: Colors.white,))
    ],
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    ),
    body:FutureBuilder<List<GisSurveyData>>(
      future: DatabaseHelper.instance.getAllGisSurveyData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final gisData = snapshot.data ?? [];
        if (gisData.isEmpty) {
          return const Center(child: Text('No offline GIS data found.'));
        }
        return ListView.builder(
          itemCount: gisData.length,
          itemBuilder: (context, index) {
            final item = gisData[index];
            return ListTile(
              title: Text('Survey ID: ${item.surveyId}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Work Description: ${item.workDescription}'),
                ],
              ),
              onTap: () {
                Navigation.instance.navigateTo(Routes.viewWorkScreen, args: gisData);
              },
            );
          },
        );
      },
    ),
    );
  }
}
