import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';
import 'package:tsnpdcl_employee/view/routed_from_ccc/model/consumer_uscno_model.dart';
import 'package:tsnpdcl_employee/widget/pdf_platform_to_temporary.dart';

class DismantleCreateCorrespondenceViewmodel extends ChangeNotifier {
  DismantleCreateCorrespondenceViewmodel({required this.context, this.args}) {
    if (args != null && args!['uscno'] != null) {
      uscNo.text = args?['uscno'];
    } else {
      uscnoReadOnly = isFalse;
      notifyListeners();
    }
    addToMeterList();
  }

  final BuildContext context;
  final Map<String, dynamic>? args;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool fetchDetailsClicked = false;

  bool _meterAvailableSwitch = false;

  bool get meterAvailableSwitch => _meterAvailableSwitch;

  bool uscnoReadOnly = isTrue;

  set meterAvailable(bool value) {
    _meterAvailableSwitch = value;
    print("_meterAvailableSwitch: $_meterAvailableSwitch");
    if (_meterAvailableSwitch == isTrue) {
      _loadMeterMake();
    }
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController uscNo = TextEditingController();
  TextEditingController consumerWithUscNo = TextEditingController();
  TextEditingController scNoCat = TextEditingController();
  TextEditingController consumerName = TextEditingController();
  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();
  TextEditingController addressLine3 = TextEditingController();
  TextEditingController addressLine4 = TextEditingController();
  TextEditingController serialNo = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController kwh = TextEditingController();
  TextEditingController disConnectionDate = TextEditingController();

  void setFromDate(String date) {
    disConnectionDate.text = date;
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
        selectedFile = await PdfPlatformToTemp.createTempFileFromPlatformFile(
            platformFile);
        fileName = PdfPlatformToTemp.getFileName(platformFile);

        notifyListeners(); // Notify UI of changes
      } catch (e) {
        print('Error creating temp file: $e');
        // Optional: Show error in UI
      }
    }
  }

  String? meterMakeName;
  List<EroModel> meterMakesMap = [];

  void updateOldMeterMake(String name) {
    meterMakeName = name;
    print("selected make: $meterMakeName");
    notifyListeners();
  }

  final List<ConsumerUscnoModel> _consumerUSCNOData = [];
  List<ConsumerUscnoModel> get consumerUSCNOData => _consumerUSCNOData;

  Future<void> getConsumerWithUscNo(String uscNo) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Fetching please wait...",
    );
    fetchDetailsClicked = isTrue;
    _consumerUSCNOData.clear();
    notifyListeners();

    final payload = {
      "token":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "uscno": uscNo,
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
              if (response.data['dataList'] != null) {
                List<dynamic> jsonList;

                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];
                }

                final List<ConsumerUscnoModel> dataList = jsonList
                    .map((json) => ConsumerUscnoModel.fromJson(json))
                    .toList();

                _consumerUSCNOData.addAll(dataList);
                storeConsumerDetails();
                notifyListeners();
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

  String? meterStatusName;
  void updateMeterStatus(String name) {
    meterStatusName = name;
    print("selected make status: $meterStatusName");
    notifyListeners();
  }

  List<EroModel> meterStatus = [];

  void addToMeterList() {
    meterStatus.add(EroModel(optionId: "01", optionName: "LIVE(01)"));
    meterStatus.add(EroModel(optionId: "02", optionName: "STUCKUP(02)"));
    meterStatus.add(EroModel(optionId: "03", optionName: "UDC(03)"));
    meterStatus.add(EroModel(optionId: "05", optionName: "DOOR-LOCK(05)"));
    meterStatus
        .add(EroModel(optionId: "06", optionName: "METER NOT EXIST(06)"));
    meterStatus.add(EroModel(optionId: "07", optionName: "ROUND COMPLETE(07)"));
    meterStatus.add(EroModel(optionId: "9", optionName: "NIL CONSUMPTION(09)"));
    meterStatus.add(EroModel(optionId: "11", optionName: "BURNT(11)"));
    meterStatus.add(EroModel(optionId: "12", optionName: "SLUGGISH(12)"));
    meterStatus.add(EroModel(optionId: "13", optionName: "OTHERS(13)"));
  }

  void storeConsumerDetails() {
    consumerWithUscNo.text = consumerUSCNOData[0].uscNo;
    consumerName.text = consumerUSCNOData[0].consumerName;
    addressLine1.text = consumerUSCNOData[0].address1 ?? "";
    addressLine2.text = consumerUSCNOData[0].address2 ?? "";
    addressLine3.text = consumerUSCNOData[0].address3 ?? "";
    addressLine4.text = consumerUSCNOData[0].address4 ?? "";
    scNoCat.text = "${consumerUSCNOData[0].scNo}/${consumerUSCNOData[0].cat}";
    notifyListeners();
  }

  void _loadMeterMake() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
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
                final List<EroModel> listData =
                rawList.map((json) => EroModel.fromJson(json)).toList();
                meterMakesMap.addAll(listData);
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
    notifyListeners();
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      } else {
        if (_consumerUSCNOData.isEmpty){
          createDismantleService();
      }else {
      updateDismantleService();
    }
        print("in else block");
      }
    }
  }

  bool validateForm() {
    if (uscNo.text.isEmpty ||
        uscNo.text.isEmpty ||
        consumerWithUscNo.text.isEmpty) {
      AlertUtils.showSnackBar(context,
          "Please Enter USCNO and fetch consumer details first", isTrue);
      return false;
    }
    if (meterAvailableSwitch == isTrue && (serialNo.text.isEmpty)) {
      AlertUtils.showSnackBar(
          context, "Please Enter meter serial number", isTrue);
      return false;
    } else if (meterAvailableSwitch == isTrue && capacity.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Please Enter meter capacity", isTrue);
      return false;
    } else if (meterAvailableSwitch == isTrue && kwh.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Please Enter KWH reading", isTrue);
      return false;
    } else if (disConnectionDate.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please select Revision from date", isTrue);
      return false;
    }
    if (fileName == "") {
      AlertUtils.showSnackBar(
          context, "Please upload consumer representation", isTrue);
      return false;
    }
    return true;
  }

  Future<void> createDismantleService() async {
    ProcessDialogHelper.showProcessDialog(context, message: "Loading...");

    final payload = {
      "token":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "deviceId": await getDeviceId(),
      "consumer": jsonEncode(_consumerUSCNOData) ,
      "kwh": meterAvailableSwitch == isTrue ? kwh.text : "-",
      "KvAh": meterAvailableSwitch == isTrue ? capacity.text : "",
      "meterCap": meterAvailableSwitch == isTrue ? capacity.text : "",
      "meterMake":meterAvailableSwitch == isTrue ? meterMakeName : "",
      "meterSlNo":serialNo.text ?? "",
      "cccComplaintId":"",
      "disconnectionDate":disConnectionDate.text,
    };

    var response = await ApiProvider(baseUrl: Apis.ERO_CORRESPONDENCE_URL)
        .postApiCallWithFile(context, Apis.CREATE_DISMANTLE_SERVICE, payload,
        'consumer_representation', selectedFile!, fileName);

    if (context.mounted) ProcessDialogHelper.closeDialog(context);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Convert string to Map
        }

        if (response.statusCode == successResponseCode) {
          final data = response.data;

          if (data['sessionValid'] == true) {
            if (data['taskSuccess'] == true) {
              if (data['message'] != null) {
                showSuccessDialog(context, data['message'], () {
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



  Future<void> updateDismantleService() async {
    ProcessDialogHelper.showProcessDialog(context, message: "Loading...");

    final payload = {
      "token":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "paidPrNo": "",
      "paidDate": "",
      "prAmount": "",
      "applicationId":"",
    };

    var response = await ApiProvider(baseUrl: Apis.ERO_CORRESPONDENCE_URL)
        .postApiCallWithFile(context, Apis.UPDATE_DISMANTLE_SERVICE, payload,
        'consumer_representation', selectedFile!, fileName);

    if (context.mounted) ProcessDialogHelper.closeDialog(context);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Convert string to Map
        }

        if (response.statusCode == successResponseCode) {
          final data = response.data;

          if (data['sessionValid'] == true) {
            if (data['taskSuccess'] == true) {
              if (data['message'] != null) {
                showSuccessDialog(context, data['message'], () {
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

  void resetValues() {
    consumerWithUscNo.clear();
    consumerName.clear();
    addressLine1.clear();
    addressLine2.clear();
    addressLine3.clear();
    addressLine4.clear();
    scNoCat.clear();
    kwh.clear();
    capacity.clear();
    serialNo.clear();

    notifyListeners();
  }
}
