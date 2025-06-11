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
import 'package:tsnpdcl_employee/view/ccc/model/open_model.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class OpenViewmodel extends ChangeNotifier {
  OpenViewmodel({required this.context, required this.data}) {
    for (int i = 0; i <= 24; i++) {
      hours.add("$i");
    }

    for (int i = 0; i <= 60; i++) {
      days.add("$i");
    }
    selectedDay = "";
    selectedHours = "";
    registeredNumber.text=data.registeredMobileNumber??"";
  }

  final BuildContext context;
  final CccOpenModel data;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  final TextEditingController remarks= TextEditingController();
  final TextEditingController registeredNumber= TextEditingController();

  ///choose option
  String? selectedOption = "";

  void toggleOption(String value) {
    selectedOption = value;
    print("$selectedOption :choose option");
    notifyListeners();
  }

  String? selectedDay ;
  String? selectedHours;
  List<String> days = [];
  List<String> hours = [];

  void onDayChange(String value) {
    selectedDay = value;
    print("Day: $selectedDay");
    notifyListeners();
  }

  void onHoursChange(String value) {
    selectedHours = value;
    print("Hours: $selectedHours");
    notifyListeners();
  }

  void update() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState)
        {
          return AlertDialog(
              title: Text(
                "#${data.ticketNumber}", style: const TextStyle(fontSize: 18),),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9, // or a fixed width like 300
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          "SELECT OPTION", style: TextStyle(color: Colors.red)),
                      Row(
                        children: [
                          Radio<String>(
                              value: "InProgress",
                              groupValue: selectedOption,
                              onChanged: (value) {
                                toggleOption(value!);
                                setState(() {});
                              }
                          ),
                          const SizedBox(width: 4),
                          const Text("InProgress"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "Resolved",
                            groupValue: selectedOption,
                            onChanged: (value) {toggleOption(value!);
                            setState(() {});
                            }
                          ),
                          const SizedBox(width: 4),
                          const Text("Resolved"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: selectedOption=="InProgress",
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Text("PROVIDE TIME FRAME",
                          style: TextStyle(color: Colors.red)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("NO OF DAYS",
                                    style: TextStyle(color: Colors.lightBlue)),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text("Select Days"),
                                  value: selectedDay?.isNotEmpty == true
                                      ? selectedDay
                                      : null,
                                  items: days.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: days.isNotEmpty ? (value) {
                                    onDayChange(value!);
                                    setState(() {});
                                  }: null,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("NO OF HOURS",
                                    style: TextStyle(color: Colors.lightBlue)),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text("Select Hours"),
                                  value: selectedHours?.isNotEmpty == true
                                      ? selectedHours
                                      : null,
                                  items: hours.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: hours.isNotEmpty ? (value) {
                                    onHoursChange(value!);
                                    setState(() {});
                                  }: null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ]
                      ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                          "ENTER REMARKS", style: TextStyle(color: Colors.red)),
                      TextFormField(
                        maxLines: null,
                        minLines: 5,
                        controller:remarks ,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          // labelText: "Enter remarks here",
                          hintText: "Type here...",
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    resetDialogValues();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey)),
                  child: const Text(
                    "CANCEL", style: TextStyle(color: Colors.white),),
                ),
                TextButton(
                  onPressed: () async{
                    String optionStatus= selectedOption=="InProgress"?"3":selectedOption=="Resolved"?"6":"-1";
                    Navigator.pop(context);
                    final success = await updateTicket(
                      optionStatus,
                      data.ticketNumber!,
                      selectedHours!,
                      selectedDay!,
                      remarks.text,
                    );
                      print("success: $success");
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),

                  child: const Text(
                    "UPDATE", style: TextStyle(color: Colors.white),),
                ),
              ]
          );
        }
        );
      },
    );
  }

  Future<bool> updateTicket(String status, String tickId, String hours, String days,String remarks)async{
    if (!validateForm1()) {
      return false;
    }else{
      print("in else block");
      await updateOpen(status, tickId, hours, days, remarks);
      return true;
    }
  }

  bool validateForm1() {
    if (selectedOption == null || selectedOption!.isEmpty) {
      AlertUtils.showSnackBar(context, "Please select a option", isTrue);
      return false;
    }else if ((selectedOption=="InProgress")&&(selectedDay==""|| selectedDay==null)) {
      AlertUtils.showSnackBar(context, "Please select no of days", isTrue);
      return false;
    } else if ((selectedOption=="InProgress")&&(selectedHours == null || selectedHours=="")) {
      AlertUtils.showSnackBar(context, "Please select no of hours", isTrue);
      return false;
    }
    else if (remarks.text .isEmpty || remarks.text=="") {
      AlertUtils.showSnackBar(context, "Please enter remarks", isTrue);
      return false;
    }    return true;
  }


  Future<bool> updateOpen(String status, String tickId, String hours, String days,String remarks) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "deviceId":await getDeviceId(),
      "ticketId":tickId,
      "status":status,
      "maxDays":days,
      "maxHours":hours,
      "remarks":remarks
    };
    var response = await ApiProvider(baseUrl: Apis.CCC_END_POINT_BASE_URL)
        .postApiCall(context, Apis.UPDATE_TICKET, payload);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['message']!=null) {
                await showSuccessDialog(context, response.data['message'], (){
                  Navigator.pop(context);
                });
                resetDialogValues();
                return true;
              }
            }else{
              showErrorDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    }catch(e){
      throw Exception("Exception Occurred while Authenticating");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
    return false;
  }

  void call() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
            builder: (context, setState)
            {
              return AlertDialog(
                  title: const Text(
                    "📞 CONNECT WITH CONSUMER", style: TextStyle(fontSize: 12),),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9, // or a fixed width like 300
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ViewDetailedLcTileWidget(
                              tileKey: "CONSUMER NO",
                              tileValue: data.mobileNo??""),

                          _buildTextField("YOUR NUMBER",registeredNumber, ),

                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        resetDialogValues();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey)),
                      child: const Text(
                        "CANCEL", style: TextStyle(color: Colors.white),),
                    ),
                    TextButton(
                      onPressed: () {
                        callConsumer( data.ticketNumber!, data.mobileNo??"", registeredNumber.text );
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green)),

                      child: const Text(
                        "CONNECT", style: TextStyle(color: Colors.white),),
                    ),
                  ]
              );
            }
        );
      },
    );
  }
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child:Row(children: [
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
            ),
          ),
        ]));
  }

  Future<bool> callConsumer(String tickId, String agentMobile, String userMobile)async{
    if (!validateForm2()) {
      return false;
    }else{
      print("in else block");
      await makeCall(tickId, agentMobile, userMobile);
      return true;
    }
  }

  bool validateForm2() {
    if (registeredNumber.text == "" || registeredNumber.text.isEmpty) {
         AlertUtils.showSnackBar(context, "Please enter your mobile number", isTrue);
          return  false;
        }else if(registeredNumber.text.length<10){
          AlertUtils.showSnackBar(context, "Please enter valid mobile number", isTrue);
          return  false;
        }
    return true;
  }
  Future<bool> makeCall( String tickId, String agentMobile, String userMobile,) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ticketId":tickId,
      "agentMobile":agentMobile,
      "customerMobile":userMobile,
    };
    var response = await ApiProvider(baseUrl: Apis.CCC_END_POINT_BASE_URL)
        .postApiCall(context, Apis.CALL_CONSUMER, payload);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['message']!=null) {
                showSuccessDialog(context, response.data['message'], (){
                  Navigator.pop(context);
                });
                resetDialogValues();
              }
            }else{
              showErrorDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    }catch(e){
      throw Exception("Exception Occurred while Authenticating");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
    return false;
  }





  void resetDialogValues() {
    selectedOption = "";
    selectedDay = "";
    selectedHours = "";
    remarks.text="";
    registeredNumber.text=data.registeredMobileNumber??"";
    notifyListeners();
  }
}