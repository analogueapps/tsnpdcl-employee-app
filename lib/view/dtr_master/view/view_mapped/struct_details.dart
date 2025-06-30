import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart'; // Adjust path

class StructDetails extends StatelessWidget {
  static const id = Routes.dtrStructure;
  final List<FeederDisModel> structData;

  const StructDetails({super.key, required this.structData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          "Structure Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: toolbarTitleSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: structData.isEmpty
            ? const Center(child: Text("No data available"))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: structData.length,
                itemBuilder: (context, index) {
                  final structure = structData[index];
                  return Column(
                    children: [
                      Container(
                        color: Colors.grey[300],
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            "STRUCTURE DETAILS",
                            style: TextStyle(fontSize: doubleSixteen),
                          ),
                        ),
                      ),
                      StructureDetailsCard(structure: structure),
                      if (structure.dtrs != null && structure.dtrs!.isNotEmpty)
                        ...structure.dtrs!
                            .map((dtr) => DTRDetailsCard(dtr: dtr)),
                    ],
                  );
                },
              ),
      ),
    );
  }
}

// Structure Details Card
class StructureDetailsCard extends StatelessWidget {
  final FeederDisModel structure;

  const StructureDetailsCard({super.key, required this.structure});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewDetailedLcTileWidget(
                tileKey: 'Structure Code',
                tileValue: structure.structureCode ?? "N/A"),
            // ViewDetailedLcTileWidget('Structure Code", ${structure.structureCode ?? "N/A"}'),
            ViewDetailedLcTileWidget(
                tileKey: 'Landmark', tileValue: structure.landMark ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Distribution Name',
                tileValue: structure.distributionName ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'SS No', tileValue: structure.ssNo ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'SS Code', tileValue: structure.ssCode ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Feeder Code',
                tileValue: structure.feederCode ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Capacity', tileValue: structure.capacity ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Structure Type',
                tileValue: structure.structureType ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Plinth Type',
                tileValue: structure.plinthType ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'AB Switch', tileValue: structure.abSwitch ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'HG Fuse Set',
                tileValue: structure.hgFuseSet ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'LT Fuse Set',
                tileValue: structure.ltFuseSet ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'LT Fuse Type',
                tileValue: structure.ltFuseType ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Load Pattern',
                tileValue: structure.loadPattern ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Latitude',
                tileValue: structure.lat?.toString() ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Longitude',
                tileValue: structure.lon?.toString() ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Created Date',
                tileValue: structure.createdDate ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Created By', tileValue: structure.createdBy ?? "N/A"),
          ],
        ),
      ),
    );
  }
}

// DTR Details Card
class DTRDetailsCard extends StatelessWidget {
  final DTRModel dtr;

  const DTRDetailsCard({super.key, required this.dtr});

  @override
  Widget build(BuildContext context) {
    final status = dtr.status?.toLowerCase() ?? '';
    final statusColor = status.contains("mismatch")
        ? Colors.red
        : status == "confirmed"
            ? Colors.green
            : Colors.purple;

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[300],
              width: double.infinity,
              child: const Center(
                child: Text(
                  "DTR DETAILS",
                  style: TextStyle(fontSize: doubleSixteen),
                ),
              ),
            ),
            const SizedBox(
              height: doubleTen,
            ),
            CachedNetworkImage(
              imageUrl: dtr.url ?? '',
              placeholder: (context, url) => const Icon(Icons.image, size: 50),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image, size: 50),
              height: 400,
              width: 400,
              fit: BoxFit.cover,
            ),
            ViewDetailedLcTileWidget(
                tileKey: 'Make', tileValue: dtr.make ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'DTR Capacity', tileValue: dtr.dtrCapacity ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Serial No', tileValue: dtr.slno ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Year Mfd', tileValue: dtr.ymfd ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Phase', tileValue: dtr.phase ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Ratio', tileValue: dtr.ratio ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Meter Phase', tileValue: dtr.meterPhase ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Equipment Code',
                tileValue: dtr.equipmentCode ?? "N/A"),
            ViewDetailedLcTileWidget(
                tileKey: 'Status',
                tileValue: dtr.status ?? "N/A",
                valueColor: statusColor),
            // Text('Status Remarks: ${dtr.statusRemarks ?? "N/A"}'),
            ViewDetailedLcTileWidget(
              tileKey: 'Created/Confirmed Date',
              tileValue:
                  "${dtr.createdDate ?? "N/A"}/ ${dtr.confirmDate ?? "N/A"}",
            ),
            ViewDetailedLcTileWidget(
                tileKey: 'Created By', tileValue: dtr.createdBy ?? "N/A"),
          ],
        ),
      ),
    );
  }
}

//static const id = Routes.structDetailsScreen;
// StructureDetailsVH holder = (StructureDetailsVH) viewHolder;
// holder.txt1.setText(jsonGuard(data, "structureCode"));
