import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/viewmodel/dtr_failure_reporting_viewmodel.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';

class ReportDTRFailure extends StatelessWidget {
  static const id = Routes.dtrFailureReportingScreen;
  const ReportDTRFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportDTRFailureViewModel(context: context),
      child: Consumer<ReportDTRFailureViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Report DTR failure',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: toolbarTitleSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      viewModel.section,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: doubleFifteen,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Stack(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          value: viewModel.section,
                          decoration: InputDecoration(
                            labelText: "Select Section",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                          ),
                          items: viewModel.section != null
                              ? [
                                  DropdownMenuItem<String>(
                                    value: viewModel.section,
                                    child: Text(
                                      viewModel.section,
                                      style: const TextStyle(
                                          fontSize: doubleFourteen),
                                    ),
                                  ),
                                ]
                              : [
                                  const DropdownMenuItem<String>(
                                    value: null,
                                    child: Text("No section selected"),
                                  ),
                                ],
                          onChanged: null,
                          disabledHint:
                              Text(viewModel.section ?? "No section selected"),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${viewModel.section} | ${viewModel.sectionCode}",
                              style: const TextStyle(color: Colors.green),
                            )),
                        const SizedBox(height: 20),
                        Text(
                          'SELECT FAILED STRUCTURE CODE',
                          style: TextStyle(color: Colors.red[800]),
                        ),
                        GestureDetector(
                          onTap: viewModel.structures.isEmpty
                              ? null
                              : () => _showStructuresDialog(context, viewModel),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  viewModel.selectedStructureId ??
                                      "Select Structure Code",
                                  style:
                                      const TextStyle(fontSize: doubleFourteen),
                                  overflow: TextOverflow
                                      .ellipsis, // Added to prevent overflow
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            viewModel.selectedStructureId ?? "",
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'SELECT FAILED EQUIPMENT CODE',
                          style: TextStyle(color: Colors.red),
                        ),
                        DropdownButtonFormField<String>(
                          value: viewModel.failedEquipmentCode,
                          items: viewModel.failedEquipmentList.map((code) {
                            return DropdownMenuItem<String>(
                              value: code,
                              child: Text(code),
                            );
                          }).toList(),
                          onChanged: (value) {
                            viewModel.setFailedEquipmentCode(value);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          hint: const Text('Select Equipment Code'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select equipment code';
                            }
                            return null;
                          },
                        ),
                        Container(
                          height: 40,
                          width: double.infinity,
                          color: Colors.grey.shade400,
                          child: const Center(child: Text('STRUCTURE DETAILS')),
                          // const SizedBox(height: 20),
                        ),
                        if (viewModel.structureData.isNotEmpty)
                          ..._buildStructureDetails(
                              viewModel.structureData.first),
                        const SizedBox(height: 20),
                        if (viewModel.structureData.isNotEmpty &&
                            viewModel.structureData.first.dtrs != null &&
                            viewModel.structureData.first.dtrs!.isNotEmpty)
                          _buildDTRDetails(
                              viewModel.structureData.first.dtrs!.first),
                        const Divider(thickness: 1, color: Colors.grey),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'DTR FAILURE REASON',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Failure Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: viewModel.dateController,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                      );
                                      if (pickedDate != null) {
                                        final formattedDate =
                                            DateFormat('dd/MM/yyyy').format(
                                                pickedDate); // e.g., "14/04/2025"
                                        viewModel.setFailureDate(formattedDate);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Failure Time',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: viewModel.timeController,
                                    readOnly: true, // Prevent manual editing
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        builder: (context, child) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    alwaysUse24HourFormat:
                                                        false),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (pickedTime != null) {
                                        // Convert TimeOfDay to 24-hour format
                                        final now = DateTime.now();
                                        final dateTime = DateTime(
                                          now.year,
                                          now.month,
                                          now.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        );
                                        final formattedTime =
                                            DateFormat('HH:mm')
                                                .format(dateTime);
                                        viewModel.setFailureTime(formattedTime);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                        const Divider(),
                        Column(children: [
                          _buildCheckboxRow(
                              viewModel,
                              'High Rating HG Fuses Used',
                              'High Rating HG Fuses Used'),
                          _buildCheckboxRow(
                              viewModel,
                              'High Rating LT Fuses Used',
                              'High Rating LT Fuses Used'),
                          _buildCheckboxRow(
                              viewModel, 'Vent Pipe Burst', 'Vent Pipe Burst'),
                          _buildCheckboxRow(
                              viewModel,
                              'Gasket damaged at tank cover',
                              'Gasket damaged at tank cover'),
                          _buildCheckboxRow(
                              viewModel, 'Earth wire cut', 'Earth wire cut'),
                          _buildCheckboxRow(
                              viewModel,
                              'Loose lines in the LT Line',
                              'Loose lines in the LT Line'),
                          _buildCheckboxRow(
                              viewModel,
                              'Phase Touching to Ground/Tree',
                              'Phase Touching to Ground/Tree'),
                          _buildCheckboxRow(
                              viewModel,
                              'Ph Touching to body internally',
                              'Ph Touching to body internally'),
                          _buildCheckboxRow(viewModel, 'Due to lightning',
                              'Due to lightning'),
                          _buildCheckboxRow(viewModel, 'Heavy Wind and Gale',
                              'Heavy Wind and Gale'),
                          _buildCheckboxRow(
                              viewModel,
                              'DTR installed long back',
                              'DTR installed long back'),
                          _buildCheckboxRow(viewModel, 'Improper HG Fuse wire',
                              'Improper HG Fuse wire'),
                          _buildCheckboxRow(viewModel, 'Improper LT Fuse wire',
                              'Improper LT Fuse wire'),
                          _buildCheckboxRow(
                              viewModel,
                              'Tank Crack OR Oil Leakage',
                              'Tank Crack OR Oil Leakage'),
                          _buildCheckboxRow(
                              viewModel, 'Moisture Entry', 'Moisture Entry'),
                          _buildCheckboxRow(viewModel, 'Flashover of Bushing',
                              'Flashover of Bushing'),
                          _buildCheckboxRow(viewModel, 'Improper Earthing',
                              'Improper Earthing'),
                          _buildCheckboxRow(viewModel, 'Overload', 'Overload'),
                          _buildCheckboxRow(viewModel, 'HG Fuse Not Standing',
                              'HG Fuse Not Standing'),
                          _buildCheckboxRow(viewModel, 'Fault due to AGL Motor',
                              'Fault due to AGL Motor'),
                          _buildCheckboxRow(
                              viewModel, 'Oil Gushing Out', 'Oil Gushing Out'),
                          _buildCheckboxRow(
                              viewModel, 'Low Oil Level', 'Low Oil Level'),
                          _buildCheckboxRow(
                              viewModel, 'Tank Burst', 'Tank Burst'),
                          _buildCheckboxRow(
                              viewModel, 'Aging of DTR', 'Aging of DTR'),
                          _buildCheckboxRow(
                              viewModel, 'Theft of Oil', 'Theft of Oil'),
                          _buildCheckboxRow(
                              viewModel,
                              'Floods-DTR Fallen-Oil shrt, Bushings dmgd',
                              'Floods-DTR Fallen-Oil shrt,\n Bushings dmgd'),
                          _buildCheckboxRow(
                              viewModel,
                              'floodsSubmergedFloods-DTR submerged in water',
                              'Floods-DTR submerged in water'),
                          _buildCheckboxRow(viewModel, 'Other', 'Other'),
                        ]),
                        const SizedBox(height: 10),
                        const Divider(thickness: 1, color: Colors.grey),
                        const Text(
                          'ESTIMATE REQUIRED?',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w400),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.estimateRequired == "Yes",
                                  onChanged: (bool? value) {
                                    viewModel.toggleEstimateRequired("Yes");
                                  },
                                ),
                                const SizedBox(width: 5),
                                const Text('Yes'),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.estimateRequired == "No",
                                  onChanged: (bool? value) {
                                    viewModel.toggleEstimateRequired("No");
                                  },
                                ),
                                const SizedBox(width: 5),
                                const Text('No'),
                              ],
                            ),
                          ],
                        ),
                        const Divider(thickness: 1, color: Colors.grey),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: viewModel.save,
                            child: const Text('SAVE'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (viewModel.isLoading ||
                  viewModel.isLoadingStructureDetails ||
                  viewModel.isLoadingStructures)
                Positioned.fill(
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.3), // Semi-transparent overlay
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ]),
          );
        },
      ),
    );
  }

  List<Widget> _buildStructureDetails(FeederDisModel detail) {
    return [
      _buildDetailRow('STRUCTURE CODE', detail.structureCode ?? 'N/A'),
      _buildDetailRow('LANDMARK', detail.landMark ?? 'N/A'),
      _buildDetailRow('DISTRIBUTION', detail.distributionName ?? 'N/A'),
      _buildDetailRow('SS NO', detail.ssNo ?? 'N/A'),
      _buildDetailRow('SUB STATION', detail.ssCode ?? 'N/A'),
      _buildDetailRow('FEEDER', detail.feederName ?? 'N/A'),
      _buildDetailRow('STRUCTURE CAPACITY', detail.capacity ?? 'N/A'),
      _buildDetailRow('STRUCTURE TYPE', detail.structureType ?? 'N/A'),
      _buildDetailRow('PLINTH TYPE', detail.plinthType ?? 'N/A'),
      _buildDetailRow('AB SWITCH TYPE', detail.abSwitch ?? 'N/A'),
      _buildDetailRow('HG FUSE SETS', detail.hgFuseSet ?? 'N/A'),
      _buildDetailRow('LT FUSE SETS', detail.ltFuseSet ?? 'N/A'),
      _buildDetailRow('LT FUSE TYPE', detail.ltFuseType ?? 'N/A'),
      _buildDetailRow('LOAD PATTERN', detail.loadPattern ?? 'N/A'),
      _buildDetailRow('LATITUDE', detail.lat?.toString() ?? 'N/A'),
      _buildDetailRow('LONGITUDE', detail.lon?.toString() ?? 'N/A'),
      _buildDetailRow('DATE OF CREATION', detail.createdDate ?? 'N/A'),
      _buildDetailRow('EMPLOYEE ID', detail.createdBy ?? 'N/A'),
    ];
  }
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.all(14),
    child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      const Divider(),
    ]),
  );
}

Widget _buildDTRDetails(DTRModel dtr) {
  return Row(
    children: [
      CachedNetworkImage(
        imageUrl: dtr.url ?? '',
        placeholder: (context, url) => const Icon(Icons.image, size: 50),
        errorWidget: (context, url, error) =>
            const Icon(Icons.broken_image, size: 50),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('EQ CODE: ${dtr.equipmentCode ?? 'N/A'}',
              style: const TextStyle(color: Colors.red)),
          Text('CAP: ${dtr.dtrCapacity ?? 'N/A'}'),
          Text('MAKE: ${dtr.make ?? 'N/A'}'),
          Text('SERIAL: ${dtr.slno ?? 'N/A'}'),
        ],
      ),
    ],
  );
}

Widget _buildCheckboxRow(
    ReportDTRFailureViewModel viewModel, String field, String label) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Checkbox(
              value: viewModel.failureReasons.contains(field),
              onChanged: (bool? value) {
                viewModel.toggleFailureReason(field);
              },
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(label)),
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Divider(thickness: 1, color: Colors.grey),
      ),
    ],
  );
}

void _showStructuresDialog(
    BuildContext context, ReportDTRFailureViewModel viewModel) {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Select Structure'),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search Field
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: "Search Structure",
                      hintText: "Type to search",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  // Structure Code List with overflow fix
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: viewModel.structures
                          .where((item) => item.optionName
                              .toLowerCase()
                              .contains(searchQuery))
                          .length,
                      itemBuilder: (context, index) {
                        final filteredItems = viewModel.structures
                            .where((item) => item.optionName
                                .toLowerCase()
                                .contains(searchQuery))
                            .toList();
                        return ListTile(
                          title: SizedBox(
                            width: 200, // Constrain width to prevent overflow
                            child: Text(
                              filteredItems[index].optionName ?? '',
                              style: const TextStyle(fontSize: doubleEleven),
                              overflow:
                                  TextOverflow.ellipsis, // Handle long text
                            ),
                          ),
                          onTap: () {
                            viewModel.setSelectedStructure(
                                filteredItems[index].optionId);
                            Navigator.pop(dialogContext);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ).then((_) {
    searchController.dispose();
  });
}
