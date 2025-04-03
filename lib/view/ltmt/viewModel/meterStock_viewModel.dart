import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/ltmt/model/load_staff_entity.dart';
import 'package:tsnpdcl_employee/view/ltmt/model/meter_stock_entity.dart';

import '../../../utils/app_constants.dart';

class MeterStockViewmodel extends ChangeNotifier {
  MeterStockViewmodel({required this.context}) {
    getLoaderLoadMetersStock();
  }

  // Current View Context
  final BuildContext context;

  //check box
  List<MeterStockEntity> selectedMeters = []; // To store selected meters
  int get checkedCount => selectedMeters.length;
  void toggleMeterSelection(MeterStockEntity meter, bool isSelected) {
    if (isSelected) {
      selectedMeters.add(meter);
    } else {
      selectedMeters.remove(meter);
    }
    notifyListeners(); // If using Provider/ChangeNotifier
    print("Selected meters count: $checkedCount");
    print("total meters: ${meterStockEntityList.length}");
    print("Selected meters: ${selectedMeters.map((m) => m.meterNo).toList()}");
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  //meterStock
  List<MeterStockEntity> _meterStockEntityList = [];
  List<MeterStockEntity> get meterStockEntityList => _meterStockEntityList;

  //loadStaff
  LoadStaffEntity? _selectedStaffEntity; // Changed to store full entity
  LoadStaffEntity? get selectedStaffEntity => _selectedStaffEntity;
  List<LoadStaffEntity> _loadStaffEntityList = [];
  List<LoadStaffEntity> get loadStaffEntityList => _loadStaffEntityList;

  void setSelectedStaff(LoadStaffEntity? staff) {
    _selectedStaffEntity = staff;
    notifyListeners();
  }

  Future<void> getLoaderLoadMetersStock() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/load/metersStock",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData), //"data": "{\"authToken\":\"{{TOKEN}}\",\"api\":\"{{API_KEY}}\", \"empId\":\"70000000\"}"
    };


    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(
          context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("Meter response: $response");
      if (response != null) {
        var responseData = response.data;
        // Ensure response.data is properly parsed
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(
                context, "Invalid response format. Please try again.");
            return;
          }
        }

        // Check status code
        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isTrue) {
            if (responseData['success'] == isTrue) {
              if (responseData['objectJson'] != null) {
                try {
                  final jsonList = responseData['objectJson'];
                  List<MeterStockEntity> dataList = [];

                  if (jsonList is String) {
                    String cleanedJsonString = jsonList
                        .replaceAll(r'\"', '"')  // Unescape quotes
                        .replaceAll(r'\u0026', '&')  // Handle Unicode characters
                        .trim();

                    // Remove trailing comma if present
                    if (cleanedJsonString.endsWith(',')) {
                      cleanedJsonString = cleanedJsonString.substring(0, cleanedJsonString.length - 1);
                    }

                    // Ensure the string is properly formatted JSON array
                    if (!cleanedJsonString.startsWith('[')) {
                      cleanedJsonString = '[$cleanedJsonString]';
                    }

                    // Parse the cleaned JSON string
                    final parsedList = jsonDecode(cleanedJsonString) as List;
                    dataList = parsedList.map((json) => MeterStockEntity.fromJson(json)).toList();
                  } else if (jsonList is List) {
                    dataList = jsonList.map((json) => MeterStockEntity.fromJson(json)).toList();
                  }

                  _meterStockEntityList.addAll(dataList);
                  print("Meters data: ${_meterStockEntityList.length} items loaded");
                  notifyListeners();
                } catch (e, stackTrace) {
                  print("Error parsing objectJson: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context, "Failed to parse meter data. Please contact support.");
                }
              }            }
          } else {
            showAlertDialog(context, responseData['message']);
          }
        } else {
          showSessionExpiredDialog(context);
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  Future<void> getLoadStaff() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/loadMyStaff",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };


    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(
          context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("load staff response: $response");
      if (response != null) {
        var responseData = response.data;
        // Ensure response.data is properly parsed
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(
                context, "Invalid response format. Please try again.");
            return;
          }
        }

        // Check status code
        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isTrue) {
            if (responseData['success'] == isTrue) {
              if (responseData['objectJson'] != null) {
                try {
                  final jsonList = responseData['objectJson'];
                  List<LoadStaffEntity> dataList = [];

                  if (jsonList is String) {
                    String cleanedJsonString = jsonList
                        .replaceAll(r'\"', '"')  // Unescape quotes
                        // .replaceAll(r'\u0026', '&')  // Handle Unicode characters
                        .trim();

                    // Remove trailing comma if present
                    if (cleanedJsonString.endsWith(',')) {
                      cleanedJsonString = cleanedJsonString.substring(0, cleanedJsonString.length - 1);
                    }

                    // Ensure the string is properly formatted JSON array
                    if (!cleanedJsonString.startsWith('[')) {
                      cleanedJsonString = '[$cleanedJsonString]';
                    }

                    // Parse the cleaned JSON string
                    final staffList = jsonDecode(cleanedJsonString) as List;
                    dataList = staffList.map((json) => LoadStaffEntity.fromJson(json)).toList();
                  } else if (jsonList is List) {
                    dataList = jsonList.map((json) => LoadStaffEntity.fromJson(json)).toList();
                  }

                  _loadStaffEntityList.addAll(dataList);
                  showStaffDialog(context);
                  print("Meters data: ${_loadStaffEntityList.length} items loaded");

                  notifyListeners();
                } catch (e, stackTrace) {
                  print("Error parsing objectJson: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context, "Failed to parse meter data. Please contact support.");
                }
              }            }
          } else {
            showAlertDialog(context, responseData['message']);
          }
        } else {
          showSessionExpiredDialog(context);
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  //floating button action
  void showMeterDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    String searchQuery = '';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Select Meter'),
              content: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Field
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: "Search Meter",
                        hintText: "Type meter number to search",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Meter List
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: _meterStockEntityList.isEmpty
                        ? const Center(child: Text("No meters available"))
                        : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _meterStockEntityList
                          .where((meter) => meter.meterNo.toString()
                          .toLowerCase()
                          .contains(searchQuery) ?? false)
                          .length,
                      itemBuilder: (context, index) {
                        final filteredMeters = _meterStockEntityList
                            .where((meter) => meter.meterNo.toString()
                            .toLowerCase()
                            .contains(searchQuery) ?? false)
                            .toList();

                        final meter = filteredMeters[index];
                        final isChecked = selectedMeters.contains(meter);

                        return ListTile(
                          title: Text(
                              "${meter.meterNo?.toString() ?? 'N/A'} | ${meter.make?.toString() ?? 'N/A'}"),
                          onTap: () {
                            toggleMeterSelection(meter, !isChecked);
                            // setState(() {}); // Update dialog UI
                            notifyListeners();
                            AlertUtils.showSnackBar(
                                context, "Meter Selected", isFalse);
                            Navigator.pop(context);
                            print("Selected meter: ${meter.meterNo}");
                          },
                        );
                      },
                    ),
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

  void showStaffDialog(BuildContext context) {
    final TextEditingController searchController1 = TextEditingController();
    String searchQuery1 = '';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Select staff'),
              content: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Field
                    TextField(
                      controller: searchController1,
                      decoration: const InputDecoration(
                        labelText: "Search Staff",
                        hintText: "Type staff to search",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery1 = value.toLowerCase();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Meter List
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: _loadStaffEntityList.isEmpty
                            ? const Center(child: Text("No meters available"))
                            : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _loadStaffEntityList
                              .where((staff) => staff.name.toString()
                              .toLowerCase()
                              .contains(searchQuery1) ?? false)
                              .length,
                          itemBuilder: (context, index) {
                            final filteredStaff = _loadStaffEntityList
                                .where((meter) => meter.name.toString()
                                .toLowerCase()
                                .contains(searchQuery1) ?? false)
                                .toList();

                            final staffName = filteredStaff[index];
                            return ListTile(
                              title: Text(
                                  "${staffName.name ?? 'N/A'}, ${staffName.designation??"null"} "),
                              onTap: () {
                                setSelectedStaff(staffName);
                                notifyListeners();
                                Navigator.pop(context);
                                allotmentDialog(context);
                                print("Sleected Staff ${staffName.name}");

                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    //     .then((_) {
    //   searchController1.dispose();
    // });
    //${selectedStaff.designation?.toString() ?? 'N/A'}
  }

  void allotmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                'Allot meters to ${_selectedStaffEntity?.name ?? "No Staff"}, ${_selectedStaffEntity?.designation ?? ""}',
                style: const TextStyle(fontSize: titleSize),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child:
                    SizedBox(
                      height: 200, // Limit height
                      child: selectedMeters.isEmpty
                          ? const Center(child: Text("No meters available"))
                          : ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedMeters.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(selectedMeters[index].meterNo.toString()), // FIXED
                          );
                        },
                      ),
                    ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    allotMetersToStaff();
                    Navigator.pop(context);
                    print("empID:${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.userIdPrefKey)}");
                  },
                  child: const Text("CONFIRM & ALLOT"),
                ),
                TextButton(
                  onPressed: () {
                    AlertUtils.showSnackBar(
                        context, "Allotment canceled by user", isTrue);
                    setSelectedStaff(null);
                    notifyListeners();
                    Navigator.pop(context);
                  },
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> allotMetersToStaff() async {
    if (selectedMeters.isEmpty || _selectedStaffEntity == null) {
      AlertUtils.showSnackBar(context, "Please select staff and meters to allot", true);
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Allotting please wait..."),
          ],
        ),
      ),
    );

    // Prepare JSON data with all meter fields
    final List<Map<String, dynamic>> meterArray = selectedMeters.map((meter) {
      return {
        "employeeId": _selectedStaffEntity!.employeeId, // From selected staff
        "meterCapacity": meter.meterCapacity,
        "meterType": meter.meterType,
        "meterTrackId": meter.meterTrackId,
        "make": meter.make,
        "meterNo": meter.meterNo,
        "opDate": meter.opDate,
        "newMeterId": meter.newMeterId,
        "sectionCode": _selectedStaffEntity!.sectionCode, // From selected staff
        "loginName": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.userIdPrefKey), // Still from prefs
      };
    }).toList();

    final Map<String, dynamic> innerData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "array": meterArray,
    };

    // Convert innerData to a JSON string
    final String innerDataString = jsonEncode(innerData);

    // Prepare the full payload
    final Map<String, dynamic> payload = {
      "path": "/saveAllotmentOfMeters",
      "apiVersion": "1.0",
      "method": "POST",
      "data": "$innerDataString", // Stringified JSON as per your example
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      // Close loading dialog
      Navigator.pop(context);

      if (response != null) {
        var responseData = response.data is String ? jsonDecode(response.data) : response.data;

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == true) {
            if (responseData['success'] == true) {
              selectedMeters.clear();
              setSelectedStaff(null);
              notifyListeners();
              await getLoaderLoadMetersStock();
              AlertUtils.showSnackBar(context, responseData['message'] ?? "Meters allotted successfully", false);
            } else {
              AlertUtils.showSnackBar(context, responseData['message'] ?? "Allotment failed", true);
            }
          } else {
            AlertUtils.showSnackBar(context, responseData['message'] ?? "Session expired", true);
            Navigator.pushReplacementNamed(context, '/login');
          }
        } else {
          AlertUtils.showSnackBar(context, "Unable to process your request", true);
        }
      } else {
        AlertUtils.showSnackBar(context, "Unable to process your request", true);
      }
    } catch (e) {
      Navigator.pop(context);
      AlertUtils.showSnackBar(context, "Sorry, something went wrong: $e", true);
      print("Error during allotment: $e");
    }
  }}