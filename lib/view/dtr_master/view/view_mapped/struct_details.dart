import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart'; // Adjust path

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
                Container(color:Colors.grey[300],
                  width:double.infinity,
                  child:const Center(
                    child:
                    Text("STRUCTURE DETAILS", style: TextStyle(fontSize: doubleSixteen),),
                  ),
                ),
                StructureDetailsCard(structure: structure),
                if (structure.dtrs != null && structure.dtrs!.isNotEmpty)
                  ...structure.dtrs!.map((dtr) => DTRDetailsCard(dtr: dtr)).toList(),
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

            Text('Structure Code: ${structure.structureCode ?? "N/A"}'),
            Text('Landmark: ${structure.landMark ?? "N/A"}'),
            Text('Distribution Name: ${structure.distributionName ?? "N/A"}'),
            Text('SS No: ${structure.ssNo ?? "N/A"}'),
            Text('SS Code: ${structure.ssCode ?? "N/A"}'),
            Text('Feeder Code: ${structure.feederCode ?? "N/A"}'),
            Text('Capacity: ${structure.capacity ?? "N/A"}'),
            Text('Structure Type: ${structure.structureType ?? "N/A"}'),
            Text('Plinth Type: ${structure.plinthType ?? "N/A"}'),
            Text('AB Switch: ${structure.abSwitch ?? "N/A"}'),
            Text('HG Fuse Set: ${structure.hgFuseSet ?? "N/A"}'),
            Text('LT Fuse Set: ${structure.ltFuseSet ?? "N/A"}'),
            Text('LT Fuse Type: ${structure.ltFuseType ?? "N/A"}'),
            Text('Load Pattern: ${structure.loadPattern ?? "N/A"}'),
            Text('Latitude: ${structure.lat?.toString() ?? "N/A"}'),
            Text('Longitude: ${structure.lon?.toString() ?? "N/A"}'),
            Text('Created Date: ${structure.createdDate ?? "N/A"}'),
            Text('Created By: ${structure.createdBy ?? "N/A"}'),
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
            Container(color:Colors.grey[300],
              width:double.infinity,
              child:const Center(
                child:
                Text("DTR DETAILS", style: TextStyle(fontSize: doubleSixteen),),
              ),
            ),
            CachedNetworkImage(
              imageUrl: dtr.url ?? '',
              placeholder: (context, url) => const Icon(Icons.image, size: 50),
              errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 50),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Text('Make: ${dtr.make ?? "N/A"}'),
            Text('DTR Capacity: ${dtr.dtrCapacity ?? "N/A"}'),
            Text('Serial No: ${dtr.slno ?? "N/A"}'),
            Text('Year Mfd: ${dtr.ymfd ?? "N/A"}'),
            Text('Phase: ${dtr.phase ?? "N/A"}'),
            Text('Ratio: ${dtr.ratio ?? "N/A"}'),
            Text('Meter Phase: ${dtr.meterPhase ?? "N/A"}'),
            Text('Equipment Code: ${dtr.equipmentCode ?? "N/A"}'),
            Text(
              'Status: ${dtr.status ?? "N/A"}',
              style: TextStyle(color: statusColor),
            ),
            // Text('Status Remarks: ${dtr.statusRemarks ?? "N/A"}'),
            Text(
              'Created/Confirmed Date: ${dtr.createdDate ?? "N/A"}/${dtr.confirmDate ?? "N/A"}',
            ),
            Text('Created By: ${dtr.createdBy ?? "N/A"}'),
          ],
        ),
      ),
    );
  }
}

//static const id = Routes.structDetailsScreen;
// StructureDetailsVH holder = (StructureDetailsVH) viewHolder;
// holder.txt1.setText(jsonGuard(data, "structureCode"));