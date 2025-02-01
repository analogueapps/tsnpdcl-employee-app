import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_dispatch_instructions_entity.dart';
import 'package:tsnpdcl_employee/view/pdms/view/otp_request_and_validate_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class DispatchInstructionsDetailsViewModel extends ChangeNotifier {
  final BuildContext context;
  final PoleDispatchInstructionsEntity poleDispatchInstructionsEntity;

  int verifiedCount = 0;

  DispatchInstructionsDetailsViewModel({required this.context, required this.poleDispatchInstructionsEntity});

  void submitForm() {

    if (poleDispatchInstructionsEntity.poleDumpedLocationEntitiesByDispatchInstructionsId != null) {
      for (var poleDumpedLocationEntity in poleDispatchInstructionsEntity.poleDumpedLocationEntitiesByDispatchInstructionsId!) {
        if (poleDumpedLocationEntity.status.toString().toLowerCase() == "verified") {
          if (poleDumpedLocationEntity.physicalVerifiedQuantity != null) {
            verifiedCount += poleDumpedLocationEntity.physicalVerifiedQuantity!.toInt();
          }
        }
      }
    }

    showDialog(
      //barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total Form-13 Issued Qty".toUpperCase(),
                          style: const TextStyle(
                            fontSize: normalSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: doubleFive,),
                      Expanded(
                        child: Text(
                          NumberFormat("00").format(verifiedCount),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: CommonColors.successGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: doubleTen,),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Form-13 Issuing Quantity".toUpperCase(),
                          style: const TextStyle(
                            fontSize: normalSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: doubleFive,),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.end,
                          NumberFormat("00").format(verifiedCount),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: doubleTen,),
                  Container(
                    padding: const EdgeInsets.all(doubleFive),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: Color(0xfffff3cd)),
                    child: const Text(
                      'Please note that entering the quantity of Form-13 issued here will not affect in SAP. Kindly issue Form-13 in SAP first, then enter the issued quantity here and submit to ensure synchronization.',

                    ),
                  ),
                  const SizedBox(height: doubleFive,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel".toUpperCase(), style: const TextStyle(fontSize: extraRegularSize, color: Colors.white),),
                      ),
                      const SizedBox(width: doubleTen,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          if (verifiedCount ==0) {
                            showErrorDialog(context, "You cannot issue Form-13 when verified quantity is zero");
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return OtpRequestAndValidateDialog(
                                  isAuthenticatedOtp: true,
                                  onComplete: (verified, requestId) {
                                    saveForm13Data();
                                  },
                                  onCancelByUser: () {

                                  },
                                );
                              },
                            );
                          }
                        },
                        child: Text("Ok".toUpperCase(), style: const TextStyle(fontSize: extraRegularSize, color: Colors.white),),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> saveForm13Data() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Please wait...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "deviceId": await getDeviceId(),
      "did": poleDispatchInstructionsEntity.dispatchInstructionId,
      "qty": verifiedCount,
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.SAVE_FORM_13_DATA_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              await showSuccessDialog(context, response.data['success'], () {
                Navigation.instance.pushBack();
              },
              );
            } else {
              showAlertDialog(context, response.data['message']);
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
  }

  Future<void> downloadDispatchInstructions() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Requesting Link...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "diId": poleDispatchInstructionsEntity.dispatchInstructionId,
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.REQUEST_DI_DOWNLOAD_LINK_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['data'] != null) {
                final Uri url = Uri.parse(response.data['data']);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              } else {
                showAlertDialog(context,"Download link generation failed.");
              }
            } else {
              showAlertDialog(context, response.data['message']);
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
  }
}
