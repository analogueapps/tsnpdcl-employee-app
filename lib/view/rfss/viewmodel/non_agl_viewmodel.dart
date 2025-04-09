import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';

class NonAglViewModel extends ChangeNotifier {
  final BuildContext context;

  NonAglViewModel({required this.context});

  void initialize() {
    Future.delayed(Duration.zero, () {
      downloadDistributions();
    });
  }


  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

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
                getDistributions();
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

  List<SubstationModel> _distribution = [];

  List<SubstationModel> get distri => _distribution;

  Future<void> getDistributions() async {
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey),
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

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      // Process response data
      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      // Validate response
      if (response.statusCode != successResponseCode) {
        throw Exception(responseData['message'] ??
            "Request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "Operation failed");
      }

      // Process station data
      if (responseData['objectJson'] == null) {
        throw Exception("No _distribution data received");
      }

      final jsonList = responseData['objectJson'];
      List<SubstationModel> dataList = [];

      if (jsonList is String) {
        // Clean and parse JSON string
        String cleanedJson = jsonList
            .replaceAll(r'\"', '"')
            .trim();

        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }

        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }

        dataList = (jsonDecode(cleanedJson) as List)
            .map((json) => SubstationModel.fromJson(json))
            .toList();
      }
      else if (jsonList is List) {
        dataList = jsonList
            .map((json) => SubstationModel.fromJson(json))
            .toList();
      }

      _distribution.addAll(dataList);
      print("Successfully loaded ${_distribution.length} stations");
    } catch (e, stackTrace) {
      print("Error fetching _distribution: $e\n$stackTrace");
      showErrorDialog(
          context, "Failed to load _distribution: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void onListDistributionSelected(String? value) {
    _selectedDistribution = value;
    getStructFeederDis();
    notifyListeners();
  }

  String? _selectedStructure;
  String? get selectedStructure => _selectedStructure;

  List<FeederDisModel> _structure = [];
  List<FeederDisModel> get struct => _structure;

  Future<void> getStructFeederDis() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {

      final requestSData = {
        "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
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

      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      print("API Response: $responseData");

      if (response.statusCode != successResponseCode) {
        throw Exception(responseData['message'] ?? "Request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "Operation failed");
      }

      final jsonList = responseData['message'];
      List<FeederDisModel> dataList = [];

      if (jsonList == null) {
        print("No feeder/distribution data received in message");
        _structure.clear();
      } else if (jsonList is String) {
        print("Raw message string: $jsonList");
        String cleanedJson = jsonList.trim();
        try {
          if (!cleanedJson.startsWith('[') || !cleanedJson.endsWith(']')) {
            throw FormatException("Invalid JSON array format in message: $cleanedJson");
          }
          dataList = (jsonDecode(cleanedJson) as List<dynamic>)
              .map((json) => FeederDisModel.fromJson(json as Map<String, dynamic>))
              .toList();
          _structure = dataList;
        } catch (e) {
          print("Error decoding JSON string: $e");
          throw e;
        }
      } else if (jsonList is List) {
        print("Processing JSON list: $jsonList");
        dataList = (jsonList as List<dynamic>)
            .map((json) => FeederDisModel.fromJson(json as Map<String, dynamic>))
            .toList();
        _structure = dataList;
      } else {
        throw Exception("Unexpected message format: ${jsonList.runtimeType}");
      }

      print("Successfully loaded ${_structure.length} structure entities");
      print("Navigating to MappedDtr with ${_structure.length} items: ${_structure.map((e) => e.toJson())}");
      Navigation.instance.navigateTo(Routes.mappedDtrScreen, args: _structure);

    } catch (e, stackTrace) {
      print("Error fetching feeder/distribution data: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load data: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
      print("Finished getStructFeederDis");
    }
  }

  void onListStructureSelected(String? value) {
    _selectedStructure = value;
    notifyListeners();
  }

  // void showSubstationDialog(BuildContext context, NonAglViewModel viewmodel) {
  //   final TextEditingController searchController = TextEditingController();
  //   String searchQuery = '';
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext dialogContext) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return AlertDialog(
  //             title: const Text('Select '),
  //             content: SizedBox(
  //               width: double.maxFinite,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   // Search Field
  //                   TextField(
  //                     controller: searchController,
  //                     decoration: const InputDecoration(
  //                       labelText: "Search distribution",
  //                       hintText: "Type to search",
  //                       border: OutlineInputBorder(),
  //                     ),
  //                     onChanged: (value) {
  //                       setState(() {
  //                         searchQuery = value;
  //                       });
  //                     },
  //                   ),
  //                   const SizedBox(height: 10),
  //                   // Substation List
  //                   SizedBox(
  //                     height: 200,
  //                     child: ListView.builder(
  //                       shrinkWrap: true,
  //                       itemCount: viewmodel.distri
  //                           .where((substation) => substation
  //
  //                           .contains(searchQuery.toLowerCase()))
  //                           .length,
  //                       itemBuilder: (context, index) {
  //                         final filteredSubstations = viewmodel.distri
  //                             .where((substation) => substation
  //                             .toLowerCase()
  //                             .contains(searchQuery.toLowerCase()))
  //                             .toList();
  //                         return ListTile(
  //                           title: Text(filteredSubstations[index]),
  //                           onTap: () {
  //                             viewmodel.onListDistributionSelected(filteredSubstations[index]);
  //                             Navigator.pop(dialogContext);
  //                           },
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   ).then((_) {
  //     searchController.dispose();
  //   });
  // }

}
