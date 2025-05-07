import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dlist/viewmodel/cluster_map_viewmodel.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/common_colors.dart' show CommonColors;

class ClusterMapScreen extends StatelessWidget {
  static const id = Routes.clusterMapScreen;
  final CameraPosition _initialPosition =
  CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 12);
  final Map<String, dynamic> data;

   ClusterMapScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClusterMapViewmodel(context: context, data: data),
      child: Consumer<ClusterMapViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              // appBar: AppBar(
              //   backgroundColor: Colors.transparent,
              //   title: Text(
              //     "Sections".toUpperCase(),
              //     style: const TextStyle(
              //         color: Colors.white,
              //         fontSize: toolbarTitleSize,
              //         fontWeight: FontWeight.w700),
              //   ),
              //   iconTheme: const IconThemeData(
              //     color: Colors.white,
              //   ),
              // ),
              body: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                myLocationEnabled: true,
                mapToolbarEnabled: false,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: true,
                minMaxZoomPreference: const MinMaxZoomPreference(6, 19),
                initialCameraPosition: viewModel.clusterPlaces.isNotEmpty
                    ? CameraPosition(target: viewModel.parseLatLngFromString(viewModel.clusterPlaces.first.latLong), zoom: 12)
                    : const CameraPosition(target: LatLng(17.969167, 79.595918), zoom: 12),
                markers: viewModel.markers,
                onCameraMove: viewModel.clusterManager?.onCameraMove ?? (_) {},
                onCameraIdle: viewModel.clusterManager?.updateMap ?? () {},
                onMapCreated: (controller) async {
                  if (!viewModel.googleMapController.isCompleted) {
                    viewModel.setController(controller);
                    await viewModel.initClusterManager(); // call this new method
                  }
                },
              ),
          );
        },
      ),
    );
  }
}
