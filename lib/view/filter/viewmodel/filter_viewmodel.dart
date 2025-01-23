import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class FilterViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  String jsonResponse;

  final TextEditingController searchController = TextEditingController();

  List<FilterLabelModelList> filters = [];
  FilterLabelModelList? selectedFilter;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<OptionList> _originalOptionList = []; // Full list of options
  List<OptionList> _filteredOptionList = []; // Filtered list based on search query
  List<OptionList> get filteredOptionList => _filteredOptionList;

  // Constructor to initialize the items
  FilterViewModel({required this.context, required this.jsonResponse}) {
    loadFilters();
  }

  void loadFilters() {
    // Parse the JSON response and update the filters list
    filters = (jsonDecode(jsonResponse) as List)
        .map((e) => FilterLabelModelList.fromJson(e))
        .toList();
    if (filters.isNotEmpty) {
      selectedFilter = filters.first; // Default to the first filter
      _originalOptionList = selectedFilter!.optionList!;
      _filteredOptionList = List.from(_originalOptionList);
    }
    notifyListeners();

  }

  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _filteredOptionList = _originalOptionList
        .where((option) =>
        option.optionName!.toLowerCase().contains(_searchQuery))
        .toList();
    notifyListeners();
  }

  void selectFilter(FilterLabelModelList filter) {
    selectedFilter = filter;
    _searchQuery = "";
    _originalOptionList = selectedFilter!.optionList!;
    _filteredOptionList = List.from(_originalOptionList);
    notifyListeners();
  }

  void toggleOptionSelection(OptionList option) {
    option.isSelected = !option.isSelected!;
    notifyListeners();
  }

  void clearFilters() {
    for (var filter in filters) {
      for (var option in filter.optionList!) {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }
}
