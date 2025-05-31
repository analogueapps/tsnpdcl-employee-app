import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/interruption_details_model.dart';
import '../../../dialogs/dialog_master.dart';
import '../../../utils/app_constants.dart';
import '../../dtr_master/model/circle_model.dart';
import '../../line_clearance/model/spinner_list.dart';
import '../model/saidi_saifi_model.dart';

class SaidiSaifiCalculatorViewmodel extends ChangeNotifier {
  SaidiSaifiCalculatorViewmodel({required this.context});
  final BuildContext context;
  final sectionCode = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey);
  final circleCode = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.circleIdPrefKey);
  Map<String, dynamic>? _selectedMonthYear;


  List<SpinnerList> listSubStationItem = [];
  String listSubStationSelect="";
  String listSubStationSelectName="";
  void onListSubStationItemSelect(String value, String value2) {
    listSubStationSelect= value;
    listSubStationSelectName=value2;
    if(listSubStationSelect!=""|| listSubStationSelect!.isNotEmpty) {
      loadFeedersForSaidiSaifi(listSubStationSelect);
    }
    notifyListeners();
  }

  List<Substation> _substations = [];

  List<InterruptionDetails> _interruptionDetails = [];
  bool _isLoading = false;

  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;

  List<Substation> get substations => _substations;

  List<InterruptionDetails> get interruptionDetails => _interruptionDetails;
  bool get isLoading => _isLoading;


  // Methods
  void setSelectedMonthYear(String month, int year, BuildContext context) async {
    _selectedMonthYear = {'month': month, 'year': year};
    notifyListeners();
    await get33kVSsOfCircle(context); // Pass month and year here
  }


  Future<void> get33kVSsOfCircle(BuildContext context) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "circleCode": circleCode,
      "sectionCode": sectionCode
    };

    final payload = {
      "path": "/load/load33kvssOfCircle",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
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
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                listSubStationItem = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                _substations = listSubStationItem.map((item) => Substation(
                  id: item.optionCode ?? '',
                  name: item.optionName ?? '',
                )).toList();
                notifyListeners(); // Notify after updating the lists
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
  }

  final formKey = GlobalKey<FormState>();
  List<InterruptionsControllers> interruptionControllers = [];
  List<DurationControllers> durationControllers = [];

  List<SubstationModel> listDistributionItem = [];

  Future<void> loadFeedersForSaidiSaifi(String? subStation ) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );


    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ssCode": subStation,
      "ss": subStation,
      "monthYear": "${selectedMonthYear!['month']}${selectedMonthYear!['year']}"
    };

    final payload = {
      "path": "/load/loadFeedersForSaidiSaifi",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
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
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(
                    response.data['objectJson']);
                final List<SubstationModel> listData = jsonList.map((json) =>
                    SubstationModel.fromJson(json)).toList();
                listDistributionItem.addAll(listData);
                for (int i = 0; i < listDistributionItem.length; i++) {
                  interruptionControllers.add(InterruptionsControllers());
                  durationControllers.add(DurationControllers());
                }

                notifyListeners();
                print("Added to listDistributionItem completed");
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
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Map<String, Map<String, String>> interruptionsDataMap = {};
  void updateInterruptionsData({
    required String feederCode,
    required String elCount,
    required String elDuration,
    required String olCount,
    required String olDuration,
    required String elOlCount,
    required String elOlDuration,
    required String lcCount,
    required String lcDuration,
    required String bdCount,
    required String bdDuration,
    required String ssCode,
  }) {
    interruptionsDataMap[feederCode] = {
      "ss": ssCode,
      "count": "",
      "duration": "",
      "elCount": elCount.isEmpty ? "" : elCount,
      "elDuration": elDuration.isEmpty ? "" : elDuration,
      "olCount": olCount.isEmpty ? "" : olCount,
      "olDuration": olDuration.isEmpty ? "" : olDuration,
      "elOlCount": elOlCount.isEmpty ? "" : elOlCount,
      "elOlDuration": elOlDuration.isEmpty ? "" : elOlDuration,
      "lcCount": lcCount.isEmpty ? "" : lcCount,
      "lcDuration": lcDuration.isEmpty ? "" : lcDuration,
      "bdCount": bdCount.isEmpty ? "" : bdCount,
      "bdDuration": bdDuration.isEmpty ? "" : bdDuration,
    };
    print("interruptionsDataMap data: $interruptionsDataMap");
  }

  bool isAnyFeederLeftBlank(BuildContext context) {
    for (var entry in interruptionsDataMap.entries) {
      final feederCode = entry.key;
      final data = entry.value;

      if (data["elCount"]!.isEmpty ||
          data["elDuration"]!.isEmpty ||
          data["olCount"]!.isEmpty ||
          data["olDuration"]!.isEmpty ||
          data["elOlCount"]!.isEmpty ||
          data["elOlDuration"]!.isEmpty ||
          data["lcCount"]!.isEmpty ||
          data["lcDuration"]!.isEmpty ||
          data["bdCount"]!.isEmpty ||
          data["bdDuration"]!.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Missing Data"),
            content: Text("Please specify interruption count & duration for feeder $feederCode. If zero, enter '0'."),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
            ],
          ),
        );
        return false;
      }
    }
    return true;
  }

  void addListeners(
      String feederCode,
      String ssCode,
      TextEditingController elCountCtrl,
      TextEditingController elDurCtrl,
      TextEditingController olCountCtrl,
      TextEditingController olDurCtrl,
      TextEditingController elOlCountCtrl,
      TextEditingController elOlDurCtrl,
      TextEditingController lcCountCtrl,
      TextEditingController lcDurCtrl,
      TextEditingController bdCountCtrl,
      TextEditingController bdDurCtrl,
      ) {
    void update() {
      updateInterruptionsData(
        feederCode: feederCode,
        ssCode: ssCode,
        elCount: elCountCtrl.text,
        elDuration: elDurCtrl.text,
        olCount: olCountCtrl.text,
        olDuration: olDurCtrl.text,
        elOlCount: elOlCountCtrl.text,
        elOlDuration: elOlDurCtrl.text,
        lcCount: lcCountCtrl.text,
        lcDuration: lcDurCtrl.text,
        bdCount: bdCountCtrl.text,
        bdDuration: bdDurCtrl.text,
      );
    }

    for (var ctrl in [
      elCountCtrl,
      elDurCtrl,
      olCountCtrl,
      olDurCtrl,
      elOlCountCtrl,
      elOlDurCtrl,
      lcCountCtrl,
      lcDurCtrl,
      bdCountCtrl,
      bdDurCtrl,
    ]) {
      ctrl.addListener(update);
    }
  }

  Future<void> submitForm() async {

    formKey.currentState!.save();
    notifyListeners();

    if (!isAnyFeederLeftBlank(context)) {
      return;
    }else{
      calculateSidiSifi();
    }

  }

  Future<void> calculateSidiSifi( ) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );


    final requestData = {
      "data": jsonEncode(interruptionsDataMap),
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "monthYear": "${selectedMonthYear!['month']}${selectedMonthYear!['year']}"
    };

    final payload = {
      "path": "/calculateSidiSifiV2",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
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
              if (response.data['message'] != null) {
               showSuccessDialog(context, response.data['message'], (){
                 Navigator.pop(context);
               });
              }
            } else {
              showAlertDialog(context, response.data['message']);
              interruptionsDataMap.clear();
              listSubStationSelect="";
              listSubStationItem.clear();

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
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
}

