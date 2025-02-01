import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_dispatch_instructions_entity.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_image_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailedTransportScreen extends StatefulWidget {
  static const id = Routes.viewDetailedTransportScreen;
  final String data;

  const ViewDetailedTransportScreen({
    super.key,
    required this.data,
  });

  @override
  State<ViewDetailedTransportScreen> createState() => _ViewDetailedTransportScreenState();
}

class _ViewDetailedTransportScreenState extends State<ViewDetailedTransportScreen> {
  late PoleTransportEntitiesByDispatchInstructionsId poleTransportEntitiesByDispatchInstructionsId;

  @override
  void initState() {
    super.initState();
    poleTransportEntitiesByDispatchInstructionsId = PoleTransportEntitiesByDispatchInstructionsId.fromJson(jsonDecode(widget.data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Shipping #${poleTransportEntitiesByDispatchInstructionsId.transportId}".toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700
              ),
            ),
            Text(
              checkNull(poleTransportEntitiesByDispatchInstructionsId.vehicleNo),
              style: const TextStyle(fontSize: normalSize, color: Colors.grey),
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              color: Colors.grey[200],
              width: double.infinity,
              child: Center(
                child: Text(
                  "Shipping Details".toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ViewDetailedLcTileWidget(tileKey: "Shipping Id", tileValue: checkNull(poleTransportEntitiesByDispatchInstructionsId.transportId.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Vehicle No", tileValue: checkNull(poleTransportEntitiesByDispatchInstructionsId.vehicleNo)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Driver Name", tileValue: checkNull(poleTransportEntitiesByDispatchInstructionsId.driverName)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Driver Phone", tileValue: checkNull(poleTransportEntitiesByDispatchInstructionsId.driverPhone)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "D.I Id", tileValue: checkNull(poleTransportEntitiesByDispatchInstructionsId.dispatchInstructionId.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Shipping Date", tileValue: formatIsoDateForDiDetails(checkNull(poleTransportEntitiesByDispatchInstructionsId.dispatchDate))),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Expected Delivery Date", tileValue: checkNull(poleTransportEntitiesByDispatchInstructionsId.expectedDeliveryDate)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Shipping Qty", tileValue: checkNull(poleTransportEntitiesByDispatchInstructionsId.transportQty.toString())),
            Visibility(
              visible: poleTransportEntitiesByDispatchInstructionsId.poleDumpedLocationEntityListByTransportId != null &&
                  poleTransportEntitiesByDispatchInstructionsId.poleDumpedLocationEntityListByTransportId!.isNotEmpty,
              child: Column(
                children: poleTransportEntitiesByDispatchInstructionsId.poleDumpedLocationEntityListByTransportId!
                    .map((dump) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      color: Colors.grey[200],
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Dump Details".toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: doubleFive,),
                    ViewDetailedLcTileWidget(
                      tileKey: "Dump Id",
                      tileValue: checkNull(dump.dumpId.toString()),
                    ),
                    const Divider(),
                    ViewDetailedLcTileWidget(
                      tileKey: "Dump Qty",
                      tileValue: checkNull(dump.dumpedQty.toString()),
                    ),
                    const Divider(),
                    ViewDetailedLcTileWidget(
                      tileKey: "Dump Date",
                      tileValue: formatIsoDateForDiDetails(checkNull(dump.dumpDate)),
                    ),
                    const Divider(),
                    ViewDetailedLcTileWidget(
                      tileKey: "Dump Lat",
                      tileValue: checkNull(dump.dumpedLat.toString()),
                    ),
                    const Divider(),
                    ViewDetailedLcTileWidget(
                      tileKey: "Dump Lon",
                      tileValue: checkNull(dump.dumpedLon.toString()),
                    ),
                    const Divider(),
                    const Row(children: [
                      SizedBox(width: doubleTen,),
                      Text('DUMPED IMAGE'),
                    ],),
                    ViewDetailedLcImageWidget(imageUrl: checkNull(dump.dumpedImageUrl,),),
                    const ViewDetailedLcHeadWidget(title: "Verification Details"),
                    ViewDetailedLcTileWidget(
                      tileKey: "Verification Qty",
                      tileValue: checkNull(dump.physicalVerifiedQuantity.toString()),
                    ),
                    const Divider(),
                    ViewDetailedLcTileWidget(
                      tileKey: "Verification Lat",
                      tileValue: checkNull(dump.verifiedLat.toString()),
                    ),
                    const Divider(),
                    ViewDetailedLcTileWidget(
                      tileKey: "Verification Lon",
                      tileValue: checkNull(dump.verifiedLon.toString()),
                    ),
                    const Divider(),
                    ViewDetailedLcTileWidget(
                      tileKey: "Verification Date",
                      tileValue: formatIsoDateForDiDetails(checkNull(dump.verifiedDate)),
                    ),
                    const Divider(),
                    const Row(children: [
                      SizedBox(width: doubleTen,),
                      Text('VERIFIED IMAGE'),
                    ],),
                    ViewDetailedLcImageWidget(imageUrl: checkNull(dump.verifiedImageUrl,),),
                    const SizedBox(height: doubleFive,),
                  ],
                ))
                    .toList(),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
