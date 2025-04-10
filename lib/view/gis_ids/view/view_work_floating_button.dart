import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/middle_poles/viewmodel/pending_list_floating_button_viewmodel.dart';

class ViewWorkFloatingButton extends StatelessWidget {
  static const id = Routes.viewWorkFloatButtonScreen;
  const ViewWorkFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = PendingListFloatingButtonViewmodel(context: context);
        viewModel.initialize();
        return viewModel;
      },
      lazy: false,
      child: Consumer<PendingListFloatingButtonViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "View Work Details",
                    style:  TextStyle(
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
                  _buildPoleSection(
                    photoPath: viewModel.poleAPhotoPath,
                    onCapturePressed: () {
                      // viewModel.setPoleAPhotoPath("path/to/photo");
                    },
                  ),
                  const SizedBox(height: 10),
                  _reusableLastRow(
                      label: "AFTER LATITUDE",
                      controller: viewModel.sanctionNoController),
                  _reusableLastRow(
                      label: "AFTER LONGITUDE",
                      controller: viewModel.sanctionNoController),
                  const SizedBox(height: 10),

                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
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
        },
      ),
    );
  }

  Widget _buildPlaceholder(String? photoPath) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: photoPath == null
            ? const Icon(Icons.photo_library, size: 50, color: Colors.grey)
            : const Text("Photo captured"),
      ),
    );
  }

  Widget _reusableLastRow({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(color: Colors.grey[200]),
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildPoleSection({
    required String? photoPath,
    required VoidCallback onCapturePressed,
  }) {
    return Column(
      children: [
        _buildPlaceholder(photoPath),

        Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: onCapturePressed,
              child:const Text("CAPTURE WORK COMPLETION PHOTO", style:  TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}