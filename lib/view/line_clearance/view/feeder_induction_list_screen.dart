import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/induction_points_of_feeder_list.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/lc_master_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class FeederInductionListScreen extends StatelessWidget {
  static const id = Routes.feederInductionListScreen;
  final Map<String, dynamic> args;

  const FeederInductionListScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Induction Points".toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              args['fdrCode'],
              style: const TextStyle(fontSize: normalSize, color: Colors.grey),
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => LcMasterViewmodel(
            context: context,
            entry: "FeederInductionListScreen",
            ssCode: args['fdrCode']),
        child: Consumer<LcMasterViewmodel>(
          builder: (context, viewModel, child) {
            return viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.inductionPointsOfFeederList.isEmpty
                    ? const Center(
                        child: Text("No induction points feeder list founded."),
                      )
                    : ListView.builder(
                        itemCount: viewModel.inductionPointsOfFeederList.length,
                        itemBuilder: (context, index) {
                          final item =
                              viewModel.inductionPointsOfFeederList[index];

                          return Column(
                            children: [
                              Align(
                                alignment:
                                    Alignment.centerRight, // Align to the right
                                child: Container(
                                  width: 90,
                                  alignment: Alignment
                                      .center, // Center content within the container
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.red, // Background color
                                  ),
                                  child: Text(
                                    getInductionText(item).toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: doubleFive,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: doubleTen,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: Image.asset(
                                        getAssets(item),
                                        width: 50.0,
                                        height: 50.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: doubleTen,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getFirstText(item).toUpperCase(),
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                extraRegularSize, // Specify a font size for better consistency
                                          ),
                                        ),
                                        Text(
                                          getSecondText(item).toUpperCase(),
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize:
                                                10, // Specify a font size for better consistency
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: doubleTen,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: doubleFive,
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                                height: 1,
                              ),
                            ],
                          );
                        });
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(doubleTwenty),
        child: PrimaryButton(
            fullWidth: isTrue,
            text: "ADD/DECLARE NO INDUCTION POINT".toUpperCase(),
            onPressed: () {
              var argument = {
                'ssCode': args['ssCode'],
                'ssName': args['ssName'],
                'fdrCode': args['fdrCode'],
                'fdrName': args['fdrName'],
              };
              Navigation.instance.navigateTo(Routes.addInductionPointScreen,
                  args: argument, onReturn: (result) {
                Provider.of<LcMasterViewmodel>(context, listen: false)
                    .getInductionPointsFeederList();
              });
            }),
      ),
    );
  }

  static String getInductionText(InductionPointsOfFeederList item) {
    switch (item.inductionSource!.toLowerCase()) {
      case 'eht':
        return "EHT";
      case '33kv':
        return "33KV LINE";
      case '11kv':
        return "11KV LINE";
      case 'lt':
        return "LT LINE";
      default:
        return "NA";
    }
  }

  static String getFirstText(InductionPointsOfFeederList item) {
    switch (item.inductionSource!.toLowerCase()) {
      case 'eht':
        return "EHT LINE";
      case '33kv':
        return "SS name: ${item.indSSName}";
      case '11kv':
        return "SS name: ${item.indSSName}";
      case 'lt':
        return "SS name: ${item.indSSName}";
      default:
        return "NA";
    }
  }

  static String getSecondText(InductionPointsOfFeederList item) {
    switch (item.inductionSource!.toLowerCase()) {
      case 'eht':
        return "";
      case '33kv':
        return "FDR name: ${item.indFdrName}";
      case '11kv':
        return "Fdr name: ${item.indFdrName}(${item.interferenceType})";
      case 'lt':
        return "Fdr name: ${item.indFdrName}|${item.indDtrStructCode}";
      default:
        return "NA";
    }
  }

  static String getAssets(InductionPointsOfFeederList item) {
    switch (item.inductionSource!.toLowerCase()) {
      case 'eht':
        return Assets.electricPoleTower;
      case '33kv':
        return Assets.electricPoleS;
      case '11kv':
        return Assets.electricPoleS;
      case 'lt':
        return Assets.dtrImage;
      default:
        return Assets.electricPoleS;
    }
  }
}
