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
import '../../dtr_master/model/circle_model.dart';

class Check11kvViewmodel extends ChangeNotifier {
  Check11kvViewmodel({required this.context, required this.args}) {
    startListening();
    _initializeCameraPosition();
    getPolesOnFeeder();
    final String? jsonString = args['d'];
    print("argument d data: ${args['d']}");

    if (args['p'] == isTrue) {
      docketEntity = DocketEntity.fromJson(jsonDecode(jsonString!));
      print("docketEntity ${docketEntity!.id}");
    }
    yearList = List.generate(
      currentYear - 1976 + 1, // Number of elements
      (index) => (currentYear - index).toString(),
    );
    selectedYear = yearList[0];
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

  String get feederName => args['fn'];

  String get feederCode => args['fc'];

  String get ssc => args['ssc'];

  String get ssn => args['ssn'];

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

      if (showPoles) {
        addMarkerWithEntity(entity);
      }

      if (!drawHuman) {
        _addSpecialMarkers(entity);
      }
      // Check this once
      // if (i == poleFeederList.length - 1) {
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
    if (_selectedTappingPole == "Straight Tapping" ||
        _selectedTappingPole == "Left Tapping") {
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
                    showAlertDialog(context,
                        "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
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
                    showAlertDialog(context,
                        "Please choose Source Pole Num or check Source pole not mapped or origin Pole");
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
      notifyListeners();

      if (selectedCrossings.contains(title)) {
        selectedCrossings.remove(title);
        notifyListeners();
      } else {
        selectedCrossings.add(title);
        notifyListeners();
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
    PoleItem(title: "Channel Cross Arm"),
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
  }

  void updatePoleInsulators(String? newValue, int index) {
    if (newValue != null) {
      _poleInsulators[index].selectedQty = int.tryParse(newValue);
      print(
          "PoleInsulators[index].selectedQty: ${_poleInsulators[index].selectedQty}");
      notifyListeners();
    }
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

  //DTR Phase
  List<String> dtrPhase = ["1Q", "3Q"];
  String? selectedDtrPhase;

  void onListDtrPhaseSelected(String? value) {
    selectedDtrPhase = value;
    print("selectedLTDistribution: $selectedDtrPhase");
    notifyListeners();
  }

  //DTR Capacity
  String? _selectedCapacity;

  String? get selectedCapacity => _selectedCapacity;
  String? selectedCapacityName;

  final List<SubstationModel> _capacity = [
    SubstationModel(optionCode: "0", optionName: "SELECT"),
    SubstationModel(optionCode: "1", optionName: "1x10(L)"),
    SubstationModel(optionCode: "1", optionName: "1x100"),
    SubstationModel(optionCode: "2", optionName: "1x100+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x15 (Agl)"),
    SubstationModel(optionCode: "1", optionName: "1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x16"),
    SubstationModel(optionCode: "2", optionName: "1x16+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x160"),
    SubstationModel(optionCode: "1", optionName: "1x200"),
    SubstationModel(optionCode: "1", optionName: "1x25"),
    SubstationModel(optionCode: "1", optionName: "1x25(L)"),
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
    SubstationModel(optionCode: "2", optionName: "2x100"),
    SubstationModel(optionCode: "2", optionName: "2x150"),
    SubstationModel(optionCode: "2", optionName: "2x16"),
    SubstationModel(optionCode: "2", optionName: "2x25"),
    SubstationModel(optionCode: "2", optionName: "2x250"),
    SubstationModel(optionCode: "2", optionName: "2x63"),
    SubstationModel(optionCode: "3", optionName: "3x10(A)"),
    SubstationModel(optionCode: "3", optionName: "3x16"),
    SubstationModel(optionCode: "3", optionName: "3x15"),
    SubstationModel(optionCode: "3", optionName: "3x25"),
  ];

  List<SubstationModel> get capacity => _capacity;
  int? _selectedCapacityIndex;

  int? get selectedCapacityIndex => _selectedCapacityIndex;

  void onListCapacitySelected(int? index) {
    _selectedCapacityIndex = index;

    _selectedCapacity = index != null ? _capacity[index].optionCode : null;
    selectedCapacityName = index != null ? _capacity[index].optionName : null;
    notifyListeners();
    print("$_selectedCapacity: selected Capacity ");
  }

  final List<SubstationModel> structureCapacity = [
    SubstationModel(optionCode: "0", optionName: "SELECT"),
    SubstationModel(optionCode: "1", optionName: "1x10(L)"),
    SubstationModel(optionCode: "1", optionName: "1x100"),
    SubstationModel(optionCode: "2", optionName: "1x100+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x15 (Agl)"),
    SubstationModel(optionCode: "1", optionName: "1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x16"),
    SubstationModel(optionCode: "2", optionName: "1x16+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x160"),
    SubstationModel(optionCode: "1", optionName: "1x200"),
    SubstationModel(optionCode: "1", optionName: "1x25"),
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
    SubstationModel(optionCode: "2", optionName: "2x100"),
    SubstationModel(optionCode: "2", optionName: "2x150"),
    SubstationModel(optionCode: "2", optionName: "2x16"),
    SubstationModel(optionCode: "2", optionName: "2x25"),
    SubstationModel(optionCode: "2", optionName: "2x250"),
    SubstationModel(optionCode: "2", optionName: "2x63"),
    SubstationModel(optionCode: "3", optionName: "3x10(A)"),
    SubstationModel(optionCode: "3", optionName: "3x16"),
    SubstationModel(optionCode: "3", optionName: "3x15"),
    SubstationModel(optionCode: "3", optionName: "3x25"),
  ];

  //DTR Make
  String? _selectedMake;

  String? get selectedMake => _selectedMake;

  final List<SubstationModel> _make = [
    SubstationModel(optionCode: "4000049", optionName: "AKSHAYA"),
    SubstationModel(optionCode: "4000053", optionName: "APEX"),
    SubstationModel(optionCode: "4000085", optionName: "ARK"),
    SubstationModel(optionCode: "4000089", optionName: "ASTER"),
    SubstationModel(optionCode: "4000088", optionName: "BALAJI"),
    SubstationModel(
        optionCode: "4000001", optionName: "BHAVANI TRANSFORMERS PVT LTD"),
    SubstationModel(optionCode: "4000125", optionName: "BHEL"),
    SubstationModel(optionCode: "4000070", optionName: "BHOPAL"),
    SubstationModel(optionCode: "4000061", optionName: "Bhopal Transformers"),
    SubstationModel(optionCode: "4000065", optionName: "Blue men"),
    SubstationModel(optionCode: "4000091", optionName: "BRG"),
    SubstationModel(optionCode: "4000002", optionName: "BSR TRANSFORMERS"),
    SubstationModel(optionCode: "4000003", optionName: "BSVR ELECTRICALS"),
    SubstationModel(optionCode: "4000004", optionName: "CHAITANYA"),
    SubstationModel(optionCode: "4000126", optionName: "Cromton Greaves"),
    SubstationModel(optionCode: "4000005", optionName: "DASANI"),
    SubstationModel(
        optionCode: "4000056", optionName: "DELL(Divyanjali Electricals)"),
    SubstationModel(optionCode: "4000006", optionName: "EAST INDIA"),
    SubstationModel(optionCode: "4000007", optionName: "ECE"),
    SubstationModel(
        optionCode: "4000008", optionName: "EKACHAKRA ELECTRICAL WORKS"),
    SubstationModel(optionCode: "4000067", optionName: "ELECTRA"),
    SubstationModel(optionCode: "4000080", optionName: "ELTRA"),
    SubstationModel(optionCode: "4000068", optionName: "EPE"),
    SubstationModel(
        optionCode: "4000063", optionName: "ETE(Electronic Transf&Eq Co.)"),
    SubstationModel(optionCode: "4000009", optionName: "GANAPATHI"),
    SubstationModel(optionCode: "4000078", optionName: "GANGA"),
    SubstationModel(optionCode: "4000127", optionName: "GE"),
    SubstationModel(optionCode: "4000064", optionName: "HHE"),
    SubstationModel(optionCode: "4000010", optionName: "HINT TRANSFORMERS HYD"),
    SubstationModel(optionCode: "4000011", optionName: "HI-POWER TRANSFORMERS"),
    SubstationModel(optionCode: "4000012", optionName: "HIT TRANSFORMERS"),
    SubstationModel(optionCode: "4000013", optionName: "HPL"),
    SubstationModel(optionCode: "4000128", optionName: "HWT"),
    SubstationModel(optionCode: "4000014", optionName: "ICOM"),
    SubstationModel(optionCode: "4000066", optionName: "IDT"),
    SubstationModel(optionCode: "4000071", optionName: "IMP"),
    SubstationModel(optionCode: "4000129", optionName: "Indo Tech"),
    SubstationModel(
        optionCode: "4000015", optionName: "JAGANMATHA TRANSFORMERS"),
    SubstationModel(optionCode: "4000016", optionName: "JVK TRANSFORMERS"),
    SubstationModel(optionCode: "4000017", optionName: "KANYAKA PARAMESHWARI"),
    SubstationModel(optionCode: "4000073", optionName: "KAVIKA"),
    SubstationModel(
        optionCode: "4000055", optionName: "KEC(Kirloskar Elec. Comp Ltd.)"),
    SubstationModel(optionCode: "4000075", optionName: "KILLOSKER"),
    SubstationModel(optionCode: "4000077", optionName: "KIVIKA"),
    SubstationModel(optionCode: "4000093", optionName: "KSR"),
    SubstationModel(
        optionCode: "4000051", optionName: "KTE(Koteshwara Rao Transf.)"),
    SubstationModel(optionCode: "4000130", optionName: "KunDa"),
    SubstationModel(
        optionCode: "4000018", optionName: "MADHU REFINERY PVT LTD"),
    SubstationModel(optionCode: "4000090", optionName: "MAITHREYA"),
    SubstationModel(optionCode: "4000019", optionName: "MANU TRANSFORMERS"),
    SubstationModel(optionCode: "4000069", optionName: "ME"),
    SubstationModel(optionCode: "4000086", optionName: "MEDHA"),
    SubstationModel(optionCode: "4000092", optionName: "MITRA"),
    SubstationModel(optionCode: "4000020", optionName: "MSR"),
    SubstationModel(
        optionCode: "4000058", optionName: "NEI(National Elec Industries)"),
    SubstationModel(optionCode: "4000081", optionName: "NIDHEE"),
    SubstationModel(optionCode: "4000082", optionName: "PACTIL"),
    SubstationModel(optionCode: "4000138", optionName: "PADMAJA Transformers"),
    SubstationModel(optionCode: "4000084", optionName: "PARAMOUNT"),
    SubstationModel(
        optionCode: "4000054", optionName: "PEI(Prompt Elec. Industries)"),
    SubstationModel(optionCode: "4000021", optionName: "PERFECT TRANSFORMERS"),
    SubstationModel(
        optionCode: "4000124", optionName: "POWERTECH TRANSFORMERS"),
    SubstationModel(optionCode: "4000022", optionName: "PRUDHVI"),
    SubstationModel(optionCode: "4000023", optionName: "RADHIKA"),
    SubstationModel(
        optionCode: "4000024", optionName: "RAMAKRISHNA TRANSFORMERS"),
    SubstationModel(optionCode: "4000025", optionName: "RAYALASEEMA"),
    SubstationModel(
        optionCode: "4000057", optionName: "RI(Raghavendra Industries)"),
    SubstationModel(optionCode: "4000026", optionName: "RISHU"),
    SubstationModel(optionCode: "4000027", optionName: "ROHINI"),
    SubstationModel(optionCode: "4000028", optionName: "SAIBABA ELECTRICALS"),
    SubstationModel(optionCode: "4000072", optionName: "SDE"),
    SubstationModel(
        optionCode: "4000046", optionName: "SDT(Star Delta Transf.)"),
    SubstationModel(optionCode: "4000029", optionName: "SERVOMAX"),
    SubstationModel(
        optionCode: "4000050", optionName: "SFS(Saibaba Flame Proof Serv)"),
    SubstationModel(optionCode: "4000048", optionName: "Shantha Veera"),
    SubstationModel(
        optionCode: "4000030", optionName: "SHIRDI SAI ELECTRICALS"),
    SubstationModel(optionCode: "4000094", optionName: "SHYAM"),
    SubstationModel(optionCode: "4000031", optionName: "SILICON TRANSFORMERS"),
    SubstationModel(optionCode: "4000131", optionName: "SNR"),
    SubstationModel(optionCode: "4000079", optionName: "SPEC"),
    SubstationModel(
        optionCode: "4000097", optionName: "SRI JAGADAMBA TRANSFORMERS"),
    SubstationModel(
        optionCode: "4000032", optionName: "SRI LAKSHMI VENKATESWARA ELEC"),
    SubstationModel(optionCode: "4000033", optionName: "SRI RAMA"),
    SubstationModel(optionCode: "4000034", optionName: "SRI SAI ELECTRICALS"),
    SubstationModel(optionCode: "4000083", optionName: "SRILATHA"),
    SubstationModel(optionCode: "4000087", optionName: "STARTEK"),
    SubstationModel(optionCode: "4000045", optionName: "STEL"),
    SubstationModel(optionCode: "4000035", optionName: "SVR"),
    SubstationModel(optionCode: "4000036", optionName: "TECHNO ELECTRICALS"),
    SubstationModel(optionCode: "4000060", optionName: "Tesla Transformers"),
    SubstationModel(optionCode: "4000095", optionName: "TOSHIBA"),
    SubstationModel(
        optionCode: "4000157", optionName: "TRANSLITE ENERGY LIMITED"),
    SubstationModel(optionCode: "4000143", optionName: "TRANS ALLIEDS GUNTUR"),
    SubstationModel(optionCode: "4000037", optionName: "TRANSCON INDUSTRIES"),
    SubstationModel(optionCode: "4000096", optionName: "TRINITY"),
    SubstationModel(
        optionCode: "4000052", optionName: "UE(Universal Electricals)"),
    SubstationModel(optionCode: "4000132", optionName: "Unitech"),
    SubstationModel(optionCode: "4000047", optionName: "UT(Universal Transf.)"),
    SubstationModel(optionCode: "4000038", optionName: "VENUGOPAL ELECTRICALS"),
    SubstationModel(optionCode: "4000039", optionName: "VICTORY ELECTRICALS"),
    SubstationModel(optionCode: "4000133", optionName: "Victory Switchgear"),
    SubstationModel(optionCode: "4000040", optionName: "VICTORY TRANSFORMERS"),
    SubstationModel(optionCode: "4000041", optionName: "VIJAY ELECTRICALS"),
    SubstationModel(optionCode: "4000042", optionName: "VIJAY TRANSFORMERS"),
    SubstationModel(optionCode: "4000059", optionName: "Vijetha Transformers"),
    SubstationModel(optionCode: "4000074", optionName: "VINOD"),
    SubstationModel(
        optionCode: "4000043", optionName: "VISHWANATH TRANFORMERS"),
    SubstationModel(optionCode: "4000076", optionName: "VTST"),
    SubstationModel(optionCode: "4000062", optionName: "Webers"),
    SubstationModel(optionCode: "4000044", optionName: "WEBTECH TRANSFORMERS"),
    SubstationModel(
        optionCode: "4000144", optionName: "ABB(Asea Brown Boveri)"),
    SubstationModel(optionCode: "4000139", optionName: "ALSTOM"),
    SubstationModel(
        optionCode: "4000136", optionName: "AMOD(AMOD Industries Pvt Ltd)"),
    SubstationModel(
        optionCode: "4000153",
        optionName: "Andhra Pradesh Electrical Equipment Corporation"),
    SubstationModel(
        optionCode: "4000152", optionName: "Avana Electrosystems Pvt Ltd"),
    SubstationModel(optionCode: "4000148", optionName: "BRG ENERGY Ltd"),
    SubstationModel(
        optionCode: "4000154", optionName: "CLASSIC TECHNOLINES PVT LTD"),
    SubstationModel(optionCode: "4000146", optionName: "CONCORD"),
    SubstationModel(optionCode: "4000150", optionName: "Crompton Greaves Ltd"),
    SubstationModel(
        optionCode: "4000142", optionName: "DHANALAKSHMI TRANSFORMERS (India)"),
    SubstationModel(optionCode: "4000134", optionName: "GSE(G.S.Electricals)"),
    SubstationModel(optionCode: "4000137", optionName: "HPC Electricals Ltd"),
    SubstationModel(optionCode: "4000099", optionName: "PTR-ACCURATE"),
    SubstationModel(optionCode: "4000100", optionName: "PTR-APEX"),
    SubstationModel(optionCode: "4000122", optionName: "PTR-AYCL"),
    SubstationModel(optionCode: "4000101", optionName: "PTR-ECE"),
    SubstationModel(optionCode: "4000123", optionName: "PTR-EIUL"),
    SubstationModel(optionCode: "4000102", optionName: "PTR-ELECTRA"),
    SubstationModel(optionCode: "4000104", optionName: "PTR-ETS"),
    SubstationModel(optionCode: "4000105", optionName: "PTR-HHE"),
    SubstationModel(optionCode: "4000106", optionName: "PTR-IMP"),
    SubstationModel(optionCode: "4000107", optionName: "PTR-INDO.TECH"),
    SubstationModel(optionCode: "4000108", optionName: "PTR-KRK"),
    SubstationModel(optionCode: "4000109", optionName: "PTR-KTE"),
    SubstationModel(optionCode: "4000110", optionName: "PTR-MARSON"),
    SubstationModel(optionCode: "4000112", optionName: "PTR-RIMA"),
    SubstationModel(optionCode: "4000111", optionName: "PTR-RKI"),
    SubstationModel(optionCode: "4000113", optionName: "PTR-SFS"),
    SubstationModel(optionCode: "4000114", optionName: "PTR-SPEC"),
    SubstationModel(optionCode: "4000115", optionName: "PTR-SSE"),
    SubstationModel(optionCode: "4000116", optionName: "PTR-TOSHIBA"),
    SubstationModel(optionCode: "4000117", optionName: "PTR-TRANSCON"),
    SubstationModel(optionCode: "4000118", optionName: "PTR-UT"),
    SubstationModel(optionCode: "4000119", optionName: "PTR-VE"),
    SubstationModel(optionCode: "4000120", optionName: "PTR-VICTORY"),
    SubstationModel(optionCode: "4000121", optionName: "PTR-VISWANATH"),
    SubstationModel(
        optionCode: "4000140", optionName: "RK ELECTRICAL INDUSTRIES"),
    SubstationModel(optionCode: "4000156", optionName: "SECURE"),
    SubstationModel(optionCode: "4000149", optionName: "SHREEM ELECTRIC Ltd"),
    SubstationModel(optionCode: "4000151", optionName: "STELMEC Limited"),
    SubstationModel(optionCode: "4000161", optionName: "TEJASWINI INDUSTRIES"),
    SubstationModel(
        optionCode: "4000155", optionName: "VAJRA TRANSPOWER Pvt Ltd"),
    SubstationModel(
        optionCode: "4000141", optionName: "VIDYUTH CONTROL SYSTEMS Pvt Ltd"),
    SubstationModel(
        optionCode: "4000098", optionName: "VIGNESWARA ELECTRICALS PRODDUTUR"),
    SubstationModel(
        optionCode: "4000158",
        optionName: "VINAYAKA TRANSMISSION PRODUCTS PRIVATE LIMITED"),
    SubstationModel(
        optionCode: "4000145", optionName: "VIJAY POWER SYSTEMS-Hyd"),
    SubstationModel(
        optionCode: "4000135",
        optionName: "Vishal Transformers and Switchgears Pvt Ltd"),
    SubstationModel(
        optionCode: "4000147",
        optionName: "WESTERN Transformers & Equipment Pvt Ltd"),
    SubstationModel(optionCode: "0", optionName: "SELECT"),
  ];

  List<SubstationModel> get make => _make;
  int? _selectedMakeIndex;

  int? get selectedMakeIndex => _selectedMakeIndex;

  void onListMakeSelected(int? index) {
    _selectedMakeIndex = index;
    _selectedMake = index != null ? _make[index].optionCode : null;
    notifyListeners();
    print("$_selectedMake: selected Make ");
  }

  //Connected Load
  String? _selectedConnected;

  String? get selectedConnected => _selectedConnected;

  void setSelectedConnected(String title) {
    _selectedConnected = title;
    print("$_selectedConnected: Connected  selected");
    notifyListeners();
  }

  //Year of Manufacturing
  final int currentYear = DateTime.now().year;
  List<String> yearList = [];
  String? selectedYear;

  void onListYearSelected(String? value) {
    selectedYear = value;
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
  Map<String, String?> smSelectedMap = {};

  List<String> dropdownTitles = [
    "Tilting Type AB Switch",
    "Horizontal Type AB Switch",
    "HG Fuse Set",
  ];

  void updateSupportQty(String? newValue, String title) {
    if (newValue != null) {
      smSelectedMap[title] = newValue;
      print("Updated $title to $newValue:smSelectedMap: $smSelectedMap");

      notifyListeners();
    }
  }

  List<int> lTDistributionBox = [
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
  String? selectedLTDistribution;

  void onListLTSelected(String? value) {
    selectedLTDistribution = value;
    print("selectedLTDistribution: $selectedLTDistribution");
    notifyListeners();
  }

  //Plint Type
  List<String> pLintType = ["Plinth", "Pillar", "Pole mounted"];
  String? selectedpLintType;

  void onListPLintSelected(String? value) {
    selectedpLintType = value;
    print("selectedLTDistribution: $selectedpLintType");
    notifyListeners();
  }

  //Earthing Type
  List<String> earthingType = ["CI", "GI"];
  String? selectedEarthingType;

  void onListEarthingType(String? value) {
    selectedEarthingType = value;
    print("selectedEarthingType: $selectedEarthingType");
    notifyListeners();
  }

  //No Of Earth Pits
  List<int> noOfEarthPits = [
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
    16
  ];
  String? selectedEarthPits;

  void onListEarthPits(String? value) {
    selectedEarthPits = value;
    print("selectedEarthPits: $selectedEarthPits");
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

//Previous Pole Num
  List<PoleFeederEntity> poleFeederList = [];
  String? poleFeederSelected;
  String? poleID;
  String? poleLat;
  String? poleLon;
  PoleFeederEntity? selectedPoleFeeder;

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
              onPressed: () {
                Navigator.pop(context);
                AlertUtils.showSnackBar(
                    context, "Please tap the pole on the map", isFalse);
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

  void onListPoleFeederChange(PoleFeederEntity? value) {
    selectedPoleFeeder = value;
    if (value != null) {
      poleFeederSelected = value.poleNum ?? "";
      poleID = value.id.toString();
      poleLat = value.lat.toString();
      poleLon = value.lon.toString();
      series = poleFeederSelected?.substring(0, 3);
      AlertUtils.showSnackBar(context, poleFeederSelected!, isFalse);
      print("POle Num: $poleFeederSelected");
      print("Series: $series");
      print("Pole ID: $poleID");
    }
    notifyListeners(); // Needed to refresh UI
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
    }
  }

  void setPoleNum() {
    poleNumber.text = (series != null ? "$series-$poleNum" : poleNum)!;
  }

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

  void showCircleDialog() {
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

  Future<void> loadHTServices(String circleCode) async {
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

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "fc": args["fc"],
      "ssc": args["ssc"],
      "fv": "11KV",
      "ssv": "33/11KV",
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
      "pid": docketEntity!.id,
      "polenum": poleNumber.text.isEmpty ? "" : poleNumber.text.trim(),
      "series": series,
      if (selectedPole != "Source Pole Not Mapped" &&
          selectedPole != "Origin Pole") ...{
        "sid": poleID,
        "slat": poleLat,
        "slon": poleLon,
      },
      "vx": selectedPoleQuantities["V Cross Arm"],
      "hx": selectedPoleQuantities["Horiz. Cross Arm"],
      "sx": selectedPoleQuantities["Channel Cross Arm"],
      "cx": selectedPoleQuantities["Side Arm"],
      //Insulators
      "pin": selectedInsulators["Pin Insulators"],
      "disc": selectedInsulators["Disc"],
      "sha": selectedInsulators["Shackles"],
      //Support type
      "stud": selectedSupportType["Stud Pole"],
      "stay": selectedSupportType["Stay set"],
      "cid": docketEntity!.id,
      if (selectedConnected == "DTR") ...{
        "dtrph": selectedDtrPhase == "1Q" ? "SPH" : "3PH",
        "dtrcap": selectedCapacityName,
        "dtrSl": dtrSlNo.text.trim(),
        "ymfg": selectedYear,
        "tab": smSelectedMap["Tilting Type AB Switch"] ?? "",
        "hzab": smSelectedMap["Horizontal Type AB Switch"],
        "hg": smSelectedMap["HG Fuse Set"],
        "plinth": selectedpLintType,
        "earth": selectedEarthingType,
        "pits": selectedEarthPits,
        "ltd": selectedLTDistribution,
      },
      "cross": buildCrossingString(),
      "connLoad": selectedConnected == "No Load" ? "N" : "DTR",
      if (selectedConnected == "DTR") ...{
        "structCode": structureCode.text.trim(),
        "cap": selectedCapacityName,
      },
      "cs": selectedConductor,
      "lat": latitude.toString(),
      "lon": longitude.toString(),
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
                      resetForm();
                    },
                  );
                  resetForm();
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
            // showSessionExpiredDialog(context);
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
          "Please select the any load connected on the current pole", isTrue);
      return false;
    } //DTR
    else if (selectedConnected == "DTR" &&
        (selectedCapacity == "" || selectedCapacity == null)) {
      AlertUtils.showSnackBar(
          context, "Please select the DTR capacity", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (_selectedMakeIndex == "" || _selectedMakeIndex == null)) {
      AlertUtils.showSnackBar(context, "Please select the DTR Make", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (structureCode.text.isEmpty || structureCode.text == "")) {
      AlertUtils.showSnackBar(context, "Please enter Structure Code", isTrue);
      return false;
    } else if (selectedConnected == "DTR" && (equipmentCode.text.isEmpty)) {
      AlertUtils.showSnackBar(context, "Please enter Equipment Code", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (selectedDtrPhase == "" || selectedDtrPhase == null)) {
      AlertUtils.showSnackBar(context, "Please select the DTR Phase", isTrue);
      return false;
    } else if (selectedConnected == "DTR" && (dtrSlNo.text.isEmpty)) {
      AlertUtils.showSnackBar(context, "Please select the DTR Sl.NO", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (selectedYear == "" || selectedYear == null)) {
      AlertUtils.showSnackBar(
          context, "Please select the DTR capacity", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (smSelectedMap["Tilting Type AB Switch"] == "" ||
            smSelectedMap["Tilting Type AB Switch"] == null)) {
      AlertUtils.showSnackBar(
          context, "Please select Tilting Type AB Switch", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (smSelectedMap["Horizontal Type AB Switch"] == "" ||
            smSelectedMap["Horizontal Type AB Switch"] == null)) {
      AlertUtils.showSnackBar(
          context, "Please select the DTR Horizontal Type AB Switch", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (smSelectedMap["HG Fuse Set"] == "" ||
            smSelectedMap["HG Fuse Set"] == null)) {
      AlertUtils.showSnackBar(
          context, "Please select the DTR HG Fuse Set", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (selectedpLintType == "" || selectedpLintType == null)) {
      AlertUtils.showSnackBar(context, "Please select the Plint Type", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (selectedEarthingType == "" || selectedEarthingType == null)) {
      AlertUtils.showSnackBar(
          context, "Please select the DTR Earthing Type", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (selectedEarthPits == "" || selectedEarthPits == null)) {
      AlertUtils.showSnackBar(
          context, "Please select the DTR No of Earth Pits", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (selectedLTDistribution == "" || selectedLTDistribution == null)) {
      AlertUtils.showSnackBar(
          context, "Please select the LT Distribution box", isTrue);
      return false;
    } else if (selectedConnected == "DTR" &&
        (smSelectedMap["Horizontal Type AB Switch"] == "" ||
            smSelectedMap["Horizontal Type AB Switch"] == null)) {
      AlertUtils.showSnackBar(
          context, "Please select the DTR Horizontal Type AB Switch", isTrue);
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
}
