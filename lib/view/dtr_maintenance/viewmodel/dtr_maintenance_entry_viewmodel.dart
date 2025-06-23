
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_inspection_sheet_entity.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/ht_side_group_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/image_upload.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class DtrMaintenanceEntryViewmodel extends ChangeNotifier {

   final BuildContext context;
   String jsonResponse;

   DtrInspectionSheetEntity? dtrInspectionSheetEntity = null;

   List<OptionList> groups = [];
   List<OptionList> get groupsList => groups;

   OptionList? selectedGroup;

   String _latitude="";
   String get latitude=>_latitude;
   String _longitude="";
   String get longitude=>_longitude;

   bool _isLoading = isFalse;
   bool get isLoading => _isLoading;

   // Constructor to initialize the items
   DtrMaintenanceEntryViewmodel({required this.context, required this.jsonResponse}) {
     dtrInspectionSheetEntity = DtrInspectionSheetEntity.fromJson(jsonDecode(jsonResponse));
     loadFilters();
   }

   void loadFilters() {
     List<OptionList> predefinedGroups = [
       OptionList(optionId: "HT_SIDE", optionName: "HT Side"),
       OptionList(optionId: "LT_SIDE", optionName: "LT Side"),
       OptionList(optionId: "OIL", optionName: "Oil"),
       OptionList(optionId: "EARTHING", optionName: "Earthing"),
       OptionList(optionId: "LT_NETWORK", optionName: "LT Network"),
       OptionList(optionId: "LA", optionName: "LA's"),
       OptionList(optionId: "DTR_LOADING", optionName: "DTR Loading"),
       OptionList(optionId: "TONG", optionName: "Tong Tester Readings"),
     ];
     groups = predefinedGroups;

     selectedGroup = predefinedGroups.firstWhere(
           (group) => group.optionId == "HT_SIDE",
       orElse: () => predefinedGroups.first,
     );
     notifyListeners();
   }

   void selectGroup(OptionList group) {
     selectedGroup = group;
     print("SelectedGroup : ${group.optionId}");
     notifyListeners();
   }


   // Map<String, bool Function()> get maintenanceCheckMap => {
   //   "HT_SIDE": htIsMaintenanceRequired,
   //   "LT_SIDE": ltIsMaintenanceRequired,
   //   "OIL": oilMaintenanceRequired,
   //   "EARTHING":earthMaintenanceRequired,
   //   "LT_NETWORK": ltnMaintenanceRequired,
   //   "LA": laMaintenanceRequired,
   //   "DTR_LOADING": dtrMaintenanceRequired,
   //   "TONG": () => false,
   // };

   // bool htIsMaintenanceRequired(){
   //   return dtrInspectionSheetEntity?.abContactsDamaged>0 ||
   //       dtrInspectionSheetEntity?.nylonBushDamaged>0||
   //       dtrInspectionSheetEntity?.abBrassStripDamaged>0||
   //       dtrInspectionSheetEntity?.hornsToBeReplaced>0||
   //       (dtrInspectionSheetEntity?.gapIsNotCorrect!="Y") ||dtrInspectionSheetEntity?.hgFuseSetPostTypeInsulatorsCount>0 || dtrInspectionSheetEntity?.htBushesDamageCount>0 || dtrInspectionSheetEntity?.htBushRodsDamCount>0;
   // }
   //
   // bool ltIsMaintenanceRequired(){
   //   return dtrInspectionSheetEntity?.ltBushesDamageCount>0 || dtrInspectionSheetEntity?.ltBushRodsDamCount>0 || dtrInspectionSheetEntity?.ltBiMetalClampsDamCount>0 ||
   //       (dtrInspectionSheetEntity?.ltBreakerStatus!="DAMAGED") || (dtrInspectionSheetEntity?.ltFuseSetStatus!="DAMAGED")
   //       || dtrInspectionSheetEntity?.ltFuseWire!="COPPER_OK"|| (dtrInspectionSheetEntity?.ltPvcCableStatus!="DAMAGED");
   //
   //
   // }
   //
   // bool oilMaintenanceRequired(){
   //   return  dtrInspectionSheetEntity?.oilShortageInLiters>0 || (dtrInspectionSheetEntity?.gasketsDamaged!="DAMAGED") || (dtrInspectionSheetEntity?.diaphragmStatus!="DAMAGED");
   // }
   //
   // bool earthMaintenanceRequired(){
   //   return  dtrInspectionSheetEntity?.earthPipesStatus!=null&&dtrInspectionSheetEntity?.earthPipesStatus.toLowerCase() == "damaged" ||
   //       dtrInspectionSheetEntity?.earthing!=null && dtrInspectionSheetEntity?.earthing.toLowerCase() == "damaged";
   // }
   //
   // bool ltnMaintenanceRequired(){
   //   return dtrInspectionSheetEntity?.noOfLooseLinesOnDtr>0 || dtrInspectionSheetEntity?.treeCuttingRequired>0 || (dtrInspectionSheetEntity?.otherObservationsByLm.toLowerCase() == "y");
   // }
   //
   // bool laMaintenanceRequired(){
   //   return dtrInspectionSheetEntity?.lightningArrestors!=null&&dtrInspectionSheetEntity?.lightningArrestors.toLowerCase() == "damaged";
   // }
   // bool dtrMaintenanceRequired(){
   //   return (dtrInspectionSheetEntity?.dtrAglLoadHp>0.0 || dtrInspectionSheetEntity?.domesticNonDomLoad >0.0 || dtrInspectionSheetEntity?.industrialLoadInHp>0.0 || dtrInspectionSheetEntity?.waterWorksLoadInHp>0.0 || dtrInspectionSheetEntity?.otherLoadInKw>0.0);
   // }


   void handleLocationIconClick() async {

     bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
     if (!isLocationEnabled) {
       bool? shouldOpenSettings = await showDialog(
         context: context,
         barrierDismissible: false,
         builder: (context) {
           return WillPopScope(
             onWillPop: () async => false,
             child: AlertDialog(
               title: const Text("Location Service Disabled"),
               content: const Text("Please enable location services to use this feature."),
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
         isLocationEnabled = await Geolocator.isLocationServiceEnabled();
       }
     }
     LocationPermission permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.denied) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
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
             title: Text("Location Permission Required"),
             content: Text("Location permissions are permanently denied. Please enable them in the app settings."),
             actions: [
               TextButton(
                 onPressed: () => Navigator.of(context).pop(false),
                 child: Text("Cancel"),
               ),
               TextButton(
                 onPressed: () => Navigator.of(context).pop(true),
                 child: Text("Open Settings"),
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

     if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text("Location permissions are still denied."),
         ),
       );
       return;
     }
     // await _getCurrentLocation();

   }

   Future<void> _getCurrentLocation() async {
     try {
       Position position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high,
       );

       _latitude = position.latitude.toString();
       _longitude = position.longitude.toString();
       print("maintenance due: $_latitude, $_longitude");
       notifyListeners();
     } catch (e) {
       print("Error fetching location: $e");

     }
   }

   String _photoPath="";
   String get photoPath => _photoPath;
   final ImageUploader _imageUploader = ImageUploader();

   final ImagePicker _maintenanceDtrPicker = ImagePicker();

   Future<void> capturePhoto() async {
     final status = await Permission.camera.request();
     if (status.isDenied || status.isPermanentlyDenied) {
       if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Text(status.isPermanentlyDenied
                 ? 'Camera permission permanently denied. Enable in settings.'
                 : 'Camera permission denied'),
             action: status.isPermanentlyDenied
                 ? SnackBarAction(label: 'Settings', onPressed: openAppSettings)
                 : null,
           ),
         );
       }
       return;
     }

     try {
       final XFile? photo = await _maintenanceDtrPicker.pickImage(
         source: ImageSource.camera,
         imageQuality: 85,
         maxWidth: 1024,
         maxHeight: 1024,
       );

       if (photo == null) {
         if (context.mounted) {
           showErrorDialog(context, "No photo captured");
         }
         return;
       }

       // Upload photo if captured
       ProcessDialogHelper.showProcessDialog(context, message: "Uploading images...");
       notifyListeners();
       final imageUrl = await _imageUploader.uploadImage(context, File(photo.path));
       print("view workfloating $imageUrl");
       if (imageUrl != null) {
         _photoPath=imageUrl;
         notifyListeners();
         print("Image uploaded successfully: $imageUrl");
         await _getCurrentLocation();
         if (context.mounted) {
           ProcessDialogHelper.closeDialog(context);
         }
       } else {
         if (context.mounted) {
           ProcessDialogHelper.closeDialog(context);
           // showAlertDialog(context, _errorMessage!);
         }
         showErrorDialog(context, "Image upload failed");
       }
     } catch (e) {
       if (context.mounted) showErrorDialog(context, "Error capturing photo");
     }
   }

   Future<void> saveDtrMaintenance() async {
     _isLoading = isTrue;
     notifyListeners();


     final payload = {
       "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
       "appId": "in.tsnpdcl.npdclemployee",
       "structureCode": dtrInspectionSheetEntity!.structureCode,
       "data":"",
       "sheetId":dtrInspectionSheetEntity!.sheetId,

     };

     var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_DTR_INSPECTIONS_URL, payload);
     _isLoading = isFalse;

     try {
       if (response != null) {
         if (response.data is String) {
           response.data = jsonDecode(response.data); // Parse string to JSON
         }
         if (response.statusCode == successResponseCode) {
           //if(response.data['sessionValid'] == isTrue) {
           if (response.data['taskSuccess'] == isTrue) {
             if(response.data['message'] != null) {
               showSuccessDialog(context, response.data['message'], (){
                 Navigator.pop(context);
               });
             }else {
               print('got the message :${response.data['message']}');
               showAlertDialog(context,response.data['message']);
             }
           } else {
             //showSessionExpiredDialog(context);
             showErrorDialog(context,response.data['message']);
           }
         }
         else {
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
