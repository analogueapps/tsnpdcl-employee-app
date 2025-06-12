import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/docket_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';
import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';

class Pole11kvFeederMarkViewmodel extends ChangeNotifier {
  Pole11kvFeederMarkViewmodel(
      {required this.context, required this.args}){
    startListening();
    _handleLocation();
    _initializeCameraPosition();
    getPolesOnFeeder();
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
  int maxId = 0;
  String get feederName => args['fn'];

  String get feederCode => args['fc'];

  String get ssc => args['ssc'];

  String get ssn => args['ssn'];


  double? latitude;
  double? longitude;
  double? totalAccuracy;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  final TextEditingController poleNumber = TextEditingController();
  final TextEditingController particularsOfCrossing = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  String empName=SharedPreferenceHelper.getStringValue(LoginSdkPrefs.empNameKey);
  String empDesignation=SharedPreferenceHelper.getStringValue(LoginSdkPrefs.designationCodeKey);
  PoleFeederEntity? poleData;

  List<int> undoStack = [];
  List<PoleFeederEntity> digitalFeederEntityList = [];
  final int UNDO_STACK_SIZE = 10;

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

  final LatLng _currentLocation = const LatLng(17.387140, 78.491684);
  CameraPosition? _cameraPosition;

  LatLng get currentLocation => _currentLocation;
  LatLng humanLocation= const LatLng(0, 0);

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

  Future<void> _addHumanMarker() async {
    final humanIcon = await _bitmapDescriptorFromAsset(Assets.human);
    markers.add(Marker(
      markerId:  MarkerId("$empName($empDesignation)"),
      position: humanLocation,
      icon: humanIcon,
      infoWindow: InfoWindow(
        title: '$empName ($empDesignation)',
      ),
    ));
  }

  Future<void> processMapData(bool drawHuman) async {
    if (poleFeederList.isEmpty) return;
    if(followSwitch && humanLocation!= null){
      await _addHumanMarker();
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: humanLocation, zoom: 18),
      ));
    }

    for (int i = 0; i < poleFeederList.length; i++) {
      final entity = poleFeederList[i];
      maxId=max(poleFeederList[i].id,maxId);
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

      if(!drawHuman){
        _addSpecialMarkers(entity);

      }
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
      textDirection: ui.TextDirection.ltr,

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
    final Uint8List data = await _getBytesFromAsset(path, 100);
    return BitmapDescriptor.fromBytes(data);
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
        // poleSelectedOnMap();
        _onMarkerTap(markerId, entity);
        poleData=entity;
      },
    );

    markers.add(marker);
    markerEntityMap[markerId] = entity;
    notifyListeners();
  }

  PoleFeederEntity? sourcePoleTag;
  void _onMarkerTap(MarkerId markerId, PoleFeederEntity entity) {
    final entity = markerEntityMap[markerId];
    print("markerEntityMap entity: $markerEntityMap");
    if (entity == null) return;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose Options'),
            actions: [
              TextButton(
                onPressed: () {
                  final poleText = entity.tempSeries != null
                      ? "${entity.tempSeries}-${entity.poleNum}"
                      : entity.poleNum;
                  poleFeederSelected = poleText ?? '';
                  print("selected Pole number is $poleText");
                  notifyListeners();
                  // If needed, store the entity as tag
                  sourcePoleTag = entity;

                  Navigator.pop(context);
                },
                child: const Text("Copy Pole Number?"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  var argument = {
                    'p': false,
                    'ssc': ssc,
                    'ssn': ssn,
                    'fc': feederCode,
                    'fn': feederName,
                    'digitalPoleId': entity.id,
                    'voltage': entity.voltage,
                    'scheduleId': 0,
                    // "dtrId":""
                  };
                  Navigation.instance.navigateTo(
                      Routes.pmiInspectionForm,
                      args: argument);
                },
                child: const Text("Enter PMI data"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  var argument = {
                    'p': false,
                    'ssc': ssc,
                    'ssn': ssn,
                    'fc': feederCode,
                    'fn': feederName,
                    'digitalPoleId': entity.id,
                    // "dtrId":""
                  };
                  Navigation.instance.navigateTo(
                      Routes.pmiList,
                      args: argument);
                },
                child: const Text("View PMI History of this Pole"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("CANCEL")),
            ],
          );
        }
          );
    }

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
    await startListening();

  }

  StreamSubscription<Position>? _positionStream;

  Future<void> startListening() async {
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
      humanLocation=  LatLng(latitude!, longitude!);
      notifyListeners();

      if (_selectedPole == "" || _selectedPole == null) {
        if (poleID != null) {
          distanceDisplay = isTrue;
          distanceBtnPoles = calculateDistance(latitude!, longitude!,
              double.parse(poleLat!), double.parse(poleLon!));
          print("distanceBtnPoles: $distanceBtnPoles");
          notifyListeners();
        } else {
          distanceDisplay = false;
          notifyListeners();
        }
      }
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

  Future<void> poleSelectedOnMap()async{
    // final entity = markerEntityMap[markerId];
    // print("markerEntityMap entity: $markerEntityMap");
    // if (entity == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Options'),
          actions: [
            TextButton(
              onPressed: () {
                // final poleText = entity.tempSeries != null
                //     ? "${entity.tempSeries}-${entity.poleNum}"
                //     : entity.poleNum;
                // poleFeederSelected = poleText ?? '';
                // print("selected Pole number is $poleText");
                // notifyListeners();
                // // If needed, store the entity as tag
                // sourcePoleTag = entity;

                Navigator.pop(context);
              },
              child: const Text("Copy Pole Number?"),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);

                var argument = {
                  'p': false,
                  'ssc': ssc,
                  'ssn':ssn,
                  'fc': feederCode,
                  'fn':feederName,
                  'digitalPoleId': "",
                  'voltage': "",
                  'scheduleId': 0,
                  // "dtrId":""
                };
                Navigation.instance.navigateTo(
                    Routes.pmiInspectionForm,
                    args: argument);
              },
              child: const Text("Enter PMI data"),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                var argument = {
                  'p': false,
                  'ssc': ssc,
                  'ssn': ssn,
                  'fc': feederCode,
                  'fn':feederName,
                  'digitalPoleId': "",
                  // "dtrId":""
                };
                Navigation.instance.navigateTo(
                    Routes.pmiList,
                    args: argument);
              },
              child: const Text("View PMI History of this Pole"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("CANCEL")),
          ],
        );
      },
    );
  }

//Pole selection
  String? _selectedPole;

  String? get selectedPole => _selectedPole;

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

  void selectMapOrList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text(
            "Sir/Madam, We have noticed that few officers are facing some difficulty while selecting Previous pole from the list, therefore here we are providing 2 ways to do that\n1. Select previous pole from the list of poles.\n2. Or just simply tap on the previous pole on the map",
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("CANCEL")),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close the dialog
                showPoleFeederDropdown(); // show dropdown in a new dialog
              },
              child: const Text("SELECT FROM LIST"),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                AlertUtils.showSnackBar(
                    context,
                    "Please tap the pole on the map",
                    isFalse);
              },
              child: const Text("SELECT ON MAP"),
            ),
          ],
        );
      },
    );
  }

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
  //Tapping from previous pole
  String? _selectedTappingPole;

  String? get selectedTappingPole => _selectedTappingPole;

  void setSelectedTappingPole(String title) {
    _selectedTappingPole = title;
    print("$_selectedTappingPole:  tap selected");
    if(selectedPole!="Origin Pole") {
      generatePoleNum(false);
    }
    if (_selectedTappingPole == "Left Tapping") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 300,
              child: Column(children: [
                const Text(
                  "Please be sure your field condition resemble to below show scenario for selecting",
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(Assets.check11KvLeft),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // if (selectedPole == "" ||
                    //     _selectedPole == null ||
                    //     _selectedPole == 'Source Pole Not Mapped' &&
                    //         selectedTappingPole != null) {
                    //   showAlertDialog(context,
                    //       "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
                    // }
                  },
                  child: const Text("OK")),
            ],
          );
        },
      );
    } else if (_selectedTappingPole == "Right Tapping") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 300,
              child: Column(children: [
                const Text(
                  "Please be sure your field condition resemble to below show scenario for selecting",
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(Assets.check11KvRight),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // if (selectedPole == "" ||
                    //     _selectedPole == null ||
                    //     _selectedPole == 'Source Pole Not Mapped' &&
                    //         selectedTappingPole != null) {
                    //   showAlertDialog(context,
                    //       "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
                    // }
                  },
                  child: Text("OK")),
            ],
          );
        },
      );
    } else {
      print("$_selectedTappingPole:  tap selected");
      if (selectedPole == "" ||
          _selectedPole == null ||
          _selectedPole == 'Source Pole Not Mapped' &&
              selectedTappingPole != null) {
        showAlertDialog(context,
            "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
      }
    }
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

  void toggleFirstGroup(String val) {
    val = val.trim();
    if (selectedFirstGroup.contains(val)) {
      selectedFirstGroup.remove(val);
    } else {
      selectedFirstGroup = [val];
    }
    print("selectedFirstGroup $selectedFirstGroup");

    notifyListeners();
  }


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
    listSubStationItem.clear();
    listSubStationSelect = null;
    _selectedConnected = title;
    print("$_selectedConnected: Connected  selected");
    notifyListeners();
  }

//Conductor Size
  String? _selectedConductor;
  String? get selectedConductor => _selectedConductor;

  void setSelectedConductor(String title) {
    _selectedConductor = title;
    print("$_selectedConductor : Conductor   selected");
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

  //cross arm status
  List<String> selectedCrossArmStatus = [];

  void setSelectedCrossArmStatus(String title) {

    if (selectedCrossArmStatus.contains(title)) {
      selectedCrossArmStatus.remove(title);
    } else {
      selectedCrossArmStatus.add(title);
    }
    print("selectedCrossArmStatus: $selectedCrossArmStatus");
    notifyListeners();
  }

  //Sub Station
  List<SpinnerList> listSubStationItem = [];
  String? listSubStationSelect;

  void onListSubStationItemSelect(String? selected) {
    listSubStationSelect = selected;
    notifyListeners();
  }

  Future<void> load33KvssList() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/load/ss",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                listSubStationItem.addAll(listData);
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
      rethrow;
    }

    notifyListeners();
  }

  //HT Serivce
  List<EroModel> htServiceList = [];
  String? selectedHtServiceName;
  void onHtServiceChange(String? htServiceName) {
    print('get the area name : $htServiceName');
    selectedHtServiceName = htServiceName;
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
      AlertUtils.showSnackBar(context, poleFeederSelected!, isFalse);

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
                processMapData(true);
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
      // poleNum = (poleFeederList.length + 1).toString();
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


  Future<void> submit33KVForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      }
      // else if (totalAccuracy! > 15.0) {
      //   showAlertDialog(context,
      //       "Please wait until we reach minimum GPS accuracy i.e 15.0 mts");
      // }
      else {
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
      "maxId": maxId,
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "fc": args["fc"],
      "ssc": args["ssc"],
      "fv": "33KV",
      "ssv": "220\\/132KV\\/33KV",
      "not": false,
      "origin": selectedPole == "Origin Pole" ? true : false,
      "tap": selectedTappingPole == "Straight Tapping"
          ? "s"
          : selectedTappingPole == "Left Tapping"
          ? "l"
          : "r",
      "pt": selectedFirstGroup.isNotEmpty ? selectedFirstGroup[0] : null,
      "ph": selectedPoleHeight,
      "nockt": selectedCircuits,
      "formation": selectedFormation,
      "typeOfPoint": selectedTypePoint,
      "crossingText":particularsOfCrossing.text.trim(),
      "polenum": poleNumber.text.isEmpty ? "0000" : poleNumber.text.trim(),
      "series": series,
      if (selectedPole == "" || selectedPole == null) ...{
        "sid": poleID,
        "slat": poleLat,
        "slon": poleLon,
      },
      "cross": buildCrossingString(),
      // "connLoad": selectedConnected == "No Load" ? "N" : selectedConnected=="HT Service"?"HT":"SS",
      "cs": selectedConductor,
      "ss": listSubStationSelect ?? "",
      "ht":selectedHtServiceName??"",
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
                List<dynamic> jsonList;
                if (response.data['objectJson'] is String) {
                  jsonList = jsonDecode(response.data['objectJson']);
                } else if (response.data['objectJson'] is List) {
                  jsonList = response.data['objectJson'];
                } else {
                  jsonList = [];
                }
                final List<PoleFeederEntity> listData = jsonList
                    .map((json) => PoleFeederEntity.fromJson(json))
                    .toList();
                int timeLapse = DateTime.now().millisecondsSinceEpoch;

                // Add all items to local list
                digitalFeederEntityList.addAll(listData);

                final now = DateTime.now();
                final formatter = DateFormat('dd MM yyyy hh:mm:ss.SSS');
                print("Done adding to local object: ${formatter.format(now)} "
                    "Time Lapse: ${DateTime.now().millisecondsSinceEpoch - timeLapse} msecs");

                timeLapse = DateTime.now().millisecondsSinceEpoch;

                if (digitalFeederEntityList.isNotEmpty) {
                  final lastItem = digitalFeederEntityList.last;

                  if (lastItem.createdBy == SharedPreferenceHelper.getStringValue(LoginSdkPrefs.userIdPrefKey) ){
                    if (undoStack.length > UNDO_STACK_SIZE) {
                      undoStack.removeLast();
                    }

                    undoStack.insert(0, lastItem.id);
                    print("undoStack: $undoStack");
                  }
                }
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

                print("data added in docketList");
                notifyListeners();
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
    if ((selectedPole == "" || selectedPole == null) &&
        selectedPoleFeeder == null) {
      AlertUtils.showSnackBar(
          context, "Please select the source pole to the current pole", isTrue);
      return false;
    } else if (poleNumber.text == "" ) {
      AlertUtils.showSnackBar(context, "Please enter Pole Number", isTrue);
      return false;
    } else if (selectedTappingPole == "" || selectedTappingPole == null) {
      AlertUtils.showSnackBar(
          context,
          "Please select tapping type from previous pole to current pole",
          isTrue);
      return false;
    } else if (selectedFirstGroup.isEmpty) {
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
    else if (selectedConnected == "Sub Station" &&
        (listSubStationSelect == "" || listSubStationSelect == null)) {
      AlertUtils.showSnackBar(
          context, "Please choose the SubStation ", isTrue);
      return false;
    } else if (selectedConnected == "HT Service" &&
        (selectedHtServiceName == "" || selectedHtServiceName == null)) {
      AlertUtils.showSnackBar(
          context, "Please choose the Service ", isTrue);
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
          context,
          "Please wait until we capture your location. Please make sure you have turned on your location",
          isTrue);
      return false;
    }
    return true;
  }

  void resetForm() {
    _selectedPole = "";
    poleNumber.clear();
    _selectedTappingPole = null;
    selectedFirstGroup.clear();
    _selectedPoleHeight = "";
    _selectedCircuits = "";
    _selectedFormation = "";
    _selectedTypePoint = "";
    selectedCrossings.clear();
    _selectedConnected = "";
    listSubStationSelect="";
    _selectedConductor = "";
    longitude = null;
    latitude = null;
    notifyListeners();
  }
}