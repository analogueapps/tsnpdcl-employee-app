import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/ltmt/model/load_staff_entity.dart';
import 'package:tsnpdcl_employee/view/ltmt/model/meter_stock_entity.dart';

class MeterOMViewmodel extends ChangeNotifier {
  MeterOMViewmodel({required this.context});

  final BuildContext context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MeterStockEntity> _meterStockEntityList1 = [];
  List<MeterStockEntity> get meterStockEntityList1 => _meterStockEntityList1;

  LoadStaffEntity? _selectedStaffEntity;
  LoadStaffEntity? get selectedStaffEntity => _selectedStaffEntity;

  final List<LoadStaffEntity> _loadStaffEntityList = [];
  List<LoadStaffEntity> get loadStaffEntityList => _loadStaffEntityList;

  String selectedEmpID = "";

  Future<void> getLoadStaff() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/loadMyStaff",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("load staff response: $response");
      if (response != null) {
        var responseData = response.data;
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

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isTrue) {
            if (responseData['success'] == isTrue) {
              if (responseData['objectJson'] != null) {
                try {
                  final jsonList = responseData['objectJson'];
                  List<LoadStaffEntity> dataList = [];

                  if (jsonList is String) {
                    String cleanedJsonString =
                        jsonList.replaceAll(r'\"', '"').trim();
                    if (cleanedJsonString.endsWith(',')) {
                      cleanedJsonString = cleanedJsonString.substring(
                          0, cleanedJsonString.length - 1);
                    }
                    if (!cleanedJsonString.startsWith('[')) {
                      cleanedJsonString = '[$cleanedJsonString]';
                    }
                    final staffList = jsonDecode(cleanedJsonString) as List;
                    dataList = staffList
                        .map((json) => LoadStaffEntity.fromJson(json))
                        .toList();
                  } else if (jsonList is List) {
                    dataList = jsonList
                        .map((json) => LoadStaffEntity.fromJson(json))
                        .toList();
                  }

                  _loadStaffEntityList.clear();
                  _loadStaffEntityList.addAll(dataList);
                  showStaffDialog(context);
                  print(
                      "Staff data: ${_loadStaffEntityList.length} items loaded");
                  notifyListeners();
                } catch (e, stackTrace) {
                  print("Error parsing objectJson: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context,
                      "Failed to parse staff data. Please contact support.");
                }
              }
            } else {
              showAlertDialog(context, responseData['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  Future<void> loadData(String empId) async {
    selectedEmpID = empId;
    await getLoaderLoadMetersStock();
  }

  Future<void> getLoaderLoadMetersStock() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "empId": selectedEmpID,
    };

    final payload = {
      "path": "/load/metersStock",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("Meter response: $response");
      if (response != null) {
        var responseData = response.data;
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

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isTrue) {
            if (responseData['success'] == isTrue) {
              if (responseData['objectJson'] != null) {
                try {
                  final jsonList = responseData['objectJson'];
                  List<MeterStockEntity> dataList = [];

                  if (jsonList is String) {
                    String cleanedJsonString = jsonList
                        .replaceAll(r'\"', '"')
                        .replaceAll(r'\u0026', '&')
                        .trim();
                    if (cleanedJsonString.endsWith(',')) {
                      cleanedJsonString = cleanedJsonString.substring(
                          0, cleanedJsonString.length - 1);
                    }
                    if (!cleanedJsonString.startsWith('[')) {
                      cleanedJsonString = '[$cleanedJsonString]';
                    }
                    final parsedList = jsonDecode(cleanedJsonString) as List;
                    dataList = parsedList
                        .map((json) => MeterStockEntity.fromJson(json))
                        .toList();
                  } else if (jsonList is List) {
                    dataList = jsonList
                        .map((json) => MeterStockEntity.fromJson(json))
                        .toList();
                  }

                  _meterStockEntityList1.clear();
                  _meterStockEntityList1.addAll(dataList);
                  print(
                      "Meters data: ${meterStockEntityList1.length} items loaded here");
                  notifyListeners();
                } catch (e, stackTrace) {
                  print("Error parsing objectJson: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context,
                      "Failed to parse meter data. Please contact support.");
                }
              }
            } else {
              showAlertDialog(context, responseData['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
    }
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
              title: const Text('Select Staff'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: _loadStaffEntityList.isEmpty
                            ? const Center(child: Text("No staff available"))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: _loadStaffEntityList
                                    .where((staff) =>
                                        staff.name
                                            .toString()
                                            .toLowerCase()
                                            .contains(searchQuery1) ??
                                        false)
                                    .length,
                                itemBuilder: (context, index) {
                                  final filteredStaff = _loadStaffEntityList
                                      .where((staff) =>
                                          staff.name
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchQuery1) ??
                                          false)
                                      .toList();
                                  final staffName = filteredStaff[index];
                                  return ListTile(
                                    title: Text(
                                        "${staffName.name ?? 'N/A'}, ${staffName.designation ?? 'N/A'}"),
                                    onTap: () {
                                      selectedEmpID = staffName.employeeId!;
                                      print(
                                          "Selected Staff ID: $selectedEmpID");
                                      Navigator.pop(context);
                                      // Use standard Flutter navigation
                                      Navigation.instance.navigateTo(
                                          Routes.meterOM,
                                          args: selectedEmpID);
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
  }

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
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: _meterStockEntityList1.isEmpty
                            ? const Center(child: Text("No meters available"))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: _meterStockEntityList1
                                    .where((meter) =>
                                        meter.meterNo
                                            .toString()
                                            .toLowerCase()
                                            .contains(searchQuery) ??
                                        false)
                                    .length,
                                itemBuilder: (context, index) {
                                  final filteredMeters = _meterStockEntityList1
                                      .where((meter) =>
                                          meter.meterNo
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchQuery) ??
                                          false)
                                      .toList();
                                  final meter = filteredMeters[index];
                                  return ListTile(
                                    title: Text(
                                        "${meter.meterNo?.toString() ?? 'N/A'} | ${meter.make?.toString() ?? 'N/A'}"),
                                    onTap: () {
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
}
