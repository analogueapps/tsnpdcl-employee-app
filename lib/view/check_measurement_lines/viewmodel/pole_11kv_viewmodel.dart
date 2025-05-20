import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';

import '../../dtr_master/model/circle_model.dart';

class Pole11kvViewmodel extends ChangeNotifier {
  Pole11kvViewmodel({required this.context, required this.args}){
    startListening();
    getPolesOnFeeder();
  }

  // Current View Context
  final formKey = GlobalKey<FormState>();
  final BuildContext context;
  final Map<String, dynamic> args;
   double MINIMUM_GPS_ACCURACY_REQUIRED = 15.0;
  String maxId = "0L";

  double? latitude;
  double? longitude;
  double? totalAccuracy;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final TextEditingController poleNumber= TextEditingController();
  final TextEditingController dtrStructure= TextEditingController();

  bool _followSwitch = true;

  bool get followSwitch => _followSwitch;

  set followMe(bool value) {
    _followSwitch = value;
    notifyListeners();
  }

  String locationDistance="";


  StreamSubscription<Position>? _positionStream;
  void startListening() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;
      totalAccuracy = position.accuracy; // <-- This is in meters

      notifyListeners();
    });
  }

  void stopListening() {
    _positionStream?.cancel();
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000; // meters
    double dLat = _degToRad(lat2 - lat1);
    double dLon = _degToRad(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double _degToRad(double deg) => deg * pi / 180;


  String? _selectedPole;
  String? get selectedPole => _selectedPole;
  void setSelectedPole(String title) {
    _selectedPole = title;
    print("$_selectedPole: filter selected");
    notifyListeners();
  }

  //Tapping from previous pole
  String? _selectedTappingPole;
  String? get selectedTappingPole => _selectedTappingPole;
  void setSelectedTappingPole(String title) {
    if(_selectedPole==""){
      showAlertDialog(context, "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
    }else {
      _selectedTappingPole = title;
      print("$_selectedTappingPole:  tap selected");
      notifyListeners();
    }
  }

  //Any Crossings:
  List<String> selectedCrossings = [];

  void setSelectedCrossings(String title) {
    if (selectedCrossings.contains(title)) {
      selectedCrossings.remove(title);
    } else {
      selectedCrossings.add(title);
    }
    notifyListeners();
  }


  //Pole type
  List<String> selectedFirstGroup = [];
  List<String> selectedSecondGroup = [];
  List<String> get selectedPoleType => [...selectedFirstGroup, ...selectedSecondGroup];

  void toggleFirstGroup(String val) {
    if (selectedSecondGroup.length == 2) {
      selectedSecondGroup.removeLast(); // Remove latest from Column 2
    }

    if (selectedFirstGroup.contains(val)) {
      selectedFirstGroup.remove(val); // Uncheck
    } else {
      selectedFirstGroup = [val]; // Replace
    }

    notifyListeners();
  }

  void toggleSecondGroup(String val) {
    bool wasCol1Selected = selectedFirstGroup.isNotEmpty;

    if (selectedSecondGroup.contains(val)) {
      selectedSecondGroup.remove(val); // Toggle off
    } else {
      if (wasCol1Selected) {
        // Remove col1 selection first
        selectedFirstGroup.clear();
      }

      // After clearing col1, limit becomes 2
      final limit = 2;

      if (selectedSecondGroup.length < limit) {
        selectedSecondGroup.add(val); // Add normally
      } else {
        // At limit, remove the oldest one
        selectedSecondGroup.removeAt(0);
        selectedSecondGroup.add(val);
      }
    }

    notifyListeners();
  }

  bool get isSecondGroupEnabled => true;

  //pole height
  List<String> poleHeightData = [
    "8.0 Mtr. Pole",
    "11 Mtr. Pole",
    "13 Mtr(Tower)",
    "19 Mtr(Tower)",
    "9.1 Mtr. Pole",
    "10 Mtrs(Tower)",
    "16 Mtr(Tower)"
  ];

  String? _selectedPoleHeight;
  String? get selectedPoleHeight => _selectedPoleHeight;

  void setSelectedPoleHeight(String height) {
    if (_selectedPoleHeight == height) {
      _selectedPoleHeight = null; // Unselect if tapped again
    } else {
      _selectedPoleHeight = height;
    }
    print("Selected height: $_selectedPoleHeight");
    notifyListeners();
  }

  //Circuits
  String? _selectedCircuits;
  String? get selectedCircuits => _selectedCircuits;
  void setSelectedCircuits(String title) {
      _selectedCircuits= title;
      print("$_selectedCircuits: Circuits selected");
      notifyListeners();
  }

  //Formation
  String? _selectedFormation;
  String? get selectedFormation=> _selectedFormation;
  void setSelectedFormation(String title) {
    _selectedFormation= title;
    print("$_selectedFormation: Formation selected");
    notifyListeners();
  }
  //Type of point
  String? _selectedTypePoint;
  String? get selectedTypePoint => _selectedTypePoint;
  void setSelectedTypePoint(String title) {
    _selectedTypePoint= title;
    print("$_selectedTypePoint: TypePoint selected");
    notifyListeners();
  }

  //Connected Load
  String? _selectedConnected;
  String? get selectedConnected => _selectedConnected;
  void setSelectedConnected(String title) {
    _selectedConnected= title;
    print("$_selectedConnected: Connected  selected");
    notifyListeners();
  }

//Conductor Size
  String? _selectedConductor ;
  String? get selectedConductor  => _selectedConductor ;
  void setSelectedConductor (String title) {
    _selectedConductor = title;
    print("$_selectedConductor : Conductor   selected");
    notifyListeners();
  }



  List<PoleFeederEntity> poleFeederList = [];
  String? poleFeederSelected;
  String? poleFeederID;
  String? poleLat;
  String? poleLon;
  PoleFeederEntity? selectedPoleFeeder;

  void onListPoleFeederChange(PoleFeederEntity? value) {
    selectedPoleFeeder = value;
    if (value != null) {
      poleFeederSelected=value.poleNum??"";
      poleFeederID=value.id.toString()??"";
      poleLat=value.lat.toString()??"";
      poleLon=value.lon.toString()??"";

      print("POle Num: $poleFeederSelected");
      print("Pole ID: $poleFeederID");
    }
    notifyListeners();
  }

  Future<void> getPolesOnFeeder() async {
    poleFeederList.clear();
    poleFeederSelected = null;
    notifyListeners();

    _isLoading = isTrue;

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ssc": args["ssc"],
      "fc":args["fc"],
    };

    final payload = {
      "path": "/getPolesOnFeeder",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(
        context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(
                    response.data['objectJson']);
                final List<PoleFeederEntity> listData = jsonList.map((json) =>
                    PoleFeederEntity.fromJson(json)).toList();
                poleFeederList.addAll(listData);
              }else {
                showAlertDialog(context, "No Data Found");
              }
            } else {
              showAlertDialog(context, "There is no existing Proposal under the selected substation");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,"An error occurred. Please try again."  );
      rethrow;
    }

    notifyListeners();
  }

  String? _selectedCapacity;
  String? get selectedCapacity => _selectedCapacity;

  final List<SubstationModel> _capacity = [SubstationModel(optionCode: "0", optionName: "SELECT"),
    SubstationModel(optionCode: "1", optionName: "1x10(L)"),
    SubstationModel(optionCode: "1", optionName: "1x10KVA(AGL)"),
    SubstationModel(optionCode: "3", optionName: "1x63+2x15KVA"),
    SubstationModel(optionCode: "1", optionName: "1x100"),
    SubstationModel(optionCode: "1", optionName: "1x75"),
    SubstationModel(optionCode: "1", optionName: "1x50"),
    SubstationModel(optionCode: "2", optionName: "1x100+1x15(L)"),
    SubstationModel(optionCode: "2", optionName: "1x100+1x160"),
    SubstationModel(optionCode: "1", optionName: "1x15 (Agl)"),
    SubstationModel(optionCode: "1", optionName: "1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x16"),
    SubstationModel(optionCode: "2", optionName: "1x16+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x160"),
    SubstationModel(optionCode: "1", optionName: "1x200"),
    SubstationModel(optionCode: "1", optionName: "1x25"),
    SubstationModel(optionCode: "1", optionName: "1x40"),
    SubstationModel(optionCode: "1", optionName: "1x25L"),
    SubstationModel(optionCode: "2", optionName: "1x25+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x250"),
    SubstationModel(optionCode: "1", optionName: "1x300"),
    SubstationModel(optionCode: "1", optionName: "1x315"),
    SubstationModel(optionCode: "1", optionName: "1x400"),
    SubstationModel(optionCode: "1", optionName: "1x500"),
    SubstationModel(optionCode: "1", optionName: "1x63"),
    SubstationModel(optionCode: "2", optionName: "1x63+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x630"),
    SubstationModel(optionCode: "1", optionName: "1x650"),
    SubstationModel(optionCode: "1", optionName: "1x750"),
    SubstationModel(optionCode: "1", optionName: "1x800"),
    SubstationModel(optionCode: "1", optionName: "1x1000"),
    SubstationModel(optionCode: "1", optionName: "1x1600"),
    SubstationModel(optionCode: "1", optionName: "1x2000"),
    SubstationModel(optionCode: "1", optionName: "1x2500"),
    SubstationModel(optionCode: "2", optionName: "2x100"),
    SubstationModel(optionCode: "2", optionName: "2x150"),
    SubstationModel(optionCode: "2", optionName: "2x16"),
    SubstationModel(optionCode: "2", optionName: "2x25"),
    SubstationModel(optionCode: "2", optionName: "2x15"),
    SubstationModel(optionCode: "2", optionName: "2x250"),
    SubstationModel(optionCode: "2", optionName: "2x63"),
    SubstationModel(optionCode: "3", optionName: "3x10(A)"),
    SubstationModel(optionCode: "3", optionName: "3x16"),
    SubstationModel(optionCode: "3", optionName: "3x25"),
    SubstationModel(optionCode: "3", optionName: "3x15"),
    SubstationModel(optionCode: "2", optionName: "1x16+1x63"),
  ];

  List<SubstationModel> get capacity => _capacity;

  int? _selectedCapacityIndex;

  int? get selectedCapacityIndex => _selectedCapacityIndex;

  void onListCapacitySelected(int? index) {
    _selectedCapacityIndex = index;
    _selectedCapacity = index != null ? _capacity[index].optionCode : null;
    print("$_selectedCapacity: selected Capacity ");
  }

//Save pole button
  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      }else{
        if(totalAccuracy!>15.0){
         showAlertDialog(context, "Please wait until we reach minimum GPS accuracy i.e 15.0 mts");
        }else{
          startListening();
          save11KVPole();
          print("in else block");
        }
      }
    }
  }


  Future<void> save11KVPole()async{
    _isLoading = isTrue;
    notifyListeners();

    if(args["p"]==false){

  }

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY, 
      "loadLatestDataOnly": true,
      "maxId": maxId,
      "fc": args["fc"],
      "ssc":args["ssc"],
      "fv": "11KV",
      "ssv": "33/11KV",
      "not":false,
      "origin": selectedPole=="Origin Pole"?"Origin Pole":"",
      "tap": selectedTappingPole=="Straight Tapping"?"s":selectedTappingPole=="Left Tapping"?"l":"r",
      "pt": selectedPoleType,
      "ph":selectedPoleHeight,
      "nockt": selectedCircuits,
      "formation":selectedFormation,
      "typeOfPoint": selectedTypePoint,
      "pid":"",// should send data when  p is true
      "polenum": poleNumber.text.trim(),
      "series": "",
      if (selectedPole == "" || selectedPole == null) ...{
        "sid": poleFeederID,
        "slat": poleLat,
        "slon": poleLon,
      },
      "cross": selectedCrossings,
      "connLoad": selectedConnected=="No Load"?"N":"DTR",
    if (selectedConnected=="DTR") ...{

      "structCode": dtrStructure.text,
      "cap": selectedCapacity,
      "cs": selectedConductor,
      "lat": latitude,
      "lon": longitude,
    }

    };

    final payload = {
      "path": "/save11KvDigitalFeederPoleForExistingFeeder",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);


    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                List<dynamic> jsonList;
                if (response.data['objectJson'] is String) {
                  jsonList = jsonDecode(response.data['objectJson']);
                } else if (response.data['objectJson'] is List) {
                  jsonList = response.data['objectJson'];
                } else {
                  jsonList = [];
                }
                // final List<DocketEntity> objectJson = jsonList.map((json) =>
                //     DocketEntity.fromJson(json)).toList();
                // docketList.addAll(objectJson);
                print("data added in docketList");
                notifyListeners();
              } else {
                showAlertDialog(context, "Unable to process your request!");
              }
            } else {
              showAlertDialog(context,
                  "There are no existing Proposals under the selected Substation");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        }
      }else{
        showAlertDialog(context, "Error connecting to the server, Please try after sometime");
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(context, "An error occurred. Please try again.");
      });
      rethrow;
    }finally{
      _isLoading=false;
      notifyListeners();
    }

    notifyListeners();
  }
  bool validateForm() {
    if ((selectedPole == "" || selectedPole == null)&&poleFeederSelected=="") {
      AlertUtils.showSnackBar(
          context, "Please select the source pole to the current pole", isTrue);
      return false;
    } else if (poleNumber.text == "" && selectedPole=="") {
      AlertUtils.showSnackBar(
          context, "Please enter Pole Number",
          isTrue);
      return false;
    } else if ( selectedTappingPole== ""||selectedTappingPole==null) {
      AlertUtils.showSnackBar(
          context, "Please select tapping type from previous pole to current pole",
          isTrue);
      return false;
    }
   else if (selectedFirstGroup.isEmpty&& selectedSecondGroup.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please select the  Pole Type",
          isTrue);
      return false;
    }else if (_selectedPoleHeight== "" || _selectedPoleHeight==null) {
      AlertUtils.showSnackBar(
          context, "Please select the Pole Height",
          isTrue);
      return false;
    }else if (selectedCircuits== "" || selectedCircuits==null) {
      AlertUtils.showSnackBar(
          context, "Please select the no.of circuits on the current pole",
          isTrue);
      return false;
    }else if (selectedFormation== "" || selectedFormation==null) {
      AlertUtils.showSnackBar(
          context, "Please select the formation type on pole",
          isTrue);
      return false;
    }else if (selectedTypePoint== "" || selectedTypePoint==null) {
      AlertUtils.showSnackBar(
          context, "Please select the type of point (Cut Point/End Point/Pin Point)",
          isTrue);
      return false;
    }else if (selectedCrossings.isEmpty||selectedCrossings==null) {
      AlertUtils.showSnackBar(
          context, "Please select any crossing",
          isTrue);
      return false;
    }else if (selectedConnected== ""|| selectedConnected==null) {
      AlertUtils.showSnackBar(
          context, "Please select the any load connected on the current pole",
          isTrue);
      return false;
    }//DTR
   else if (selectedConnected=="DTR"&&(dtrStructure.text== "" || dtrStructure.text==null)) {
      AlertUtils.showSnackBar(
          context, "Please enter the DTR Structure code ",
          isTrue);
      return false;
    }else if (selectedConnected=="DTR"&&(selectedCapacity== "" || selectedCapacity==null)) {
      AlertUtils.showSnackBar(
          context, "Please select the DTR capacity",
          isTrue);
      return false;
    }else if (_selectedConductor == ""|| _selectedConductor ==null) {
      AlertUtils.showSnackBar(
          context, "Please select the conductor size from previous pole to this pole",
          isTrue);
      return false;
    }
   else if ((latitude== ""&&longitude=="") || (latitude== null&&longitude==null)) { //location
      AlertUtils.showSnackBar(
          context, "Please wait until we capture your location",
          isTrue);
      return false;
    }
    return true;
  }

  //For
//Accuracy: 18.9 <-this should be less than 15
// lat:17.4445931
//   log: 78.3844044
//please wait until we reach ,minimum gps accuracy i.e.,15 mts


}