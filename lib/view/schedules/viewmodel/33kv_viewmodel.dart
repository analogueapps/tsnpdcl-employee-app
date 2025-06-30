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
import 'package:tsnpdcl_employee/view/schedules/models/33kv_model.dart';
import 'package:tsnpdcl_employee/view/schedules/models/view_schedule_model.dart';

class Kv33ViewModel extends ChangeNotifier {
  Kv33ViewModel({required this.context, required this.data});

  final BuildContext context;
  final Map<String, dynamic> data;
  final List<SSMaintenanceAttributesEntity> ssMaintenanceAttributesEntityList =
      [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<InspectionItem> abSwitchItems = [
    InspectionItem('OK'),
    InspectionItem('NO PROPER ALIGNMENT'),
    InspectionItem('DAMAGED MOVING CONTACT'),
    InspectionItem('DAMAGED FIXED CONTACT'),
    InspectionItem('NO PROPER CONNECTOR'),
    InspectionItem('SLACKNESS'),
  ];

  List<InspectionItem> busBarConnectorItems = [
    InspectionItem('OK'),
    InspectionItem('NOT SUITABLE CONNECTOR'),
    InspectionItem('DAMAGED CONNECTOR'),
    InspectionItem('SLACKNESS'),
  ];

  List<InspectionItem> busCouplerItems = [
    InspectionItem('OK'),
    InspectionItem('NO PROPER ALIGNMENT'),
    InspectionItem('DAMAGED MOVING CONTACT'),
    InspectionItem('DAMAGED FIXED CONTACT'),
    InspectionItem('NO PROPER CONNECTOR'),
    InspectionItem('SLACKNESS'),
  ];
  List<InspectionItem> laItems = [
    InspectionItem('OK'),
    InspectionItem('NOT AVAILABLE'),
    InspectionItem('FAILED'),
    InspectionItem('NOT CONNECTED'),
  ];
  List<InspectionItem> vcbItems = [
    InspectionItem('OK'),
    InspectionItem('DEFECT IN MECHANISM'),
    InspectionItem('DEFECT EM'),
    InspectionItem('DEFECT AMMETER'),
    InspectionItem('DEFECT BATTERY'),
    InspectionItem('DEFECT HTC'),
    InspectionItem('DEFECT ALARM BELLS'),
  ];
  List<InspectionItem> ctsItems = [
    InspectionItem('OK'),
    InspectionItem('IOL LEAKAGE'),
    InspectionItem('DAMAGED CONNECTING BUSH RODS'),
  ];
  List<InspectionItem> postTypeItems = [
    InspectionItem('OK'),
    InspectionItem('PHYSICALLY DAMAGED'),
    InspectionItem('FLASHOVER'),
  ];
  List<InspectionItem> hgFuseItems = [
    InspectionItem('OK'),
    InspectionItem('INSULATOR DAMAGED'),
    InspectionItem('DEFECTIVE ON ROD'),
  ];
  List<InspectionItem> fuseWireItems = [
    InspectionItem('OK'),
    InspectionItem('NOT RATED ONE'),
    InspectionItem('DAMAGED'),
  ];
  List<InspectionItem> ptsItems = [
    InspectionItem('OK'),
    InspectionItem('REPLACEMENT REQUIRED'),
  ];
  List<InspectionItem> ptrItems = [
    InspectionItem('OK'),
    InspectionItem('OIL LEAKAGE'),
    InspectionItem('SILICAGEL REQUIRED'),
    InspectionItem('GASSES TO BE RELEASED'),
    InspectionItem('DEFECT OTI/WTI'),
    InspectionItem('DEFECT PTR CONNECTORS'),
    InspectionItem('SLACKNESS IN CONNECTION'),
  ];
  List<InspectionItem> groupVcbItems = [
    InspectionItem('OK'),
    InspectionItem('NOT WORKING'),
  ];
  List<InspectionItem> groupABSwitchItems = [
    InspectionItem('OK'),
    InspectionItem('NO PROPER ALIGNMENT'),
    InspectionItem('DAMAGED MOVING CONTACT'),
    InspectionItem('DAMAGED FIXED CONTACT'),
    InspectionItem('NO PROPER CONNECTOR'),
    InspectionItem('SLACKNESS'),
  ];
  List<InspectionItem> KV11busCouplerItems = [
    InspectionItem('OK'),
    InspectionItem('NO PROPER ALIGNMENT'),
    InspectionItem('DAMAGED MOVING CONTACT'),
    InspectionItem('DAMAGED FIXED CONTACT'),
    InspectionItem('NO PROPER  CONNECTOR'),
    InspectionItem('SLACKNESS'),
  ];
  List<InspectionItem> busBarConnectorsItems = [
    InspectionItem('OK'),
    InspectionItem('NOT SUITABLE CONNECTOR'),
    InspectionItem('DAMAGED CONNECTOR'),
    InspectionItem('SLACKNESS'),
  ];
  List<InspectionItem> KV11ctsItems = [
    InspectionItem('OK'),
    InspectionItem('OIL LEAKAGE'),
    InspectionItem('DAMAGED CONNECTING BUSH RODS'),
  ];
  List<InspectionItem> KV11vcbItems = [
    InspectionItem('OK'),
    InspectionItem('DEFECT IN MECHANISM'),
    InspectionItem('DEFECT EM'),
    InspectionItem('DEFECT AMMETER'),
    InspectionItem('DEFECT BATTERY'),
    InspectionItem('DEFECT HTC'),
    InspectionItem('DEFECT ALARM BELLS'),
  ];
  List<InspectionItem> fdrABSwitchItems = [
    InspectionItem('OK'),
    InspectionItem('NO PROPER ALIGNMENT'),
    InspectionItem('DAMAGED MOVING CONTACT'),
    InspectionItem('DAMAGED FIXED CONTACT'),
    InspectionItem('NO PROPER CONNECTOR'),
    InspectionItem('SLACKNESS'),
  ];
  List<InspectionItem> KV11ptsItems = [
    InspectionItem('OK'),
    InspectionItem('REPLACEMENT REQUIRED'),
  ];
  List<InspectionItem> capacitorBankItems = [
    InspectionItem('OK'),
    InspectionItem('DEFECTIVE CELSS'),
  ];
  List<InspectionItem> stationDtrItems = [
    InspectionItem('OK'),
    InspectionItem('NOT OK'),
  ];
  List<InspectionItem> ssEarthingItems = [
    InspectionItem('OK'),
    InspectionItem('BEYOND SP LIMITS'),
  ];
  List<InspectionItem> yardLightingItems = [
    InspectionItem('OK'),
    InspectionItem('DAMAGED LIGHTS'),
    InspectionItem('NEW LIGHTS REQUIRED'),
  ];
  List<InspectionItem> redHotsItems = [
    InspectionItem('OBSERVED'),
    InspectionItem('NOT OBSERVED'),
  ];

  void handleAbSwitchCheck(int index, bool? value) {
    handleSectionCheck(abSwitchItems, index, value);
  }

  void handleBusBarConnectorCheck(int index, bool? value) {
    handleSectionCheck(busBarConnectorItems, index, value);
  }

  void handleBusCouplerCheck(int index, bool? value) {
    handleSectionCheck(busCouplerItems, index, value);
  }

  void handleLaCheck(int index, bool? value) {
    handleSectionCheckKV33Las(laItems, index, value);
  }

  void handleVcbCheck(int index, bool? value) {
    handleSectionCheck(vcbItems, index, value);
  }

  void handleCtsCheck(int index, bool? value) {
    handleSectionCheck(ctsItems, index, value);
  }

  void handlePoseTypeCheck(int index, bool? value) {
    handleSectionCheck(postTypeItems, index, value);
  }

  void handleHgFuseCheck(int index, bool? value) {
    handleSectionCheck(hgFuseItems, index, value);
  }

  void handleFuseWireCheck(int index, bool? value) {
    handleSectionCheck(fuseWireItems, index, value);
  }

  void handlePtsCheck(int index, bool? value) {
    handleSectionCheck(ptsItems, index, value);
  }

  void handlePtrCheck(int index, bool? value) {
    handleSectionCheck(ptrItems, index, value);
  }

  void handleGroupVcbCheck(int index, bool? value) {
    handleSectionCheck(groupVcbItems, index, value);
  }

  void handleGroupABSwitchCheck(int index, bool? value) {
    handleSectionCheckForGroupABSwitch(groupABSwitchItems, index, value);
  }

  void handleKV11BusCouplerCheck(int index, bool? value) {
    handleSectionCheck(KV11busCouplerItems, index, value);
  }

  void handleBusConnectorsCheck(int index, bool? value) {
    handleSectionCheck(busBarConnectorsItems, index, value);
  }

  void handleKV11CtsCheck(int index, bool? value) {
    handleSectionCheck(KV11ctsItems, index, value);
  }

  void handleKV11VcbCheck(int index, bool? value) {
    handleSectionCheck(KV11vcbItems, index, value);
  }

  void handleFdrABSwitchCheck(int index, bool? value) {
    handleSectionCheck(fdrABSwitchItems, index, value);
  }

  void handleKV11PtsCheck(int index, bool? value) {
    handleSectionCheck(KV11ptsItems, index, value);
  }

  void handleCapacitorCheckCheck(int index, bool? value) {
    handleSectionCheck(capacitorBankItems, index, value);
  }

  void handleStationDtrCheck(int index, bool? value) {
    handleSectionCheck(stationDtrItems, index, value);
  }

  void handleSsEarthingCheck(int index, bool? value) {
    handleSectionCheck(ssEarthingItems, index, value);
  }

  void handleYardLightingCheck(int index, bool? value) {
    handleSectionCheck(yardLightingItems, index, value);
  }

  void handleRedHotsCheck(int index, bool? value) {
    handleSectionCheck(redHotsItems, index, value);
  }

  void handleSectionCheck(
    List<InspectionItem> items,
    int index,
    bool? value,
  ) {
    if (index == 0) {
      if (value == true) {
        for (int i = 1; i < items.length; i++) {
          items[i].isChecked = false;
        }
      }
      items[0].isChecked = value ?? false;
    } else {
      if (value == true) {
        items[0].isChecked = false;
      }
      items[index].isChecked = value ?? false;
    }
    notifyListeners();
  }

  void handleSectionCheckForGroupABSwitch(
    List<InspectionItem> items,
    int index,
    bool? value,
  ) {
    if (index == 0) {
      if (value == true) {
        for (int i = 1; i < items.length; i++) {
          if (i == 2 && items[2].isChecked == true) {
            continue;
          } else if (i == 3 && items[3].isChecked == true) {
            continue;
          } else {
            items[i].isChecked = false;
          }
        }
      }
      items[0].isChecked = value ?? false;
    } else {
      if (value == true) {
        items[0].isChecked = false;
      }
      items[index].isChecked = value ?? false;
    }
    notifyListeners();
  }

  void handleSectionCheckKV33Las(
    List<InspectionItem> items,
    int index,
    bool? value,
  ) {
    value = value ?? false;

    if (index == 0) {
      if (value) {
        for (int i = 1; i < items.length; i++) {
          items[i].isChecked = false;
        }
      }
      items[0].isChecked = value;
      if (value) items[1].isChecked = false;
    } else if (index == 1) {
      if (value) {
        for (int i = 2; i < items.length; i++) {
          items[i].isChecked = false;
        }
        items[0].isChecked = false;
      }
      items[1].isChecked = value;
    } else {
      if (value) {
        items[0].isChecked = false;
        items[1].isChecked = false;
      }
      items[index].isChecked = value;
    }

    notifyListeners();
  }

  bool validateSection(
      List<InspectionItem> items, String sectionName, BuildContext context) {
    bool atLeastOneChecked = items.any((item) => item.isChecked);
    if (!atLeastOneChecked) {
      AlertUtils.showSnackBar(
          context, 'Please select $sectionName status', isTrue);
      // You could also scroll to the section here if needed
      return false;
    }
    return true;
  }

  List<SSMaintenanceAttributesEntity> buildAttributes(
    String attributeType,
    List<InspectionItem> items,
    String ssCode,
  ) {
    return items.map((item) {
      return SSMaintenanceAttributesEntity(
        attributeType: attributeType,
        attributeName: item.name,
        attributeValue: item.isChecked ? "Y" : "N",
        instance: "AFTER",
        ssCode: ssCode,
      );
    }).toList();
  }

  SSMaintenanceEntity buildSSMaintenanceEntity(String ssCode) {
    final allAttributes = <SSMaintenanceAttributesEntity>[];

    allAttributes
        .addAll(buildAttributes("33KV AB SWITCH", abSwitchItems, ssCode));
    allAttributes.addAll(buildAttributes(
        "33KV BUS BAR CONNECTORS", busBarConnectorItems, ssCode));
    allAttributes
        .addAll(buildAttributes("33KV BUS COUPLER", busCouplerItems, ssCode));

    allAttributes.addAll(buildAttributes("33KV LA(S)", laItems, ssCode));
    allAttributes.addAll(buildAttributes("33KV VCB", vcbItems, ssCode));
    allAttributes.addAll(buildAttributes("33KV CT(S)", ctsItems, ssCode));
    allAttributes.addAll(
        buildAttributes("33KV Post Type Insulator", postTypeItems, ssCode));
    allAttributes
        .addAll(buildAttributes("33KV HG Fuse Sets", hgFuseItems, ssCode));
    allAttributes
        .addAll(buildAttributes("33KV Fuse Wire", fuseWireItems, ssCode));
    allAttributes.addAll(buildAttributes("33KV PT(S)", ptsItems, ssCode));
    allAttributes.addAll(buildAttributes("PTR", ptrItems, ssCode));
    allAttributes
        .addAll(buildAttributes("Group VCB(S)", groupVcbItems, ssCode));
    allAttributes.addAll(
        buildAttributes("11KV Group AB Switch", groupABSwitchItems, ssCode));
    allAttributes.addAll(
        buildAttributes("11KV Bus Coupler", KV11busCouplerItems, ssCode));
    allAttributes.addAll(buildAttributes(
        "11KV Bus Bar Connectors", busBarConnectorsItems, ssCode));
    allAttributes.addAll(buildAttributes("11KV CT(S)", KV11ctsItems, ssCode));
    allAttributes.addAll(buildAttributes("11KV VCB", KV11vcbItems, ssCode));
    allAttributes.addAll(
        buildAttributes("11KV FDR AB Switch", fdrABSwitchItems, ssCode));
    allAttributes.addAll(buildAttributes("11KV PT(S)", KV11ptsItems, ssCode));
    allAttributes
        .addAll(buildAttributes("Capacitor Bank", capacitorBankItems, ssCode));
    allAttributes
        .addAll(buildAttributes("Station DTR", stationDtrItems, ssCode));
    allAttributes
        .addAll(buildAttributes("SS Earthing", ssEarthingItems, ssCode));
    allAttributes
        .addAll(buildAttributes("Yard Lights", yardLightingItems, ssCode));
    allAttributes.addAll(buildAttributes("Red Hots", redHotsItems, ssCode));
    addBodyCurrentAttributes(ssCode, data['i_ng'] ?? '', data['i_bg'] ?? '');
    allAttributes.addAll(ssMaintenanceAttributesEntityList);

    return SSMaintenanceEntity(
      ssCode: ssCode,
      attributes: allAttributes,
    );
  }

  Future<void> submit(context) async {
    _isLoading = true;
    notifyListeners();

    final ssCode = data['ssCode'];
    final ssMaintenanceEntity = buildSSMaintenanceEntity(ssCode);

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployees",
      "ssCode": ssCode,
      "data": jsonEncode(ssMaintenanceEntity.toJson()),
      "id": data['id'] ?? -2
    };
    try {
      var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL)
          .postApiCall(context, Apis.SAVE_MAINTENANCE, payload);

      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['message'] != null) {
                showSuccessDialog(context, response.data['message'], () {
                  Navigator.pop(context);
                });
              } else {
                showAlertDialog(context, response.data['message']);
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        }
      }
    } catch (e) {
      _isLoading = true;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addBodyCurrentAttributes(
      String ssCode, String iNgValue, String iBgValue) {
    final iNg = SSMaintenanceAttributesEntity(
      attributeType: "BODY CURRENT I(N-G)",
      attributeValue: iNgValue,
      ssCode: ssCode,
      instance: "BEFORE",
      attributeName: "NEUTRAL GROUND CURRENT",
    );

    final iBg = SSMaintenanceAttributesEntity(
      attributeType: 'BODY CURRENT I(B-G)',
      attributeValue: iBgValue,
      ssCode: ssCode,
      instance: "BEFORE",
      attributeName: "BODY GROUND CURRENT",
    );

    ssMaintenanceAttributesEntityList.addAll([iNg, iBg]);
  }
}
