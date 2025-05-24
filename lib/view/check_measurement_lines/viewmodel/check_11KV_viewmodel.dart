import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/check_measure_11kv_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/docket_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';
import '../../dtr_master/model/circle_model.dart';

class Check11kvViewmodel extends ChangeNotifier {
  Check11kvViewmodel({required this.context, required this.args}) {
    startListening();
    getPolesOnFeeder();
    final String? jsonString = args['d'];
    print("argument d data: ${args['d']}");

    if (args['p'] == isTrue) {
      docketEntity = DocketEntity.fromJson(jsonDecode(jsonString!));
      print("docketEntity ${docketEntity!.id}");
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  // Current View Context
  final formKey = GlobalKey<FormState>();

  final BuildContext context;
  final Map<String, dynamic> args;
  double MINIMUM_GPS_ACCURACY_REQUIRED = 15.0;
  String maxId = "9752778"; //From Map initially OL

  double? latitude;
  double? longitude;
  double? totalAccuracy;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  final TextEditingController poleNumber = TextEditingController();
  final TextEditingController subStationCapacity = TextEditingController();
  final TextEditingController particularsOfCrossing = TextEditingController();
  final TextEditingController structureCode = TextEditingController();
  final TextEditingController equipmentCode = TextEditingController();
  final TextEditingController dtrSlNo = TextEditingController();

  bool serverCheck = false;
  bool deviceCheck = false;
  String? series, poleNum;
  DocketEntity? docketEntity;

  bool _followSwitch = true;

  bool get followSwitch => _followSwitch;
  bool distanceDisplay = false;
  double? distanceBtnPoles;

  set followMe(bool value) {
    _followSwitch = value;
    notifyListeners();
  }

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

      // if (_selectedPole == "" || _selectedPole == null) {
      //   if (poleID != null) {
      //     distanceDisplay = isTrue;
      //     distanceBtnPoles = calculateDistance(
      //         latitude!, longitude!,
      //         double.parse(poleLat!),
      //         double.parse(poleLon!)
      //     );
      //     print("distanceBtnPoles: $distanceBtnPoles");
      //     notifyListeners();
      //   } else {
      //     distanceDisplay = false;
      //     notifyListeners();
      //   }
      // }
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


  //Tapping from previous pole
  String? _selectedTappingPole;

  String? get selectedTappingPole => _selectedTappingPole;

  void setSelectedTappingPole(String title) {
    _selectedTappingPole = title;
    print("$_selectedTappingPole:  tap selected");
    // if (selectedPole == "" ||
    //     _selectedPole == null||_selectedPole=='Source Pole Not Mapped' && selectedTappingPole != null) {
    //   showAlertDialog(context,
    //       "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
    // } else {
    //   if (selectedPole != "Origin Pole") {
    //     generatePoleNum(serverCheck);
    //   } else {
    //     AlertUtils.showSnackBar(context, "${args['fn']}001", isFalse);
    //   }
    //   notifyListeners();
    // }
  }

  //Any Crossings:
  List<String> selectedCrossings = [];

  void setSelectedCrossings(String title) {
    if (title == "None") {
      selectedCrossings = ["None"];
    } else {
      selectedCrossings.remove("None");

      if (selectedCrossings.contains(title)) {
        selectedCrossings.remove(title);
      } else {
        selectedCrossings.add(title);
      }
    }
    notifyListeners();
  }

  String buildCrossingString() {
    if (selectedCrossings.contains("None")) {
      return "None";
    }

    return selectedCrossings.join('|');
  }

  //Pole type
  List<String> selectedFirstGroup = [];
  List<String> selectedSecondGroup = [];

  void toggleFirstGroup(String val) {
    if (selectedSecondGroup.length == 2) {
      selectedSecondGroup.removeLast();
    }

    if (selectedFirstGroup.contains(val)) {
      selectedFirstGroup.remove(val);
    } else {
      selectedFirstGroup = [val];
    }
    print("selectedFirstGroup $selectedFirstGroup");

    notifyListeners();
  }

  void toggleSecondGroup(String val) {
    bool wasCol1Selected = selectedFirstGroup.isNotEmpty;

    if (selectedSecondGroup.contains(val)) {
      selectedSecondGroup.remove(val);
    } else {
      if (wasCol1Selected) {
        selectedFirstGroup.clear();
      }

      final limit = 2;

      if (selectedSecondGroup.length < limit) {
        selectedSecondGroup.add(val);
      } else {
        selectedSecondGroup.removeAt(0);
        selectedSecondGroup.add(val);
      }
    }
    print("selectedSecondGroup: $selectedSecondGroup");
    notifyListeners();
  }

  bool get isSecondGroupEnabled => true;

  //pole height
  List<String> poleHeightData = [
    "8.0 Mtr. Pole ",
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
    _selectedCircuits = title;
    print("$_selectedCircuits: Circuits selected");
    notifyListeners();
  }

  //Formation
  String? _selectedFormation;

  String? get selectedFormation => _selectedFormation;

  void setSelectedFormation(String title) {
    _selectedFormation = title;
    print("$_selectedFormation: Formation selected");
    notifyListeners();
  }

  //Type of point
  String? _selectedTypePoint;

  String? get selectedTypePoint => _selectedTypePoint;

  void setSelectedTypePoint(String title) {
    _selectedTypePoint = title;
    print("$_selectedTypePoint: TypePoint selected");
    notifyListeners();
  }

  //Pole Details
  List<String> poleDetailsName = [
    "V Cross Arm ",
    "Horiz. Cross Arm",
    "Channet Cross Arm",
    "Side Arm",
  ];
  String? _selectedPoleDetailsName;
  String? get selectedPoleDetailsName => _selectedPoleDetailsName;

  void setSelectedPoleDetailName(String qty) {
    if (_selectedPoleDetailsName == qty) {
      _selectedPoleDetailsName = null; // Unselect if tapped again
    } else {
      _selectedPoleDetailsName = qty;
    }
    print("selectedPoleDetailsName: $_selectedPoleDetailsName");
    notifyListeners();
  }



  List<int> poleQty=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];

  String? selectedPoleQty;

  void updatePoleQtyForItem(String? newValue, int index) {
    if (newValue != null) {
      _poleItems[index].selectedQty = int.tryParse(newValue);
      print("_poleItems[index].selectedQty: ${_poleItems[index].selectedQty}");
      notifyListeners();
    }
  }

  final List<PoleItem> _poleItems = [
    PoleItem(title: "V Cross Arm"),
    PoleItem(title: "Horiz. Cross Arm"),
    PoleItem(title: "Channet Cross Arm"),
    PoleItem(title: "Side Arm"),
  ];

  List<PoleItem> get poleItems => _poleItems;
  void toggleSelection(int index) {
    _poleItems[index].isSelected = !_poleItems[index].isSelected;
    if (!_poleItems[index].isSelected) {
      _poleItems[index].selectedQty = null;
    }
    print("poleItems: ${poleItems.toString()}");
    notifyListeners();
    //poleItems: [PoleItem(title: V Cross Arm, isSelected: false, selectedQty: null), PoleItem(title: Horiz. Cross Arm, isSelected: false, selectedQty: null), PoleItem(title: Channet Cross Arm, isSelected: true, selectedQty: 11), PoleItem(title: Side Arm, isSelected: false, selectedQty: null)]
  }

  //Insulators:
  final List<PoleItem> _poleInsulators = [
    PoleItem(title: "Pin Insulators"),
    PoleItem(title: "Disc"),
    PoleItem(title: "Shackles"),
  ];

  List<PoleItem> get poleInsulators => _poleInsulators;
  void toggleInsulators(int index) {
    _poleInsulators[index].isSelected = !_poleInsulators[index].isSelected;
    if (!_poleInsulators[index].isSelected) {
      _poleInsulators[index].selectedQty = null;
    }
    print("poleInsulators: ${poleInsulators.toString()}");
    notifyListeners();
    //poleItems: [PoleItem(title: V Cross Arm, isSelected: false, selectedQty: null), PoleItem(title: Horiz. Cross Arm, isSelected: false, selectedQty: null), PoleItem(title: Channet Cross Arm, isSelected: true, selectedQty: 11), PoleItem(title: Side Arm, isSelected: false, selectedQty: null)]
  }

  void updatePoleInsulators(String? newValue, int index) {
    if (newValue != null) {
      _poleInsulators[index].selectedQty = int.tryParse(newValue);
      print("PoleInsulators[index].selectedQty: ${_poleInsulators[index].selectedQty}");
      notifyListeners();
    }
  }

  //Support Type
  final List<PoleItem> _poleSupport = [
    PoleItem(title: "Stud Pole"),
    PoleItem(title: "Stay set"),
  ];

  List<PoleItem> get poleSupport => _poleSupport;
  void toggleSupport(int index) {
    _poleSupport[index].isSelected = !_poleSupport[index].isSelected;
    if (!_poleSupport[index].isSelected) {
      _poleSupport[index].selectedQty = null;
    }
    print("poleSupport: ${poleSupport.toString()}");
    notifyListeners();
    //poleItems: [PoleItem(title: V Cross Arm, isSelected: false, selectedQty: null), PoleItem(title: Horiz. Cross Arm, isSelected: false, selectedQty: null), PoleItem(title: Channet Cross Arm, isSelected: true, selectedQty: 11), PoleItem(title: Side Arm, isSelected: false, selectedQty: null)]
  }

  void updatePoleSupport(String? newValue, int index) {
    if (newValue != null) {
      _poleSupport[index].selectedQty = int.tryParse(newValue);
      print("poleSupport[index].selectedQty: ${_poleSupport[index].selectedQty}");
      notifyListeners();
    }
  }

  //Connected Load
  String? _selectedConnected;

  String? get selectedConnected => _selectedConnected;

  void setSelectedConnected(String title) {
    _selectedConnected = title;
    print("$_selectedConnected: Connected  selected");
    notifyListeners();
  }

  //Support Material
  List<int> supportQty=[0,1,2,3,4,];
  String? smSelected;

  void updateSupportQty(String? newValue, String?  title) {
    if (newValue != null) {
      smSelected=newValue;

      print("smSelected: $smSelected");
      notifyListeners();
    }
  }

//Conductor Size
  String? _selectedConductor;

  String? get selectedConductor => _selectedConductor;

  void setSelectedConductor(String title) {
    _selectedConductor = title;
    print("$_selectedConductor : Conductor   selected");
    notifyListeners();
  }

  List<PoleFeederEntity> poleFeederList = [];
  String? poleFeederSelected;
  String? poleID;
  String? poleLat;
  String? poleLon;
  PoleFeederEntity? selectedPoleFeeder;

  void onListPoleFeederChange(PoleFeederEntity? value) {
    selectedPoleFeeder = value;
    if (value != null) {
      poleFeederSelected = value.poleNum ?? "";
      poleID = value.id.toString() ?? "";
      poleLat = value.lat.toString() ?? "";
      poleLon = value.lon.toString() ?? "";
      AlertUtils.showSnackBar(context, poleFeederSelected! , isFalse);

      print("POle Num: $poleFeederSelected");
      print("Pole ID: $poleID");
    }
    notifyListeners();
  }

  Future<void> getPolesOnFeeder() async {
    poleFeederList.clear();
    poleFeederSelected = null;
    notifyListeners();

    _isLoading = isTrue;

    final requestData = {
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ssc": args["ssc"],
      "fc": args["fc"],
    };

    final payload = {
      "path": "/getPolesOnFeeder",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
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
                final List<dynamic> jsonList =
                jsonDecode(response.data['objectJson']);
                final List<PoleFeederEntity> listData = jsonList
                    .map((json) => PoleFeederEntity.fromJson(json))
                    .toList();
                poleFeederList.addAll(listData);
              } else {
                showAlertDialog(context, "No Data Found");
              }
            } else {
              showAlertDialog(context,
                  "There is no existing Proposal under the selected substation");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  List<PoleFeederEntity> generatedPoleList = [];
  String? generatedPoleSelected;

  Future<void> generatePoleNum(bool isServer) async {
    generatedPoleList.clear();
    generatedPoleSelected = null;
    notifyListeners();

    _isLoading = isTrue;

    if (isServer) {
      print("generatePoleNum if");

      final requestData = {
        "authToken":
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "ssc": args["ssc"],
        "fc": args["fc"],
        "not": false,
        "tap": selectedTappingPole == "Straight Tapping"
            ? "s"
            : selectedTappingPole == "Left Tapping"
            ? "l"
            : "r",
        "sid": poleID,
      };

      final payload = {
        "path": "/getNewPoleNum",
        "apiVersion": "1.0.1",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
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
                  final objectJson = response.data['objectJson'];

                  List<dynamic> list = jsonDecode(objectJson);

                  if (list.isNotEmpty && list.length >= 2) {
                    series = list[0];
                    poleNum = list[1];

                    setPoleNum();
                  }
                } else {
                  showAlertDialog(context, "No Data Found");
                }
              } else {
                showAlertDialog(context,
                    "There is no existing Proposal under the selected substation");
              }
            } else {
              showSessionExpiredDialog(context);
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        }
      } catch (e) {
        showErrorDialog(context, "An error occurred. Please try again.");
        rethrow;
      }
    } else {
      _isLoading = isFalse;
      print("generatePoleNum else");
      series = args["fn"]
          .substring(0, args["fn"].length < 3 ? args["fn"].length : 3);
      poleNum = (poleFeederList.length + 1).toString();
      print("generate series: $series");
      notifyListeners();
      AlertUtils.showSnackBar(
          context, "Generated with on device logic", isFalse);
    }

    notifyListeners();
  }

  void setPoleNum() {
    poleNumber.text = (series != null ? "$series-$poleNum" : poleNum)!;
  }

  String? _selectedCapacity;

  String? get selectedCapacity => _selectedCapacity;

  final List<SubstationModel> _capacity = [
    SubstationModel(optionCode: "0", optionName: "SELECT"),
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

  //NOT USED
  bool isHTServiceChecked = false;
  List<String> circles = [
    "KHAMMAM", "HANAMKONDA", "KARIMNAGAR", "NIZAMABAD",
    "ADILABAD", "KOTHAGUDEM", "WARANGAL", "JANGAON",
    "BHUPALPALLY", "MAHABUBABAD", "JAGITYAL", "PEDDAPALLY",
    "KAMAREDDY", "NIRMAL", "ASIFABAD", "MANCHERIAL"
  ];

  void showCircleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Circle'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: circles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(circles[index]),
                  onTap: () {
                    Navigator.of(context).pop();
                    loadHTServices((index + 1).toString());
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> loadHTServices(String cicleCode) async {

    _isLoading = isTrue;

    final requestData = {
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "cc": "",
    };

    final payload = {
      "path": "/getHTServicesOfCircle",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
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
                /////////////////////<- Didn't implemented in TSNPDCL CODE->//////////////////////////
              } else {
                showAlertDialog(context, "No  HT Services found!");
              }
            } else {
              showAlertDialog(context,
                  "There is no existing Proposal under the selected substation");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> submit33KVForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      } else if (totalAccuracy! > 15.0) {
        showAlertDialog(context,
            "Please wait until we reach minimum GPS accuracy i.e 15.0 mts");
      } else {
        save33KVPole();
        print("in else block");
      }
    }
  }
  Future<void> save33KVPole() async {
    _isLoading = isTrue;
    notifyListeners();

    final requestData = {
      "loadLatestDataOnly": true,
      "maxId": maxId, // from map
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "fc": args["fc"],
      "ssc": args["ssc"],
      "fv": "11KV",
      "ssv": "220\\/132KV\\/33KV",
      // "not": selectedPole == "Source Pole Not Mapped" ? true : false,
      // "origin": selectedPole == "Origin Pole" ? true : false,
      "tap": selectedTappingPole == "Straight Tapping"
          ? "s"
          : selectedTappingPole == "Left Tapping"
          ? "l"
          : "r",
      "pt": selectedSecondGroup.isNotEmpty
          ? selectedSecondGroup[0]
          : (selectedFirstGroup.isNotEmpty ? selectedFirstGroup[0] : null),
      "ph": selectedPoleHeight,
      "nockt": selectedCircuits,
      "formation": selectedFormation,
      "typeOfPoint": selectedTypePoint,
      "pid": docketEntity!.id,
      "polenum": poleNumber.text.isEmpty ? "0000" : poleNumber.text.trim(),
      // if (selectedPole != "Origin Pole") ...{
      //   "series": series,
      // },
      // if (selectedPole == "" || selectedPole == null) ...{
      //   "sid": poleID,
      //   "slat": poleLat,
      //   "slon": poleLon,
      // },
      "cross": buildCrossingString(),
      "connLoad": selectedConnected == "No Load" ? "N" : "NEW SS",
      "sscap":selectedConnected=="Sub Station"?subStationCapacity.text.trim():null,
      "cs": selectedConductor,
      "ss":"NA",
      "lat": "$latitude",
      "lon": "$longitude",
    };

    final payload = {
      "path": "/saveDigitalFeederPoleForExistingFeeder",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    print("payload: ${jsonEncode(payload)}");

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
                if (response.data["message"] != null) {
                  showSuccessDialog(
                    context,
                    response.data["message"],
                        () {
                      Navigator.pop(context);
                      resetForm();
                    },
                  );
                }
                List<dynamic> jsonList;
                if (response.data['objectJson'] is String) {
                  jsonList = jsonDecode(response.data['objectJson']);
                } else if (response.data['objectJson'] is List) {
                  jsonList = response.data['objectJson'];
                } else {
                  jsonList = [];
                }
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
      } else {
        showAlertDialog(context,
            "Error connecting to the server, Please try after sometime");
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(context, "An error occurred. Please try again.");
      });
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    notifyListeners();
  }

  bool validateForm() {
    // if ((selectedPole == "" || selectedPole == null) &&
    //     selectedPoleFeeder==null) {
    //   AlertUtils.showSnackBar(
    //       context, "Please select the source pole to the current pole", isTrue);
    //   return false;
    // } else

      if (poleNumber.text == "") {
      AlertUtils.showSnackBar(context, "Please enter Pole Number", isTrue);
      return false;
    } else if (selectedTappingPole == "" || selectedTappingPole == null) {
      AlertUtils.showSnackBar(
          context,
          "Please select tapping type from previous pole to current pole",
          isTrue);
      return false;
    } else if (selectedFirstGroup.isEmpty && selectedSecondGroup.isEmpty) {
      AlertUtils.showSnackBar(context, "Please select the  Pole Type", isTrue);
      return false;
    } else if (_selectedPoleHeight == "" || _selectedPoleHeight == null) {
      AlertUtils.showSnackBar(context, "Please select the Pole Height", isTrue);
      return false;
    } else if (selectedCircuits == "" || selectedCircuits == null) {
      AlertUtils.showSnackBar(context,
          "Please select the no.of circuits on the current pole", isTrue);
      return false;
    } else if (selectedFormation == "" || selectedFormation == null) {
      AlertUtils.showSnackBar(
          context, "Please select the formation type on pole", isTrue);
      return false;
    } else if (selectedTypePoint == "" || selectedTypePoint == null) {
      AlertUtils.showSnackBar(
          context,
          "Please select the type of point (Cut Point/End Point/Pin Point)",
          isTrue);
      return false;
    } else if (selectedCrossings.isEmpty || selectedCrossings == null) {
      AlertUtils.showSnackBar(context, "Please select any crossing", isTrue);
      return false;
    } else if (selectedConnected == "" || selectedConnected == null) {
      AlertUtils.showSnackBar(context,
          "Please select the any load connected on the current pole", isTrue);
      return false;
    } //DTR
      else if (selectedConnected == "DTR" &&
          (selectedCapacity == "" || selectedCapacity == null)) {
        AlertUtils.showSnackBar(
            context, "Please select the DTR capacity", isTrue);
        return false;
      } else if (_selectedConductor == "" || _selectedConductor == null) {
      AlertUtils.showSnackBar(
          context,
          "Please select the conductor size from previous pole to this pole",
          isTrue);
      return false;
    } else if ((latitude == "" && longitude == "") ||
        (latitude == null && longitude == null)) {
      //location
      AlertUtils.showSnackBar(
          context, "Please wait until we capture your location. Please make sure you have turned on your location", isTrue);
      return false;
    }
    return true;
  }

  void resetForm() {
    poleNumber.clear();
    _selectedTappingPole = null;
    selectedFirstGroup.clear();
    selectedSecondGroup.clear();
    _selectedPoleHeight="";
    _selectedCircuits="";
    _selectedFormation="";
    _selectedTypePoint="";
    selectedCrossings.clear();
    _selectedConnected="";
    subStationCapacity.clear();
    _selectedConductor="";
    longitude=null;
    latitude=null;
    notifyListeners();
  }

}