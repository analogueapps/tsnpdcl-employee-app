import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/widget/pdf_platform_to_temporary.dart';

class RevokeOfServicesViewmodel extends ChangeNotifier {
  RevokeOfServicesViewmodel({required this.context, required this.args}) {
    uscNo.text = args['uscno'];
  }

  final BuildContext context;
  final Map<String, dynamic> args;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool fetchDetailsClicked = false;

  bool _meterAvailableSwitch = false;

  bool get meterAvailableSwitch => _meterAvailableSwitch;

  set meterAvailable(bool value) {
    _meterAvailableSwitch = value;
    print("_meterAvailableSwitch: $_meterAvailableSwitch");
    if(_meterAvailableSwitch==isTrue){
      _loadMeterMake();
    }
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController uscNo= TextEditingController();
  TextEditingController consumerWithUscNo= TextEditingController();
  TextEditingController serialNo= TextEditingController();
  TextEditingController disconnectionDate= TextEditingController();
  TextEditingController capacity= TextEditingController();
  TextEditingController kwh= TextEditingController();
  TextEditingController kvah= TextEditingController();

  void setDate(String date) {
    disconnectionDate.text = date;
    notifyListeners();
  }

  String? selectedOption = "";

  void toggleOption(String value) {
    selectedOption = value;
    print("$selectedOption :choose option");
    notifyListeners();
  }

  //File Upload
  File? selectedFile;
  String? fileName;

  void pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile platformFile = result.files.first;

      try {
        // Convert to temp file
        selectedFile = await PdfPlatformToTemp.createTempFileFromPlatformFile(platformFile);
        fileName = PdfPlatformToTemp.getFileName(platformFile);

        notifyListeners(); // Notify UI of changes
      } catch (e) {
        print('Error creating temp file: $e');
        // Optional: Show error in UI
      }
    }
  }

  String? meterMakeName;
  List<String> optionNames = [];
  List<Map<String, dynamic>> meterMakesMap = [];

  void updateOldMeterMake(String name) {
    meterMakeName = name;
    print("selected make: $meterMakeName");
    notifyListeners();
  }

  Future<void> getConsumerWithUscNo(String uscNo)async{
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Fetching please wait...",
    );
    fetchDetailsClicked=isTrue;
    notifyListeners();



    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "uscno":uscNo
    };

    var response = await ApiProvider(baseUrl: Apis.ERO_CORRESPONDENCE_URL)
        .postApiCall(context, Apis.GET_USCNO_SERVICE_OF_SECTION, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['dataList']!=null) {
                print("data is there in getConsumerWithUscNo");
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

  void _loadMeterMake() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/load/meterMakes",
      "method": "POST",
      "apiVersion": "1.0",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.CHECK_BS_UDC_IP_PORT)
        .postApiCall(context, Apis.METER_MAKE, payload);
    print('Meter make response : $response');
    _isLoading = false;
    notifyListeners();

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Convert string to Map
        }

        if (response.statusCode == successResponseCode) {
          final data = response.data;

          if (data['tokenValid'] == true) {
            if (data['success'] == true) {
              if (data['objectJson'] != null) {
                final List<dynamic> rawList = jsonDecode(data['objectJson']);
                meterMakesMap = rawList.cast<Map<String, dynamic>>();
              } else {
                showAlertDialog(context, "No Data Found");
              }
            } else {
              showAlertDialog(context, data['message'] ?? "Task Failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,
              response.data['message'] ?? "Unexpected server response");
        }
      }
    } catch (e) {
      print("Error: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
    optionNames =
        meterMakesMap.map((item) => item['optionName'] as String).toList();
    notifyListeners();
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      }else{
        // confirmServiceData(circleId, ero, sc, usc);
        print("in else block");
      }
    }
  }
  bool validateForm() {
    if (uscNo.text.isEmpty || uscNo.text.isEmpty || consumerWithUscNo.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please Enter USCNO and fetch consumer details first", isTrue);
      return false;
    }
    if (meterAvailableSwitch == isTrue &&(serialNo.text.isEmpty)) {
      AlertUtils.showSnackBar(
          context, "Please Enter meter serial number",
          isTrue);
      return false;
    }
    else if (meterAvailableSwitch == isTrue && capacity.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please Enter meter capacity",
          isTrue);
      return false;
    }else if (meterAvailableSwitch == isTrue && kwh.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please Enter KWH reading",
          isTrue);
      return false;
    }else if (meterAvailableSwitch == isTrue  && kvah.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please Enter KVAH reading",
          isTrue);
      return false;
    }else if (meterAvailableSwitch == isTrue && disconnectionDate.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please select disconnection date",
          isTrue);
      return false;
    }
    if(fileName==""){
      AlertUtils.showSnackBar(
          context, "Please upload consumer representation",
          isTrue);
      return false;
    }
    return true;
  }


  Future<void> confirmServiceData(String circleId, String ero,
      String sc, String usc) async {
    ProcessDialogHelper.showProcessDialog(context, message: "Loading...");

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "deviceId": await getDeviceId(),
      "consumer": "", //should get data from getConsumerWithUscNo
      "kwh": meterAvailableSwitch == isTrue ? kwh.text : "-",
      "KvAh": meterAvailableSwitch == isTrue ? kvah.text : "",
      "meterCap":meterAvailableSwitch == isTrue ? capacity.text:"",
      "meterMake":meterAvailableSwitch == isTrue ? "":"",
      "meterSlNo":serialNo.text??"",
      "cccComplaintId":args['cccComplaintId'],
      "disconnectionDate":disconnectionDate
    };

    var response = await ApiProvider(baseUrl: Apis.ERO_CORRESPONDENCE_URL)
        .postApiCallWithFile(context, Apis.CREATE_DISMANTLE, payload, 'consumerRepresentation',selectedFile!, fileName );

    if (context.mounted) ProcessDialogHelper.closeDialog(context);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Convert string to Map
        }

        if (response.statusCode == successResponseCode) {
          final data = response.data;

          if (data['tokenValid'] == true) {
            if (data['success'] == true) {
              if (data['message'] != null) {
                showSuccessDialog(context, data['message'] , (){
                  Navigator.pop(context);
                });
              } else {
                showAlertDialog(context, "No Data Found");
              }
            } else {
              showAlertDialog(context, data['message'] ?? "Task Failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,
              response.data['message'] ?? "Unexpected server response");
        }
      }
    } catch (e) {
      print("Error: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
  }
}