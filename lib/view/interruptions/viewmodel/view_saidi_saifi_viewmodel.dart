import 'package:flutter/material.dart';

class ViewSaidiSaifiViewmodel extends ChangeNotifier {
  Map<String, dynamic>? _selectedMonthYear;

  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;

  void setSelectedMonthYear(String month, int year, BuildContext context) {
    _selectedMonthYear = {'month': month, 'year': year};
    notifyListeners();
    // Add additional logic here if needed (e.g., API calls)
  }
}