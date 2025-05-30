
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/lc_master_ss_list.dart';
import 'package:tsnpdcl_employee/view/ptr_feeder_loaders/model/load_abmps_controllers.dart';
import 'package:tsnpdcl_employee/view/ptr_feeder_loaders/model/load_abmps_model.dart';

class PtrFeederViewmodel extends ChangeNotifier {
  final BuildContext context;

  PtrFeederViewmodel({required this.context}){
    loadHours.add("Select");
    loadHours.add("00:00");
    loadHours.add("01:00");
    loadHours.add("02:00");
    loadHours.add("03:00");
    loadHours.add("04:00");
    loadHours.add("05:00");
    loadHours.add("06:00");
    loadHours.add("07:00");
    loadHours.add("08:00");
    loadHours.add("09:00");
    loadHours.add("10:00");
    loadHours.add("11:00");
    loadHours.add("12:00");
    loadHours.add("13:00");
    loadHours.add("14:00");
    loadHours.add("15:00");
    loadHours.add("16:00");
    loadHours.add("17:00");
    loadHours.add("18:00");
    loadHours.add("19:00");
    loadHours.add("20:00");
    loadHours.add("21:00");
    loadHours.add("22:00");
    loadHours.add("23:00");
    getSubstation();
  }
  final formKey = GlobalKey<FormState>();

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  List<LoadInAmpsControllers> controllers = [];
  final TextEditingController rController= TextEditingController();
  final  TextEditingController yController=  TextEditingController();
  final  TextEditingController bController=  TextEditingController();

  String? statusMessage;

  String pickedDate='';
  Future<void> pickDateFromDateTimePicker(BuildContext context) async {
    DateTime? selected= await showDatePicker(
      context: context,
      firstDate: DateTime(1900,01,01),
      lastDate:DateTime.now(),
    );
    pickedDate='${selected?.day}/${selected?.month}/${selected?.year}';
    notifyListeners();
  }


  String? _selectedSs;
  String? get selectedSs => _selectedSs;
  final List<LcMasterSsList> _subStationList = [];
  List<LcMasterSsList> get subStationList => _subStationList;

  Future<void> getSubstation() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_SS_OF_SECTION_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['dataList'] != null) {
                // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
                List<dynamic> jsonList;

                // If dataList is a String, decode it; otherwise, it's already a List
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];  // Fallback to empty list if the type is unexpected
                }
                final List<LcMasterSsList> dataList = jsonList.map((json) => LcMasterSsList.fromJson(json)).toList();
                _subStationList.addAll(dataList);
                notifyListeners();
              }
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  void updateSs(String? value) {
    _selectedSs = value;
    notifyListeners();
  }

  List<String> loadHours = [];
  String? selectedLoadHour;
  void updateLoadHour(String? newHour) {
    selectedLoadHour = newHour;
    notifyListeners();
  }


  //GET DETAILS BUTTON
  void getDetails(String? ssCode){
    if (!validateForm1()) {
      return;
    }else{
      print("in else block");
      getPtrFeederSS(ssCode!);
    }
  }

  bool validateForm1() {
    if (_selectedSs == null || _selectedSs!.isEmpty) {
      AlertUtils.showSnackBar(context, "Please select substation", isTrue);
      return false;
    }else if (pickedDate.isEmpty) {
      AlertUtils.showSnackBar(context, "Please choose date", isTrue);
      return false;
    } else if (selectedLoadHour == null || selectedLoadHour!.isEmpty) {
      AlertUtils.showSnackBar(context, "Please select load hours", isTrue);
      return false;
    }
    return true;
  }


  final List<LoadInAmpsModel> _loadInAmpsModelList=[];
  List<LoadInAmpsModel> get loadInAmpsModelList=>_loadInAmpsModelList;

  Future<void> getPtrFeederSS(String ssCode) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ssCode":ssCode
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_PTR_FEEDERS_SS, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['dataList'] != null) {
                List<dynamic> jsonList;
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];
                }
                _loadInAmpsModelList.clear();
                final List<LoadInAmpsModel> dataList = jsonList.map((json) => LoadInAmpsModel.fromJson(json)).toList();
                _loadInAmpsModelList.addAll(dataList);
                controllers = _loadInAmpsModelList.map((_) => LoadInAmpsControllers()).toList();
                print('Controller final values: $controllers');
                notifyListeners();
              }
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  Future<bool> cautionForBackScreen(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Container(
            width: double.infinity,
            height: 60,
            color: Colors.orange,
            child: Center(child: const Text("EXIT?"))
        ),
        content: const Text("Exit this screen? You will lose any unsaved data."),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('EXIT'),
          ),
        ],
      ),
    ) ?? false;
  }

  bool validateAllPhaseControllers(){
    if(_loadInAmpsModelList.isEmpty){
      AlertUtils.showSnackBar(context, "Please load PTRs and feeders first", isTrue);
    }
    for(int i=0;i<controllers.length;i++){
      String name ='${_loadInAmpsModelList[i].name}' == "PTR" ? '${_loadInAmpsModelList[i].name}(${_loadInAmpsModelList[i].capacity})':'${_loadInAmpsModelList[i].name}';
      for(int j=0;j<3;j++){
        if(controllers[i].bController.text.isEmpty || controllers[i].rController.text.isEmpty || controllers[i].yController.text.isEmpty){
          AlertUtils.showSnackBar(context, "Please load in amps for $name", isTrue);
          return false;
        }
      }
    }
    return true;
  }

  Future<void> submitLoads() async{

    _isLoading = isTrue;
    notifyListeners();

    List<LoadInAmpsModel> feedersList=[];
    for(int i=0;i<controllers.length;i++){
      Map<String, dynamic> sample = {
        "BPhaseCurrent": controllers[i].bController.text,
        "capacity": _loadInAmpsModelList[i].capacity,
        "name":_loadInAmpsModelList[i].name,
        "rPhaseCurrent": controllers[i].rController.text,
        "sapCode": _loadInAmpsModelList[i].sapCode,
        "ssCode": _loadInAmpsModelList[i].ssCode,
        "type": _loadInAmpsModelList[i].type,
        "yPhaseCurrent": controllers[i].yController.text,
      };
      feedersList.add(LoadInAmpsModel.fromJson(sample));
    }
    String formattedData = jsonEncode(feedersList.map((f) => f.toJson()).toList());
    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "data":formattedData,
      "calenderDate":"${pickedDate}",
      "hours":"$selectedLoadHour",
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.SAVE_PTR_FEEDERS, payload);
    _isLoading = isFalse;
    print('response ${response}');
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['dataList'] != null) {
                statusMessage=response.data['message'];
                print('Status message value : $statusMessage');
                if(response.data['message']!=""){
                  showSuccessDialog(context, response.data['message'], (){
                    Navigator.pop(context);
                  });
                }
                _loadInAmpsModelList.clear();
                notifyListeners();
              }
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    } finally{
      _isLoading=isFalse;
    }

  }


}