import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dlist/viewmodel/cluster_map_viewmodel.dart';

class ClusterMapScreen extends StatelessWidget {
  static const id = Routes.clusterMapScreen;
  final Map<String, dynamic> data;

   const ClusterMapScreen({
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
                  : Stack(
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                    myLocationEnabled: true,
                    mapToolbarEnabled: false,
                    zoomGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    minMaxZoomPreference: const MinMaxZoomPreference(6, 19),
                    initialCameraPosition: viewModel.clusterPlaces.isNotEmpty
                        ? CameraPosition(target: viewModel.parseLatLngFromString(viewModel.clusterPlaces.first.latLong), zoom: 12)
                        : CameraPosition(target: viewModel.parseLatLngFromString("18.0008N,79.5500E"), zoom: 12),
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
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 70.0),
                      color: const Color(0x85000000), // semi-transparent black
                      alignment: Alignment.center,
                      child: Text(
                        viewModel.titleText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            floatingActionButton: Visibility(
              visible: viewModel.clusterPlaces.isNotEmpty,
              child: FloatingActionButton(
                onPressed: () {
                  viewModel.filterFabClicked();
                },
                backgroundColor: CommonColors.colorPrimary,
                child: const Icon(Icons.filter_alt_outlined, color: Colors.white,),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar:  viewModel.isLoading
                ? const SizedBox()
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        viewModel.getRangeDListServicesFromServer();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('Re-sync'.toUpperCase()),
                    ),
                  ),
                  const SizedBox(width: 80,),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        viewModel.findServiceClicked();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('Find service'.toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
