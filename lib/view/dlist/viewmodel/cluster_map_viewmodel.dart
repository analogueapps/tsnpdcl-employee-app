import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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
  gcluster.ClusterManager<Place>? clusterManager;
  List<Place> _clusterPlaces = [];
  List<Place> get clusterPlaces => _clusterPlaces;

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

    clusterManager = gcluster.ClusterManager<Place>(
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

                _clusterPlaces = listData[0].dlistEntityRealmList!
                    .map((e) => _convertToPlace(e))
                    .whereType<Place>() // remove nulls
                    .toList();

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
    clusterManager = gcluster.ClusterManager<Place>(
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
        gmaps.CameraUpdate.newLatLngZoom(_clusterPlaces.first.latLng, 16),
      );
      return;
    }

    double south = _clusterPlaces.first.latLng.latitude;
    double north = _clusterPlaces.first.latLng.latitude;
    double west = _clusterPlaces.first.latLng.longitude;
    double east = _clusterPlaces.first.latLng.longitude;

    for (var place in _clusterPlaces) {
      final lat = place.latLng.latitude;
      final lng = place.latLng.longitude;

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

  void _updateMarkers(Set<gmaps.Marker> m) {
    markers = m;
    notifyListeners();
  }

  Future<gmaps.Marker> _markerBuilder(gcluster.Cluster<Place> cluster) async {
    final isMultiple = cluster.isMultiple;
    final firstItem = cluster.items.first;

    return gmaps.Marker(
      markerId: gmaps.MarkerId(cluster.getId()),
      position: cluster.location,
      infoWindow: gmaps.InfoWindow(
        title: isMultiple ? 'Cluster (${cluster.count})' : firstItem.name,
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
    );
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

