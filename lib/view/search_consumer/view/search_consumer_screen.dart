import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/search_consumer/viewmodel/search_consumer_viewmodel.dart';

class SearchConsumerScreen extends StatelessWidget {
  static const id = Routes.searchConsumerScreen;

  const SearchConsumerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchConsumerViewmodel(context: context),
      child: Consumer<SearchConsumerViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.searchConsumerTitle.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () async {
                    final result = await showTextInputDialog(
                      context: context,
                      title: 'Search Consumer',
                      message: 'Enter unique service number',
                      okLabel: 'Search',
                      cancelLabel: 'Cancel',
                      isDestructiveAction: true,
                      barrierDismissible: false,
                      textFields: [
                        const DialogTextField(
                          keyboardType: TextInputType.number,
                          hintText: 'Enter unique service number',
                        ),
                      ],
                    );

                    if (result != null &&
                        result[0] != null &&
                        result[0] is String) {
                      // Get the service number from the dialog result
                      String serviceNumber = result[0];

                      viewModel.searchConsumer(serviceNumber);
                    }
                  },
                ),
              ],
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    // initialCameraPosition: CameraPosition(
                    //   target: viewModel.markerPosition ?? const LatLng(0, 0),
                    //   zoom: viewModel.markerPosition != null ? 15.0 : 0,
                    // ),
                    initialCameraPosition: viewModel.initialCameraPosition!,
                    markers: viewModel.markerPosition != null ? {
                      Marker(
                        markerId: MarkerId(viewModel.consumerLocation?.consumerName ?? 'unknown'),
                        position: viewModel.markerPosition!,
                        infoWindow: InfoWindow(
                          title: viewModel.consumerLocation?.scno ?? 'Unknown',
                        ),
                      ),
                    } : {},
                    myLocationEnabled: isFalse,
                    myLocationButtonEnabled: isFalse,
                    zoomControlsEnabled: isFalse,
                    onMapCreated: (controller) {
                      viewModel.mapController = controller;
                    },
                  ),
          );
        },
      ),
    );
  }
}
