import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';



class MapDtrViewMobel extends ChangeNotifier{

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  //Filter
  String? _selectedFilter;

  String? get selectedFilter => _selectedFilter;

  final TextEditingController equipNoORStructCode = TextEditingController();

  void setSelectedFilter(String title) {
    _selectedFilter = title;
    print("$_selectedFilter: filter selected");
    notifyListeners();
  }
}