import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/view_work_floating_viewmodel.dart';

class ViewWorkFloatingButton extends StatelessWidget {
  static const id = Routes.viewWorkFloatButtonScreen;
  final String surId;
  const ViewWorkFloatingButton({super.key, required this.surId});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = ViewWorkFloatingViewmodel(context: context,surveyID: surId );
        viewModel.initialize();
        return viewModel;
      },
      lazy: false,
      child: Consumer<ViewWorkFloatingViewmodel>(
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
                    icon: const Icon(Icons.save),
                    color: Colors.white,
                    onPressed: viewModel.submitForm
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
              child:  Padding(padding: const EdgeInsets.all(15),
                child:Form(
                key: viewModel.formKey,
                child:Column(
                children: [
                  const SizedBox(height: doubleTwenty,),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: viewModel.viewWorkCapturedImage.isEmpty
                        ? const Icon(Icons.image, size: 50)
                        : Image.network(
                      Apis.NPDCL_STORAGE_SERVER_IP +viewModel.viewWorkCapturedImage,
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                    ),
                  ),

                  const SizedBox(height: 11),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text(
                        'CAPTURE WORK COMPLETION PHOTO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white
                        ),
                      ),
                      onPressed: () => viewModel.viewWorkCapturePhoto(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _reusableLastRow(
                      label: "AFTER LATITUDE",
                      controller: viewModel.latitudeController),
                  _reusableLastRow(
                      label: "AFTER LONGITUDE",
                      controller: viewModel.longitudeController),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('REMARKS(if any)'),
                    ),
                    controller: viewModel.remarksController,
                    // focusNode: viewModel.remarksFocusNode,
                  ),

                ],
              ),
            ),
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
              readOnly: true,
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
}