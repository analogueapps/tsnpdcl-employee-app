import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailedPendingListScreen extends StatelessWidget {
  static const id = "ViewDetailedPendingListScreen";

  const ViewDetailedPendingListScreen({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const ViewDetailedLcTileWidget(tileKey: "STATUS", tileValue: "PENDING"),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "FEEDER NAME", tileValue: "DJCND"),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "WORK DESCRIPTION", tileValue: "NJXCNDCD"),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "POLE TYPE", tileValue: "33KV"),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "SANCTION NO.", tileValue: "DJNXDN"),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10),
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
              child: const Center(
                child: Icon(Icons.photo_library, size: 50, color: Colors.grey),
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
            const ViewDetailedLcTileWidget(tileKey: "POLE - A LATITUDE", tileValue: "17.4446414"),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "POLE - A LONGITUDE", tileValue: "78.3843504"),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10),
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
              child: const Center(
                child: Icon(Icons.photo_library, size: 50, color: Colors.grey),
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
            const ViewDetailedLcTileWidget(tileKey: "POLE - B LATITUDE", tileValue: "17.4446414"),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "POLE - B LONGITUDE", tileValue: "78.3843504"),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "DISTANCE B/W A & B", tileValue: "0.21"),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "REMARKS", tileValue: ""),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "UPLOAD BY EMP ID", tileValue: "70000000"),
            const Divider(),
            const ViewDetailedLcTileWidget(
                tileKey: "DATE OF UPLOAD", tileValue: "Tue Apr 01 15:22:26 IST 2025"),
            const Divider(),
            const ViewDetailedLcTileWidget(
                tileKey: "DATE OF A,B POLES MARKED", tileValue: "01 Apr 2025 15:22:36"),
            const Divider(),
            const ViewDetailedLcTileWidget(tileKey: "DATE OF MIDDLE POLE MARKED", tileValue: ""),
            const Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigation.instance.navigateTo(Routes.pendingListFloatingButton);
          // Add your action here, e.g., navigate to an edit screen or show a dialog
          print("Pencil FAB pressed");
        },
        backgroundColor: CommonColors.colorPrimary, // Match your app theme
        shape: const CircleBorder(), // Makes it round
        child: const Icon(
          Icons.edit, // Pencil icon
          color: Colors.white,
        ),
      ),
    );
  }
}