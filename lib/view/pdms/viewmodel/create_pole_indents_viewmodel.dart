import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/all_lc_request_list.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/induction_points_of_feeder_list.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/lc_master_ss_list.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_request_indent_entity.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';

class CreatePoleIndentsViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  late NpdclUser npdclUser;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<PoleRequestIndentEntity> _createPoleIndentList = [];
  List<PoleRequestIndentEntity> get createPoleIndentList => _createPoleIndentList;

  // Constructor to initialize the items
  CreatePoleIndentsViewmodel({required this.context}) {
    _loadUser();
    allPoleIndentListFromServer();
  }

  void _loadUser() {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    npdclUser = user[0];
  }

  Future<void> allPoleIndentListFromServer() async {
    _isLoading = isTrue;
    notifyListeners();

    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    NpdclUser npdclUser = user[0];

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "circleId": npdclUser.secMasterEntity!.circleId
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_INDENTS_OF_STATUS_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          //if(response.data['sessionValid'] == isTrue) {
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
                final List<PoleRequestIndentEntity> dataList = jsonList.map((json) => PoleRequestIndentEntity.fromJson(json)).toList();
                _createPoleIndentList.addAll(dataList);
                notifyListeners();
              }
            }
          // } else {
          //   showSessionExpiredDialog(context);
          // }
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

  void createActionClicked() {
    bool isChecked1 = false;
    bool isChecked2 = false;
    final TextEditingController requisitionNoTextEditingController = TextEditingController();
    final TextEditingController quantityTextEditingController = TextEditingController();

    // List of string items
    final List<String> items = ["8m/140", "9.10m/280", "11.0m/365"];

    // Selected item
    String? selectedItem;

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
                  Center(
                    child: Text(
                      "Create Pole Indent".toUpperCase(),
                      style: const TextStyle(
                        fontSize: toolbarTitleSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: doubleFifteen,),
                  Text(
                    "REQUISITION NO".toUpperCase(),
                    style: const TextStyle(
                      fontSize: normalSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: doubleFive,),
                  FillTextFormField(
                    controller: requisitionNoTextEditingController,
                    labelText: '',
                    keyboardType: TextInputType.text,
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
                  DropdownButton<String>(
                    hint: const Text("Select an item"),
                    value: selectedItem,
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItem = newValue;
                      });
                    },
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
                    controller: quantityTextEditingController,
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
                          if (requisitionNoTextEditingController.text.isEmpty || requisitionNoTextEditingController.text.length < 5) {
                            showAlertDialog(context, "Please enter SAP Requisition No");
                          } else if (selectedItem == null || selectedItem!.isEmpty) {
                            showAlertDialog(context, "Please select the Pole Type");
                          } else if (quantityTextEditingController.text.isEmpty) {
                            showAlertDialog(context, "Please enter quantity");
                          } else if (!isChecked1) {
                            showAlertDialog(context, "Please check the checkbox");
                          } else if (!isChecked2) {
                            showAlertDialog(context, "Please check the checkbox");
                          } else {
                            createIndent(requisitionNoTextEditingController.text, selectedItem!, quantityTextEditingController.text);
                          }
                        },
                        child: Text("Create Indent".toUpperCase(), style: const TextStyle(fontSize: extraRegularSize, color: Colors.white),),
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

  Future<void> createIndent(String reqNo, String poleType, String qty) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Please wait...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "qty": qty,
      "reqNo": reqNo,
      "poleType": poleType,
      "circleId": npdclUser.secMasterEntity!.circleId
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.CREATE_POLE_INDENT_URL, payload);
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
