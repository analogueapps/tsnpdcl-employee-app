import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dlist/helper/find_service_search_dialog.dart';
import 'package:tsnpdcl_employee/view/dlist/model/dfilter.dart';
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

  String _titleText = "Showing All Distributions";
  String get titleText => _titleText;

  List<DlistEntityRealmList> _dlistEntityRealmList = [];
  List<DlistEntityRealmList> get dlistEntityRealmList => _dlistEntityRealmList;

  DFilter? dFilter;

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
      await clusterManager?.setMapId(_mapController!.mapId);
      clusterManager?.updateMap();
      await moveToClusterBounds(); // Move camera after updateMap
    }

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
                _dlistEntityRealmList = listData[0].dlistEntityRealmList!;
                notifyListeners();
                addRealmItems();
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

    print("Moving camera to ${_clusterPlaces.map((e) => e.latLong)}");

    if (_clusterPlaces.length == 1) {
      await controller.animateCamera(
        gmaps.CameraUpdate.newLatLngZoom(parseLatLngFromString(_clusterPlaces.first.latLong), 16),
      );
      return;
    }

    if (_clusterPlaces.length > 1) {
      await controller.animateCamera(
        gmaps.CameraUpdate.newLatLngZoom(parseLatLngFromString(_clusterPlaces.first.latLong), 10),
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
    notifyListeners();
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
      final style = _formatClusterStyle(cluster.count);
      markerIcon = await _getMarkerBitmap(125, text: style.text, bgColor: style.color);
    } else {
      markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }

    return gmaps.Marker(
      markerId: gmaps.MarkerId(cluster.getId()),
      position: cluster.location,
      infoWindow: gmaps.InfoWindow(
        title: isMultiple ? '' : '${firstItem.ctname}(${firstItem.sno})',
        snippet: 'Arrears:${firstItem.arrears} Demands:${firstItem.curdem} Tot:${firstItem.dlamt}',
      ),
      onTap: () {
        if (!isMultiple) {
          Navigation.instance.navigateTo(Routes.dlistAttendScreen, args: jsonEncode(firstItem));
        }
      },
      icon: markerIcon,
    );
  }

  String _formatClusterCount(int count) {
    if (count >= 1000) {
      return '1000+';
    } else if (count >= 100) {
      return '100+';
    } else if (count >= 50) {
      return '50+';
    } else if (count >= 20) {
      return '20+';
    } else if (count >= 10) {
      return '10+';
    }
    return count.toString();
  }

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {required String text, required Color bgColor}) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Paint circlePaint = Paint()..color = bgColor;
    final double radius = size / 2;

    canvas.drawCircle(Offset(radius, radius), radius, circlePaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: size / 4,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(radius - textPainter.width / 2, radius - textPainter.height / 2),
    );

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
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

  void filterFabClicked() {
    var argument = {
      //"filter": jsonEncode(dFilter),
      "data": jsonEncode(_dlistEntityRealmList)
    };

    if (dFilter != null) {
      argument["filter"] = jsonEncode(dFilter);
    }

    Navigation.instance.navigateTo(Routes.dlistFilterScreen, args: argument,onReturn: (result) {
      if(result != null) {
        dFilter = DFilter.fromJson(jsonDecode(result));
        String d = 'Showing ${dFilter!.distributionName} - ${dFilter!.distributionCode}\n'
            'Amount Range: ${dFilter!.amountFrom} - ${dFilter!.amountTo}';
        _titleText = d;
        notifyListeners();
        addRealmItems();
      }
    });
  }

  Future<void> addRealmItems() async {

    if (dFilter != null) {
      List<String> statusCodes = [];

      if (dFilter!.bsSelected) statusCodes.add("99");
      if (dFilter!.udcSelected) statusCodes.add("03");
      if (dFilter!.liveSelected) statusCodes.add("01");

      List<DlistEntityRealmList> filteredList = _dlistEntityRealmList.where((item) {
        return item.ctareacd == dFilter?.distributionCode &&
            statusCodes.contains(item.dlstat) &&
            item.dlamt != null &&
            item.dlamt! >= dFilter!.amountFrom &&
            item.dlamt! <= dFilter!.amountTo;
      }).toList();

      _clusterPlaces = filteredList;
    } else {
      _clusterPlaces = _dlistEntityRealmList;
    }

    if (googleMapController.isCompleted) {
      final controller = await googleMapController.future;
      setController(controller);
      await initClusterManager();
    }
    // Automatically move camera to bounds
    Future.delayed(const Duration(milliseconds: 500), () {
      moveToClusterBounds();
    });
    notifyListeners();
  }

  Future<void> findServiceClicked() async {
    final selectedItem = await showCupertinoModalPopup(
      context: context,
      builder: (_) => FindServiceSearchDialog(items: _dlistEntityRealmList),
    );

    if (selectedItem != null) {
      // Do something with selectedItem
      //print('Selected SC No: ${selectedItem.dlscno}');
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Choose Option"),
            actions: [
              CupertinoDialogAction(
                child: const Text("Show Location"),
                onPressed: () async {
                  Navigator.pop(context); // Close dialog
                  // _mapController!.animateCamera(
                  //   CameraUpdate.newLatLngZoom(selectedItem.position, 28),
                  // );
                  final latLng = parseLatLngFromString(selectedItem.latLong);
                  final controller = await googleMapController.future;

                  controller.animateCamera(
                    CameraUpdate.newLatLngZoom(latLng, 28),
                  );
                  notifyListeners();
                },
              ),
              CupertinoDialogAction(
                child: const Text("Open Entry Form"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigation.instance.navigateTo(Routes.dlistAttendScreen, args: jsonEncode(selectedItem));
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          );
        },
      );
    }
  }
}

class ClusterStyle {
  final String text;
  final Color color;

  ClusterStyle(this.text, this.color);
}

ClusterStyle _formatClusterStyle(int count) {
  if (count >= 1000) {
    return ClusterStyle('1000+', Colors.red.shade900);
  } else if (count >= 200) {
    return ClusterStyle('200+', Colors.brown.shade700);
  } else if (count >= 100) {
    return ClusterStyle('100+', Colors.green.shade700);
  } else if (count >= 10) {
    return ClusterStyle('10+', Colors.blue.shade900);
  }
  return ClusterStyle(count.toString(), Colors.deepPurple.shade700);
}


