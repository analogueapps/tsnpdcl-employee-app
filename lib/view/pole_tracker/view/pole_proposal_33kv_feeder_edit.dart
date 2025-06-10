import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/pole_proposal_33kv_feeder_edit_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class PoleProposal33kvFeederEdit extends StatelessWidget {
  static const id = Routes.pole33kvProposalFeederMarkEditScreen;
  final Map<String, dynamic> args;

  const PoleProposal33kvFeederEdit({
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
            children: [
          Text(
          "Edit Mode".toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700
          ),
        ),
        Text("${args['fn']}(${args['fc']})",
          style: const TextStyle(
            color: Colors.white,
            fontSize: btnTextSize,
            fontWeight: FontWeight.w700
        ),),
        ]
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

      ),
      body: ChangeNotifierProvider(
          create: (_) =>
              PoleProposal33kvFeederEditViewmodel(context: context, args: args),
          child: Consumer<PoleProposal33kvFeederEditViewmodel>(
              builder: (context, viewModel, child) {
                return  Form(
                    key: viewModel.formKey,
                    child: Stack(children: [
                    Column(
                    children: [
                    Expanded(
                    child: GoogleMap(
                    initialCameraPosition: viewModel.cameraPosition ?? const CameraPosition(target: LatLng(0, 0), zoom: 10),
                polylines: viewModel.polylines,
                markers: viewModel.markers,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                onMapCreated: (controller) {
                viewModel.mapController = controller;
                },
                ),
                ),
                Expanded(
                child: viewModel.deleteOrEdit==isFalse?
                Container():
                const SingleChildScrollView(
                padding: EdgeInsets.only(
                right: 10, left: 10, bottom: 30),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 ViewDetailedLcTileWidget(
                tileKey: "SubStation",
                tileValue: "0000",
                valueColor: Colors.red,
                ),
                ]
                ),
                ),
                ),
                ]
                ),
                ]
                )
                );
                }
          )
      ),
    );
  }
}
