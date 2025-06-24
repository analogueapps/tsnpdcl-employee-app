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
import 'package:tsnpdcl_employee/view/routed_from_ccc/model/ccc_complaint_model.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';


class CccComplaintsViewmodel extends ChangeNotifier {
  CccComplaintsViewmodel({required this.context}) {
    getCCCDivertedComplaints( );
  }

  final BuildContext context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<CccComplaintModel> _complaintList = [];
  List<CccComplaintModel> get complaintData => _complaintList;

  Map<String, String> billingSubTypes = {
    "Bill stop Revoke request": "REVOKE_OF_SERVICES",
    "Bill stop/Revoke request": "REVOKE_OF_SERVICES",
    "Wrong billing": "WRONG_BILLING",
    "Wrong meter reading": "WRONG_BILLING",
    "Dismantling of service": "DISMANTLE_OF_SERVICES",
  };

  Future<bool> getCCCDivertedComplaints( ) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
    };
    var response = await ApiProvider(baseUrl: Apis.ERO_CORRESPONDENCE_URL)
        .postApiCall(context, Apis.CCC_COMPLAINTS_URL, payload);

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
                await showSuccessDialog(
                  context,
                  response.data['message'],
                      () {
                    Navigator.pop(context);
                  },
                );
              } else if (response.data['dataList'] != null) {
                final dataList = response.data['dataList'];
                if (dataList is List && dataList.isNotEmpty) {
                  List<CccComplaintModel> fetchedList = dataList
                      .map((item) =>
                      CccComplaintModel.fromJson(item))
                      .toList();

                  _complaintList.addAll(fetchedList);

                  print("Fetched complaints: ${fetchedList.length}");
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
    }catch(e){
      throw Exception("Exception Occurred while Authenticating");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
    return false;
  }

  void complaintDialog(context, String subComplaint, String  complaintId,String uscno ){
    showDialog(
      context: context,
      builder: (_) {
        return   AlertDialog(
                  title: const Text(
                    "Choose Action", style: const TextStyle(fontSize: 18),),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(onPressed: (){
                        final subtypeKey = billingSubTypes[subComplaint];

                        if (subtypeKey != null) {
                          final arguments = {
                            "uscno": uscno,
                            "cccComplaintId": complaintId,
                          };

                          switch (subtypeKey) {
                            case "REVOKE_OF_SERVICES":
                              print("Redirected to REVOKE_OF_SERVICES");
                              // Navigation.instance
                              //     .navigateTo(Routes.openDetail, args: arguments,);
                              break;
                            case "WRONG_BILLING":
                              print("Redirected to WRONG_BILLING");
                              // Navigator.pushNamed(context, '/wrong_billing', arguments: arguments);
                              break;
                            case "DISMANTLE_OF_SERVICES":
                              print("Redirected to DISMANTLE_OF_SERVICES");
                              Navigator.of(context).pop();
                              Navigation.instance
                                  .navigateTo(Routes.dismantleOfServices, args: arguments,);
                              break;
                          }
                        } else {
                          AlertUtils.showSnackBar(
                            context,
                            "Sorry, complaint subtype not matching predefined types",
                            true,
                          );
                        }

                      }, child: Text("Create Ero Correspondence", style: TextStyle(color:Colors.black),)),
                      TextButton(onPressed: null, child: Text("View Detail Complaint", style: TextStyle(color:Colors.black),))
                    ],
                  ) ,
          actions: [
            SizedBox( width: double.infinity,
              child:PrimaryButton(text: "Cancel", onPressed: () {
                Navigator.of(context).pop();
              },
              ),
            ),
          ],

              );
      },
    );
  }
}