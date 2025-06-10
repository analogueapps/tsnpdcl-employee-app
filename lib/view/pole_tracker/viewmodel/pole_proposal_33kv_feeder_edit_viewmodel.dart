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
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/docket_model.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/polefeeder_model.dart';
import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';

class PoleProposal33kvFeederEditViewmodel extends ChangeNotifier {
  PoleProposal33kvFeederEditViewmodel(
      {required this.context, required this.args}) {
    startListening();
    _handleLocation();
    _initializeCameraPosition();
    getPolesOnFeeder();
    // final String? jsonString = args['d'];
    // print("argument d data: ${args['d']}");
    //
    // if (args['p'] == isTrue) {
    //   docketEntity = DocketEntity.fromJson(jsonDecode(jsonString!));
    //   print("docketEntity ${docketEntity!.id}");
    // }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  int maxId = 0;

  double? latitude;
  double? longitude;
  double? totalAccuracy;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  final BuildContext context;
  final Map<String, dynamic> args;

  final TextEditingController poleNumber = TextEditingController();
  final TextEditingController particularsOfCrossing = TextEditingController();

  String empName=SharedPreferenceHelper.getStringValue(LoginSdkPrefs.empNameKey);
  String empDesignation=SharedPreferenceHelper.getStringValue(LoginSdkPrefs.designationCodeKey);

  List<int> undoStack = [];
  List<PoleFeederEntity> digitalFeederEntityList = [];
  final int UNDO_STACK_SIZE = 10;

  bool deleteOrEdit= isFalse;

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
        onClickOfMap(entity);
      },
    );

    markers.add(marker);
    markerEntityMap[markerId] = entity;
    notifyListeners();
  }

  PoleFeederEntity? sourcePoleTag;

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

      // if (_selectedPole == "" || _selectedPole == null) {
      //   if (poleID != null) {
      //     distanceDisplay = isTrue;
      //     distanceBtnPoles = calculateDistance(latitude!, longitude!,
      //         double.parse(poleLat!), double.parse(poleLon!));
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
        // "tap": selectedTappingPole == "Straight Tapping"
        //     ? "s"
        //     : selectedTappingPole == "Left Tapping"
        //     ? "l"
        //     : "r",
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

                    // setPoleNum();
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
}