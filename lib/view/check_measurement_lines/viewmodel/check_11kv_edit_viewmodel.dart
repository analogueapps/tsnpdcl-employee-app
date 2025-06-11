

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/docket_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';
import 'package:tsnpdcl_employee/view/rfss/database/mapping_agl_db/agl_databases/structure_code_db.dart';

import '../model/structure_capacity_model.dart';

class Check11kvEditViewmodel extends ChangeNotifier {
  Check11kvEditViewmodel({required this.context, required this.args}) {
    startListening();
    _initializeCameraPosition();
    loadStructureCodes();
    getPolesOnFeeder();
  }
  final BuildContext context;
  final Map<String, dynamic> args;
  final formKey = GlobalKey<FormState>();
  bool serverCheck = false;

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  bool deleteOrEdit= isFalse;
  final TextEditingController poleNumber = TextEditingController();
  final TextEditingController particularsOfCrossing = TextEditingController();
  final TextEditingController remarks = TextEditingController();
  String? series, poleNum;
  DocketEntity? docketEntity;

  double? latitude;
  double? longitude;
  double? totalAccuracy;
  bool distanceDisplay = false;
  double? distanceBtnPoles;
  double MINIMUM_GPS_ACCURACY_REQUIRED = 15.0;

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

        if (poleID != null) {
          distanceDisplay = isTrue;
          distanceBtnPoles = calculateDistance(
              latitude!, longitude!,
              double.parse(poleLat!),
              double.parse(poleLon!)
          );
          print("distanceBtnPoles: $distanceBtnPoles");
          notifyListeners();
        } else {
          distanceDisplay = false;
          notifyListeners();
        }
    });
  }

  final LatLng _currentLocation = const LatLng(17.387140, 78.491684);
  CameraPosition? _cameraPosition;

  LatLng get currentLocation => _currentLocation;

  // Update to nullable getter and setter
  CameraPosition? get cameraPosition => _cameraPosition;

  set cameraPosition(CameraPosition? position) {
    _cameraPosition = position;
    notifyListeners();
  }

  LatLng? markerPosition;
  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  set mapController(GoogleMapController? controller) {
    _mapController = controller;
    notifyListeners();
  }

  Set<Polyline> polylines = {};
  Set<Marker> markers = {};

  bool showPoles = true;
  void _initializeCameraPosition() {
    // _bitmapDescriptorFromAsset(Assets.);
    _cameraPosition = CameraPosition(
      target: _currentLocation,
      zoom: 14.0,
    );
    notifyListeners();
  }

  Future<void> processMapData() async {
    if (poleFeederList.isEmpty) return;
    for (int i = 0; i < poleFeederList.length; i++) {
      final entity = poleFeederList[i];

      if (entity.sourceLat != null && entity.sourceLon != null) {
        final polyline = Polyline(
          polylineId: PolylineId('polyline_$i'),
          points: [
            LatLng(double.parse(entity.sourceLat!), double.parse(entity.sourceLon!)),
            LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
          ],
          width: 4,
          color: entity.tempSeries != null ? Colors.blue : entity.newProposalId != null ? Colors.red : Colors.black,
        );
        polylines.add(polyline);

        if (showPoles) {
          // double distance = _calculateDistance(
          //   double.parse(entity.sourceLat!),
          //   double.parse(entity.sourceLon!),
          //   double.parse(entity.lat!),
          //   double.parse(entity.lon!),
          // );
          double distance = Geolocator.distanceBetween(
            double.parse(entity.sourceLat!),
            double.parse(entity.sourceLon!),
            double.parse(entity.lat!),
            double.parse(entity.lon!),
          );
          final midpoint = _calculateMidpoint(
            double.parse(entity.sourceLat!),
            double.parse(entity.sourceLon!),
            double.parse(entity.lat!),
            double.parse(entity.lon!),
          );
          _addTextMarker('${distance.toStringAsFixed(1)}m', midpoint);
        }
      }

      if (showPoles) {
        addMarkerWithEntity(entity);
      }

        _addSpecialMarkers(entity);
      if (i == poleFeederList.length - 1) {
        _cameraPosition = CameraPosition(
          target: LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
          zoom: 14.0,
        );
        notifyListeners();

        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
            20.0,
          ),
        );
      }
    }
    notifyListeners();
  }


  Future<void> _addSpecialMarkers(PoleFeederEntity entity) async {
    if (entity.sourceType?.toLowerCase() == 'ss') {
      markers.add(Marker(
        markerId: MarkerId('sourceType_${entity.id}'),
        position: LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
        icon: entity.feederVolt == "33KV" ? await _bitmapDescriptorFromAsset(Assets.ss132Kv) : await _bitmapDescriptorFromAsset(Assets.ss33Kv),
      ));
    }

    if (entity.loadType != null) {
      switch (entity.loadType!.toLowerCase()) {
        case 'ss':
          markers.add(Marker(
            markerId: MarkerId('loadType_ss_${entity.id}'),
            position: LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
            icon: await _bitmapDescriptorFromAsset(Assets.ss33Kv),
          ));
          break;
        case 'dtr':
          markers.add(Marker(
            markerId: MarkerId('loadType_dtr_${entity.id}'),
            position: LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
            icon: await _bitmapDescriptorFromAsset(Assets.dtr),
          ));
          break;
        case 'ht':
          markers.add(Marker(
            markerId: MarkerId('loadType_ht_${entity.id}'),
            position: LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
            icon: await _bitmapDescriptorFromAsset(Assets.htService),
          ));
          break;
      }
    }
  }

  Future<void> _addTextMarker(String text, LatLng position) async {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 25, // Adjust font size
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromPoints(
        const Offset(0, 0),
        Offset(textPainter.width, textPainter.height),
      ),
    );

    // Center the text
    textPainter.paint(canvas, Offset(0, 0)); // Adjust if necessary

    final picture = recorder.endRecording();
    final img = await picture.toImage(
      textPainter.width.toInt(),
      textPainter.height.toInt(),
    );

    final ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      final Uint8List uint8List = byteData.buffer.asUint8List();
      final bitmapDescriptor = BitmapDescriptor.fromBytes(uint8List);

      markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          icon: bitmapDescriptor,
        ),
      );
      notifyListeners();
    } else {
      print("Error converting image to ByteData");
    }
  }

  LatLng _calculateMidpoint(double lat1, double lon1, double lat2, double lon2) {
    double midLat = (lat1 + lat2) / 2;
    double midLon = (lon1 + lon2) / 2;
    return LatLng(midLat, midLon);
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromAsset(String path) async {
    try {
      final Uint8List data = await _getBytesFromAsset(path, 50);
      print("Loaded bitmap from asset: $path, size: ${data.length}");
      return BitmapDescriptor.fromBytes(data);
    } catch (e) {
      print("Failed to load bitmap: $e");
      rethrow;
    }
  }


  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData byteData = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    final Uint8List resizedData = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    return resizedData;
  }

  // Optimize for better map rendering performance
  Future<void> moveCameraToLastPosition() async {
    if (poleFeederList.isNotEmpty) {
      final lastItem = poleFeederList.last;
      final lat = double.parse(lastItem.lat!);
      final lon = double.parse(lastItem.lon!);

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, lon), 20.0),
      );
    }
  }

  Map<MarkerId, PoleFeederEntity> markerEntityMap = {};

  void addMarkerWithEntity(PoleFeederEntity entity) async {
    final markerId = MarkerId(entity.poleNum ?? UniqueKey().toString());
    final marker = Marker(
      markerId: markerId,
      position: LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
      icon: await _bitmapDescriptorFromAsset(Assets.horizontalPole),
      onTap: () {
        onClickOfMap(entity);
        print(" Entity object is: $entity");
      },
    );

    markers.add(marker);
    markerEntityMap[markerId] = entity;
    notifyListeners();
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


  void onClickOfMap(PoleFeederEntity entity){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "What would you like to do?",
          ),
          actions: [
            TextButton(
                onPressed: () {
                Navigator.pop(context);
                deletePoleDialog();
                },
                child: const Text("DELETE")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deleteOrEdit=isTrue;
                notifyListeners();
                showAlertDialog(context,
                    "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
              },
              child: const Text("EDIT THIS POLE DATA"),
            ),
            TextButton(
              onPressed: (){ Navigator.pop(context);},
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }

  void deletePoleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Pole?"),
          content:  const Text(
            "Delete 0000 pole? \n You can revert this action!",
          ),
          actions: [
            TextButton(
                onPressed: () {
                  // should implement deletePole();  api here
                },
                child: const Text("DELETE")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
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
                processMapData();
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

  Future<void> deletePole() async {

    _isLoading = isTrue;

    final requestData = {
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "poleId":"", // from map
      "ssc": args["ssc"],
      "fc": args["fc"],
    };

    final payload = {
      "path": "/undoPole",
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
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                ////////<- Should Implement ->////////
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

  String? _selectedPole;

  String? get selectedPole => _selectedPole;

  void showPoleFeederDropdown() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<PoleFeederEntity> filteredList = List.from(poleFeederList);
        String searchQuery = '';

        return StatefulBuilder(
          builder: (context, setState) {
            void filterList(String query) {
              setState(() {
                searchQuery = query;
                filteredList = poleFeederList.where((item) {
                  final displayText =
                  (item.tempSeries != null && item.tempSeries!.isNotEmpty
                      ? '${item.tempSeries}-${item.poleNum}'
                      : item.poleNum ?? '')
                      .toLowerCase();
                  return displayText.contains(query.toLowerCase());
                }).toList();
              });
            }

            return AlertDialog(
              title: const Text('Select Pole Feeder'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search pole feeder...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: filterList,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        final displayText = item.tempSeries != null &&
                            item.tempSeries!.isNotEmpty
                            ? '${item.tempSeries}-${item.poleNum}'
                            : item.poleNum ?? '';

                        return ListTile(
                          title: Text(displayText),
                          selected: item == selectedPoleFeeder,
                          selectedTileColor: Colors.blue.shade50,
                          onTap: () {
                            Navigator.pop(context);
                            onListPoleFeederChange(
                                item); // 🔥 Ensure you pass the correct `item`
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void setSelectedPole(String title) {
    _selectedPole = title;
    if (_selectedPole == "Origin Pole") {
      series = null;
      poleNum = args["fn"].substring(0, 3) + "001";
      print("PoleNum: $poleNum");
    }
    print("$_selectedPole: filter selected");
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
    if(selectedTappingPole=="Is Extension Pole?"){
      poleNumber.text = (series != null ? "$series-$poleNum (EP)" : "$poleNum(EP)" )!;
    }
    poleNumber.text = (series != null ? "$series-$poleNum" : poleNum)!;
  }


  //Tapping from previous pole
  String? _selectedTappingPole;

  String? get selectedTappingPole => _selectedTappingPole;

  void setSelectedTappingPole(String title) {
    _selectedTappingPole = title;
    notifyListeners();
    print("$_selectedTappingPole:  tap selected");
if(_selectedTappingPole!=null && _selectedTappingPole!.isNotEmpty){
  generatePoleNum(serverCheck);
}
  }

  //Is Extension Pole
String? isExtensionSelected;

  void setSelectedExtension(String value) {
    isExtensionSelected = value;
    notifyListeners();
    print("$isExtensionSelected:  tap selected");
    //Is Extension Pole?:  tap selected
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


  //Pole Height
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

  //No.of Circuits on pole
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

  //Connected Load
  String? _selectedConnected;

  String? get selectedConnected => _selectedConnected;

  void setSelectedConnected(String title) {
    _selectedConnected = title;
    print("$_selectedConnected: Connected  selected");
    notifyListeners();
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

  List<String> selectedPoleStatus = [];

  void setSelectedPoleStatus(String title) {

      if (selectedPoleStatus.contains(title)) {
        selectedPoleStatus.remove(title);
      } else {
        selectedPoleStatus.add(title);
      }
      print("setSelectedPoleStatus: $selectedPoleStatus");
    notifyListeners();
  }

  String buildCrossingString() {
    if (selectedCrossings.contains("None")) {
      return "None";
    }

    return selectedCrossings.join('|');
  }

  //select structure code
  List<Option> structureCodes = [];
  Option? selectedCode;
  String? selectedCapacity;



  Future<void> loadStructureCodes() async {
    final structures = await StructureDatabaseHelper.instance.getAllStructures();
    structureCodes = structures
        .where((e) => e.structureCode != null && e.capacity != null)
        .map((e) => Option(
      code: e.structureCode!,
      capacity: e.capacity!,
    ))
        .toList();
    print("Done loading data from DB Structure");

  }

  void setSelectedDtr(Option title) {
    selectedCode = title;
    print("${selectedCode?.code}: selectedCode");
    print("${selectedCode?.capacity}: selectedCode capacity");
    notifyListeners();
  }




  String? _selectedConductor;

  String? get selectedConductor => _selectedConductor;

  void setSelectedConductor(String title) {
    _selectedConductor = title;
    print("$_selectedConductor : Conductor   selected");
    notifyListeners();
  }

  String? abCableSelected;
  void setSelectedabCable(String title) {
    abCableSelected = title;
    print("$abCableSelected : abCableSelected   selected");
    notifyListeners();
  }

  //Conductor Status
  List<String> selectedConductorStatus = [];

  void setSelectedConductorStatus(String title) {

    if (selectedConductorStatus.contains(title)) {
      selectedConductorStatus.remove(title);
    } else {
      selectedConductorStatus.add(title);
    }
    print("selectedConductorStatus: $selectedConductorStatus");
    notifyListeners();
  }

  //Stud/Stay Required
  List<String> selectedStudStayRequired = [];

  void setSelectedStudStayRequired(String title) {

    if (selectedStudStayRequired.contains(title)) {
      selectedStudStayRequired.remove(title);
    } else {
      selectedStudStayRequired.add(title);
    }
    print("selectedStudStayRequired: $selectedStudStayRequired");
    notifyListeners();
  }

  //Middle Poles Required
  List<String> selectedMiddlePolesRequired = [];

  void setSelectedMiddlePolesRequired(String title) {

    if (selectedMiddlePolesRequired.contains(title)) {
      selectedMiddlePolesRequired.remove(title);
    } else {
      selectedMiddlePolesRequired.add(title);
    }
    print("selectedMiddlePolesRequired: $selectedMiddlePolesRequired");
    notifyListeners();
  }

  //Cross Arm Status
  List<String> selectedCrossArmStatus = [];

  void setSelectedCrossArmStatus(String title) {

    if (selectedCrossArmStatus.contains(title)) {
      selectedCrossArmStatus.remove(title);
    } else {
      selectedCrossArmStatus.add(title);
    }
    print("selectedConductorStatus: $selectedCrossArmStatus");
    notifyListeners();
  }

  //Insulators/Discs
  List<String> insulatorDiscType = ["Select","Discs","Insulators"];
  String? selectedInsulatorDiscType;

  void onListInsulatorDiscType(String? value) {
    if (insulatorDiscType.contains(value)) {
      selectedInsulatorDiscType = value;
      notifyListeners();
      print("selectedInsulatorDiscType: $selectedInsulatorDiscQty");
    } else {
      print("Invalid value: $value");
    }
  }


  List<String> insulatorDiscQty = ["Select",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",];
  String? selectedInsulatorDiscQty;

  void onListInsulatorDiscQty(String? value) {
    if (insulatorDiscQty.contains(value)) {
      selectedInsulatorDiscQty = value;
      notifyListeners();
      print("selectedInsulatorDiscQty: $selectedInsulatorDiscQty");
    } else {
      print("Invalid value: $value");
    }
  }


  //DTR Details
  //AB
  List<String> selectedABSwitch = [];

  void setSelectedABSwitch(String title) {

    if (selectedABSwitch.contains(title)) {
      selectedABSwitch.remove(title);
    } else {
      selectedABSwitch.add(title);
    }
    print("selectedABSwitch: $selectedABSwitch");
    notifyListeners();
  }

  //LT
  List<String> selectedLTFuse = [];

  void setSelectedLTFuse(String title) {

    if (selectedLTFuse.contains(title)) {
      selectedLTFuse.remove(title);
    } else {
      selectedLTFuse.add(title);
    }
    print("selectedLTFuse: $selectedLTFuse");
    notifyListeners();
  }

  //HT
  List<String> selectedHTFuse = [];

  void setSelectedHTFuse(String title) {

    if (selectedHTFuse.contains(title)) {
      selectedHTFuse.remove(title);
    } else {
      selectedHTFuse.add(title);
    }
    print("selectedHTFuse: $selectedHTFuse");
    notifyListeners();
  }

  //DTR Plinth
  List<String> selectedDTRPlinth = [];

  void setSelectedDTRPlinth(String title) {

    if (selectedDTRPlinth.contains(title)) {
      selectedDTRPlinth.remove(title);
    } else {
      selectedDTRPlinth.add(title);
    }
    print("selectedDTRPlinth: $selectedDTRPlinth");
    notifyListeners();
  }

  //DTR Earthing
  List<String> selectedDTREarth = [];

  void setSelectedDTREarth(String title) {

    if (selectedDTREarth.contains(title)) {
      selectedDTREarth.remove(title);
    } else {
      selectedDTREarth.add(title);
    }
    print("selectedDTREarth: $selectedDTREarth");
    notifyListeners();
  }

  //Earth Pipe Status
  List<String> selectedEarthPipe = [];

  void setSelectedEarthPipe(String title) {

    if (selectedEarthPipe.contains(title)) {
      selectedEarthPipe.remove(title);
    } else {
      selectedEarthPipe.add(title);
    }
    print("selectedEarthPipe: $selectedEarthPipe");
    notifyListeners();
  }

  //Bi-metailc
  List<String> selectedBiMetalic = [];

  void setSelectedBiMetalic(String title) {

    if (selectedBiMetalic.contains(title)) {
      selectedBiMetalic.remove(title);
    } else {
      selectedBiMetalic.add(title);
    }
    print("selectedBiMetalic: $selectedBiMetalic");
    notifyListeners();
  }


  //Lightening Arrestors
  List<String> selectedLighteningArr = [];

  void setSelectedLighteningArr(String title) {

    if (selectedLighteningArr.contains(title)) {
      selectedLighteningArr.remove(title);
    } else {
      selectedLighteningArr.add(title);
    }
    print("selectedLighteningArr: $selectedLighteningArr");
    notifyListeners();
  }


  Future<void> submitCheck11KVForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      } else if (totalAccuracy! > 15.0) {
        showAlertDialog(context,
            "Please wait until we reach minimum GPS accuracy i.e 15.0 mts");
      } else {
        saveCheck11KVPole();
        print("in else block");
      }
    }
  }

  Future<void> saveCheck11KVPole() async {
    _isLoading = isTrue;
    notifyListeners();
    // PoleFeederEntity d= selectedDigitalPole;

    final requestData = {
      "loadLatestDataOnly": true,
      "maxId": "",//from map
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "fc": args["fc"],
      "ssc": args["ssc"],
      "fv": "11KV",
      "ssv": "33\\/11KV",
      "not": false,
      "origin": selectedPole == "Origin Pole" ? true : false,
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
      "polenum": poleNumber.text.isEmpty ? "0000" : poleNumber.text.trim(),
        "series": series,//null

      if (selectedPole == "" || selectedPole == null) ...{
        "sid": poleID,
        "slat": poleLat,
        "slon": poleLon,
      },
      "cross": buildCrossingString(),
      "connLoad": selectedConnected == "No Load" ? "N" : "DTR",
      if (selectedConnected == "DTR") ...{
        "structCode": selectedCode?.code,
        "cap": selectedCode?.capacity,
      },
      "cs": abCableSelected==""?selectedConductor:abCableSelected, //check this(bhav)
      "lat": poleLat,//d.getLat()
      "lon": poleLon,
      "digitalID":"", //d.getId()
    };

    print("requestData: $requestData");
    final payload = {
      "path": "/save11KvDigitalFeederPoleForExistingFeeder",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    print("payload: ${jsonEncode(payload)}");

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

    try {
      if (response != null) {
        Navigator.pop(context);
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
                    response.data["message"], //Missing mandatory params
                        () {
                      Navigator.pop(context);
                    },
                  );
                }
              } else {
                showAlertDialog(context, "Unable to process your request!");
              }
            } else {
              showAlertDialog(context,
                  response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,
              "Error connecting to the server, Please try after sometime");
        }
      }
    } catch (e) {
        showErrorDialog(context, "An error occurred. Please try again.");
      _isLoading = false;
      notifyListeners();
    }

    notifyListeners();
  }

  bool validateForm() {
    if (poleFeederSelected==null||poleFeederSelected=="") {
      AlertUtils.showSnackBar(context, "Please select previous pole number", isTrue);
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
    }else if (selectedCrossings.isEmpty || selectedCrossings == null) {
      AlertUtils.showSnackBar(context, "Please select any crossing", isTrue);
      return false;
    } else if (selectedConnected == "" || selectedConnected == null) {
      AlertUtils.showSnackBar(context,
          "Please select the any load connected on the current pole", isTrue);
      return false;
    }else if (selectedConnected == "DTR" &&( selectedCode == null||selectedCode=="")) {
      AlertUtils.showSnackBar(context,
          "Please select structure code", isTrue);
      return false;
    } else if (_selectedConductor == "" || _selectedConductor == null) {
      AlertUtils.showSnackBar(
          context,
          "Please select the conductor size from previous pole to this pole",
          isTrue);
      return false;
    }
    else if ((latitude == "" && longitude == "") ||
        (latitude == null && longitude == null)) {
      AlertUtils.showSnackBar(
          context, "Please wait until we capture your location. Please make sure you have turned on your location", isTrue);
      return false;
    }
    return true;
  }


}

