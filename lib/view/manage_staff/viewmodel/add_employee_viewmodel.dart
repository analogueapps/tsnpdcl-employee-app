import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class AddEmployeeViewModel extends ChangeNotifier {

  AddEmployeeViewModel(BuildContext context){
  }

  //Controllers
  TextEditingController empIdController = TextEditingController();
  TextEditingController empMobileNoController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool edit=false;

  late var objectList=[];
  String? empId;
  String? name;
  String? mobileNo;
  String? staffType;
  bool fieldStaff=false;
  bool subStationOperator=false;

  List<String> locations=[];
  String? selectedLocation;
  Map<String ,String > subStationMap={};

  bool validateConfirm(BuildContext context){
    if(staffType==null || selectedLocation==null){
      showErrorDialog(context, 'Please select substation where SS operator is working');
      return false;
    }
    return true;
  }

  bool isValidate(BuildContext context) {
    if (empIdController.text.length < 7) {
      showErrorDialog(context, 'Please enter valid employee Id');
      return false;
    } else if (empMobileNoController.text.length < 10) {
      showErrorDialog(context, 'Please enter valid Mobile number');
      return false;
    }
    return true;
  }

  void _loadSubStations(BuildContext context) async {

    _isLoading=isTrue;
    notifyListeners();

    final payload={
      "token":SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId":"in.tsnpdcl.npdclemployee",
      "usePertainsSection":true,
      "tre":false,
      "mrt":false,
      "htMeters":false,
    };

    try{

      var response = await ApiProvider(baseUrl: Apis.SS_BASE_URL).postApiCall(context, Apis.SS_MAIN_URL, payload);

      _isLoading=isFalse;
      notifyListeners();

      if(response!.data['sessionValid']==isTrue){
        if(response.data['taskSuccess']==isTrue){
          List<dynamic> data=response.data['dataList'];
          if(data.length!=0){
            locations=data.map((item)=>item['ssName'] as String).toList();
            subStationMap={
              for(var item in data) item['ssName']:item['ssCode']
            };
            print('print subStation Map : $subStationMap');
            print('print locations Map : $locations');
            print('print selected locations : $selectedLocation');
          }else {
            print('No dta founf');
          }
        }else{
          showErrorDialog(context, response.data['message']);
        }
      } else {
        showSessionExpiredDialog(context);
      }
    } catch (e) {
      showErrorDialog(context, 'Something went wrong, Try again !');
    }
  }

  void getUserDetails(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "api": Apis.API_KEY,
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "empid": empIdController.text
    };
    final payload = {
      "path": "/getEmployee",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData)
    };
    try {
      final response = await ApiProvider(baseUrl: Apis.CHECK_BS_UDC_IP_PORT)
          .postApiCall(context, Apis.GET_EMPLOYEE_URL, payload);
      // print("got response : ${response!.data}");
      _isLoading = isFalse;
      notifyListeners();

      final parsedData=jsonDecode(response!.data);

      if (parsedData['tokenValid'] == true) {
        if (parsedData['success'] == true) {
          final objectJsonRaw = parsedData['objectJson'];
          objectList = jsonDecode(objectJsonRaw);
          if (objectList.length == 0) {
            showAlertActionDialog(
                context: context,
                title: "Invalid Employee Id",
                message: "We don't have any O&M staff linked with the Employee Id provided.",
                okLabel: "OK",
                onPressed: () {});
          } else {
            empId=objectList[0]['employeeId'];
            name=objectList[0]['name'];
            mobileNo=objectList[0]['personalPhone'];
            displayEmployeeDetails();
          }
        } else {
          showErrorDialog(context, '${response.data['message']}');
        }
      } else {
        showSessionExpiredDialog(context);
      }
    } catch (e) {
      showErrorDialog(context, '${e.toString()}');
      // showErrorDialog(context, 'An error occurred. Please try again.');
    }
    _loadSubStations(context);
  }

  void confirmAddStaff(BuildContext context) async {

    _isLoading=isTrue;
    notifyListeners();

    final requestData= {
      "api":Apis.API_KEY,
      "authToken":SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "personalMobile":empMobileNoController.text,
      "sectionCode":SharedPreferenceHelper.getStringValue(LoginSdkPrefs.empOfcCode),
      "ofcType":SharedPreferenceHelper.getStringValue(LoginSdkPrefs.empOfcType),
      "ofcCode":SharedPreferenceHelper.getStringValue(LoginSdkPrefs.empOfcCode),
      "wing":SharedPreferenceHelper.getStringValue(LoginSdkPrefs.empWing),
      "smartLogin":"Y",
      "empId":empIdController.text,
      "isSsOp": subStationOperator ? "Y": null,
      if(subStationOperator) "ssCode":subStationMap['$selectedLocation'],
    };
    final payload= {
      "path":"/registerOneTime",
      "apiVersion":"1.0.1",
      "method":"POST",
      "data":jsonEncode(requestData)
    };
    try{
      var response = await ApiProvider(baseUrl: Apis.CHECK_BS_UDC_IP_PORT).postApiCall(context, Apis.GET_EMPLOYEE_URL, payload);
      _isLoading = isFalse;
      notifyListeners();

      final jsonObj=jsonDecode(response!.data);
      print('print decoded type : ${jsonObj.runtimeType}');

      if(jsonObj['tokenValid']==isTrue){
        if(jsonObj['success']==isTrue){
          showSuccessDialog(context, jsonObj['message'], (){Navigator.pop(context);});
        }else{
          showErrorDialog(context, jsonObj['message']);
        }
      } else {
        showSessionExpiredDialog(context);
      }
    } catch (e){
      showErrorDialog(context, 'Something went wrong, Try after some time !');
    }

  }

  void displayEmployeeDetails() {
    edit=!edit;
    notifyListeners();
  }

  void setFieldStaff(bool check) {
    if (check) {
      fieldStaff = true;
      subStationOperator = false;
      staffType = "FIELD STAFF";
      notifyListeners();
    }
  }

  void setSsOperator(bool check) {
    if (check) {
      fieldStaff = false;
      subStationOperator = true;
      staffType = "SUBSTATION OPERATOR";
      notifyListeners();
    }
  }
  void setLocation(String name){
    selectedLocation=name;
    notifyListeners();
  }
}
