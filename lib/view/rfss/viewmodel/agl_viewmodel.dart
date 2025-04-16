import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';

import '../database/mapping_of_services/agl_databases/distribution_db.dart';



class AglViewModel extends ChangeNotifier{
  final BuildContext context;

  AglViewModel({required this.context});
  String? latitude;
  String? longitude;

  void initialize() {
    Future.delayed(Duration.zero, () {
      _handleLocationIconClick();
      downloadDistributions();

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

    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
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

        permission = await Geolocator.checkPermission();
      }
    }
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
                Navigator.of(context).pop();
                loadOfflineDistributions();
              },
              child: const Text('OFFLINE'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                getDistributions();
              },
              child: const Text('DOWNLOAD'),
            ),
          ],
        ),
        );
      },
    );
  }

  //DOWNLOAD OTHER SECTION DTRS BUTTON
  void downloadOtherSectionDTRS() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            title: const Text("Download Neighbor section structure codes?", style: TextStyle(fontSize:doubleEighteen),),
            content: const Text("Do you want to download neighbor section structure codes also?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('CLOSE'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigation.instance.navigateTo(Routes.downloadStructures); // Close the dialog
                },
                child: const Text('YES'),
              ),
            ],
          ),
        );
      },
    );
  }

//SEARCH DIALOG FOR DISTRIBUTION
  void showDistributionDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    String searchQuery = '';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final filteredDistributions = listDistributionItem
                .where((distribution) => distribution.optionName!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
                .toList();

            return AlertDialog(
              title: const Text('Select Distribution'),
              content: SizedBox(
                width: 300,
                height: double.infinity,
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
                    // Distribution List
                    SizedBox(
                      height: 600,
                      child: filteredDistributions.isEmpty
                          ? const Center(child: Text('No distributions found'))
                          : ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredDistributions.length,
                        itemBuilder: (context, index) {
                          final distribution = filteredDistributions[index];
                          return ListTile(
                            title: Text(distribution.optionName ?? 'Unknown'),
                            onTap: () {
                              onListDistributionValueChange(distribution.optionCode);
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

  List<SubstationModel> listDistributionItem = [];
  String? listDistributionSelect;

  Future<void> getDistributions() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "sc":SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.sectionCodePrefKey),
    };

    final payload = {
      "path": "/load/distributions",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SubstationModel> listData = jsonList.map((json) => SubstationModel.fromJson(json)).toList();
                listDistributionItem.addAll(listData);


                if (listDistributionItem.isNotEmpty) {
                  listDistributionSelect = listDistributionItem.first.optionCode;
                }
                // Store in database
                await DatabaseHelper.instance.clearSubstations();
                await DatabaseHelper.instance.insertSubstations(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  //OFFLINE DISTRIBUTIONS
  Future<void> loadOfflineDistributions() async {
    try {
      // Fetch data from database
      final List<SubstationModel> dbData = await DatabaseHelper.instance.getSubstations();

      listDistributionItem.clear();
      listDistributionItem.addAll(dbData);

      listDistributionSelect = listDistributionItem.isNotEmpty ? listDistributionItem.first.optionCode : null;

      notifyListeners();
    } catch (e) {
      showErrorDialog(context, "Failed to load offline data: $e");
    }
  }

  void onListDistributionValueChange(String? value) {
    listDistributionSelect = value;
    print("10808: $listDistributionSelect");
    notifyListeners();
  }


  String? _selectedStructure;
  String? get selectedStructure => _selectedStructure;

  List _structure = [];

  List get struct => _structure;

  Future<void> getStructuresOfSection() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,

    };

    final payload = {
      "path": "/getStructuresOfSection",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SubstationModel> listData = jsonList.map((json) => SubstationModel.fromJson(json)).toList();
                listDistributionItem.addAll(listData);
                listDistributionItem.clear();
                listDistributionItem.addAll(listData);

                // Store in database
                await DatabaseHelper.instance.clearSubstations(); // Clear old data
                await DatabaseHelper.instance.insertSubstations(listData); // Insert new data
              }
            } else {
              showAlertDialog(context,response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  void onListStructureSelected(String? value) {
    _selectedStructure = value;
    notifyListeners();
  }

  //DOWNLOAD UNMAPPED SERVICES
  Future<void> getUnmappedServices(String distributionCode) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "dc":distributionCode,
      "agl":true,
      "rfss":false

    };

    final payload = {
      "path": "/getUnMappedServices",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SubstationModel> listData = jsonList.map((json) => SubstationModel.fromJson(json)).toList();


                // Store in database
                await DatabaseHelper.instance.clearSubstations(); // Clear old data
                await DatabaseHelper.instance.insertSubstations(listData); // Insert new data
              }
            } else {
              showAlertDialog(context,response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

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


  //UPLOAD API
  Future<void> savedMappedServices(String distributionCode) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "data":"[uscno, structure,lat, lon, loadInHp, areaCode, authorisationFlag, farmerName]",

    };

    final payload = {
      "path": "/savedMappedServices",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SubstationModel> listData = jsonList.map((json) => SubstationModel.fromJson(json)).toList();


                // Store in database
                await DatabaseHelper.instance.clearSubstations(); // Clear old data
                await DatabaseHelper.instance.insertSubstations(listData); // Insert new data
              }
            } else {
              showAlertDialog(context,response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }


}