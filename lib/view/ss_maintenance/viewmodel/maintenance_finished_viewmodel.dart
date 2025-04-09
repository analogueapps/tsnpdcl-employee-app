import 'package:flutter/cupertino.dart';

class MaintenanceFinishedViewmodel extends ChangeNotifier {
  final BuildContext context;
  final List<Map<String, String>> _maintenanceItems = [
    {
      "id": "#90204",
      "name": "0003-33kv ss-nakkalagutta",
      "date": "25/06/2024 03:54 PM",
    },
    {
      "id": "#90205",
      "name": "0004-33kv ss-karimnagar",
      "date": "26/06/2024 10:30 AM",
    },
    {
      "id": "#90206",
      "name": "0005-33kv ss-warangal",
      "date": "27/06/2024 02:15 PM",
    },
  ];

  List<Map<String, String>> _filteredItems = [];

  List<Map<String, String>> get maintenanceItems => _filteredItems;

  String _searchQuery = '';

  MaintenanceFinishedViewmodel({required this.context}) {
    _filteredItems = List.from(_maintenanceItems);
    print("Initial items: ${_filteredItems.length}");
    notifyListeners();
  }

  void filterItems(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _filteredItems = List.from(_maintenanceItems);
    } else {
      _filteredItems = _maintenanceItems.where((item) {
        return item["id"]!.toLowerCase().contains(_searchQuery) ||
            item["name"]!.toLowerCase().contains(_searchQuery) ||
            item["date"]!.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    print("Filtered items: ${_filteredItems.length}, Query: $_searchQuery");
    notifyListeners();
  }
}