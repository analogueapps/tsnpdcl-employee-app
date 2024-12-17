import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/asset_mapping/viewmodel/asset_mapping_viewmodel.dart';
import 'package:tsnpdcl_employee/view/measure_distance/viewmodel/measure_distance_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class MeasureDistanceScreen extends StatefulWidget {
  static const id = Routes.measureDistanceScreen;

  const MeasureDistanceScreen({super.key});

  @override
  State<MeasureDistanceScreen> createState() => _MeasureDistanceScreenState();
}

class _MeasureDistanceScreenState extends State<MeasureDistanceScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.measureDistTitle.toUpperCase(),
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
        create: (_) => MeasureDistanceViewmodel(),
        child: Consumer<MeasureDistanceViewmodel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Point A'.toUpperCase(), style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600)),
                  const SizedBox(height: doubleFifteen),
                  Row(
                    children: [
                      const Text(
                          'Latitude',
                          style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      const Text(
                          ' : ',
                          style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      Text(
                          '${viewModel.pointALat ?? ""}',
                          style: const TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500,
                            color: Colors.green
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: doubleTen),
                  Row(
                    children: [
                      const Text(
                          'Longitude',
                          style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      const Text(
                          ' : ',
                          style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      Text(
                          '${viewModel.pointALon ?? ""}',
                          style: const TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.green
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: doubleTen),
                  const SizedBox(height: doubleFifteen),
                  Divider(
                    height: doubleOne,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: doubleFifteen),
                  Text('Point B'.toUpperCase(), style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600)),
                  const SizedBox(height: doubleFifteen),
                  Row(
                    children: [
                      const Text(
                          'Latitude',
                          style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      const Text(
                          ' : ',
                          style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      Text(
                          '${viewModel.pointBLat ?? ""}',
                          style: const TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.green
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: doubleTen),
                  Row(
                    children: [
                      const Text(
                          'Longitude',
                          style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      const Text(
                          ' : ',
                          style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      Text(
                          '${viewModel.pointBLon ?? ""}',
                          style: const TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.green
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: doubleTen),
                  const SizedBox(height: doubleFifteen),
                  Divider(
                    height: doubleOne,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: doubleFifteen),
                  Center(
                    child: Visibility(
                      visible: viewModel.pointALat != null && viewModel.pointBLat != null,
                        child: Text(
                            'Distance B/W A & B : ${viewModel.distanceInMeters?.toStringAsFixed(2)} meters',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: CommonColors.colorSecondary,
                          ),
                        ),
                    ),
                  ),
                  const SizedBox(height: doubleTwenty),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (viewModel.pointALat == null) {
                          viewModel.capturePointA(); // Capture Point A if it doesn't exist
                        } else {
                          viewModel.capturePointB(); // Capture Point B if Point A exists
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CommonColors.colorPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(doubleFive),
                        ),
                        //elevation: 15.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(doubleTwelve),
                        child: Text(
                          viewModel.pointALat == null
                              ? 'Capture Point A'.toUpperCase()
                              : 'Capture Point B'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: normalSize,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: doubleFive),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          viewModel.reset();
                        },
                        child: Text("Reset".toUpperCase(), style: const TextStyle(color: Colors.red),)
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
