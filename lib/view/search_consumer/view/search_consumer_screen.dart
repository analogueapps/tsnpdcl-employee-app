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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.searchConsumerTitle.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => SearchConsumerViewmodel(),
        child: Consumer<SearchConsumerViewmodel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return GoogleMap(
              initialCameraPosition: viewModel.initialCameraPosition!,
              myLocationEnabled: isFalse,
              myLocationButtonEnabled: isFalse,
              zoomControlsEnabled: isFalse,
              onMapCreated: (controller) {
                viewModel.mapController = controller;
              },
            );
          },
        ),
      ),
    );
  }
}
