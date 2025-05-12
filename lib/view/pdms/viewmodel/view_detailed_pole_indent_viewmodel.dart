import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/designation_utils.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_codes.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_request_indent_entity.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/pdms/view/forward_or_reject_indent_dialog.dart';
import 'package:tsnpdcl_employee/view/pdms/view/otp_request_and_validate_dialog.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class ViewDetailedPoleIndentViewModel extends ChangeNotifier {
  final BuildContext context;
  final String data;
  late PoleRequestIndentEntity poleRequestIndentEntity;
  late NpdclUser npdclUser;

  bool isButtonVisible = false;
  String buttonText = "";
  Color buttonColor = Colors.transparent;
  Function? buttonAction;

  ViewDetailedPoleIndentViewModel({required this.context, required this.data}) {
    poleRequestIndentEntity = PoleRequestIndentEntity.fromJson(jsonDecode(data));
    _loadUser();
    _updateButtonState();
  }

  void _loadUser() {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    npdclUser = user[0];
  }

  void _updateButtonState() {
    String? indentStatus = poleRequestIndentEntity.indentStatus;

    if (indentStatus == "CANCELED") {
      isButtonVisible = false;
    } else if (DesignationUtils.isAde(npdclUser.designationCode!.toInt())) {
      isButtonVisible = true;
      buttonText = "FORWARD TO STORES";
      buttonColor = CommonColors.deepBlue;
      buttonAction = _forwardToStores;
    } else if (DesignationUtils.isAe(npdclUser.designationCode!.toInt()) &&
        DesignationUtils.isOperationWing(checkNull(npdclUser.wing))) {
      isButtonVisible = true;
      buttonText = "CANCEL INDENT";
      buttonColor = CommonColors.deepRed;
      buttonAction = _showCancelIndentDialog;
    } else if (DesignationUtils.isAe(npdclUser.designationCode!.toInt()) &&
        DesignationUtils.isStoreWing(checkNull(npdclUser!.wing)) &&
        (indentStatus == StatusCodes.PoleIndentStatus.AE_OD_STR ||
            indentStatus == StatusCodes.PoleIndentStatus.PAR_APPROVED)) {
      isButtonVisible = true;
      buttonText = "APPROVE/REJECT";
      buttonColor = CommonColors.colorPrimary;
      buttonAction = _showApprovalDialog;
    } else if (DesignationUtils.isAde(npdclUser.designationCode!.toInt()) &&
        DesignationUtils.isStoreWing(checkNull(npdclUser!.wing)) &&
        indentStatus == StatusCodes.PoleIndentStatus.ADE_STR) {
      isButtonVisible = true;
      buttonText = "APPROVE/REJECT";
      buttonColor = CommonColors.colorPrimary;
      buttonAction = _showApprovalDialog;
    } else {
      isButtonVisible = false;
    }
    notifyListeners();
  }

  void _forwardToStores() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return OtpRequestAndValidateDialog(
          isAuthenticatedOtp: true,
          onComplete: (verified, requestId) {
            forwardPoleIndentToStores();
          },
          onCancelByUser: () {

          },
        );
      },
    );
  }

  void _showCancelIndentDialog() {
    showAlertActionDialog(
        context: context,
        title: "CANCEL INDENT",
        message: "Do you want to cancel this Indent #${poleRequestIndentEntity.indentId} ?",
        okLabel: "YES,CANCEL",
        cancelLabel: "NO",
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return OtpRequestAndValidateDialog(
                isAuthenticatedOtp: true,
                onComplete: (verified, requestId) {
                  updateIndent(true);
                },
                onCancelByUser: () {

                },
              );
            },
          );
        }
    );
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showGeneralDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     barrierLabel: '',
    //     pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    //       return ForwardOrRejectIndentDialog(
    //           poleRequestIndentEntity: poleRequestIndentEntity,
    //           onActionTaken: (poleRequestIndentEntity) {
    //
    //           }
    //       );
    //     },
    //   );
    // });
  }

  void _showApprovalDialog() {
    List<String> items = ["Process Multiple Indents At Once","Process Single Indent"];
    showDialog(
      context: context,
      barrierDismissible: isFalse,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose Option", style: TextStyle(fontWeight: FontWeight.w700),),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    Navigator.pop(context);
                    if(index == 0) {
                      
                    } else if (index == 1) {
                      showForwardOrRejectDialog();
                    }
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateIndent(bool cancel) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Please wait...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "indentId": poleRequestIndentEntity.indentId,
      "cancelIndent": cancel
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.UPDATE_POLE_INDENT_URL, payload);
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

  Future<void> forwardPoleIndentToStores() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Please wait...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "indentId": poleRequestIndentEntity.indentId,
      "cancelIndent": false
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.FORWARD_POLE_INDENT_TO_STORES_URL, payload);
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

  void showForwardOrRejectDialog() {

  }

  bool isIndentEditable() {
    return (poleRequestIndentEntity.balanceQty != null && poleRequestIndentEntity.balanceQty! > 0) && poleRequestIndentEntity.indentStatus != StatusCodes.PoleIndentStatus.CANCELED;
  }

  void editActionClicked() {
    bool isChecked1 = false;
    bool isChecked2 = false;
    final TextEditingController textEditingController = TextEditingController();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              titlePadding: EdgeInsets.zero,
              title: Container(
                width: double.infinity,
                color: CommonColors.colorPrimary,
                padding: const EdgeInsets.symmetric(vertical: doubleFifteen),
                child: Text(
                  "Modify Pole Indent".toUpperCase(),
                  textAlign: TextAlign.center, // Center align the text
                  style: const TextStyle(
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.w600, // Optional: Bold text
                    fontSize: titleSize, // Optional: Font size
                  ),
                ),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * pointEight, // 80% of screen width
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "REQUISITION NO".toUpperCase(),
                      style: const TextStyle(
                        fontSize: normalSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: doubleFive,),
                    FillTextFormField(
                      controller: TextEditingController(text: checkNull(poleRequestIndentEntity.requisitionNo.toString())),
                      labelText: '',
                      keyboardType: TextInputType.none,
                      isReadOnly: isTrue,
                    ),
                    const SizedBox(height: doubleFifteen,),
                    const Text(
                      "Choose pole type",
                      style: TextStyle(
                        fontSize: normalSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: doubleFive,),
                    FillTextFormField(
                      controller: TextEditingController(text: checkNull(poleRequestIndentEntity.poleType)),
                      labelText: '',
                      keyboardType: TextInputType.none,
                      isReadOnly: isTrue,
                      suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.only(top: doubleTen, bottom: doubleTen),
                      child:  Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Indent Quantity",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                checkNull(poleRequestIndentEntity.requestedQty.toString()),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.only(top: doubleTen, bottom: doubleTen),
                      child:  Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Balance Quantity",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                checkNull(poleRequestIndentEntity.balanceQty.toString()),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const Text(
                      "Quantity",
                      style: TextStyle(
                        fontSize: normalSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: doubleFive,),
                    FillTextFormField(
                      controller: textEditingController,
                      labelText: '',
                      keyboardType: TextInputType.number,
                    ),
                    const Divider(),
                    CheckboxListTile(
                      value: isChecked1, // Boolean variable to track state
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked1 = value ?? false;
                        });
                      },
                      title: const Text(
                        "Indent Qty is available against the remaining quantity of SAP Requisition",
                      ),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      value: isChecked2, // Boolean variable to track state
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked2 = value ?? false;
                        });
                      },
                      title: const Text(
                        "SAP Requisition has selected Pole Type.",
                      ),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
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
                            if (poleRequestIndentEntity.requisitionNo!.isEmpty || poleRequestIndentEntity.requisitionNo!.length < 5) {
                              showAlertDialog(context, "Please enter SAP Requisition No");
                            } else if (poleRequestIndentEntity.poleType!.isEmpty) {
                              showAlertDialog(context, "Please select the Pole Type");
                            } else if (textEditingController.text.isEmpty) {
                              showAlertDialog(context, "Please enter quantity");
                            } else if (textEditingController.text.length > (poleRequestIndentEntity.balanceQty ?? 0)) {
                              showAlertDialog(context, "Please enter quantity less than available balance quantity (${poleRequestIndentEntity.balanceQty})");
                            } else if (!isChecked1) {
                              showAlertDialog(context, "Please check the checkbox");
                            } else if (!isChecked2) {
                              showAlertDialog(context, "Please check the checkbox");
                            } else {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return OtpRequestAndValidateDialog(
                                    isAuthenticatedOtp: true,
                                    onComplete: (verified, requestId) {
                                      updateIndentWithQty(false, int.parse(textEditingController.text));
                                    },
                                    onCancelByUser: () {

                                    },
                                  );
                                },
                              );
                            }
                          },
                          child: Text("Update Indent".toUpperCase(), style: const TextStyle(fontSize: extraRegularSize, color: Colors.white),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> updateIndentWithQty(bool cancel, int qty) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Please wait...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "indentId": poleRequestIndentEntity.indentId,
      "cancelIndent": cancel,
      "qty": qty,
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.UPDATE_POLE_INDENT_URL, payload);
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
}
