import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/model/substation_model.dart';
import 'dart:convert'; // For jsonEncode/jsonDecode
import 'package:flutter/foundation.dart'; // For notifyListeners

class CTFailureReportViewModel extends ChangeNotifier {
  final BuildContext context;
  String? selectedHTSC;
  String? selectedVillage;
  String? selectedMake;
  String? selectedCTPTRatio;
  List<SubstationModel> _substations = [];
  List<String> _areas = []; // Store API-fetched areas
  List<String> _makes = []; // Store API-fetched makes
  List<String> _ctptRatios = []; // Store API-fetched CT/PT ratios
  bool _isLoading = false;
  List<SubstationModel> get substations => _substations;
  bool get isLoading => _isLoading;
  static const int successResponseCode = 200;
  final Map<String, String> _areaCodeMap = {};

  final TextEditingController mfController = TextEditingController();
  final TextEditingController serialNoController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController makeController = TextEditingController();

  // Counter to track active API calls
  int _activeApiCalls = 0;

  CTFailureReportViewModel({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getHTServices();
      getCtPtMakes();
      getCtPtRatios();
    });
  }

  // Helper method to show loading dialog only if no dialog is currently shown
  void _showLoadingDialog() {
    if (_activeApiCalls == 0) {
      ProcessDialogHelper.showProcessDialog(
        context,
        message: "Processing Data...",
      );
    }
    _activeApiCalls++;
  }

  // Helper method to dismiss loading dialog only when all API calls are complete
  void _dismissLoadingDialog() {
    _activeApiCalls--;
    if (_activeApiCalls <= 0) {
      Navigator.of(context, rootNavigator: true).pop();
      _activeApiCalls = 0; // Reset to avoid negative counts
    }
  }

  Future<void> getHTServices() async {
    _substations.clear();
    _isLoading = true;
    notifyListeners();
    _showLoadingDialog(); // Show loader

    try {
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey);
      final payload = {
        "path": "/getHTServices",
        "apiVersion": "1.0.1",
        "method": "POST",
        "data": jsonEncode({
          "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
          "api": Apis.API_KEY,
        })
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (response.statusCode == successResponseCode) {
        if (responseData['tokenValid'] == true &&
            responseData['success'] == true) {
          dynamic objectJson = responseData['objectJson'];
          List<dynamic> jsonList;

          if (objectJson is String) {
            jsonList = jsonDecode(objectJson) as List<dynamic>;
          } else if (objectJson is List) {
            jsonList = objectJson;
          } else {
            jsonList = [];
          }

          _substations = jsonList
              .map((json) => SubstationModel.fromJson(json))
              .toList();

          if (_substations.isNotEmpty) {
            selectedHTSC = '${_substations.first.newUscno}(${_substations.first.cname})';
            notifyListeners(); // Notify listeners after setting selectedHTSC
            await fetchAreas(); // Call fetchAreas to get areas for default HTSC
          }
        } else {
          showAlertDialog(
            context,
            responseData['message'] ?? "Request failed",
          );
        }
      } else {
        showAlertDialog(
          context,
          responseData['message'] ?? "API returned status ${response.statusCode}",
        );
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
      _dismissLoadingDialog(); // Dismiss loader
    }
  }

  Future<void> fetchAreas() async {
    if (selectedHTSC == null || selectedHTSC!.isEmpty) {
      return;
    }

    _isLoading = true;
    notifyListeners();
    _showLoadingDialog(); // Show loader

    try {
      SubstationModel? selectedSubstation;
      for (var substation in _substations) {
        if ('${substation.newUscno}(${substation.cname})' == selectedHTSC) {
          selectedSubstation = substation;
          break;
        }
      }

      if (selectedSubstation == null || selectedSubstation.ebsSeccode == null) {
        showAlertDialog(context, "Invalid HT SC. NO. selected.");
        return;
      }

      final payload = {
        "path": "/getAreas",
        "apiVersion": "1.0.1",
        "method": "POST",
        "data": jsonEncode({
          "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
          "api": Apis.API_KEY,
          "ebssec": selectedSubstation.ebsSeccode,
        })
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (response.statusCode == successResponseCode) {
        if (responseData['tokenValid'] == true &&
            responseData['success'] == true) {
          dynamic objectJson = responseData['objectJson'];
          List<dynamic> jsonList;

          if (objectJson is String) {
            jsonList = jsonDecode(objectJson) as List<dynamic>;
          } else if (objectJson is List) {
            jsonList = objectJson;
          } else {
            jsonList = [];
          }

          // Clear previous areas
          _areas.clear();
          _areaCodeMap.clear();

          // Extract areaname and areacode
          for (var json in jsonList) {
            String areaName = json['areaname']?.toString() ?? '';
            String areaCode = json['areacode']?.toString() ?? '';
            if (areaName.isNotEmpty) {
              _areas.add(areaName);
              _areaCodeMap[areaName] = areaCode;
            }
          }

          // Set the first area as default if available
          if (_areas.isNotEmpty) {
            selectedVillage = _areas.first;
          } else {
            selectedVillage = null;
          }

          notifyListeners();
        } else {
          showAlertDialog(
            context,
            responseData['message'] ?? "Failed to fetch areas",
          );
        }
      } else {
        showAlertDialog(
          context,
          responseData['message'] ?? "API returned status ${response.statusCode}",
        );
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
      _dismissLoadingDialog(); // Dismiss loader
    }
  }

  Future<void> getCtPtMakes() async {
    _isLoading = true;
    notifyListeners();
    _showLoadingDialog(); // Show loader

    try {
      final payload = {
        "path": "/getCtPtMakes",
        "apiVersion": "1.0.1",
        "method": "POST",
        "data": jsonEncode({
          "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
          "api": Apis.API_KEY,
        })
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (response.statusCode == successResponseCode) {
        if (responseData['tokenValid'] == true &&
            responseData['success'] == true) {
          dynamic objectJson = responseData['objectJson'];
          List<dynamic> jsonList;

          if (objectJson is String) {
            jsonList = jsonDecode(objectJson) as List<dynamic>;
          } else if (objectJson is List) {
            jsonList = objectJson;
          } else {
            jsonList = [];
          }

          // Extract only the 'value' field from each item
          _makes = jsonList.map((item) => item['value'].toString()).toList();

          // Set the first make as default if available
          if (_makes.isNotEmpty) {
            selectedMake = _makes.first;
          } else {
            selectedMake = null;
          }

          notifyListeners(); // Notify listeners to update make dropdown
        } else {
          showAlertDialog(
            context,
            responseData['message'] ?? "Failed to fetch makes",
          );
        }
      } else {
        showAlertDialog(
          context,
          responseData['message'] ?? "API returned status ${response.statusCode}",
        );
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
      _dismissLoadingDialog(); // Dismiss loader
    }
  }

  Future<void> getCtPtRatios() async {
    _isLoading = true;
    notifyListeners();
    _showLoadingDialog(); // Show loader

    try {
      final payload = {
        "path": "/getCtPtRatios",
        "apiVersion": "1.0.1",
        "method": "POST",
        "data": jsonEncode({
          "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
          "api": Apis.API_KEY,
        })
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;

      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (response.statusCode == successResponseCode) {
        List<dynamic> jsonList;

        // Handle responseData as a Map with objectJson
        if (responseData is Map && responseData['objectJson'] != null) {
          String objectJson = responseData['objectJson'];
          jsonList = jsonDecode(objectJson) as List<dynamic>;
        } else if (responseData is List) {
          jsonList = responseData;
        } else {
          jsonList = [];
        }

        _ctptRatios = jsonList
            .where((item) => item['value'] != null)
            .map((item) => item['value'].toString())
            .toList();

        if (_ctptRatios.isNotEmpty) {
          selectedCTPTRatio = _ctptRatios.first;
        } else {
          selectedCTPTRatio = null;
        }

        notifyListeners();
      } else {
        showAlertDialog(
          context,
          responseData['message'] ?? "API returned status ${response.statusCode}",
        );
      }
    } catch (e) {
      print('Error in getCtPtRatios: $e'); // Debug log
      showErrorDialog(context, "An error occurred while fetching CT/PT ratios: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
      _dismissLoadingDialog(); // Dismiss loader
    }
  }

  List<String> get htscList => _substations.isNotEmpty
      ? _substations
      .map((substation) => '${substation.newUscno}(${substation.cname})')
      .toList()
      : ['Select HT SC. NO.'];

  // Replace villageList with API-fetched areas
  List<String> get villageList => _areas.isNotEmpty ? _areas : ['Select Village'];

  // Replace makeList with API-fetched makes
  List<String> get makeList => _makes.isNotEmpty ? _makes : ['Select Make'];

  List<String> get ctptRatios =>
      _ctptRatios.isNotEmpty ? _ctptRatios : ['Select Ratio'];

  String extractMiddlePartRevised(String text) {
    int startIndex = text.indexOf('(');
    int endIndex = text.lastIndexOf(')');

    if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
      return text.substring(startIndex + 1, endIndex);
    }
    return '';
  }

  void updateHTSC(String? value) {
    selectedHTSC = value;
    _areas.clear(); // Clear previous areas
    selectedVillage = null; // Reset village selection
    notifyListeners();
    fetchAreas(); // Fetch areas for the new HTSC
  }

  void updateVillage(String? value) {
    selectedVillage = value;
    notifyListeners();
  }

  void updateMake(String? value) {
    selectedMake = value;
    makeController.text = value ?? '';
    notifyListeners();
  }

  void updateCTPTRatio(String? value) {
    selectedCTPTRatio = value;
    notifyListeners();
  }

  // Update saveCtPtReport to use area code from map
  Future<void> saveCtPtReport() async {
    if (!_validateForm()) {
      AlertUtils.showSnackBar(context, "Please fill all required fields.", isTrue);
      return;
    }

    _isLoading = true;
    notifyListeners();
    _showLoadingDialog(); // Show loader

    try {
      SubstationModel? selectedSubstation;
      for (var substation in _substations) {
        if ('${substation.newUscno}(${substation.cname})' == selectedHTSC) {
          selectedSubstation = substation;
          break;
        }
      }

      if (selectedSubstation == null) {
        showAlertDialog(context, "Invalid HT SC. NO. selected.");
        return;
      }

      // Get areacode from the selected village
      String areaCode = _areaCodeMap[selectedVillage] ?? '';

      final dataPayload = {
        "authToken":
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "an": selectedVillage ?? "",
        "ac": areaCode, // Use area code from map
        "ctr": selectedCTPTRatio ?? "",
        "ebssec": selectedSubstation.ebsSeccode ?? "",
        "htsc": selectedSubstation.newUscno ?? "",
        "make": selectedMake ?? "",
        "mf": mfController.text,
        "slno": serialNoController.text,
        "yom": yearController.text,
        "cn": extractMiddlePartRevised(selectedHTSC ?? ""),
      };

      final payload = {
        "path": "/saveCtPtReport",
        "apiVersion": "1.0.1",
        "method": "POST",
        "data": jsonEncode(dataPayload),
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (response.statusCode == successResponseCode) {
        if (responseData['tokenValid'] == true && responseData['success'] == true) {
          AlertUtils.showSnackBar(context, responseData['message'] ?? "CT/PT report saved successfully!", isFalse);
          _resetForm();
          Navigator.pop(context);
        } else {
          AlertUtils.showSnackBar(context, responseData['message'] ?? "Failed to save CT/PT report", isTrue);
        }
      } else {
        AlertUtils.showSnackBar(context, responseData['message'] ?? "API returned status ${response.statusCode}", isTrue);
      }
    } catch (e) {
      AlertUtils.showSnackBar(context, "An error occurred: $e", isTrue);
    } finally {
      _isLoading = false;
      notifyListeners();
      _dismissLoadingDialog(); // Dismiss loader
    }
  }

  bool _validateForm() {
    return selectedHTSC != null &&
        selectedVillage != null &&
        selectedMake != null &&
        selectedCTPTRatio != null &&
        mfController.text.isNotEmpty &&
        serialNoController.text.isNotEmpty &&
        yearController.text.isNotEmpty &&
        RegExp(r'^\d+$').hasMatch(mfController.text) &&
        RegExp(r'^\d+$').hasMatch(yearController.text);
    // yearController.text.length == 4;
  }

  // Helper method to reset form after successful submission
  void _resetForm() {
    selectedHTSC = _substations.isNotEmpty
        ? '${_substations.first.newUscno}(${_substations.first.cname})'
        : null;
    selectedVillage = _areas.isNotEmpty ? _areas.first : null;
    selectedMake = _makes.isNotEmpty ? _makes.first : null;
    selectedCTPTRatio = _ctptRatios.isNotEmpty ? _ctptRatios.first : null;
    mfController.clear();
    serialNoController.clear();
    yearController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    mfController.dispose();
    serialNoController.dispose();
    yearController.dispose();
    makeController.dispose();
    super.dispose();
  }
}