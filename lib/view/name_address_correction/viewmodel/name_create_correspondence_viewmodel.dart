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
import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';
import 'package:tsnpdcl_employee/view/routed_from_ccc/model/consumer_uscno_model.dart';
import 'package:tsnpdcl_employee/widget/pdf_platform_to_temporary.dart';

class NameCreateCorrespondenceViewmodel extends ChangeNotifier {
  NameCreateCorrespondenceViewmodel({required this.context}) ;

  final BuildContext context;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool fetchDetailsClicked = false;
  String titleOfUpload="";

  //Name
  bool _nameSwitch = false;

  bool get nameSwitch => _nameSwitch;

  set nameAvailable(bool value) {
    _nameSwitch = value;
    print("__nameSwitch: $_nameSwitch");
    if(_nameSwitch==isFalse){
      _addressSwitch=isTrue;
      notifyListeners();
    }
    notifyListeners();
  }

  //Address
  bool _addressSwitch = false;
  bool get addressSwitch => _addressSwitch;

  set addressAvailable(bool value) {
    _addressSwitch = value;
    print("__nameSwitch: $_addressSwitch");
    if(_addressSwitch==isTrue){
    }
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController uscNo= TextEditingController();
  TextEditingController consumerWithUscNo= TextEditingController();
  TextEditingController scNoCat= TextEditingController();
  TextEditingController consumerName= TextEditingController();
  TextEditingController addressLine1= TextEditingController();
  TextEditingController addressLine2= TextEditingController();
  TextEditingController addressLine3= TextEditingController();
  TextEditingController addressLine4= TextEditingController();
  TextEditingController editAddressLine1= TextEditingController();
  TextEditingController editAddressLine2= TextEditingController();
  TextEditingController editAddressLine3= TextEditingController();
  TextEditingController editAddressLine4= TextEditingController();
  TextEditingController pinCode= TextEditingController();
  TextEditingController surname= TextEditingController();
  TextEditingController name= TextEditingController();
  TextEditingController fatherNameOrWO= TextEditingController();
  

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
        print("Selected fileName: $fileName");
        print("Selected file: $selectedFile");

        notifyListeners(); // Notify UI of changes
      } catch (e) {
        print('Error creating temp file: $e');
        // Optional: Show error in UI
      }
    }
  }


  List<ConsumerUscnoModel> _consumerUSCNOData=[];
  List<ConsumerUscnoModel> get consumerUSCNOData=>_consumerUSCNOData;

  Future<void> getConsumerWithUscNo(String uscNo)async{
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Fetching please wait...",
    );
    fetchDetailsClicked=isTrue;
    _consumerUSCNOData.clear();
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "uscno":uscNo,
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
                List<dynamic> jsonList;

                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];
                }

                final List<ConsumerUscnoModel> dataList =
                jsonList.map((json) => ConsumerUscnoModel.fromJson(json)).toList();

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

  void storeConsumerDetails(){
    if (consumerUSCNOData[0].cat=="1")
    {
      titleOfUpload="UPLOAD AADHAR";
      notifyListeners();
    }else {
      titleOfUpload="UPLOAD MUNICIPALITY RECEIPT";
      notifyListeners();
    }
    consumerWithUscNo.text= consumerUSCNOData[0].uscNo;
    consumerName.text= consumerUSCNOData[0].consumerName;
    addressLine1.text= consumerUSCNOData[0].address1??"";
    addressLine2.text= consumerUSCNOData[0].address2??"";
    addressLine3.text= consumerUSCNOData[0].address3??"";
    addressLine4.text= consumerUSCNOData[0].address4??"";
    scNoCat.text= "${consumerUSCNOData[0].scNo}/${consumerUSCNOData[0].cat}";
    name.text= consumerUSCNOData[0].consumerName;
    fatherNameOrWO.text= consumerUSCNOData[0].fatherName??"";
    editAddressLine1.text=consumerUSCNOData[0].address1??"";
    editAddressLine2.text=consumerUSCNOData[0].address2??"";
    editAddressLine3.text=consumerUSCNOData[0].address3??"";
    editAddressLine4.text=consumerUSCNOData[0].address4??"";
    pinCode.text=consumerUSCNOData[0].pinCode??"";
    notifyListeners();
  }

   String getCorrectionType(){
    if (nameSwitch==isTrue && addressSwitch==isFalse)
    {
      return "NAME";
    }else if (nameSwitch==isFalse&&addressSwitch==isTrue)
    {
      return "ADDRESS";
    }else
    {
      return "NAME & ADDRESS";
    }
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      }else{
        saveRevokeData();
        print("in else block");
      }
    }
  }
  bool validateForm() {
    if (_consumerUSCNOData.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please fetch consumer details first", isTrue);
      return false;
    }
    if (nameSwitch == isTrue &&(surname.text.isEmpty)) {
      AlertUtils.showSnackBar(
          context, "Please enter Surname of the consumer",
          isTrue);
      return false;
    }
    else if (_nameSwitch == isTrue && name.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please enter Name of the consumer",
          isTrue);
      return false;
    }
    else if (_addressSwitch == isTrue  && editAddressLine1.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please enter address line 1",
          isTrue);
      return false;
    }else if (_addressSwitch == isTrue  && editAddressLine2.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please enter address line 2",
          isTrue);
      return false;
    }else if (_addressSwitch == isTrue  && pinCode.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please Enter KVAH reading",
          isTrue);
      return false;
    }else if (selectedOption=="") {
      AlertUtils.showSnackBar(
          context, "Please select document proof type",
          isTrue);
      return false;
    }
    if(fileName==""){
      AlertUtils.showSnackBar(
          context, "Please upload Name or Address proof document",
          isTrue);
      return false;
    }
    return true;
  }


  Future<void> saveRevokeData() async {
    ProcessDialogHelper.showProcessDialog(context, message: "Loading...");

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "areaName": consumerUSCNOData[0].areaName,
      "areaCode":consumerUSCNOData[0].areaCode,
      "cat":consumerUSCNOData[0].cat,
      "uscNo":consumerUSCNOData[0].uscNo,
      "scNo":consumerUSCNOData[0].scNo,
      "existConsumerName":consumerUSCNOData[0].consumerName,
      "existFatherName":consumerUSCNOData[0].fatherName,
      "existSurname":consumerUSCNOData[0].surname??"",
      "existAdd1":consumerUSCNOData[0].address1,
      "existAdd2":consumerUSCNOData[0].address2,
      "existAdd3":consumerUSCNOData[0].address3,
      "existAdd4":consumerUSCNOData[0].address4,
      "changedFatherName":fatherNameOrWO.text,
      "changedSurname":surname.text,
      "changedAdd1":editAddressLine1.text,
      "changedAdd2":editAddressLine2.text,
      "changedAdd3":editAddressLine3.text,
      "changedAdd4":editAddressLine4.text,
      "changedConsumerName":name.text,
      "correctionType":getCorrectionType(),
      "deviceId":await getDeviceId(),
      "documentType":selectedOption=="AADHAR"?"AADHAR":"MUNICIPAL TAX RECEIPT",
      "eroCode":consumerUSCNOData[0].eroCode,
      "existPinCode":consumerUSCNOData[0].pinCode,
      "changedPinCode": pinCode.text,
    };

    var response = await ApiProvider(baseUrl: Apis.ERO_CORRESPONDENCE_URL)
        .postApiCallWithFile(context, Apis.SAVE_REVOKE_SERVICES, payload, 'consumer_representation',selectedFile!, fileName );

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

  void resetValues(){
    consumerWithUscNo.clear();
    consumerName.clear();
    addressLine1.clear();
    addressLine2.clear();
    addressLine3.clear();
    addressLine4.clear();
    scNoCat.clear();
    name.clear();
    fatherNameOrWO.clear();
    surname.clear();
    editAddressLine1.clear();
    editAddressLine2.clear();
    editAddressLine3.clear();
    editAddressLine4.clear();
    pinCode.clear();
    selectedOption = "";
    fileName=null;
    selectedFile=null;
    notifyListeners();
  }
}