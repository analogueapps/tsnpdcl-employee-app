import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/image_upload.dart';

class MeterChangeEntryScreenViewModel extends ChangeNotifier {
  Map<String, dynamic> args;
  MeterChangeEntryScreenViewModel({required BuildContext context, required this.args}) {
    _loadMeterMake(context);
    _checkCameraPermissions(context);
  }

  //Contrllers
  final TextEditingController poNoController = TextEditingController();
  final TextEditingController poDateController = TextEditingController();
  final TextEditingController oldMeterNoController = TextEditingController();
  final TextEditingController oldMeterCapacityController =
      TextEditingController();
  final TextEditingController oldMeterStatusController =
      TextEditingController();
  final TextEditingController oldMeterFinalReadingController =
      TextEditingController();
  final TextEditingController oldMeterSealBitController =
      TextEditingController();

  final TextEditingController newMeterNoController = TextEditingController();
  final TextEditingController newMeterInitialReadingController =
      TextEditingController();
  final TextEditingController newMeterSealBitNoController =
      TextEditingController();

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  PermissionStatus? status;

  final ImagePicker _picker = ImagePicker();
  File? captureOldImage;
  File? captureNewImage;

  final ImageUploader _imageUploader = ImageUploader();
  final imageUrls = <String>[];

  DateTime? pickedDate;

  List<Map<String, dynamic>> meterMakesMap = [];
  List<String> optionNames = [];
  String? oldMeterMakeName;
  String? newMeterMakeName;
  String? meterType;
  String? oldMeterPhase;
  String? newMeterPhase;
  bool newSinglePhase = false;
  bool newThreePhase = false;
  bool oldSinglePhase = false;
  bool oldThreePhase = false;
  String? boxPosition;
  bool withBox = false;
  bool withoutBox = false;
  bool noDisplay = false;
  bool oldMeterNoImageVisibility=false;
  bool newMeterNoImageVisibility=false;
  String? _errorMessage;
  bool unableToScanOldMeterNo=false;
  bool unableToScanNewMeterNo=false;
  bool barCodeScanOnOld=false;
  bool barCodeScanOnNew=false;
  bool _isScanned = false;
  String? _code;
  // Barcode? barcode;


  List<String> meterTypeOptions = [
    "Mechanical",
    "Electronic With IRDA",
    "Electronic Without IRDA",
  ];

  void _loadMeterMake(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/load/meterMakes",
      "method": "POST",
      "apiVersion": "1.0",
      "data": jsonEncode(requestData),
    };

    print('Meter make url : ${Apis.CHECK_BS_UDC_IP_PORT} --- ${Apis.METER_MAKE} --- /load/meterMakes');
    var response = await ApiProvider(baseUrl: Apis.CHECK_BS_UDC_IP_PORT)
        .postApiCall(context, Apis.METER_MAKE, payload);
    print('Meter make response : $response');
    _isLoading = false;
    notifyListeners();

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Convert string to Map
        }

        if (response.statusCode == successResponseCode) {
          final data = response.data;

          if (data['tokenValid'] == true) {
            if (data['success'] == true) {
              if (data['objectJson'] != null) {
                final List<dynamic> rawList = jsonDecode(data['objectJson']);
                meterMakesMap = rawList.cast<Map<String, dynamic>>();
              } else {
                showAlertDialog(context, "No Data Found");
              }
            } else {
              showAlertDialog(context, data['message'] ?? "Task Failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,
              response.data['message'] ?? "Unexpected server response");
        }
      }
    } catch (e) {
      print("Error: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
    optionNames =
        meterMakesMap.map((item) => item['optionName'] as String).toList();
    notifyListeners();
  }

  void updateOldMeterMake(String name) {
    oldMeterMakeName = name;
    notifyListeners();
  }

  void updateNewMeterMake(String name) {
    newMeterMakeName = name;
    notifyListeners();
  }

  void updateMeterType(String name) {
    meterType = name;
    notifyListeners();
  }

  void setNewSinglePhase(bool check) {
    newSinglePhase = check;
    newThreePhase = !check;
    newMeterPhase =check ? "Single Phase":"";
    notifyListeners();
  }

  void setNewThreePhase(bool check) {
    newThreePhase = check;
    newSinglePhase = !check;
    newMeterPhase = check ? "3 Phase" : "";
    notifyListeners();
  }

  void setOldSinglePhase(bool check) {
    oldSinglePhase = check;
    oldThreePhase = !check;
    oldMeterPhase = check ? "Single Phase" : "";
    notifyListeners();
  }

  void setOldThreePhase(bool check) {
    oldThreePhase = check;
    oldSinglePhase = !check;
    oldMeterPhase = check ? "3 Phase" : "";
    notifyListeners();
  }


  void setWithBox(bool check) {
    withBox = check;
    withoutBox = !check;
    boxPosition = "Fixed with box";
    notifyListeners();
  }

  void setWithoutBox(bool check) {
    withoutBox = check;
    withBox = !check;
    boxPosition = "Fixed without box";
    notifyListeners();
  }

  void setNoDisplay(bool check) {
    noDisplay = check;
    notifyListeners();
  }

  void _checkCameraPermissions(BuildContext context) async {
    status = await Permission.camera.status;

    if (status!.isDenied) {
      // Ask for permission
      final newStatus = await Permission.camera.request();
      status = newStatus;
      if (!newStatus.isGranted) {
        showErrorDialog(
            context, 'Camera permission is required to scan barcode.');
      }
    } else if (status!.isPermanentlyDenied) {
      // Ask user to manually enable permission from settings
      bool? openSettings = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'Camera permission has been permanently denied. Please open app settings to allow it manually.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );

      if (openSettings == true) {
        await openAppSettings();
      }
    }

    notifyListeners();
  }

  void chooseDate(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2010, 2, 1), // Initial date: Feb 1, 2010
      firstDate: DateTime(2010, 2, 1),   // Minimum selectable date
      lastDate: DateTime.now(),         // Maximum date: current date
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate!);
      poDateController.text = formattedDate;
      notifyListeners();
    }
  }

  void showAttention(BuildContext context,String newOrOld){
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Attention"),
          content: const Text(
            "Use this option when only barcode scanning is not working, or meter doesn't have barcode on it.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                captureMeterNo(context, newOrOld);
                Navigator.pop(context);
              },
              child: const Text("Proceed"),
            ),
          ],
        );
      },
    );
  }

  // void getBarCode(BuildContext context, BarcodeCapture result) async {
  //   final code = result.barcodes.first.rawValue;
  //   if (code == null) return;
  //
  //   print('Scanned barcode: $code');
  //
  //   // Only assign to one field based on active scan
  //   if (barCodeScanOnOld) {
  //     oldMeterNoController.text = code;
  //     barCodeScanOnOld = false;
  //   } else if (barCodeScanOnNew) {
  //     newMeterNoController.text = code;
  //     barCodeScanOnNew = false;
  //   }
  //
  //   notifyListeners();
  // }
  void scanBarCode(BuildContext context) async {
    if (status!.isGranted) {
      barCodeScanOnNew = false;
      barCodeScanOnOld = true;
      notifyListeners();
    } else {
      _checkCameraPermissions(context);
    }
  }

  void scanBarCodeNew(BuildContext context) async {
    if (status!.isGranted) {
      barCodeScanOnOld = false;
      barCodeScanOnNew = true;
      notifyListeners();
    } else {
      _checkCameraPermissions(context);
    }
  }


  Future<void> captureMeterNo(BuildContext context, String type) async {

    if (status != null && status!.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        if (type == "old") {
          unableToScanOldMeterNo=isTrue;
          captureOldImage = File(image.path);
          oldMeterNoImageVisibility = true;
          notifyListeners();
        } else if (type == "new") {
          unableToScanNewMeterNo = isTrue;
          captureNewImage = File(image.path);
          newMeterNoImageVisibility = true;
          notifyListeners();
        }
      } else {
        print("User cancelled camera");
      }
    } else {
      _checkCameraPermissions(context);
    }
    notifyListeners();
  }

  bool validate(BuildContext context) {
    if (poNoController.text.isEmpty) {
      showErrorDialog(context, "Please enter PO number on Old meter.");
      return false;
    } else if (poDateController.text.isEmpty) {
      showErrorDialog(context, "Please enter PO date on Old meter.");
      return false;
    } else if (oldMeterNoController.text.isEmpty) {
      showErrorDialog(context, "Please scan Old meter no.");
      return false;
    } else if (oldMeterMakeName == null) {
      showErrorDialog(context, "Please select old meter make");
      return false;
    } else if (oldMeterPhase == null) {
      showErrorDialog(context, "Please select old meter phase");
      return false;
    } else if (oldMeterCapacityController.text.isEmpty) {
      showErrorDialog(context, "Please enter old meter capacity");
      return false;
    } else if (oldMeterFinalReadingController.text.isEmpty && !noDisplay) {
      showErrorDialog(context, "Please enter old meter final reading");
      return false;
    } else if (oldMeterSealBitController.text.isEmpty) {
      showErrorDialog(context, "Please enter old meter seal bit number");
      return false;
    } else if (newMeterNoController.text.isEmpty) {
      showErrorDialog(context, "Please scan your new meter serial number barcode");
      return false;
    } else if (newMeterMakeName == null) {
      showErrorDialog(context, "Please select new meter make");return false;
    } else if (newMeterPhase == null) {
      showErrorDialog(context, "Please select new meter phase");return false;
    } else if (newMeterSealBitNoController.text.isEmpty) {
      showErrorDialog(context, "Please enter seal bit number");return false;
    } else if (boxPosition == null) {
      // print('Box position : $boxPosition');
      showErrorDialog(context, "Please select new meter box position");return false;
    } else if (meterType == null) {
      showErrorDialog(context, "Please select new meter type");return false;
    } else if (unableToScanOldMeterNo && captureOldImage==null ){
      showErrorDialog(context, 'Please capture old meter images');
    } else if (unableToScanOldMeterNo && captureNewImage==null ){
      showErrorDialog(context, 'Please capture new meter images');
    }
    return true;
  }

  void saveMeterDetails(BuildContext context) async {
    print('USCNO : ${args['t'].toInt().toString()}');
    _isLoading = true;
    notifyListeners();

    String? oldMeterImageUrl;
    String? newMeterImageUrl;

    // Upload images only if manual entry was required
    if (unableToScanOldMeterNo || unableToScanNewMeterNo) {
      print('Entered into the image Upload');
      if (captureOldImage != null) {
        oldMeterImageUrl = await _imageUploader.uploadImage(context, captureOldImage!);
        if (oldMeterImageUrl == null) {
          _errorMessage = 'Failed to upload old meter image';
          if (context.mounted) showErrorDialog(context, _errorMessage!);
          _isLoading = false;
          notifyListeners();
          return; // Exit if upload fails
        }
      }

      if (captureNewImage != null) {
        newMeterImageUrl = await _imageUploader.uploadImage(context, captureNewImage!);
        if (newMeterImageUrl == null) {
          _errorMessage = 'Failed to upload new meter image';
          if (context.mounted) showErrorDialog(context, _errorMessage!);
          _isLoading = false;
          notifyListeners();
          return; // Exit if upload fails
        }
      }
    }

    try {
      final requestData = {
        "uscno": args['t'].toInt().toString(),
        "sc": args['sc'].toString(),
        "dc": args['dc'],
        "name": args['n'],
        "oldMtrNo": oldMeterNoController.text,
        "oldCap": oldMeterCapacityController.text,
        "newMtrNo": newMeterNoController.text,
        "oldPhase": oldMeterPhase=="Single Phase" ?"1":"3",
        "oldMtrFr": noDisplay ? "-1" : oldMeterFinalReadingController.text,
        "oldMake": oldMeterMakeName,
        "newMake": newMeterMakeName,
        "newMtrIr": newMeterInitialReadingController.text,
        "sealbit": newMeterSealBitNoController.text,
        "newPhase": newMeterPhase=="Single Phase" ? "1" : "3",
        "meterType": meterType,
        "statusCode": args['st'].toString(), // Fixed: Removed .toInt() if status is string
        "oldMtrSeal": oldMeterSealBitController.text,
        "box": withBox ? "BOX" : "NO BOX", // Explicit values like Android code
        "poNum": poNoController.text,
        "poDate": poDateController.text,
        // Conditionally include images only if uploaded
        if (oldMeterImageUrl != null) "photo": oldMeterImageUrl,
        if (newMeterImageUrl != null) "newPhoto": newMeterImageUrl,
        "authToken":SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "api":Apis.API_KEY,
      };

      final payload = {
        "path": "/saveExceptionalMeter",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      final response = await ApiProvider(baseUrl: Apis.CHECK_BS_UDC_IP_PORT)
          .postApiCall(context, Apis.METER_CHANGE_COMPLETE_ROOT, payload);

      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Convert string to Map
        }

        if (response.statusCode == successResponseCode) {
          final data = response.data;

          if (data['tokenValid'] == true) {
            if (data['success'] == true) {
              showSuccessDialog(context, data['message'], (){Navigator.pop(context);});
            } else {
              showAlertDialog(context, data['message'] ?? "Task Failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,
              response.data['message'] ?? "Unexpected server response");
        }
      }

    } catch (e) {
      if (context.mounted) showErrorDialog(context, e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

