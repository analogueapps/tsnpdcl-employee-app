import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/view/rfss/database/mapping_agl_db/agl_databases/saveMapped_db.dart';
import 'package:tsnpdcl_employee/view/rfss/database/mapping_agl_db/agl_databases/structure_code_db.dart';
import 'package:tsnpdcl_employee/view/rfss/model/dtrStructureEntity.dart';
import 'package:tsnpdcl_employee/view/rfss/model/save_agl_data_model.dart';
import 'package:tsnpdcl_employee/view/rfss/model/save_mapped_model.dart';

import '../database/mapping_agl_db/agl_databases/distribution_db.dart';

class AglViewModel extends ChangeNotifier {
  final BuildContext context;

  AglViewModel({required this.context});

  String latitude = "";
  String longitude = "";

  void initialize() {
    Future.delayed(Duration.zero, () {
      _handleLocationIconClick();
      downloadDistributions();
      deleteAllUnMappedServices();
    });
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController farmerName = TextEditingController();
  final TextEditingController connectedLoad = TextEditingController();
  final TextEditingController uscno = TextEditingController();

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
              content: const Text(
                  "Please enable location services to use this feature."),
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
            title: const Text("Location Permission Required"),
            content: const Text(
                "Location permissions are permanently denied. Please enable them in the app settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Open Settings"),
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
          child: AlertDialog(
            title: const Text("Download Distributions ?"),
            content: const Text(
                "To Download Distributions from the server, please click the DOWNLOAD button. If you have already downloaded the distributions, click OFFLINE."),
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
          child: AlertDialog(
            title: const Text(
              "Download Neighbor section structure codes?",
              style: TextStyle(fontSize: doubleEighteen),
            ),
            content: const Text(
                "Do you want to download neighbor section structure codes also?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CLOSE'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigation.instance.navigateTo(Routes.downloadStructures);
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
                .where((distribution) => distribution.optionName
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
                                final distribution =
                                    filteredDistributions[index];
                                return ListTile(
                                  title: Text(
                                      distribution.optionName ?? 'Unknown'),
                                  onTap: () {
                                    onListDistributionValueChange(
                                        distribution.optionCode);
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
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "sc": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.sectionCodePrefKey),
    };

    final payload = {
      "path": "/load/distributions",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList =
                    jsonDecode(response.data['objectJson']);
                final List<SubstationModel> listData = jsonList
                    .map((json) => SubstationModel.fromJson(json))
                    .toList();
                deleteAllUnMappedServices();
                listDistributionItem.addAll(listData);
                getStructuresOfSection();
                if (listDistributionItem.isNotEmpty) {
                  listDistributionSelect =
                      listDistributionItem.first.optionCode;
                }
                // Store in database
                await DatabaseHelper.instance.clearSubstations();
                await DatabaseHelper.instance.insertSubstations(listData);
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  //OFFLINE DISTRIBUTIONS
  Future<void> loadOfflineDistributions() async {
    try {
      // Fetch data from database
      final List<SubstationModel> dbData =
          await DatabaseHelper.instance.getSubstations();
      final List<String> dbstructuredata =
          await StructureDatabaseHelper.instance.getAllStructureCodes();

      deleteAllUnMappedServices();
      listDistributionItem.clear();
      listDistributionItem.addAll(dbData);

      _structure.clear();
      _structure.addAll(dbstructuredata.toSet().toList());
      if (_structure.isNotEmpty) {
        _selectedStructure = _structure.first;
      }

      listDistributionSelect = listDistributionItem.isNotEmpty
          ? listDistributionItem.first.optionCode
          : null;

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

  final List<String> _structure = [];

  List get struct => _structure;

  Future<void> getStructuresOfSection() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/getStructuresOfSection",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['message'] != "[]") {
                final List<dynamic> structures =
                    jsonDecode(response.data['message']);
                final dbHelper = StructureDatabaseHelper.instance;
                for (var structure in structures) {
                  final structureCode = DTRStructureEntity.fromJson(structure);
                  await dbHelper.insertStructure(structureCode);
                  if (!_structure.contains(structureCode)) {
                    _structure.add(structureCode.structureCode);
                    print(
                        "Added successfully in both db and list in agl_viewmodel");
                  }
                }
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  void onListStructureSelected(String? value) {
    _selectedStructure = value;
    notifyListeners();
  }

  //DOWNLOAD UNMAPPED SERVICES
  List<Map<String, String>> _services = [];

  List<Map<String, String>> get services => _services;

  String? _selectedServiceNo;

  String? get selectedServiceNo => _selectedServiceNo;

  // To store the selected areaCode
  String? _selectedAreaCode;

  String? get selectedAreaCode => _selectedAreaCode;

  String? _selectedUSCNO;

  String? get selectedUSCNO => _selectedUSCNO;

  Future<void> fetchServicesFromDb() async {
    final dbHelper = AGLUnMappedDatabaseHelper();
    final List<UploadMappedService> dbServices =
        await dbHelper.getUnMappedServices();

    _services = dbServices
        .map((service) => {
              'scno': service.scno,
              'name': service.name,
              'areaCode': service.areaCode,
              'uscno': service.uscno
            })
        .toList();

    notifyListeners();
  }

  // Get display items for dropdown (scno + name)
  List<String> get serviceDisplayItems {
    return _services
        .map((service) => '${service['scno']} - ${service['name']}')
        .toList();
  }

  void onServiceSelected(String? displayValue) {
    if (displayValue == null) return;

    final selectedService = _services.firstWhere(
      (service) => displayValue == '${service['scno']} - ${service['name']}',
      orElse: () => {},
    );

    if (selectedService.isNotEmpty) {
      _selectedServiceNo = selectedService['scno'];
      _selectedAreaCode = selectedService['areaCode'];
      _selectedUSCNO = selectedService['uscno'] ?? uscno.text;
      print(
          "Slected Service no and $_selectedServiceNo, area:$_selectedAreaCode , uscon: $_selectedUSCNO");
      notifyListeners();
    }
  }

  Future<void> getUnmappedServices(String distributionCode) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "dc": distributionCode,
      "agl": true,
      "rfss": false
    };

    final payload = {
      "path": "/getUnMappedServices",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['message'] != null) {
                showSuccessDialog(context, response.data['message'], () {});
                if (response.data['objectJson'] != null) {
                  final List<dynamic> jsonList =
                      jsonDecode(response.data['objectJson']);
                  final List<UploadMappedService> listData = jsonList
                      .map((json) => UploadMappedService.fromJson(json))
                      .toList();
                  await AGLUnMappedDatabaseHelper()
                      .insertUnMappedServices(listData.toSet().toList());
                  print("Store data in SQLite in Unmmaped in AGL");
                  final storedServices =
                      await AGLUnMappedDatabaseHelper().getUnMappedServices();
                  await fetchServicesFromDb();
                  debugPrint('Stored ${storedServices.length} services');
                }
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> deleteAllUnMappedServices() async {
    try {
      final dbHelper = AGLUnMappedDatabaseHelper();
      final counts = await dbHelper.clearUnMappedServices();

      // Clear local lists and selections
      _services.clear();
      _selectedServiceNo = null;
      _selectedAreaCode = null;

      notifyListeners();

      print('Deleted  records');
    } catch (e) {
      print('Error deleting services: $e');
    }
  }

  ///choose option
  String? selectedOption = "";

  void toggleOption(String value) {
    selectedOption = value;
    print("$selectedOption :choose option");
    notifyListeners();
  }

  //UPLOAD Data API
  Future<void> submitForm() async {
    formKey.currentState!.save();
    notifyListeners();

    if (!validateForm()) {
      return;
    } else {
      addService();
      savedMappedServices(usersData);
    }
  }

  bool validateForm() {
    String usCNO = uscno.text.trim();
    String load = connectedLoad.text.trim();

    if (latitude == "" && longitude == "") {
      AlertUtils.showSnackBar(context, "Please turn on location", isTrue);
      _handleLocationIconClick();
      return false;
    } else if (selectedOption == "") {
      AlertUtils.showSnackBar(
          context, "Please select service authorised or not", isTrue);
      return false;
    } else if (selectedOption == "A" && selectedAreaCode == "") {
      AlertUtils.showSnackBar(
          context, "Please select service, you want to map", isTrue);
      return false;
    } else if (selectedOption == "U" && load.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please specify unauthorised service load in HP", isTrue);
      return false;
    } else if (selectedOption == "M" && usCNO.length < 8) {
      AlertUtils.showSnackBar(context, "USCNO should be 8 characters", isTrue);
      return false;
    } else if (services.isEmpty) {
      AlertUtils.showSnackBar(
          context, "No mapped services found, to upload", isTrue);
      return false;
    } else if (selectedOption == "M" && usCNO.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please specify valid non agl service number", isTrue);
      return false;
    }
    return true;
  }

  List<SaveAglDataModel> usersData = [];

  void addService() {
    usersData.add(SaveAglDataModel(
        uscno: selectedUSCNO!,
        digitalDtrStructureCode: selectedStructure,
        latitude: latitude,
        longitude: longitude,
        unAuthorisedLoadInHp:
            connectedLoad.text == "" ? "000" : connectedLoad.text,
        areaCode: selectedAreaCode,
        authorisationFlag: selectedOption,
        farmerName: farmerName.text != "" ? farmerName.text : ""));
  }

  Future<void> savedMappedServices(
      List<SaveAglDataModel> uploadServices) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final List<Map<String, dynamic>> servicesData = uploadServices.map((un) {
      return {
        "uscno": un.uscno,
        "structure": un.digitalDtrStructureCode,
        "lat": un.latitude,
        "lon": un.longitude,
        "loadInHp": un.unAuthorisedLoadInHp,
        "areaCode": un.areaCode,
        "authorisationFlag": un.authorisationFlag,
        "farmerName": un.farmerName,
      };
    }).toList();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "data": servicesData,
    };

    final payload = {
      "path": "/savedMappedServices",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['message'] != null) {
                showSuccessDialog(context, response.data['message'], () {
                  Navigation.instance.pushBack();
                });
                usersData.clear();
                clearData();
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  void clearData() {
    formKey.currentState!.reset();
    uscno.clear();
    farmerName.clear();
    _selectedUSCNO = null;
    selectedOption = null;
    _selectedAreaCode = null;
    _selectedServiceNo = null;
    _selectedStructure = null;
    deleteAllUnMappedServices();
  }
}
