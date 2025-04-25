import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dropdown_option.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dtr_structure_entity.dart';


class ReportDTRFailureViewModel extends ChangeNotifier {
  ReportDTRFailureViewModel( {required this.context}) {
    _fetchStructures();
  }
  final formKey = GlobalKey<FormState>();
  final sectionCode =
  SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey);
  final section =
  SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionPrefKey);
  final BuildContext context;
  List<DropdownOption> _structures = [];
  DateTime? selectedDateTime;
  Map<String, dynamic>? _currentStructure;
  bool _isLoading = false;
  bool _isLoadingStructures = false;
  bool _isLoadingStructureDetails = false;
  String? _selectedStructureId;

  List<DropdownOption> get structures => _structures;
  Map<String, dynamic>? get currentStructure => _currentStructure;
  bool get isLoading => _isLoading;
  bool get isLoadingStructures => _isLoadingStructures;
  bool get isLoadingStructureDetails => _isLoadingStructureDetails;
  String? get selectedStructureId => _selectedStructureId;

  List<FeederDisModel> _structureData = [];
  List<FeederDisModel> get structureData => _structureData;


  //equipment code :
  final List<String> failedEquipmentList = ["00000"];
  String? get failedEquipmentCode => _failedEquipmentCode;
  void setFailedEquipmentCode(String? value) {
    _failedEquipmentCode = value;
    notifyListeners();
  }

  // Dropdown selections
  String? _failedEquipmentCode;
  String? _selectedStructureCode;

  String get getEstimateRequired => estimateRequired;
  String? get selectedStructureCode => _selectedStructureCode;


  void setSelectedStructureCode(String? value) {
    _selectedStructureCode = value;
    notifyListeners();
  }

//Date and time
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  void setFailureDate(String date) {
    dateController.text = date;
    notifyListeners();
  }

  void setFailureTime(String time) {
    timeController.text = time;
    notifyListeners();
  }

  Future<void> _fetchStructures() async {
    if (_isLoadingStructures) return;
    _isLoadingStructures = true;
    notifyListeners();
    failedEquipmentList.clear();
    _failedEquipmentCode=null;
    notifyListeners();

    try {
      final requestData = {
        "authToken":
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "sectionCode": sectionCode,
      };

      final payload = {
        "path": "/getStructuresOfSection",
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

      // Process structure data (check 'objectJson' or 'message')
      dynamic jsonList = responseData['objectJson'] ?? responseData['message'];
      if (jsonList == null) {
        throw Exception("No structure data received");
      }

      List<DTRStructureEntity> dataList = [];

      if (jsonList is String) {
        // Clean and parse JSON string
        String cleanedJson = jsonList.replaceAll(r'\"', '"').trim();
        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }
        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }

        dataList = (jsonDecode(cleanedJson) as List)
            .map((json) => DTRStructureEntity.fromJson(json))
            .toList();
      } else if (jsonList is List) {
        dataList =
            jsonList.map((json) => DTRStructureEntity.fromJson(json)).toList();
      }


      _structures = dataList
          .where((e) => e.structureCode != null)
          .map((e) => DropdownOption(
        optionId: e.structureCode!,
        optionName: e.structureCode!,
      ))
          .toList();

      if (_structures.isNotEmpty) {
        _selectedStructureId = _structures.first.optionId;
        // Schedule the load for the next frame to ensure UI is ready
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await _loadStructureDetails(_selectedStructureId!);
          // Update equipment list after loading
          _updateEquipmentList();
          notifyListeners();
        });
      }


      String firstStructureCode =
      dataList.isNotEmpty ? dataList[0].structureCode! : "";

      print("Fetched ${dataList.length} structures");
      print("First structure code: $firstStructureCode");

      if (firstStructureCode.isNotEmpty) {
        _selectedStructureId = firstStructureCode; // Set default selection
        print("Default selected structure ID set to: $_selectedStructureId");
        print(
            "Calling _loadStructureDetails with $firstStructureCode, isLoadingStructures: $_isLoadingStructures");
        _isLoadingStructures =
        false;
        notifyListeners();
      } else {
        print("No structure code found.");
      }

      print("Successfully loaded ${_structures.length} structures");
    } catch (e, stackTrace) {
      print("Error fetching structures: $e\n$stackTrace");
      if (context.mounted) {
        showErrorDialog(context, "Failed to load structures: ${e.toString()}");
      }
    } finally {
      _isLoadingStructures = false;
      notifyListeners();
    }
  }

  void _updateEquipmentList() {
    failedEquipmentList.clear();
    _failedEquipmentCode=null;
    notifyListeners();
    var uniqueCodes = <String>{};
    for (var structure in _structureData) {
      if (structure.dtrs != null) {
        for (var dtr in structure.dtrs!) {
          if (dtr.equipmentCode != null && dtr.equipmentCode!.isNotEmpty) {
            uniqueCodes.add(dtr.equipmentCode!);
          }
        }
      }
    }

    failedEquipmentList.addAll(uniqueCodes.toList());

    if (failedEquipmentList.isNotEmpty) {
      _failedEquipmentCode = failedEquipmentList.firstWhere(
            (code) => code != "00000",
        orElse: () => failedEquipmentList.first,
      );
    }

    notifyListeners();
  }

  Future<void> setSelectedStructure(String? structureId) async {
    failedEquipmentList.clear();
    _failedEquipmentCode=null;
    notifyListeners();
    _selectedStructureId = structureId;
    if (structureId != null) {
      await _loadStructureDetails(structureId);
      print("stuctureId: $structureId");
    } else {
      _currentStructure = null;
    }
    notifyListeners();
  }

  Future<void> _loadStructureDetails(String structureCode) async {
    if (_isLoadingStructureDetails) {
      print("Already loading structure details, skipping");
      return;
    }

    print("Starting _loadStructureDetails with: $structureCode");
    _structureData.clear();
    _isLoadingStructureDetails = true;
    notifyListeners();

    try {
      String authToken = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? '';
      if (authToken.isEmpty) {
        throw Exception("Authentication token is empty");
      }

      final requestData = {
        "authToken": authToken,
        "api": Apis.API_KEY,
        "structureCode": structureCode,
      };

      final payload = {
        "path": "/getDtrsOfStructure",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      print("Making API request with payload: $payload");
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("Null response from API");
      }

      print("Received response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      dynamic responseData = response.data;
      if (responseData is String) {
        try {
          responseData = jsonDecode(responseData);
        } catch (e) {
          throw Exception("Failed to decode JSON: $e");
        }
      }

      if (response.statusCode != successResponseCode) {
        throw Exception("API request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "API reported failure");
      }

      if (responseData['message'] == null) {
        throw Exception("No message data in response");
      }

      // Process the response data
      final jsonMessage = responseData['message'];
      List<FeederDisModel> dataList = [];

      if (jsonMessage is String) {
        try {
          final structureJson = jsonDecode(jsonMessage);
          if (structureJson is Map) {
            dataList.add(FeederDisModel.fromJson(structureJson));
          } else if (structureJson is List) {
            dataList.addAll(structureJson.map((e) => FeederDisModel.fromJson(e)));
          }
        } catch (e) {
          throw Exception("Failed to parse message string: $e");
        }
      } else if (jsonMessage is Map<String, dynamic>) {
        dataList.add(FeederDisModel.fromJson(jsonMessage));
      } else if (jsonMessage is List) {
        dataList.addAll(jsonMessage.map((e) => FeederDisModel.fromJson(e)));
      }

      _structureData = dataList;
      print("Successfully loaded ${_structureData.length} structure details");

      // Update equipment list from DTRs
      failedEquipmentList.clear();
      _failedEquipmentCode=null;
      notifyListeners();
      for (var structure in _structureData) {
        if (structure.dtrs != null) {
          for (var dtr in structure.dtrs!) {
            if (dtr.equipmentCode != null) {
              failedEquipmentList.add(dtr.equipmentCode!);
            }
          }
        }
      }
      if (failedEquipmentList.isEmpty) {
        failedEquipmentList.add("00000"); // Default value if none found
      }

      notifyListeners();

    } catch (e, stackTrace) {
      print("Error in _loadStructureDetails: $e\n$stackTrace");
      if (context.mounted) {
        showErrorDialog(context, "Failed to load structure details: ${e.toString()}");
      }
    } finally {
      _isLoadingStructureDetails = false;
      notifyListeners();
      print("Completed _loadStructureDetails");
    }
  }


  //Dtr failure reason
  List<String> failureReasons = [];

  void toggleFailureReason(String reason) {
    if (failureReasons.contains(reason)) {
      failureReasons.remove(reason); // Uncheck: Remove from list
    } else {
      failureReasons.add(reason); // Check: Add to list
    }
    notifyListeners();
  }
  List<String> get getFailureReasons => failureReasons;

  //yes or no check box
  String estimateRequired = "";
  void toggleEstimateRequired(String value) {
    if (estimateRequired == value) {
      estimateRequired = "";
    } else {
      estimateRequired = value;
    }
    notifyListeners();
  }

  void save() {
    formKey.currentState!.save();
    notifyListeners();

    if (!validateForm()) {
      return;
    } else {
      saveDTRFailure(failureReasons,getEstimateRequired,dateController.text,timeController.text, selectedStructureId!,_failedEquipmentCode!  );
      print(SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.sectionCodePrefKey) + "Section Code");
      print('Equipment Code: $_failedEquipmentCode');
      print('Structure Code: $selectedStructureId');
      print('Date: ${dateController.text}');
      print('Time: ${timeController.text}');
      print('estimateRequiredNo: $getEstimateRequired');
      print('reason: $failureReasons');
    }
  }

  bool validateForm() {
    if ((dateController.text==''||dateController.text==null)&&(timeController.text==""||timeController.text==null)) {
      AlertUtils.showSnackBar(context, "Please select DTR failure date and time", isTrue);
      print("Please select DTR failure date");
      return false;
    }else if (dateController.text.isNotEmpty && timeController.text.isEmpty ) {
      AlertUtils.showSnackBar(
          context, "Please select DTR failure time",
          isTrue);
      return false;
    }else if (dateController.text.isEmpty && timeController.text.isNotEmpty ) {
      AlertUtils.showSnackBar(
          context, "Please select DTR failure date",
          isTrue);
      return false;
    }
    else if (failureReasons.isEmpty || failureReasons==[] ) {
      AlertUtils.showSnackBar(
          context, "Please select at least one reason for the  DTR failure",
          isTrue);
      return false;
    } else if (getEstimateRequired.isEmpty ) {
      AlertUtils.showSnackBar(
          context, "Please select Estimate Required Yes/No",
          isTrue);
      return false;
    }else if (_failedEquipmentCode==null ) {
      AlertUtils.showSnackBar(
          context, "Please select failed equipment code ",
          isTrue);
      return false;
    }
    return true;
  }

  Future<void> saveDTRFailure(List<String> reasons, String estimateRequired, String date, String time, String structCode, String equipmentCode) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "reasons": reasons,
      "estimateRequired": estimateRequired,
      "failureDate": date,
      "failureTime": time,
      "structureCode": structCode,
      "equipmentCode": equipmentCode,
      "reportedBySap": "Y", //reportedBySap ==false?Y:N
      "sapFailureCount": "INSPECTED",
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.SAVE_DTR_FAILURE_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == true) {
            if (response.data['taskSuccess'] == true) {
              if (response.data['message'] != null && (response.data['dataList'] == null || response.data['dataList'].isEmpty)) {
                showErrorDialog(context, response.data['message']);
              } else {
                showSuccessDialog(context, response.data['message'] ?? 'Success', () {
                  Navigator.pop(context);
                });
              }
            } else {

              showErrorDialog(context, response.data['message'] ?? 'Operation failed');
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message'] ?? 'Request failed with status: ${response.statusCode}');
        }      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

}