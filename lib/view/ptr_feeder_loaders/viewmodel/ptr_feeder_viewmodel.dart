
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
                _loadInAmpsModelList.clear();
                final List<LoadInAmpsModel> dataList = jsonList.map((json) => LoadInAmpsModel.fromJson(json)).toList();
                _loadInAmpsModelList.addAll(dataList);
                controllers = _loadInAmpsModelList.map((_) => LoadInAmpsControllers()).toList();
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


  //for (int i = 0; i < loadInAmpsModelList.length; i++) {
//     final ctrl = controllers[i];
//     final model = loadInAmpsModelList[i];
//
//     model.rPhaseCurrent = _parseFloat(ctrl.rController.text);
//     model.yPhaseCurrent = _parseFloat(ctrl.yController.text);
//     model.bPhaseCurrent = _parseFloat(ctrl.bController.text);
//   }

  // double? _parseFloat(String value) {
  //   return value.isEmpty ? null : double.tryParse(value);
  // }
  // Future<void> savePtrFeederLoads(String ssCode, ) async {
  //   _isLoading = isTrue;
  //   notifyListeners();
  //
  //   final payload = {
  //     "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
  //     "appId": "in.tsnpdcl.npdclemployee",
  //     "data":"",
  //     "calenderDate":"",
  //     "hours":""
  //   };
  //
  //   var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.SAVE_PTR_FEEDERS, payload);
  //   _isLoading = isFalse;
  //
  //   try {
  //     if (response != null) {
  //       if (response.data is String) {
  //         response.data = jsonDecode(response.data); // Parse string to JSON
  //       }
  //       if (response.statusCode == successResponseCode) {
  //         if(response.data['sessionValid'] == isTrue) {
  //           if (response.data['taskSuccess'] == isTrue) {
  //             if(response.data['dataList'] != null) {
  //               // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
  //               List<dynamic> jsonList;
  //
  //               // If dataList is a String, decode it; otherwise, it's already a List
  //               if (response.data['dataList'] is String) {
  //                 jsonList = jsonDecode(response.data['dataList']);
  //               } else if (response.data['dataList'] is List) {
  //                 jsonList = response.data['dataList'];
  //               } else {
  //                 jsonList = [];  // Fallback to empty list if the type is unexpected
  //               }
  //               // final List<LcMasterSsList> dataList = jsonList.map((json) => LcMasterSsList.fromJson(json)).toList();
  //               // _subStationList.addAll(dataList);
  //               // notifyListeners();
  //             }
  //           }
  //         } else {
  //           showSessionExpiredDialog(context);
  //         }
  //       } else {
  //         showAlertDialog(context,response.data['message']);
  //       }
  //     }
  //   } catch (e) {
  //     showErrorDialog(context,  "An error occurred. Please try again.");
  //     rethrow;
  //   }
  //
  //   notifyListeners();
  // }



}