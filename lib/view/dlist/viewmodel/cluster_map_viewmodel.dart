import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dlist/model/place_model.dart';
import 'package:tsnpdcl_employee/view/dlist/model/range_dlist.dart';

// Import google maps flutter and cluster manager with prefixes to avoid conflicts
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart' as gcluster;


class ClusterMapViewmodel extends ChangeNotifier {
  final BuildContext context;
  final Map<String, dynamic> data;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  List<DlistEntityRealmList> _dlistEntityRealmList = [];
  List<DlistEntityRealmList> get dlistEntityRealmList => _dlistEntityRealmList;

  Set<gmaps.Marker> markers = {};
  late gmaps.GoogleMapController? _mapController;
  late Completer<gmaps.GoogleMapController> googleMapController = Completer<gmaps.GoogleMapController>();
  gcluster.ClusterManager<DlistEntityRealmList>? clusterManager;
  List<DlistEntityRealmList> _clusterPlaces = [];
  List<DlistEntityRealmList> get clusterPlaces => _clusterPlaces;

  ClusterMapViewmodel({required this.context, required this.data}) {
    getRangeDListServicesFromServer();
  }

  void setController(gmaps.GoogleMapController controller) {
    _mapController = controller;
    if (!googleMapController.isCompleted) {
      googleMapController.complete(controller);
    }
  }

  Future<void> initClusterManager() async {
    if (_clusterPlaces.isEmpty) return;

    clusterManager = gcluster.ClusterManager<DlistEntityRealmList>(
      _clusterPlaces,
      _updateMarkers,
      markerBuilder: (cluster) => _markerBuilder(cluster),
      stopClusteringZoom: 17,
    );

    if (_mapController != null) {
      clusterManager?.setMapId(_mapController!.mapId);
      clusterManager?.updateMap();
    }

    await moveToClusterBounds();
    notifyListeners();
  }

  Future<void> getRangeDListServicesFromServer() async {
    _dlistEntityRealmList.clear();
    _clusterPlaces.clear();
    _isLoading = isTrue;
    notifyListeners();

    final requestData = {
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "my": data['my'],
      "oc": data['oc'],
      "r": data['r'],
    };

    final payload = {
      "path": "/getRangeDListServices",
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
                final List<RangeDlist> listData =
                jsonList.map((json) => RangeDlist.fromJson(json)).toList();

                _clusterPlaces = listData[0].dlistEntityRealmList!;
                    // .map((e) => _convertToPlace(e))
                    // .whereType<Place>() // remove nulls
                    // .toList();

                // clusterManager = gcluster.ClusterManager<Place>(
                //   _clusterPlaces,
                //   _updateMarkers,
                //   markerBuilder: (gcluster.Cluster<Place> cluster) => _markerBuilder(cluster),
                //   stopClusteringZoom: 17,
                // );
                if (googleMapController.isCompleted) {
                  final controller = await googleMapController.future;
                  setController(controller);
                  await initClusterManager();
                }
              }
            } else {
              showAlertDialog(context, response.data['message']);
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

  void _setupClusterManager() {
    clusterManager = gcluster.ClusterManager<DlistEntityRealmList>(
      _clusterPlaces,
      _updateMarkers,
      markerBuilder: (cluster) => _markerBuilder(cluster),
      stopClusteringZoom: 17,
    );
    clusterManager?.updateMap();
    notifyListeners();
  }

  Future<void> moveToClusterBounds() async {
    if (_clusterPlaces.isEmpty || !googleMapController.isCompleted) return;

    final controller = await googleMapController.future;



    if (_clusterPlaces.length == 1) {
      await controller.animateCamera(
        gmaps.CameraUpdate.newLatLngZoom(parseLatLngFromString(_clusterPlaces.first.latLong), 16),
      );
      return;
    }

    double south = parseLatLngFromString(_clusterPlaces.first.latLong).latitude;
    double north = parseLatLngFromString(_clusterPlaces.first.latLong).latitude;
    double west = parseLatLngFromString(_clusterPlaces.first.latLong).longitude;
    double east = parseLatLngFromString(_clusterPlaces.first.latLong).longitude;

    for (var place in _clusterPlaces) {
      final lat = parseLatLngFromString(place.latLong).latitude;
      final lng = parseLatLngFromString(place.latLong).longitude;

      if (lat < south) south = lat;
      if (lat > north) north = lat;
      if (lng < west) west = lng;
      if (lng > east) east = lng;
    }

    final bounds = gmaps.LatLngBounds(
      southwest: gmaps.LatLng(south, west),
      northeast: gmaps.LatLng(north, east),
    );

    await controller.animateCamera(gmaps.CameraUpdate.newLatLngBounds(bounds, 80));
  }

  LatLng parseLatLngFromString(String? latLong) {
    if (latLong == null || !latLong.contains(',')) {
      return const LatLng(0.0, 0.0);
    }

    try {
      final parts = latLong.split(',');
      if (parts.length != 2) return const LatLng(0.0, 0.0);

      double parseCoord(String value) {
        value = value.trim().toUpperCase();
        final isNegative = value.contains('S') || value.contains('W');
        final cleaned = value.replaceAll(RegExp(r'[NSEW]'), '');
        final num = double.parse(cleaned);
        return isNegative ? -num : num;
      }

      final lat = parseCoord(parts[0]);
      final lng = parseCoord(parts[1]);

      return LatLng(lat, lng);
    } catch (e) {
      return const LatLng(0.0, 0.0);
    }
  }

  void _updateMarkers(Set<gmaps.Marker> m) {
    markers = m;
    notifyListeners();
  }

  Future<gmaps.Marker> _markerBuilder(gcluster.Cluster<DlistEntityRealmList> cluster) async {
    final isMultiple = cluster.isMultiple;
    final firstItem = cluster.items.first;

    BitmapDescriptor markerIcon;

    if (isMultiple) {
      // For clusters (multiple markers), generate cluster icon with count
      markerIcon = await _getMarkerBitmap(125, text: cluster.count.toString());
    } else {
      // For single marker, show location icon
      markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

      // OR use a custom asset icon like this:
      // markerIcon = await BitmapDescriptor.fromAssetImage(
      //     ImageConfiguration(devicePixelRatio: 2.5), 'assets/icons/location_pin.png');
    }

    return gmaps.Marker(
      markerId: gmaps.MarkerId(cluster.getId()),
      position: cluster.location,
      infoWindow: gmaps.InfoWindow(
        title: isMultiple ? '' : '${firstItem.ctname}(${firstItem.sno})',
        snippet: 'Arrears:${firstItem.arrears}Demands:${firstItem.curdem}Tot:${firstItem.dlamt}',
      ),
      onTap: () {
        if (!isMultiple) {
          // Navigate to details like in your Java code
          // Navigator.pushNamed(
          //   context,
          //   Routes.dlistAttendScreen, // Make sure this route exists
          //   arguments: {
          //     'place': firstItem, // You may want to pass `DlistEntityRealmList` directly
          //   },
          // );
        }
      },
      icon: markerIcon,
    );
  }

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    //if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(fontSize: size / 3, color: Colors.white, fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  Place? _convertToPlace(DlistEntityRealmList item) {
    try {
      final latLong = item.latLong;
      if (latLong == null || !latLong.contains(',')) return null;

      final parts = latLong.split(',');
      final lat = double.tryParse(parts[0].trim());
      final lng = double.tryParse(parts[1].trim());
      if (lat == null || lng == null) return null;

      return Place(name: item.ctname ?? 'Unknown', latLng: gmaps.LatLng(lat, lng));
    } catch (e) {
      return null;
    }
  }
}

