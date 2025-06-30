import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/middle_poles/viewmodel/middlepoles_11kv_viewmodel.dart';

class MiddlePole11kv extends StatelessWidget {
  static const id = Routes.middlePole11kv;
  const MiddlePole11kv({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = Middlepoles11kvViewmodel(context: context);
        viewModel.initialize();
        return viewModel;
      },
      lazy: false,
      child: Consumer<Middlepoles11kvViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    GlobalConstants.newMiddlePoles.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: toolbarTitleSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                    icon: const Icon(Icons.save_outlined),
                    color: Colors.white,
                    onPressed: () {
                      viewModel.submitForm();
                    }),
                IconButton(
                  icon: const Icon(Icons.folder_outlined),
                  color: Colors.white,
                  onPressed: () => print("Folder icon pressed"),
                ),
              ],
              iconTheme: const IconThemeData(color: Colors.white),
              leading: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
              automaticallyImplyLeading: false,
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                    key: viewModel.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // _reusableLastRow(
                          //     label: "11KV FEEDER", controller: viewModel.feederController, status: isFalse),
                          const SizedBox(
                            height: doubleTen,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text(
                                  " 11KV FEEDER",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: DropdownButtonFormField<String>(
                                  value: viewModel.feeder.any((f) =>
                                          f.optionCode ==
                                          viewModel.selectedFeeder)
                                      ? viewModel.selectedFeeder
                                      : null,
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    viewModel.onListFeederSelected(newValue);
                                  },
                                  items: viewModel.feeder.map((feeder) {
                                    return DropdownMenuItem<String>(
                                      value: feeder.optionCode,
                                      child: Text(feeder.optionName),
                                    );
                                  }).toList(),
                                  // decoration: InputDecoration(
                                  //   hintText:"label",
                                  //   hintStyle: TextStyle(color: Colors.grey[200]),
                                  //   contentPadding:
                                  //   const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                  //   border: const OutlineInputBorder(),
                                  // ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10, right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Expanded(
                                  flex: 1, // Half screen for label
                                  child: Text(
                                    "POLE TYPE",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  flex: 1, // Half screen for dropdown
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: viewModel.selectedPoleType,
                                    hint: const Text(""),
                                    items: const [
                                      DropdownMenuItem<String>(
                                        value: "SELECT",
                                        child: Text("SELECT"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "11KV",
                                        child: Text("11KV"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "LT",
                                        child: Text("LT"),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      viewModel.setPoleType(value);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          _reusableLastRow(
                              label: "WORK DESCRIPTION",
                              controller: viewModel.workDescriptionController,
                              status: isFalse),
                          _reusableLastRow(
                              label: "SANCTION NO.",
                              controller: viewModel.sanctionNoController,
                              status: isFalse),
                          const SizedBox(height: 7),
                          _buildPoleSection(
                            title: "POLE A DETAILS",
                            photoPath: viewModel.poleAPhoto11KV != ""
                                ? Apis.NPDCL_STORAGE_SERVER_IP +
                                    viewModel.poleAPhoto11KV
                                : "",
                            onCapturePressed: () {
                              viewModel.capturePoleA11Photo();
                            },
                          ),
                          const SizedBox(height: 10),
                          _reusableLastRow(
                              label: "POLE - A LATITUDE",
                              controller: viewModel.latPoleA11kv,
                              status: isTrue),
                          _reusableLastRow(
                              label: "POLE - A LONGITUDE",
                              controller: viewModel.logPoleA11kv,
                              status: isTrue),
                          const SizedBox(height: 10),
                          _buildPoleSection(
                            title: "POLE B DETAILS",
                            photoPath: viewModel.poleB11PhotoPath != ""
                                ? Apis.NPDCL_STORAGE_SERVER_IP +
                                    viewModel.poleB11PhotoPath
                                : "",
                            onCapturePressed: () {
                              viewModel.capturePoleB11Photo();
                            },
                          ),
                          _reusableLastRow(
                              label: "POLE-B LATITUDE",
                              controller: viewModel.latPoleB11kv,
                              status: isTrue),
                          _reusableLastRow(
                              label: "POLE-B LONGITUDE",
                              controller: viewModel.latPoleB11kv,
                              status: isTrue),
                          _reusableLastRow(
                              label: "DISTANCE B/W A&B",
                              controller: viewModel.distanceController,
                              status: isTrue),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 20, left: 20, right: 20),
                            child: TextFormField(
                              controller: viewModel.remarksController,
                              decoration: const InputDecoration(
                                labelText: 'REMARKS(If Any)',
                                border: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildPlaceholder(String photoPath) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: photoPath.isEmpty
          ? const Icon(Icons.image, size: 50)
          : Image.network(
              photoPath,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
    );
  }

  static Widget _reusableLabel(String label) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 8),
      color: Colors.grey[200],
      width: double.infinity,
      child: Text(label.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }

  Widget _reusableLastRow(
      {required String label,
      required TextEditingController controller,
      required bool status}) {
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
              readOnly: status,
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(color: Colors.grey[200]),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildPoleSection({
    required String title,
    required String? photoPath,
    required VoidCallback onCapturePressed,
  }) {
    return Column(
      children: [
        _reusableLabel(title),
        _buildPlaceholder(photoPath!),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: SizedBox(
            width: double.infinity,
            child: Text("$title PHOTO",
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 8),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              "PLEASE TAKE THE PHOTO OF $title",
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: onCapturePressed,
              child: Text("CAPTURE $title PHOTO",
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
