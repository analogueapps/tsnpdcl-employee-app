import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/check_measure_11kv_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/docket_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';
import '../../dtr_master/model/circle_model.dart';

class Check33kvViewmodel extends ChangeNotifier {
  Check33kvViewmodel({required this.context, required this.args}) {
    _handleLocation();
    _initializeCameraPosition();
    getPolesOnFeeder();
    getSubStationList();

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
  String empName =
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.empNameKey);
  String empDesignation =
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.designationCodeKey);

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

  //check 33KV
  List<String> items = [
    "KHAMMAM",
    "HANAMKONDA",
    "KARIMNAGAR",
    "NIZAMABAD",
    "ADILABAD",
    "KOTHAGUDEM",
    "WARANGAL",
    "JANGAON",
    "BHUPALPALLY",
    "MAHABUBABAD",
    "JAGITYAL",
    "PEDDAPALLY",
    "KAMAREDDY",
    "NIRMAL",
    "ASIFABAD",
    "MANCHERIAL",
  ];

  set followMe(bool value) {
    _followSwitch = value;
    notifyListeners();
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

  Future<void> _addHumanMarker() async {
    final humanIcon = await _bitmapDescriptorFromAsset(Assets.human);
    print("employee name = $empName");
    markers.add(Marker(
      markerId: MarkerId("$empName($empDesignation)"),
      position: _currentLocation,
      icon: humanIcon,
      infoWindow: InfoWindow(
        title: '$empName ($empDesignation)',
      ),
    ));
  }

  Future<void> processMapData(bool drawHuman) async {
    if (poleFeederList.isEmpty) return;

    if (followSwitch) {
      await _addHumanMarker();

      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 18),
      ));
    }

    for (int i = 0; i < poleFeederList.length; i++) {
      final entity = poleFeederList[i];

      if (entity.sourceLat != null && entity.sourceLon != null) {
        final polyline = Polyline(
          polylineId: PolylineId('polyline_$i'),
          points: [
            LatLng(double.parse(entity.sourceLat!),
                double.parse(entity.sourceLon!)),
            LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
          ],
          width: 4,
          color: entity.tempSeries != null
              ? Colors.blue
              : entity.newProposalId != null
                  ? Colors.red
                  : Colors.black,
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

      // if (showPoles) {
      //   final marker = Marker(
      //     markerId: MarkerId('marker_$i'),
      //     position: LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
      //     icon: entity.poleType != null && entity.poleType!.toLowerCase().contains('tower')
      //         ? await _bitmapDescriptorFromAsset(Assets.towerPole)
      //         : await _bitmapDescriptorFromAsset(Assets.horizontalPole),
      //   );
      //   markers.add(marker);
      //   print("Added marker at: ${marker.position.latitude}, ${marker.position.longitude}");
      // }

      if (showPoles) {
        addMarkerWithEntity(entity);
      }
      if (!drawHuman) {
        _addSpecialMarkers(entity);
      }
      // check this once
      // if (i == poleFeederList.length - 1) {
      //
      //   _cameraPosition = CameraPosition(
      //     target: LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
      //     zoom: 14.0,
      //   );
      //   notifyListeners();
      //
      //   _mapController?.animateCamera(
      //     CameraUpdate.newLatLngZoom(
      //       LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
      //       20.0,
      //     ),
      //   );
      // }
    }
    notifyListeners();
  }

  Future<void> _addSpecialMarkers(PoleFeederEntity entity) async {
    if (entity.sourceType?.toLowerCase() == 'ss') {
      markers.add(Marker(
        markerId: MarkerId('sourceType_${entity.id}'),
        position: LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
        icon: entity.feederVolt == "33KV"
            ? await _bitmapDescriptorFromAsset(Assets.ss132Kv)
            : await _bitmapDescriptorFromAsset(Assets.ss33Kv),
      ));
    }

    if (entity.loadType != null) {
      switch (entity.loadType!.toLowerCase()) {
        case 'ss':
          markers.add(Marker(
            markerId: MarkerId('loadType_ss_${entity.id}'),
            position:
                LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
            icon: await _bitmapDescriptorFromAsset(Assets.ss33Kv),
          ));
          break;
        case 'dtr':
          markers.add(Marker(
            markerId: MarkerId('loadType_dtr_${entity.id}'),
            position:
                LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
            icon: await _bitmapDescriptorFromAsset(Assets.dtr),
          ));
          break;
        case 'ht':
          markers.add(Marker(
            markerId: MarkerId('loadType_ht_${entity.id}'),
            position:
                LatLng(double.parse(entity.lat!), double.parse(entity.lon!)),
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
    textPainter.paint(canvas, const Offset(0, 0)); // Adjust if necessary

    final picture = recorder.endRecording();
    final img = await picture.toImage(
      textPainter.width.toInt(),
      textPainter.height.toInt(),
    );

    final ByteData? byteData =
        await img.toByteData(format: ui.ImageByteFormat.png);
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

  LatLng _calculateMidpoint(
      double lat1, double lon1, double lat2, double lon2) {
    double midLat = (lat1 + lat2) / 2;
    double midLon = (lon1 + lon2) / 2;
    return LatLng(midLat, midLon);
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromAsset(String path) async {
    final Uint8List data = await _getBytesFromAsset(path, 50);
    return BitmapDescriptor.fromBytes(data);
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData byteData = await rootBundle.load(path);
    ui.Codec codec =
        await ui.instantiateImageCodec(byteData.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    final Uint8List resizedData =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
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
        _onMarkerTap(markerId);
      },
    );

    markers.add(marker);
    markerEntityMap[markerId] = entity;
    notifyListeners();
  }

  PoleFeederEntity? sourcePoleTag;

  void _onMarkerTap(MarkerId markerId) {
    final entity = markerEntityMap[markerId];
    print("markerEntityMap entity: $markerEntityMap");
    if (entity == null) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text("Copy this pole num to previous pole number box?"),
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
            child: const Text("Copy"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
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
    await startListening();
  }

  StreamSubscription<Position>? _positionStream;

  Future<void> startListening() async {
    print("started Implementing");
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;
      totalAccuracy = position.accuracy; // <-- This is in meters

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

  //Pole Selection
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

  //Tapping from previous pole
  String? _selectedTappingPole;

  String? get selectedTappingPole => _selectedTappingPole;

  void setSelectedTappingPole(String title) {
    _selectedTappingPole = title;
    notifyListeners();
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
                    if (selectedPole == "" ||
                        _selectedPole == null ||
                        _selectedPole == 'Source Pole Not Mapped' &&
                            selectedTappingPole != null) {
                      showAlertDialog(context,
                          "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
                    }
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
                    if (selectedPole == "" ||
                        _selectedPole == null ||
                        _selectedPole == 'Source Pole Not Mapped' &&
                            selectedTappingPole != null) {
                      showAlertDialog(context,
                          "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
                    }
                  },
                  child: const Text("OK")),
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

      const limit = 2;

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

  List<int> poleQty = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];

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
  }

  Map<String, String> get selectedPoleQuantities {
    final Map<String, String> result = {};

    for (var item in _poleItems) {
      if (item.isSelected && item.selectedQty != null) {
        result[item.title] = item.selectedQty.toString();
      }
    }
    print("result: $result");
    return result;
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

  Map<String, String> get selectedInsulators {
    final Map<String, String> result = {};

    for (var item in _poleInsulators) {
      if (item.isSelected && item.selectedQty != null) {
        result[item.title] = item.selectedQty.toString();
      }
    }
    print("result: $result");
    return result;
  }

  void updatePoleInsulators(String? newValue, int index) {
    if (newValue != null) {
      _poleInsulators[index].selectedQty = int.tryParse(newValue);
      print(
          "PoleInsulators[index].selectedQty: ${_poleInsulators[index].selectedQty}");
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
  }

  void updatePoleSupport(String? newValue, int index) {
    if (newValue != null) {
      _poleSupport[index].selectedQty = int.tryParse(newValue);
      print(
          "poleSupport[index].selectedQty: ${_poleSupport[index].selectedQty}");
      notifyListeners();
    }
  }

  Map<String, String> get selectedSupportType {
    final Map<String, String> result = {};

    for (var item in _poleSupport) {
      if (item.isSelected && item.selectedQty != null) {
        result[item.title] = item.selectedQty.toString();
      }
    }
    print("result: $result");
    return result;
  }

  //Connected Load
  String? _selectedConnected;

  String? get selectedConnected => _selectedConnected;

  void setSelectedConnected(String title) {
    _selectedConnected = title;
    print("$_selectedConnected: Connected  selected");
    if (_selectedConnected == "HT Services") {
      showCircleDialog(() {
        Future.delayed(const Duration(milliseconds: 300), () {
          notifyListeners();
        });
      });
    }
    notifyListeners();
  }

  //Support Material
  List<int> supportQty = [
    0,
    1,
    2,
    3,
    4,
  ];
  String? smSelected;

  void updateSupportQty(String? newValue, String? title) {
    if (newValue != null) {
      smSelected = newValue;

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
    "KHAMMAM",
    "HANAMKONDA",
    "KARIMNAGAR",
    "NIZAMABAD",
    "ADILABAD",
    "KOTHAGUDEM",
    "WARANGAL",
    "JANGAON",
    "BHUPALPALLY",
    "MAHABUBABAD",
    "JAGITYAL",
    "PEDDAPALLY",
    "KAMAREDDY",
    "NIRMAL",
    "ASIFABAD",
    "MANCHERIAL"
  ];

  bool _hasTappedDropdownOnce = false;

  bool get hasTappedDropdownOnce => _hasTappedDropdownOnce;

  void markDropdownTapped() {
    _hasTappedDropdownOnce = true;
    notifyListeners();
  }

  void showCircleDialog(VoidCallback onCircleSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Circle'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: circles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(circles[index]),
                  onTap: () {
                    Navigator.of(context).pop();
                    ccValue = index + 1;
                    notifyListeners();
                    print('CC value assigned : $ccValue');
                    loadHTServices(ccValue.toString()).then((_) {
                      onCircleSelected();
                    });
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  int? ccValue;
  List<SpinnerList> htServiceList = [];
  List<String?> htServiceNames = [];
  String? selectedHtServiceName;
  String? selectedArea;

  void onHtServiceChange(String? htServiceName) {
    print('get the area name : $htServiceName');
    selectedHtServiceName = htServiceName;
    notifyListeners();
  }

  List<SpinnerList?> substationList = [];
  SpinnerList? selectedSubstation;

  Future<void> getSubStationList() async {
    _isLoading = isTrue;

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ssc": args['ssc'],
    };

    final payload = {
      "path": "/load/load33kvssOf132KvSs",
      "apiVersion": "1.0",
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
                List<dynamic> ssRawList = jsonDecode(objectJson);
                if (ssRawList.isNotEmpty && ssRawList.length >= 2) {
                  substationList = ssRawList
                      .map((json) => SpinnerList.fromJson(json))
                      .toList();
                  print('HT Service List Length: ${htServiceList.length}');
                  notifyListeners();
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
  }

  void onSubstationChange(SpinnerList? selected) {
    selectedSubstation = selected;
    notifyListeners();
  }

  Future<void> loadHTServices(String circleCode) async {
    _isLoading = isTrue;
    notifyListeners();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "cc": circleCode,
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
                final objectJson = response.data['objectJson'];
                List<dynamic> serviceRawList = jsonDecode(objectJson);
                if (serviceRawList.isNotEmpty && serviceRawList.length >= 2) {
                  htServiceList = serviceRawList
                      .map((json) => SpinnerList.fromJson(json))
                      .toList();
                  htServiceNames = htServiceList
                      .map((service) => service.optionName)
                      .toList();
                  notifyListeners();
                }
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
    print("submit33KVForm starting");
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        print("submit33KVForm validation");
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
    //922
    _isLoading = isTrue;
    notifyListeners();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "fc": args["fc"],
      "ssc": args["ssc"],
      "fv": "33KV",
      "ssv": "220\\/132KV\\/33KV",
      "not": selectedPole == "Source Pole Not Mapped" ? true : false,
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
      // "pid": docketEntity!.id,
      "polenum": poleNumber.text.isEmpty ? "0000" : poleNumber.text.trim(),
      "crossingText": particularsOfCrossing.text.trim(),
      if (selectedPole != "Origin Pole") ...{
        "series": series,
      },
      "cid": docketEntity!.id,
      if (selectedPole == "Source Pole Not Mapped" ||
          selectedPole != "Origin Pole") ...{
        "sid": poleID,
        "slat": poleLat,
        "slon": poleLon,
      },
      "cross": buildCrossingString(),
      "connLoad": selectedConnected == "No Load" ? "N" : "NEW SS",
      "ht": selectedHtServiceName != null
          ? "${htServiceNames.indexOf(selectedHtServiceName)}"
          : "",
      "ss": selectedSubstation != null
          ? "${substationList.indexOf(selectedSubstation)}"
          : "",
      "cs": selectedConductor,
      "lat": latitude.toString(),
      "lon": longitude.toString(),
      "vx": selectedPoleQuantities["V Cross Arm"],
      "hx": selectedPoleQuantities["Horiz. Cross Arm"],
      "sx": selectedPoleQuantities["Channel Cross Arm"],
      "cx": selectedPoleQuantities["Side Arm"],
      "pin": selectedInsulators["Pin Insulators"],
      "disc": selectedInsulators["Disc"],
      "sha": selectedInsulators["Shackles"],
      "stud": selectedSupportType["Stud Pole"],
      "stay": selectedSupportType["Stay set"],
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
              showAlertDialog(context, response.data['message']);
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
  }

  bool validateForm() {
    final selectedItems = poleItems.where((item) => item.isSelected).toList();
    final hasInvalidQty = selectedItems.any(
      (item) =>
          item.selectedQty == null ||
          item.selectedQty.toString().trim().isEmpty,
    );
    if ((selectedPole == "" || selectedPole == null) &&
        selectedPoleFeeder == null) {
      AlertUtils.showSnackBar(
          context, "Please select the source pole to the current pole", isTrue);
      return false;
    } else if (poleFeederSelected == null || poleFeederSelected == "") {
      AlertUtils.showSnackBar(
          context, "Please select previous pole number", isTrue);
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
    } else if (selectedItems.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please select at least one cross arm type.", true);
      return false;
    } else if (hasInvalidQty) {
      AlertUtils.showSnackBar(
          context, "Please enter quantity for all selected cross arms.", true);
      return false;
    } else if (selectedCrossings.isEmpty) {
      AlertUtils.showSnackBar(context, "Please select any crossing", isTrue);
      return false;
    } else if (selectedConnected == "" || selectedConnected == null) {
      AlertUtils.showSnackBar(context,
          "Please select the any connected load on the current pole", isTrue);
      return false;
    } else if (selectedConnected == "HT Services" &&
        selectedHtServiceName == null) {
      AlertUtils.showSnackBar(context,
          "Please select the HT Service connected on this pole", isTrue);
      return false;
    } else if (selectedConnected == "Sub Station" &&
        selectedSubstation == null) {
      AlertUtils.showSnackBar(
          context, "Please select the connected 33/11 KV Substation", isTrue);
      return false;
    } else if (_selectedConductor == "" || _selectedConductor == null) {
      AlertUtils.showSnackBar(
          context,
          "Please select the conductor size from previous pole to this pole",
          isTrue);
      return false;
    } else if ((latitude == "" && longitude == "") ||
        (latitude == null && longitude == null)) {
      AlertUtils.showSnackBar(
          context,
          "Please wait until we capture your location. Please make sure you have turned on your location",
          isTrue);
      startListening();
      return false;
    }
    return true;
  }

  void resetForm() {
    poleNumber.clear();
    _selectedTappingPole = null;
    selectedFirstGroup.clear();
    selectedSecondGroup.clear();
    _selectedPoleHeight = "";
    _selectedCircuits = "";
    _selectedFormation = "";
    _selectedTypePoint = "";
    selectedCrossings.clear();
    _selectedConnected = "";
    subStationCapacity.clear();
    _selectedConductor = "";
    longitude = null;
    latitude = null;
    notifyListeners();
  }

  // void showDialogueCopyPoleNum() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: const SizedBox(
  //           height: 40,
  //           child: Column(children: [
  //             Text(
  //               "Copy this pole mum to previous pole number box?",
  //             ),
  //           ]),
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Cancle")),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Copy")),
  //         ],
  //       );
  //     },
  //   );
  // }

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
            const TextButton(
              onPressed: null,
              child: Text("SELECT ON MAP"),
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
                            onListPoleFeederChange(item);
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
}
