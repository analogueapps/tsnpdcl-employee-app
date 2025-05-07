import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/middle_poles/viewmodel/view_brief_details_PF_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailedPendingListScreen extends StatelessWidget {
  static const id = Routes.viewDetailedPendingListScreen;

  const ViewDetailedPendingListScreen({super.key, required this.surveyID, required this.status});
  final int surveyID;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              GlobalConstants.viewMiddlePole.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.folder_outlined),
              color: Colors.white,
              onPressed: () => print("Folder icon pressed"),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
      ),
      body:ChangeNotifierProvider(
        create: (_) => ViewBriefDetailsPfViewmodel(context: context, surId: surveyID, individualStatus: status),
        child:Consumer<ViewBriefDetailsPfViewmodel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
          itemCount: viewModel.workDetails.length,
          itemBuilder: (context, index) {
            final data = viewModel.workDetails[index];
            return data == null
                ?
            const Center(child: Text("Please try again")) :
            Column(
              children: [
                const SizedBox(height: 10),
                 ViewDetailedLcTileWidget(
                    tileKey: "STATUS", tileValue: data.status, valueColor: status=="PENDING"? Colors.red: Colors.green,),
                 ViewDetailedLcTileWidget(
                    tileKey: "WORK DESCRIPTION", tileValue: data.workDescription),
                ViewDetailedLcTileWidget(
                    tileKey: "FEEDER NAME", tileValue: data.feederName),
                 ViewDetailedLcTileWidget(
                    tileKey: "POLE TYPE", tileValue: data.poleType),
                 ViewDetailedLcTileWidget(
                    tileKey: "SANCTION NO.", tileValue: data.sanctionNo),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 10),
                  color: Colors.grey[200],
                  width: double.infinity,
                  child: Text(
                    "POLE A DETAILS".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    data.poleAImageUrl!=null
                        ? data.poleAImageUrl
                        : 'https://example.com/placeholder.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  width: double.infinity,
                  child: Text(
                    "POLE - A PHOTO".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                 ViewDetailedLcTileWidget(
                    tileKey: "POLE - A LATITUDE", tileValue: data.poleALat.toString()),
                ViewDetailedLcTileWidget(
                    tileKey: "POLE - A LONGITUDE", tileValue: data.poleALon.toString()
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 10),
                  color: Colors.grey[200],
                  width: double.infinity,
                  child: Text(
                    "POLE B DETAILS".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    data.poleBImageUrl != null
                        ? data.poleBImageUrl!
                        : 'https://example.com/placeholder.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  width: double.infinity,
                  child: Text(
                    "POLE - B PHOTO".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                 ViewDetailedLcTileWidget(
                    tileKey: "POLE - B LATITUDE", tileValue: data.poleBLat.toString()),
                 ViewDetailedLcTileWidget(
                    tileKey: "POLE - B LONGITUDE", tileValue: data.poleBLon.toString()),
                 ViewDetailedLcTileWidget(
                    tileKey: "DISTANCE B/W A & B", tileValue:data.distance),
                ViewDetailedLcTileWidget(
                    tileKey: "REMARKS", tileValue: data.remarksBySurveyor),

                status=="FINISHED"? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 10),
                        color: Colors.grey[200],
                        width: double.infinity,
                        child: Text(
                          "MIDDLE POLE DETAILS".toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      data.middlePoleImageUrl != null
                          ? data.middlePoleImageUrl!
                          : 'https://example.com/placeholder.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
                        );
                      },
                    ),
                  ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 10),
                        color: Colors.grey[200],
                        width: double.infinity,
                        child: Text(
                          "MIDDLE POLE PHOTO".toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 10,),
                      ViewDetailedLcTileWidget(
                          tileKey: "MIDDLE POLE LATITUDE", tileValue: data.middlePoleLat.toString()),
                      ViewDetailedLcTileWidget(
                          tileKey: "MIDDLE POLE LONGITUDE", tileValue: data.middlePoleLon.toString()),

                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 10),
                        color: Colors.grey[200],
                        width: double.infinity,
                        child: Text(
                          "UPLOAD DETAILS".toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                ]
                ):SizedBox(),
                ViewDetailedLcTileWidget(
                    tileKey: "UPLOAD BY EMP ID", tileValue: data.surveyorId),
                 ViewDetailedLcTileWidget(
                    tileKey: "DATE OF UPLOAD",
                    tileValue: data.dateOfAbMarked??""),
                ViewDetailedLcTileWidget(
                    tileKey: "DATE OF A,B POLES MARKED",
                    tileValue:data.dateOfAbMarkedAsLong.toString()),
                 ViewDetailedLcTileWidget(
                    tileKey: "DATE OF MIDDLE POLE MARKED", tileValue: data.dateOfMpMarkedAsLong.toString()),
                SizedBox(height: doubleThirty,)
              ],
            );
          }
    );
    },
        ),
      ),
      floatingActionButton: status=="PENDING"?FloatingActionButton(
        onPressed: () {
          Navigation.instance.navigateTo(Routes.pendingListFloatingButton,args: {
            'surveyID': surveyID,
            'status': status,
          } );
          print("Pencil FAB pressed");
        },
        backgroundColor: CommonColors.colorPrimary, // Match your app theme
        shape: const CircleBorder(), // Makes it round
        child: const Icon(
          Icons.edit, // Pencil icon
          color: Colors.white,
        ),
      ): null,
  );
  }
}