import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/routed_from_ccc/model/detailTicket.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailComplaintViewmodel extends ChangeNotifier {
  ViewDetailComplaintViewmodel({required this.context, required this.args}) {
    getDetailedTicket(args['ticketId']);
  }

  final Map<String, dynamic> args;

  final BuildContext context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController registeredNumber =
      TextEditingController(); //mobileNo

  final List<DetailTicketModel> _complaintDetailsList = [];
  List<DetailTicketModel> get complaintDetailsList => _complaintDetailsList;

  Future<bool> getDetailedTicket(String ticketId) async {
    _complaintDetailsList.clear();
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ticketId": args['ticketId']
    };
    var response = await ApiProvider(baseUrl: Apis.CCC_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_DETAILED_TICKET, payload);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              final dataList = response.data['dataList'];
              if (dataList is List && dataList.isEmpty) {
                await showAlertDialog(
                  context,
                  response.data['message'],
                );
              } else if (response.data['dataList'] != null) {
                final dataList = response.data['dataList'];
                final complaintData = dataList[0]['cccComplaint'];
                if (complaintData.isNotEmpty) {
                  final complaintModel =
                      DetailTicketModel.fromJson(complaintData);
                  _complaintDetailsList.add(complaintModel);

                  print(
                      "Fetched complaint: ${_complaintDetailsList.length}"); // Or another field
                }
              }
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      // throw Exception("Exception Occurred while Authenticating");
      showAlertDialog(context, "$e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  void call() {
    registeredNumber.text = complaintDetailsList[0].mobileNo ?? "";
    notifyListeners();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
              title: const Text(
                "📞 CONNECT WITH CONSUMER",
                style: TextStyle(fontSize: 12),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.9, // or a fixed width like 300
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ViewDetailedLcTileWidget(
                        tileKey: "CONSUMER NO",
                        tileValue:
                            complaintDetailsList[0].registeredMobileNumber ??
                                "",
                        valueColor: Colors.redAccent,
                      ),
                      _buildTextField(
                        "YOUR NUMBER",
                        registeredNumber,
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
                      backgroundColor: WidgetStateProperty.all(Colors.grey)),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    callConsumer(
                        complaintDetailsList[0].ticketNumber!,
                        complaintDetailsList[0].mobileNo ?? "",
                        registeredNumber.text);
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green)),
                  child: const Text(
                    "CONNECT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]);
        });
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Row(children: [
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

  Future<bool> callConsumer(
      String tickId, String agentMobile, String userMobile) async {
    if (!validateForm2()) {
      return false;
    } else {
      print("in else block");
      await makeCall(tickId, agentMobile, userMobile);
      return true;
    }
  }

  bool validateForm2() {
    if (registeredNumber.text == "" || registeredNumber.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please enter your mobile number", isTrue);
      return false;
    } else if (registeredNumber.text.length < 10) {
      AlertUtils.showSnackBar(
          context, "Please enter valid mobile number", isTrue);
      return false;
    }
    return true;
  }

  Future<bool> makeCall(
    String tickId,
    String agentMobile,
    String userMobile,
  ) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ticketId": tickId,
      "agentMobile": agentMobile,
      "customerMobile": userMobile,
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
              if (response.data['message'] != null) {
                showSuccessDialog(context, response.data['message'], () {
                  Navigator.pop(context);
                });
                resetDialogValues();
              }
            } else {
              showErrorDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      throw Exception("Exception Occurred while Authenticating");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  void resetDialogValues() {
    registeredNumber.text =
        complaintDetailsList[0].registeredMobileNumber ?? "";
    notifyListeners();
  }
}
