import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

import '../model/pmi_model.dart';

class PmiInspectionFormViewmodel extends ChangeNotifier {
   PmiInspectionFormViewmodel({required this.context, required this.args}){
    _handleLocation();
    loadFormUrl();
  }

  final BuildContext context;
  final Map<String, dynamic> args;
  double? latitude;
  double? longitude;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  bool readOnly=false;

   List<FormControl> formControls = [];
   List<RowItem> rowItems = [];

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
  }

   Future<void> loadFormUrl() async {
     _isLoading = isTrue;
     notifyListeners();

     final requestData = {
       "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
       "api": Apis.API_KEY,
       "voltage":args['voltage'],
       "digitalPoleId":args['digitalPoleId'],
       "scheduleId":0,
       "readOnly":false
     };

     final payload = {
       "path": "/loadPMIInspectionForm",
       "apiVersion": "1.0",
       "method": "POST",
       "data": jsonEncode(requestData),
     };

     var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
     try {
       if (response != null) {
         if (response.data is String) {
           response.data = jsonDecode(response.data); // Parse string to JSON
         }
         if (response.statusCode == successResponseCode) {
           if(response.data['tokenValid'] == isTrue) {
             if (response.data['success'] == isTrue) {
               if(response.data['objectJson'] != null) {
                 final data = jsonDecode(response.data['objectJson']);
                 final objectJson = jsonDecode(data['objectJson']);
                   formControls = (objectJson as List).map((e) => FormControl.fromJson(e)).toList();
                   rowItems = objectJson[0]['rowList'].map<RowItem>((e) => RowItem.fromJson(e)).toList();
                 notifyListeners();
               }
             } else {
               showAlertDialog(context,response.data['message']);
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
       print(e);
       rethrow;
     }finally {
       _isLoading = false;
       notifyListeners();
     }

     notifyListeners();
   }

   Color hexToColor(String hex) {
     return Color(int.parse(hex.replaceFirst('#', '0xff')));
   }


   Widget buildFormField(FormControl control) {
     if (control.viewType == 'EDIT_TEXT') {
       return TextFormField(
         initialValue: control.text,
         enabled: control.focusable,
         decoration: InputDecoration(
           labelText: control.label,
           hintText: control.hint,
           labelStyle: TextStyle(color: Colors.black),
           hintStyle: TextStyle(color: hexToColor(control.hintTextColor)),
         ),
         style: TextStyle(color: hexToColor(control.textColor)),
         maxLength: control.maxLength,
         validator: (value) {
           if (control.required && (value == null || value.isEmpty)) {
             return '${control.label} is required';
           }
           if (value != null && value.length < control.minLength) {
             return 'Minimum length is ${control.minLength}';
           }
           return null;
         },
       );
     } else if (control.viewType == 'SPINNER' && control.items != null) {
       return DropdownButtonFormField<String>(
         value: control.text == 'null' ? null : control.text,
         decoration: InputDecoration(
           labelText: control.label,
           labelStyle: TextStyle(color: Colors.black),
         ),
         items: control.items!.map((item) {
           return DropdownMenuItem<String>(
             value: item,
             child: Text(item),
           );
         }).toList(),
         onChanged: control.focusable ? (value) {

             control.text = value ?? '';
           notifyListeners();
         } : null,
       );
     } else if (control.viewType == 'LOCATION_PHOTO') {
       return Column(
         children: [
           Text(control.headerBar?.label ?? 'Photo', style: TextStyle(color: hexToColor(control.headerBar?.labelColor ?? '#000000'))),
           control.text.isNotEmpty
               ? Image.network(control.text, height: double.infinity, fit: BoxFit.cover)
               : ElevatedButton(
             onPressed: () {
               // Implement photo capture logic
             },
             child: Text('Capture Photo'),
           ),
         ],
       );
     }
     return SizedBox.shrink();
   }
}
