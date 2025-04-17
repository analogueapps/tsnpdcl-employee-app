import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';

import '../database/mapping_of_services/agl_databases/structure_code_db.dart';

class DownloadStructureViewModel extends ChangeNotifier {
  final BuildContext context;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<SpinnerList> list33kVSsOfCircleItem = [];
  String? list33kVSsOfCircleSelect;

  List<SpinnerList> listFeederItem = [];
  String? listFeederSelect;

  List<SpinnerList> list33KvFeederOf132kVssItem = [];
  String? list33KvFeederOf132kVssSelect;

  DownloadStructureViewModel({required this.context}) {
    get33kVSsOfCircle();
  }

  Future<void> get33kVSsOfCircle() async {
    if (_isLoading) return; // Prevent multiple calls
    _isLoading = true;

    list33kVSsOfCircleItem.clear();
    list33kVSsOfCircleSelect = null;
    listFeederItem.clear();
    listFeederSelect = null;
    notifyListeners();
    notifyListeners();

    // Show dialog safely
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ProcessDialogHelper.showProcessDialog(
          context,
          message: "Loading...",
        );
      }
    });

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey) ?? '',
        "api": Apis.API_KEY,
      };

      final payload = {
        "path": "/load/load33kvssOfCircle",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(
          context, Apis.NPDCL_EMP_URL, payload);

      // Close dialog safely
      if (context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ProcessDialogHelper.closeDialog(context);
        });
      }

      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == true) {
            if (response.data['success'] == true) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(
                    response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) =>
                    SpinnerList.fromJson(json)).toList();
                list33kVSsOfCircleItem.clear(); // Clear existing data
                list33kVSsOfCircleItem.addAll(listData);
              } else {
                if (context.mounted) {
                  showAlertDialog(
                      context, response.data['message'] ?? 'No data available');
                }
              }
            } else {
              if (context.mounted) {
                showAlertDialog(
                    context, response.data['message'] ?? 'Operation failed');
              }
            }
          } else {
            if (context.mounted) {
              showSessionExpiredDialog(context);
            }
          }
        } else {
          if (context.mounted) {
            showAlertDialog(context, response.data['message'] ??
                'Request failed with status: ${response.statusCode}');
          }
        }
      } else {
        if (context.mounted) {
          showErrorDialog(context, 'No response from server');
        }
      }
    } catch (e) {
      if (context.mounted) {
        showErrorDialog(context, 'An error occurred: $e');
      }
    } finally {
      _isLoading = false;
      if (context.mounted) {
        notifyListeners();
      }
    }
  }

  void onList33kVSsOfCircleValueChange(String? value) {
    listFeederItem.clear();
    listFeederSelect = null;
    notifyListeners();
    list33kVSsOfCircleSelect = value;
    if (value != null) {
      print("subStation: $list33kVSsOfCircleSelect");
      getFeedersData(value);
    }
    notifyListeners();
  }


  Future<void> getFeedersData(String ss) async {
    listFeederItem.clear();
    listFeederSelect = null;
    notifyListeners();

    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ss": ss,
    };

    final payload = {
      "path": "/load/feeders",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(
        context, Apis.NPDCL_EMP_URL, payload);
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
                final List<dynamic> jsonList = jsonDecode(
                    response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) =>
                    SpinnerList.fromJson(json)).toList();
                listFeederItem.addAll(listData);
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

  void downloadAnother() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text(
              "Success", style: TextStyle(fontSize: doubleEighteen),),
            content: const Text(
                "DTR structure codes downloaded and made available for offline!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('CLOSE'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('DOWNLOAD ANOTHER'),
              ),
            ],
          ),
        );
      },
    );
  }


  void onListFeederValueChange(String? value) {
    listFeederSelect = value;
    if (value != null) {
      print("feeder data: $listFeederSelect");
      getStructFeederDis(listFeederSelect!);
    }
    notifyListeners();
  }

  Future<void> getStructFeederDis(String feederValue) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

      final requestFData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey) ?? "",
        "api": Apis.API_KEY,
        "fc": feederValue,
        "status": "",
        "ignoreSection": "true"
      };


      final payload = {
        "path": "/getStructuresOfFeederOrDistribution",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestFData),
      };

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
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
                  // Parse the message field which contains the list of structures
                  final List<dynamic> structures = jsonDecode(response.data['message']);
                  final dbHelper = StructureDatabaseHelper.instance;

                  // Save each structureCode to the database
                  print("Structure codes insertion starting ");
                  for (var structure in structures) {
                    final structureCode = structure['structureCode'] as String;
                    await dbHelper.insertStructureCode(structureCode);
                    print("Structure codes insertion done ");
                  }
                  downloadAnother();
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
  }
