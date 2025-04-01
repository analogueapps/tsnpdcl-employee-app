import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';

class AglViewModel extends ChangeNotifier{
  final BuildContext context;

  AglViewModel({required this.context});
  String? latitude;
  String? longitude;

  void initialize() {
    Future.delayed(Duration.zero, () {
      _handleLocationIconClick();
      downloadDistributions();
      // getCurrentLocation();
    });
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController farmerName= TextEditingController();
  final TextEditingController connectedLoad= TextEditingController();
  final TextEditingController uscno= TextEditingController();


  void _handleLocationIconClick() async {

    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      bool? shouldOpenSettings = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async => false,
          child: AlertDialog(
            title: const Text("Location Service Disabled"),
            content: const Text("Please enable location services to use this feature."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Open Settings"),
              ),
            ],
          ),
          );
        },
      );

      if (shouldOpenSettings == true) {
        await Geolocator.openLocationSettings();
        isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      }
    }

    // if (!isLocationEnabled) {
    //   // Show a snackbar if the location service is still disabled
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Location services are still disabled."),
    //     ),
    //   );
    //   return;
    // }

    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location permissions are denied."),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Show a dialog to open app settings
      bool? shouldOpenSettings = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Location Permission Required"),
            content: Text("Location permissions are permanently denied. Please enable them in the app settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Open Settings"),
              ),
            ],
          );
        },
      );

      if (shouldOpenSettings == true) {
        await Geolocator.openAppSettings();
        // After opening settings, check again if the permissions are granted
        permission = await Geolocator.checkPermission();
      }
    }

    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Location permissions are still denied."),
        ),
      );
      return;
    }

    // Fetch current location if permissions are granted
    await _getCurrentLocation();

  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        print("$latitude, $longitude in agl_viewmodel");
        notifyListeners();
    } catch (e) {
      print("Error fetching location: $e");
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text("Failed to fetch location."))
      // );
    }
  }

  void downloadDistributions() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async => false,
        child:AlertDialog(
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
        ),
        );
      },
    );
  }

  void showDistributionDialog(BuildContext context, AglViewModel viewmodel) {
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

  List _structure = [
    "12236-NAKKALAGUTTA-NKG-SS-0071",
    "12236-NAKKALAGUTTA-NKG-SS-0066",
    "12236-NAKKALAGUTTA-NKG-SS-0059"];

  List get struct => _structure;
  void onListStructureSelected(String? value) {
    _selectedStructure = value;
    notifyListeners();
  }

  String? _selectedServiceNo;
  String? get selectedServiceNo => _selectedServiceNo;

  List _serviceNo = [];

  List get serviceNo => _serviceNo;
  void onListServiceNoSelected(String? value) {
    _selectedServiceNo = value;
    notifyListeners();
  }

  ///choose option
  String? selectedOption = "";
  void toggleOption(String value) {
    selectedOption = value;
    print("$selectedOption :choose option");
    notifyListeners();
  }


}