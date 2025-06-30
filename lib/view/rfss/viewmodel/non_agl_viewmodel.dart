import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/view/rfss/database/mapping_non_agl_db/non_agl_distribution_db.dart';
import 'package:tsnpdcl_employee/view/rfss/database/mapping_non_agl_db/non_agl_structure_db.dart';
import 'package:tsnpdcl_employee/view/rfss/database/mapping_non_agl_db/non_agl_unmapped_services_db.dart';
import 'package:tsnpdcl_employee/view/rfss/model/save_mapped_model.dart';

class NonAglViewModel extends ChangeNotifier {
  final BuildContext context;

  NonAglViewModel({required this.context});

  void initialize() {
    Future.delayed(Duration.zero, () {
      downloadDistributions();
    });
  }

  final formKey = GlobalKey<FormState>();
  final bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

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
                  loadOfflineData();
                },
                child: const Text('OFFLINE'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  getDistributions();
                  getStructOfCode();
                },
                child: const Text('DOWNLOAD'),
              ),
            ],
          ),
        );
      },
    );
  }

  //DOWNLOAD OFFLINE
  Future<void> loadOfflineData() async {
    try {
      // Fetch data from database
      final List<SubstationModel> dbData =
          await NonAglDistributionDb.instance.getAllNonAglDistribution();
      final List<String> dbstructuredata =
          await NonAglStructureDb.instance.getAllStructureCodes();

      // deleteAllUnMappedServices();
      distributionList.clear();
      distributionList.addAll(dbData);

      _structure.clear();
      _structure.addAll(dbstructuredata.toSet().toList());
      if (_structure.isNotEmpty) {
        _selectedStructure = _structure.first;
      }

      _selectedDistribution = distributionList.isNotEmpty
          ? distributionList.first.optionCode
          : null;

      notifyListeners();
    } catch (e) {
      showErrorDialog(context, "Failed to load offline data: $e");
    }
  }

  String? _selectedDistribution;
  String? get selectedDistribution => _selectedDistribution;

  final List<SubstationModel> _distribution = [];

  List<SubstationModel> get distributionList => _distribution;

  Future<void> getDistributions() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    try {
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

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (context.mounted) {
        ProcessDialogHelper.closeDialog(context);
      }

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
                distributionList.addAll(listData);
                if (distributionList.isNotEmpty) {
                  _selectedDistribution = distributionList.first.optionCode;
                }
                // Store in database
                await NonAglDistributionDb.instance.clearAllData();
                await NonAglDistributionDb.instance
                    .insertNonAglDistribution(listData);
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

  void onListDistributionSelected(String? value) {
    _selectedDistribution = value;
    notifyListeners();
  }

  String? _selectedStructure;
  String? get selectedStructure => _selectedStructure;

  final List _structure = [];
  List get struct => _structure;

  Future<void> getStructOfCode() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestSData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/getStructuresOfSection",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestSData),
    };

    final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

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
                final dbHelper = NonAglStructureDb.instance;
                // // Clear existing data first
                await dbHelper.deleteAllData();
                _structure.clear();
                for (var structure in structures) {
                  final structureCode = structure['structureCode'] as String;
                  await dbHelper.insertStructureCode(structureCode);
                  if (!_structure.contains(structureCode)) {
                    _structure.add(structureCode);
                    notifyListeners();
                  }
                }
                if (_structure.isNotEmpty) {
                  _selectedStructure = _structure.first;
                  notifyListeners();
                  print("Done _structure.first");
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
    } finally {
      if (context.mounted) {
        ProcessDialogHelper.closeDialog(context);
      }
    }
  }

  void onListStructureSelected(String? value) {
    _selectedStructure = value;
    notifyListeners();
  }

  //DOWNLOAD UNMAPPED SERVICES
  List<UploadMappedService> unmappedServices = [];
  Future<void> nonAGLUnmappedServices(String distributionCode) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "dc": distributionCode,
      "agl": false,
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
                AlertUtils.showSnackBar(
                    context, response.data['message'], isFalse);
                if (response.data['objectJson'] != null) {
                  final List<dynamic> jsonList =
                      jsonDecode(response.data['objectJson']);
                  final List<UploadMappedService> listData = jsonList
                      .map((json) => UploadMappedService.fromJson(json))
                      .toList();
                  deleteAllAGLUnMappedData();
                  await NonAglUnmappedServicesDb()
                      .insertUnMappedServices(listData.toSet().toList());
                  print("Store data in SQLite in Unmmaped in AGL");
                  unmappedServices =
                      await NonAglUnmappedServicesDb().getUnMappedServices();
                  for (var service in unmappedServices) {
                    _checkboxStates[service.uscno] = false;
                  }
                  print('Stored ${unmappedServices.length} services');
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

  Future<void> deleteAllAGLUnMappedData() async {
    try {
      final dbHelper = NonAglUnmappedServicesDb();
      await dbHelper.clearUnMappedServices();
      notifyListeners();
      print('Deleted  records');
    } catch (e) {
      print('Error deleting services: $e');
    }
  }

  //CHECKBOX IMPLEMENTATION
  final Map<String, bool> _checkboxStates = {};
  final Map<String, String?> _serviceMappings = {};
  bool isChecked(String? checkUSNCO) => _checkboxStates[checkUSNCO] ?? false;

  String? _selectedServiceStructureCode;
  String? get selectedServiceStructureCode => _selectedServiceStructureCode;

  Map<String, String?> get checkedServices {
    return Map.fromEntries(_checkboxStates.entries
        .where((entry) => entry.value == true)
        .map((entry) => MapEntry(entry.key, _serviceMappings[entry.key])));
  }

// Update your toggleCheckbox method
  void toggleCheckbox(UploadMappedService service, bool? isChecked) {
    if (isChecked == true) {
      _checkboxStates[service.uscno] = true;
      _serviceMappings[service.uscno] = _selectedStructure;
      print("Checked USCNO: ${service.uscno}");
      print("With Structure Code: $_selectedStructure");
    } else {
      _checkboxStates.remove(service.uscno);
      _serviceMappings.remove(service.uscno);
    }

    // Print all currently checked items
    printAllCheckedServices();

    notifyListeners();
  }

  void printAllCheckedServices() {
    print("--- Currently Checked Services ---");
    checkedServices.forEach((uscno, structureCode) {
      print("USCNO: $uscno | Structure Code: $structureCode");
    });
    print("---------------------------------");
  }

  //SAVE AND UPLOAD
  Future<void> submitForm() async {
    formKey.currentState!.save();
    notifyListeners();
    if (!validateForm()) {
      return;
    } else {
      savedMappedServices(checkedServices);
    }
  }

  bool validateForm() {
    if (unmappedServices.isEmpty) {
      AlertUtils.showSnackBar(
          context, "No mapped services found, to upload", isTrue);
      return false;
    } else if (_checkboxStates == {} && _serviceMappings == {}) {
      AlertUtils.showSnackBar(
          context, "Please select any one check box", isTrue);
      return false;
    }
    return true;
  }

  Future<void> savedMappedServices(Map<String, String?> uploadData) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final List<Map<String, dynamic>> mappedData =
        uploadData.entries.map((entry) {
      return {
        "uscno": entry.key,
        "structure": entry.value,
      };
    }).toList();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "data": mappedData,
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
                showSuccessDialog(context, response.data['message'],
                    () {}); //Navigation.instance.pushBack();
                _checkboxStates.clear();
                _serviceMappings.clear();
                notifyListeners();
                nonAGLUnmappedServices(selectedDistribution!);
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

  void showSearchableStructureDialog(BuildContext context) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) {
        String filter = '';
        return StatefulBuilder(
          builder: (context, setState) {
            final filtered = struct
                .where((s) => s.toLowerCase().contains(filter.toLowerCase()))
                .toList();
            return AlertDialog(
              title: TextField(
                decoration: const InputDecoration(hintText: "Search"),
                onChanged: (val) => setState(() => filter = val),
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: 300,
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filtered[index]),
                      onTap: () => Navigator.pop(context, filtered[index]),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );

    if (selected != null) {
      onListStructureSelected(selected);
    }
  }
}
