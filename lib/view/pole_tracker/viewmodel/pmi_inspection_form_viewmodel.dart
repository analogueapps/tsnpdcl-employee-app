import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';

import '../model/pmi_model.dart';

class PmiInspectionFormViewmodel extends ChangeNotifier {
  PmiInspectionFormViewmodel({required this.context, required this.args}) {
    _handleLocation();
    print('Im in the constructure..!');
    loadFormUrl();
  }

  final BuildContext context;
  final Map<String, dynamic> args;
  double? latitude;
  double? longitude;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  bool readOnly = isTrue;

  List<FormControl> formControls = [];
  List<RowItem> rowItems = [];

  PermissionStatus? status;
  late final ImagePicker _picker = ImagePicker();
  File? capturedImage;

  // List<String> poleNumList=["pole1","pole2","pole3"];
  List<String> poleConditionList = [];
  List<String> lineSpanList = ["span1", "span2", "span3"];
  List<String> linePassingList = ["passing1", "passing2", "passing3"];
  List<String> cableOnPoleList = ["cable1", "cable2", "cable3"];
  List<String> stayConditionList = ["stay1", "stay2", "stay3"];
  List<String> strutConditionList = ["strut1", "strut2", "strut3"];
  List<String> xArmList = ["arm1", "arm2", "arm3"];
  List<String> topCleatList = ["top1", "top2", "top3"];
  List<String> insulatorsList = ["insulator1", "insulator2", "insulator3"];
  List<String> treeBranchClearance = ["tree1", "tree2", "tree3"];
  List<String> pinBindingList = ["pin1", "pin2", "pin3"];
  List<String> jumperingList = ["pin1", "pin2", "pin3"];
  List<String> earthingList = ["earthing1", "earthing2", "earthing3"];
  List<String> lineSwitchList = ["switch1", "switch2", "switch3"];
  List<String> lineLaList = ["la1", "la2", "la3"];
  List<String> lineCapacitorsList = ["capacitor1", "capacitor2", "capacitor3"];
  List<String> multiCircuitList = ["multi1", "multi2", "multi3"];
  List<String> lineToLineList = ["line1", "line2", "line3"];
  List<String> roadCrossingList = ["crossing1", "crossing2", "crossing3"];
  List<String> waterList = ["water1", "water2", "water3"];
  List<String> statusList = ["status1", "status2", "status3"];
  String? selectedPoleNum;
  String? selectedPoleCondition;
  String? selectedLineSpan;
  String? selectedLinePassing;
  String? selectedCableOnPole;
  String? selectedStayCondition;
  String? selectedStrutCondition;
  String? selectedArm;
  String? selectedTopCleat;
  String? selectedInsulator;
  String? selectedTreeBranchClearance;
  String? selectedPinBinding;
  String? selectedJumpering;
  String? selectedEarthing;
  String? selectedLineSwitch;
  String? selectedLineLa;
  String? selectedLineCapacitor;
  String? selectedMultiCircuit;
  String? selectedLineToLine;
  String? selectedRoadCrossing;
  String? selectedWater;
  String? selectedStatus;

  TextEditingController remarks = TextEditingController();
  TextEditingController poleNumber = TextEditingController();

  void _handleLocation() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      // Show a dialog to enable location services
      bool? shouldOpenSettings = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text("Location Service Disabled"),
              content: const Text(
                  "Please enable location services to use this feature."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Open Settings"),
                ),
              ],
            ),
          );
        },
      );

      if (shouldOpenSettings == true) {
        await Geolocator.openLocationSettings();
        // After opening settings, check again if the location service is enabled
        isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      }
    }
    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Location permissions are denied."),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool? shouldOpenSettings = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Location Permission Required"),
            content: const Text(
                "Location permissions are permanently denied. Please enable them in the app settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Open Settings"),
              ),
            ],
          );
        },
      );

      if (shouldOpenSettings == true) {
        await Geolocator.openAppSettings();
        permission = await Geolocator.checkPermission();
      }
    }

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Location permissions are still denied."),
        ),
      );
      return;
    }
  }

  Future<void> loadFormUrl() async {
    _isLoading = isTrue;
    notifyListeners();

    print('voltage : ${args['voltage']}');
    print('digital pole id  : ${args['digitalPoleId']}');

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "voltage": args['voltage'],
      "digitalPoleId": args['digitalPoleId'],
      "scheduleId": 0,
      "readOnly": false
    };

    final payload = {
      "path": "/loadPMIInspectionForm",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                formControls.clear();
                rowItems.clear();
                final data =
                    jsonDecode(response.data['objectJson']); // should be a List
                if (data is List) {
                  List<FormControl> formData =
                      (data[0]['formControlList'] as List)
                          .map<FormControl>((e) => FormControl.fromJson(e))
                          .toList();
                  List<RowItem> rowData = (data[0]['rowList'] as List)
                      .map<RowItem>((e) => RowItem.fromJson(e))
                      .toList();

                  formControls.addAll(formData);
                  rowItems.addAll(rowData);
                  print('formControls : ${formControls.toString()}');
                  notifyListeners();
                } else {
                  print("Error: Decoded objectJson is not a List or is empty");
                }
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
      showErrorDialog(
          context, e.toString()); //An error occurred. Please try again.
      print('Exception : ${e.toString()}');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    notifyListeners();
  }

  Color hexToColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xff')));
  }

  ///////////////////////////////Bhavana
  //DropDowns
  Map<String, String?> selectedValues = {}; // label -> selected value map

  void setSelectedValue(String label, String? value) {
    selectedValues[label] = value;
    notifyListeners();
  }

  //TextEditingControllers
  final Map<String, TextEditingController> _textControllers = {};

  TextEditingController getTextController(String label) {
    return _textControllers.putIfAbsent(label, () => TextEditingController());
  }

  void setTextValue(String label, String value) {
    if (_textControllers.containsKey(label)) {
      _textControllers[label]?.text = value;
    }
  }

  String? getSelectedValue(String label) => selectedValues[label];

  Widget entryForm(FormControl control, PmiInspectionFormViewmodel viewModel) {
    if (control.viewType == 'EDIT_TEXT') {
      final controller = viewModel.getTextController(control.label ?? "");
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            control.headerBar?.label != null
                ? ViewDetailedLcHeadWidget(
                    title: control.headerBar?.label ?? "")
                : const SizedBox.shrink(),
            Row(
              children: [
                Expanded(child: Text(control.label ?? "")),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: control.label ?? "Enter Text",
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      viewModel.setTextValue(control.label ?? "", value);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (control.viewType == 'SPINNER' && control.items != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(children: [
          control.headerBar?.label != null
              ? ViewDetailedLcHeadWidget(title: control.headerBar?.label ?? "")
              : const Text(""),
          Row(children: [
            Expanded(
              child: Text(control.label ?? ""),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: control.label ?? "Select",
                  border: const OutlineInputBorder(),
                ),
                value: viewModel.getSelectedValue(control.label ?? ""),
                items: control.items!
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
                onChanged: (value) {
                  viewModel.setSelectedValue(control.label ?? "", value);
                },
              ),
            ),
          ]),
        ]),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  ///////////////////////////

  void changeReadOnlyStatus() {
    readOnly = !readOnly;
    notifyListeners();
  }

  void setPoleNum(String newPoleNum) {
    selectedPoleNum = newPoleNum;
    notifyListeners();
  }

  void setPoleCondition(String newPoleCondition) {
    selectedPoleCondition = newPoleCondition;
    notifyListeners();
  }

  void setLineSpan(String newLineSpan) {
    selectedLineSpan = newLineSpan;
    notifyListeners();
  }

  void setLinePassing(String newLinePassing) {
    selectedLinePassing = newLinePassing;
    notifyListeners();
  }

  void setCableOnPole(String newCableOnPole) {
    selectedCableOnPole = newCableOnPole;
    notifyListeners();
  }

  void setStayCondition(String newStayValue) {
    selectedStayCondition = newStayValue;
    notifyListeners();
  }

  void setStrutCondition(String newStrutValue) {
    selectedStrutCondition = newStrutValue;
    notifyListeners();
  }

  void setArm(String newArm) {
    selectedArm = newArm;
    notifyListeners();
  }

  void setTopCleat(String newTopCleat) {
    selectedTopCleat = newTopCleat;
    notifyListeners();
  }

  void setInsulators(String newInsulator) {
    selectedInsulator = newInsulator;
    notifyListeners();
  }

  void setTreeBranchClearance(String newTreeBranchClearance) {
    selectedTreeBranchClearance = newTreeBranchClearance;
    notifyListeners();
  }

  void setPinBinding(String newPinBinding) {
    selectedPinBinding = newPinBinding;
    notifyListeners();
  }

  void setJumpering(String newJumpering) {
    selectedJumpering = newJumpering;
    notifyListeners();
  }

  void setEarthing(String newEarthing) {
    selectedEarthing = newEarthing;
    notifyListeners();
  }

  void setLineSwitch(String newLineSwitch) {
    selectedLineSwitch = newLineSwitch;
    notifyListeners();
  }

  void setLineLa(String newLineSwitch) {
    selectedLineLa = newLineSwitch;
    notifyListeners();
  }

  void setLineCapacitor(String newLineCapacitor) {
    selectedLineCapacitor = newLineCapacitor;
    notifyListeners();
  }

  void setMultiCircuit(String newMultiCircuit) {
    selectedMultiCircuit = newMultiCircuit;
    notifyListeners();
  }

  void setLineToLine(String newLineToLine) {
    selectedLineToLine = newLineToLine;
    notifyListeners();
  }

  void setRoadCrossing(String newRoadCrossing) {
    selectedRoadCrossing = newRoadCrossing;
    notifyListeners();
  }

  void setWater(String newWater) {
    selectedWater = newWater;
    notifyListeners();
  }

  void setStatus(String newStatus) {
    selectedStatus = newStatus;
    notifyListeners();
  }

  void captureImage() async {
    status = await Permission.camera.status;
    print('permission status : $status ');
    if (status!.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        capturedImage = File(image.path);
      }
    } else if (status!.isDenied) {
      status = await Permission.camera.request();
      if (status!.isGranted) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          capturedImage = File(image.path);
          notifyListeners();
        }
      }
    } else {
      openAppSettings();
    }
    notifyListeners();
  }
}
