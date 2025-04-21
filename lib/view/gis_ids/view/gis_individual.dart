import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/gis_individual_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class GisIndividualId extends StatelessWidget {
  static const id = Routes.gisIndividual;

  const GisIndividualId({super.key, required this.individualGIDId});

  final int individualGIDId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          GisIndividualIdViewModel(context: context, gisID: individualGIDId),
      child: Consumer<GisIndividualIdViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "GIS- $individualGIDId",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigation.instance.navigateTo(Routes.addGis);
                    },
                    child: const Text(
                      "ADD GIS POINT",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.gisData.isEmpty
                          ? const Center(child: Text('No GIS data available'))
                          : InkWell(
                              onTap: () {
                                Navigation.instance.navigateTo(
                                    Routes.viewWorkScreen,
                                    args: viewModel.gisData);
                              },
                              child: ListView.builder(
                                itemCount: viewModel.gisData.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.gisData[index];
                                  return ListTile(
                                    title: Text(
                                        'SURVEY ID: ${item.surveyId ?? 'N/A'}'),
                                    subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Work Description: ${item.workDescription ?? 'N/A'}'),
                                          Text(item.feederName ?? 'N/A'),
                                          Text(
                                              'LatA:${item.beforeLat ?? 'N/A'}'),
                                          Text(
                                              'LonA:${item.pbeforeLon ?? 'N/A'}'),
                                          Text(
                                            item.dateOfBeforeMarked ?? 'N/A',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                           Align(
                                              alignment: Alignment.bottomLeft,
                                              child: SizedBox(
                                                width: 200,
                                                child: item.status == "PENDING"? PrimaryButton(
                                                    text: 'SAVE FOR OFFLINE',
                                                    onPressed: () {
                                                      viewModel.saveForOffline(
                                                          individualGIDId);
                                                    }):null,
                                              ),
                                            ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Divider(),
                                        ]),
                                    trailing: Text(
                                      item.status ?? 'N/A',
                                      style: TextStyle(
                                          color: item.status == "PENDING"
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: 15),
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
