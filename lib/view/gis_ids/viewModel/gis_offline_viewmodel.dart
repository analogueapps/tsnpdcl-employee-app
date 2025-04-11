import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/view/gis_ids/database/gis_offline_list_db.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_ids_model.dart';

class OfflineGisViewModel extends ChangeNotifier {
  List<GisIdsModel> offlineGisData = [];
  bool isLoading = false;

  OfflineGisViewModel() {
    fetchOfflineGisData();
  }

  Future<void> fetchOfflineGisData() async {
    try {
      isLoading = true;
      notifyListeners();

      offlineGisData = await DatabaseHelper.instance.getAllGisIds();
    } catch (e) {
      print('Error fetching offline GIS data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}