import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_manufacturing_firm_entity.dart';

class CreateFirmViewmodel extends ChangeNotifier {
  final BuildContext context;
  final String data;

  final formKey = GlobalKey<FormState>();
  final TextEditingController supplierNameController = TextEditingController();
  final TextEditingController firmNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController sapVendorNoController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController licenseNoController = TextEditingController();
  bool isBlackListed = false;

  PoleManufacturingFirmEntity? poleManufacturingFirmEntity;

  CreateFirmViewmodel({required this.context, required this.data}) {
    if(data != "new") {
      poleManufacturingFirmEntity = PoleManufacturingFirmEntity.fromJson(jsonDecode(data));
      supplierNameController.text = poleManufacturingFirmEntity!.supplierName!;
      firmNameController.text = poleManufacturingFirmEntity!.firmName!;
      phoneController.text = poleManufacturingFirmEntity!.mobileNo!;
      sapVendorNoController.text = poleManufacturingFirmEntity!.sapVendorId!;
      emailAddressController.text = poleManufacturingFirmEntity!.email!;
      //licenseNoController.text = poleManufacturingFirmEntity!.licenseNo!;
    }
    notifyListeners();
  }

  void showBlackListDialog(bool value) {
    if(value) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("BLACK LIST?"),
          content: Text(
            "You are about to blacklist this Firm (${poleManufacturingFirmEntity?.firmName}). "
                "When firm is blacklisted, Firm user cannot access mobile app.",
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
                isBlackListed = false;
                notifyListeners();
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text("YES, BLACKLIST"),
              onPressed: () {
                Navigator.of(context).pop();
                isBlackListed = true;
                notifyListeners();
              },
            ),
          ],
        ),
      );
    } else {
      isBlackListed = value;
      notifyListeners();
    }
  }

  // API call simulation
  Future<void> createFirm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      ProcessDialogHelper.showProcessDialog(
        context,
        message: "Please wait...",
      );

      final payload = {
        "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "deviceId": await getDeviceId(),
        "mobileNo": phoneController.text,
        "firmName": firmNameController.text,
        "licenseNo": licenseNoController.text,
        "email": emailAddressController.text,
        "supplierName": supplierNameController.text,
        "vendorId": sapVendorNoController.text,
      };

      var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.CREATE_FIRM_URL, payload);
      if (context.mounted) {
        ProcessDialogHelper.closeDialog(context);
      }
      try {
        if (response != null) {
          if (response.data is String) {
            response.data = jsonDecode(response.data); // Parse string to JSON
          }
          if (response.statusCode == successResponseCode) {
            if (response.data['taskSuccess'] == isTrue) {
              showSuccessDialog(context, response.data['message'], () {
                Navigator.pop(context, "Added");
              });
            } else {
              showAlertDialog(context,response.data['message']);
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
  }

  Future<void> updateFirm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      ProcessDialogHelper.showProcessDialog(
        context,
        message: "Please wait...",
      );

      final payload = {
        "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "deviceId": await getDeviceId(),
        "firmId": poleManufacturingFirmEntity?.firmId,
        "mobileNo": phoneController.text,
        "firmName": firmNameController.text,
        "licenseNo": licenseNoController.text,
        "email": emailAddressController.text,
        "supplierName": supplierNameController.text,
        "vendorId": sapVendorNoController.text,
        "blackListed": isBlackListed,
      };

      var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.UPDATE_FIRM_URL, payload);
      if (context.mounted) {
        ProcessDialogHelper.closeDialog(context);
      }
      try {
        if (response != null) {
          if (response.data is String) {
            response.data = jsonDecode(response.data); // Parse string to JSON
          }
          if (response.statusCode == successResponseCode) {
            if (response.data['taskSuccess'] == isTrue) {
              showSuccessDialog(context, response.data['message'], () {
                Navigator.pop(context, "Added");
              });
            } else {
              showAlertDialog(context,response.data['message']);
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
  }
}
