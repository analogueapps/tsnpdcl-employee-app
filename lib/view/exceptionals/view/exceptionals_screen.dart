import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/exceptionals/viewmodel/exceptionals_viewmodel.dart';

class ExceptionalsScreen extends StatelessWidget {
  static const id = Routes.exceptionalsScreen;
  const ExceptionalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExceptionalsViewmodel(context: context),
      child: Consumer<ExceptionalsViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "Exceptionals".toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: viewModel.initialCameraPosition!,
                  // markers: viewModel.markerPosition != null ? {
                  //   Marker(
                  //     markerId: MarkerId(viewModel.consumerLocation?.consumerName ?? 'unknown'),
                  //     position: viewModel.markerPosition!,
                  //     infoWindow: InfoWindow(
                  //       title: viewModel.consumerLocation?.scno ?? 'Unknown',
                  //     ),
                  //   ),
                  // } : {},
                  markers: viewModel.markers,
                  myLocationEnabled: isFalse,
                  myLocationButtonEnabled: isFalse,
                  zoomControlsEnabled: isFalse,
                  onMapCreated: (controller) {
                    viewModel.mapController = controller;
                  },
                ),
                Positioned(
                  bottom: doubleFifty,
                  left: doubleSixteen,
                  right: doubleSixteen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("Re-sync", style: TextStyle(color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.findServiceClicked();
                          print("findServiceClicked is clicked");
                        },
                        child: const Text("Find Service"),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  top: doubleSixteen,
                  left: doubleSixteen,
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.orange),
                      SizedBox(width: 8),
                      Text("Burnt", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 16),
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 8),
                      Text("Struck Up", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            )
          );
        },
      ),
    );
  }
}
