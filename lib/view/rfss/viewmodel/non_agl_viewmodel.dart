import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NonAglViewModel extends ChangeNotifier {
  final BuildContext context;

  NonAglViewModel({required this.context});

  void initialize() {
    Future.delayed(Duration.zero, () {
      downloadDistributions();
    });
  }

  void downloadDistributions() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Download Distributions ?"),
          content: const Text("To Download Distributions from the server, please click the DOWNLOAD button. If you have already downloaded the distributions, click OFFLINE."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OFFLINE'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('DOWNLOAD'),
            ),
          ],
        );
      },
    );
  }

  String? _selectedDistribution;
  String? get selectedDistribution => _selectedDistribution;

  List _distribution = ["10808-R T C COLONY", "12236-NAKKALAGUTTA-NKG", "12237-BALASAMUDRAM"];

  List get distri => _distribution;
  void onListDistributionSelected(String? value) {
    _selectedDistribution = value;
    notifyListeners();
  }

  String? _selectedStructure;
  String? get selectedStructure => _selectedStructure;

  List _structure = ["12236-NAKKALAGUTTA-NKG-SS-0071", "12236-NAKKALAGUTTA-NKG-SS-0066", "12236-NAKKALAGUTTA-NKG-SS-0059"];

  List get struct => _structure;
  void onListStructureSelected(String? value) {
    _selectedStructure = value;
    notifyListeners();
  }

  void showSubstationDialog(BuildContext context, NonAglViewModel viewmodel) {
    final TextEditingController searchController = TextEditingController();
    String searchQuery = '';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Select '),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Field
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: "Search distribution",
                        hintText: "Type to search",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Substation List
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: viewmodel.distri
                            .where((substation) => substation
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                            .length,
                        itemBuilder: (context, index) {
                          final filteredSubstations = viewmodel.distri
                              .where((substation) => substation
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                              .toList();
                          return ListTile(
                            title: Text(filteredSubstations[index]),
                            onTap: () {
                              viewmodel.onListDistributionSelected(filteredSubstations[index]);
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

}
