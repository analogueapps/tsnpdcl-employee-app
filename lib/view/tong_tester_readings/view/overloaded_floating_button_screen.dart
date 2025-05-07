import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/viewmodel/overloaded_dtrs_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class OverloadedFloatingButtonView extends StatelessWidget {
  static const id = Routes.tongTesterReadingsScreen;

  const OverloadedFloatingButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OverloadedFloatingButtonProvider(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            "Tong Tester Readings Entry",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Consumer<OverloadedFloatingButtonProvider>(
          builder: (context, provider, _) {
            // Check if we are loading either structures or structure details
            if (provider.isLoadingStructures ||
                provider.isLoadingStructureDetails) {
              return const Center(
                child: CircularProgressIndicator(), // Show loading spinner
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Select Section Dropdown
                    DropdownButtonFormField<String>(
                      value: provider.section,
                      decoration: InputDecoration(
                        labelText: "Select Section",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                      ),
                      items: provider.section != null
                          ? [
                        DropdownMenuItem<String>(
                          value: provider.section,
                          child: Text(provider.section!),
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
                      Text(provider.section ?? "No section selected"),
                    ),
                    SizedBox(height: 6),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${provider.section} | ${provider.sectionCode}",
                          style: TextStyle(color: Colors.green),
                        )),
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text("SELECT STRUCTURE CODE",
                          style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(height: 5,),
                    // Select Structure Dropdown (triggers dialog)
                    GestureDetector(
                      onTap: provider.structures.isEmpty
                          ? null
                          : () => _showStructuresDialog(context, provider),
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
                              provider.selectedStructureId ??
                                  "Select Structure Code",
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow
                                  .ellipsis, // Added to prevent overflow
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        provider.selectedStructureId ?? "",
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // New Structure Details UI
                    if (provider.currentStructure != null)
                      SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 1, // Single structure from currentStructure
                          itemBuilder: (context, index) {
                            final structure = FeederDisModel.fromJson(
                                provider.currentStructure!);
                            return Column(
                              children: [
                                Container(
                                  color: Colors.grey[300],
                                  width: double.infinity,
                                  height: 40,
                                  child: const Center(
                                    child: Text(
                                      "STRUCTURE DETAILS",
                                      style: TextStyle(fontSize: doubleSixteen),
                                    ),
                                  ),
                                ),
                                _buildStructureDetailsCard(structure),
                                if (structure.dtrs != null &&
                                    structure.dtrs!.isNotEmpty)
                                  ...structure.dtrs!
                                      .map((dtr) => _buildDTRDetailsCard(dtr))
                                      .toList(),
                              ],
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 20),

                    // ================ TONG TESTER READINGS SECTION ================
                    Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      height: 40,
                      child: const Center(
                        child: Text(
                          "TONG TESTER READINGS",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Current Readings Row (Rph, Yph, Bph, Neutral)
                    Row(
                      children: [
                        // Rph Input
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextFormField(
                              controller: provider.rphController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Rph (Amps)",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Rph value';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        // Yph Input
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextFormField(
                              controller: provider.yphController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Yph (Amps)",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Yph value';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // Bph Input
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextFormField(
                              controller: provider.bphController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Bph (Amps)",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Bph value';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        // Neutral Input
                        Expanded(
                          child: TextFormField(
                            controller: provider.neutralController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Neutral (Amps)",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Neutral value';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Total Connected Load
                    TextFormField(
                      controller: provider.totalLoadController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "TOTAL CONNECTED LOAD (KVA)",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter total load';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text("READING DATE & TIME",
                          style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => provider.selectDateTime(), // Changed from viewModel to provider
                      child: InputDecorator(
                        decoration: InputDecoration(
                          hintText: "DD/MM/YYYY HH:MM",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          provider.selectedDateTime == null // Changed from viewModel to provider
                              ? "DD/MM/YYYY HH:MM"
                              : provider.formatDateTime(
                              provider.selectedDateTime!), // Changed from viewModel to provider
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Location Type Dropdown
                    DropdownButtonFormField<String>(
                      value: provider.selectedLocationType,
                      decoration: const InputDecoration(
                        labelText: "Location Type",
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: "MUNICIPAL TOWN", child: Text("MUNICIPAL TOWN")),
                        DropdownMenuItem(value: "MANDAL HEAD QUARTERS", child: Text("MANDAL HEAD QUARTERS")),
                        DropdownMenuItem(
                            value: "RURAL", child: Text("RURAL")),
                      ],
                      onChanged: (value) {
                        provider.selectedLocationType = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select location type';
                        }
                        return null;
                      },
                    ),
                    // ================ END TONG TESTER READINGS SECTION ================
                    SizedBox(
                      height: 10,
                    ),
                    // Save Button
                    if (provider.currentStructure != null)
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                            text: "SAVE",
                            onPressed: () {
                              provider.saveTongTesterReading();
                            }),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  void _showStructuresDialog(
      BuildContext context, OverloadedFloatingButtonProvider provider) {
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
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.structures
                            .where((item) => item.optionName!
                            .toLowerCase()
                            .contains(searchQuery))
                            .length,
                        itemBuilder: (context, index) {
                          final filteredItems = provider.structures
                              .where((item) => item.optionName!
                              .toLowerCase()
                              .contains(searchQuery))
                              .toList();
                          return ListTile(
                            title: SizedBox(
                              width: 200, // Constrain width to prevent overflow
                              child: Text(
                                filteredItems[index].optionName ?? '',
                                overflow:
                                TextOverflow.ellipsis, // Handle long text
                              ),
                            ),
                            onTap: () {
                              provider.setSelectedStructure(
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

  // Method to build Structure Details UI (replacing StructureDetailsCard)
  Widget _buildStructureDetailsCard(FeederDisModel structure) {
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
            Text('Substation: ${structure.ssCode ?? "N/A"}'),
            Text('Feeder: ${structure.feederCode ?? "N/A"}'),
            Text('Structure Capacity: ${structure.capacity ?? "N/A"}'),
            Text('Structure Type: ${structure.structureType ?? "N/A"}'),
            Text('Plinth Type: ${structure.plinthType ?? "N/A"}'),
            Text('AB Switch type: ${structure.abSwitch ?? "N/A"}'),
            Text('HG Fuse Sets: ${structure.hgFuseSet ?? "N/A"}'),
            Text('LT Fuse Sets: ${structure.ltFuseSet ?? "N/A"}'),
            Text('LT Fuse Type: ${structure.ltFuseType ?? "N/A"}'),
            Text('Load Pattern: ${structure.loadPattern ?? "N/A"}'),
            Text('Latitude: ${structure.lat?.toString() ?? "N/A"}'),
            Text('Longitude: ${structure.lon?.toString() ?? "N/A"}'),
            Text('Date of Creation: ${structure.createdDate ?? "N/A"}'),
            Text('Employee ID: ${structure.createdBy ?? "N/A"}'),
          ],
        ),
      ),
    );
  }

  // Method to build DTR Details UI (replacing DTRDetailsCard)
  Widget _buildDTRDetailsCard(DTRModel dtr) {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(width: 10),
            Expanded(
              // Added to constrain the Column's width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Equipment Code: ${dtr.equipmentCode ?? "N/A"}',
                    overflow: TextOverflow.ellipsis, // Truncate long text
                  ),
                  Text(
                    'CAP: ${dtr.dtrCapacity ?? "N/A"}',
                    overflow: TextOverflow.ellipsis, // Truncate long text
                  ),
                  Text(
                    'Make: ${dtr.make ?? "N/A"}',
                    overflow: TextOverflow.ellipsis, // Truncate long text
                  ),
                  Text(
                    'Serial No: ${dtr.slno ?? "N/A"}',
                    overflow: TextOverflow.ellipsis, // Truncate long text
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}