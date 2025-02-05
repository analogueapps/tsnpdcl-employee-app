import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_dumped_location_entity.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_image_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailedPoleDumpedLocationScreen extends StatefulWidget {
  static const id = Routes.viewDetailedPoleDumpedLocationScreen;
  final String data;

  const ViewDetailedPoleDumpedLocationScreen({
    super.key,
    required this.data,
  });

  @override
  State<ViewDetailedPoleDumpedLocationScreen> createState() => _ViewDetailedPoleDumpedLocationScreenState();
}

class _ViewDetailedPoleDumpedLocationScreenState extends State<ViewDetailedPoleDumpedLocationScreen> {
  late PoleDumpedLocationEntity poleDumpedLocationEntity;

  @override
  void initState() {
    poleDumpedLocationEntity = PoleDumpedLocationEntity.fromJson(jsonDecode(widget.data));
    super.initState();
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
              "View Dump Info".toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "#${poleDumpedLocationEntity.dumpId}",
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
                  "Dum Details".toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ViewDetailedLcTileWidget(tileKey: "Dump Id", tileValue: checkNull(poleDumpedLocationEntity.dumpId.toString()), valueColor: CommonColors.colorPrimary,),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Dumped Qty", tileValue: checkNull(poleDumpedLocationEntity.dumpedQty.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Dumped Date", tileValue: formatIsoDateForDiDetails(checkNull(poleDumpedLocationEntity.dumpDate))),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Dump Lat", tileValue: checkNull(poleDumpedLocationEntity.dumpedLat.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Dump Lon", tileValue: checkNull(poleDumpedLocationEntity.dumpedLon.toString())),
            const Divider(),
            ViewDetailedLcImageWidget(imageUrl: checkNull(poleDumpedLocationEntity.dumpedImageUrl)),
            const ViewDetailedLcHeadWidget(title: "Verification Details"),
            ViewDetailedLcTileWidget(tileKey: "Verified Qty By AE", tileValue: checkNull(poleDumpedLocationEntity.physicalVerifiedQuantity.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Verified Lat", tileValue: checkNull(poleDumpedLocationEntity.verifiedLat.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Verified Lon", tileValue: checkNull(poleDumpedLocationEntity.verifiedLon.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Verified Date", tileValue: formatIsoDateForDiDetails(checkNull(poleDumpedLocationEntity.verifiedDate))),
            const Divider(),
            ViewDetailedLcImageWidget(imageUrl: checkNull(poleDumpedLocationEntity.verifiedImageUrl)),
            Visibility(
              visible: poleDumpedLocationEntity.employeeMasterEntityByVerifiedEmpId != null,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    color: Colors.grey[200],
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Verified By".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: doubleFive,),
                  ViewDetailedLcTileWidget(tileKey: "Verified By Name", tileValue: checkNull(poleDumpedLocationEntity.employeeMasterEntityByVerifiedEmpId!.empName)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Verified By Designation", tileValue: checkNull(poleDumpedLocationEntity.employeeMasterEntityByVerifiedEmpId!.designation)),
                  const SizedBox(height: doubleFive,),
                ],
              ),
            ),
            const SizedBox(height: doubleFive,),
          ],
        ),
      ),
    );
  }
}
