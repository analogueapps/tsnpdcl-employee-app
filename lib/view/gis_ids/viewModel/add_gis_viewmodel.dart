import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/meeseva/meeseva_UI/showDialog_gps.dart'; // Adjust import path

class AddGisPointViewModel extends ChangeNotifier {
  // Text controllers
  final TextEditingController gisRegController = TextEditingController(text: "GIS-00121036");
  final TextEditingController gisIdController = TextEditingController(text: "121036");
  final TextEditingController feederController = TextEditingController(text: "007-09-11KV ADVOCATESCOLONY");
  final TextEditingController workDescriptionController = TextEditingController(text: "After Work T230102010101003 Alternate supply @ Caption");
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  // Dropdown values
  String? voltageLevel;
  String? pointType;

  // Focus node
  late FocusNode remarksFocusNode;

  // Dropdown items
  final List<String> voltageItems = [
    'SELECT',
    '33KV',
    '11KV',
    'LT',
  ];

  final List<String> pointTypeItems = [
    '--SELECT--',
    'LINE TRAPPING POINT',
    'LINE TURNING/ANGLE POINT',
    'LINE END POINT',
    'SS CONSTRUCTION',
    'MIDDLE POLE',
    'BROKEN POLE',
    'DAMAGED POLE',
    'RUSTED POLE',
    'RE-CONSTRUCTION',
    'LOOSE LINE STRINGING',
    'THEFT OF CONDUCTOR',
    'THEFT OF DTR',
    'DTR ENHANCEMENT',
    'DTR IMPROVEMENT',
    'DTR DAMAGE DUO TO CYCLONE',
    'DTR FOR NEW SERVICE',
    'SHIFTING OF DTR',
    'PERMISSION OF SERVICE CONNECTION',
    'TREE CUTTING START POINT',
    'TREE CUTTING END POINT',
    'CIVIL WORKS',
    'SECTION OFFICE LOCATION',
    'OTHERS'
  ];

  AddGisPointViewModel(BuildContext context) {
    remarksFocusNode = FocusNode();
    _initialize(context);
  }

  void _initialize(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showGPSPermissionDialog(context); // Show GPS dialog after frame
    });
  }

  // Dropdown change handlers
  void setVoltageLevel(String? newValue) {
    voltageLevel = newValue;
    notifyListeners();
  }

  void setPointType(String? newValue) {
    pointType = newValue;
    notifyListeners();
  }

  // Focus request for remarks
  void requestRemarksFocus() {
    remarksFocusNode.requestFocus();
  }

  // Placeholder methods for save and folder actions
  void save() {
    print("Save action triggered");
    // Implement save logic here
  }

  void openFolder() {
    print("Folder action triggered");
    // Implement folder logic here
  }

  @override
  void dispose() {
    gisRegController.dispose();
    gisIdController.dispose();
    feederController.dispose();
    workDescriptionController.dispose();
    longitudeController.dispose();
    latitudeController.dispose();
    remarksController.dispose();
    remarksFocusNode.dispose();
    super.dispose();
  }
}