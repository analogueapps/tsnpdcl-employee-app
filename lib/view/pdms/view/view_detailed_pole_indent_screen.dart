import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/status_codes.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/view_detailed_lc_viewmodel.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_request_indent_entity.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_image_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailedPoleIndentScreen extends StatefulWidget {
  static const id = Routes.viewDetailedPoleIndentScreen;
  final String data;

  const ViewDetailedPoleIndentScreen({
    super.key,
    required this.data,
  });

  @override
  State<ViewDetailedPoleIndentScreen> createState() =>
      _ViewDetailedPoleIndentScreenState();
}

class _ViewDetailedPoleIndentScreenState
    extends State<ViewDetailedPoleIndentScreen> {
  PoleRequestIndentEntity? poleRequestIndentEntity;

  @override
  void initState() {
    poleRequestIndentEntity = PoleRequestIndentEntity.fromJson(jsonDecode(widget.data));
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
              "View Indent".toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "#${poleRequestIndentEntity?.indentId}",
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
            const SizedBox(height: doubleFive,),
            ViewDetailedLcTileWidget(tileKey: "Indent Id", tileValue: checkNull(poleRequestIndentEntity?.indentId.toString()), valueColor: CommonColors.colorPrimary,),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Indent Date", tileValue: formatIsoDateForPdmsDetails(checkNull(poleRequestIndentEntity?.indentDate))),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Section", tileValue: checkNull(poleRequestIndentEntity?.section)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Pole type", tileValue: checkNull(poleRequestIndentEntity?.poleType)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Requisition no", tileValue: checkNull(poleRequestIndentEntity?.requisitionNo)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Indent qty", tileValue: checkNull(poleRequestIndentEntity?.requestedQty.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Deleted qty by ae", tileValue: checkNull(null)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Balance qty", tileValue: checkNull(poleRequestIndentEntity?.balanceQty.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Ae od recom. qty", tileValue: checkNull(poleRequestIndentEntity?.aeOdRecommendedQty.toString())),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Ade stores approved qty", tileValue: checkNull(null)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Indent status", tileValue: checkNull(poleRequestIndentEntity?.indentStatus), valueColor: CommonColors.colorPrimary,),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Ae od remarks", tileValue: checkNull(null)),
            const Divider(),
            ViewDetailedLcTileWidget(tileKey: "Ade stores remarks", tileValue: checkNull(null)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              color: Colors.grey[200],
              width: double.infinity,
              child: Center(
                child: Text(
                  "Indent History".toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: poleRequestIndentEntity!.poleRequestIndentTrackEntitiesByIndentId != null &&
                  poleRequestIndentEntity!.poleRequestIndentTrackEntitiesByIndentId!.isNotEmpty,
              child: Column(
                children: poleRequestIndentEntity!.poleRequestIndentTrackEntitiesByIndentId!
                    .map((poleRequestIndentTrackEntitiesByIndentId) => Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      color: Colors.grey[200],
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Log".toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: doubleFive,),
                    ViewDetailedLcTileWidget(tileKey: "Track id", tileValue: checkNull(poleRequestIndentTrackEntitiesByIndentId.trackId.toString())),
                    const Divider(),
                    ViewDetailedLcTileWidget(tileKey: "Log date", tileValue: formatIsoDateForPdmsDetails(checkNull(poleRequestIndentTrackEntitiesByIndentId.indentDate))),
                    const Divider(),
                    ViewDetailedLcTileWidget(tileKey: "Indent qty", tileValue: checkNull(poleRequestIndentTrackEntitiesByIndentId.requestedQty.toString())),
                    const Divider(),
                    ViewDetailedLcTileWidget(tileKey: "Balance qty", tileValue: checkNull(poleRequestIndentTrackEntitiesByIndentId.balanceQty.toString())),
                    const Divider(),
                    ViewDetailedLcTileWidget(tileKey: "Ae deleted qty", tileValue: checkNull(null)),
                    const Divider(),
                    ViewDetailedLcTileWidget(tileKey: "Ae/od recommended qty", tileValue: checkNull(poleRequestIndentTrackEntitiesByIndentId.aeOdRecommendedQty.toString())),
                    const Divider(),
                    ViewDetailedLcTileWidget(tileKey: "Approved qty", tileValue: checkNull(null)),
                    const Divider(),
                    ViewDetailedLcTileWidget(tileKey: "Ade op action date", tileValue: checkNull(null)),
                    const Divider(),
                    ViewDetailedLcTileWidget(tileKey: "Indent status", tileValue: checkNull(poleRequestIndentTrackEntitiesByIndentId.indentStatus)),
                    const SizedBox(height: doubleFive,),
                  ],
                ))
                    .toList(),

              ),
            ),
            const SizedBox(height: doubleTen,),
          ],
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: poleRequestIndentEntity?.indentStatus != StatusCodes.PoleIndentStatus.CANCELED,
        child: Padding(
          padding: const EdgeInsets.all(doubleTwenty),
          child: PrimaryButton(
              fullWidth: isTrue,
              buttonColor: CommonColors.colorPrimary,
              text: "Surya".toUpperCase(),
              onPressed: () {

              }
          ),
        ),
      ),
    );
  }
}
