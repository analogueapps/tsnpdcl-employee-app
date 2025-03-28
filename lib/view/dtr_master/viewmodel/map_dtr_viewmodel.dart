import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';

class MapDtrViewMobel extends ChangeNotifier {
  MapDtrViewMobel({required this.context});
  final BuildContext context;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;
  
  final formKey = GlobalKey<FormState>();
  final TextEditingController equipNoORStructCode = TextEditingController();

  String? _selectedFilter;
  String? get selectedFilter => _selectedFilter;

  String? _selectedDistribution;
  String? get selectedDistribution => _selectedDistribution;

  // List<Option> _circles = [];
  List _distributions = ["RTC", "Nakkalagutta", "Ramnagar"];
  List get distributions => _distributions;

  void onListDistriSelected(String? value) {
    _selectedDistribution = value;
    notifyListeners();
  }

  //Feeder wise
  //1. Circle
  String? _selectedCircle;
  String? get selectedCircle => _selectedCircle;

  // List<Option> _circles = [];
  List _circle = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get circle => _circle;

  void onListCircleSelected(String? value) {
    _selectedCircle = value;
    notifyListeners();
  }

  // 2.station
  String? _selectedStation;
  String? get selectedStation => _selectedStation;

  List _station = ["KHA", "ANGALp", "ADILA"];

  List get station => _station;
  void onListStationSelected(String? value) {
    _selectedStation = value;
    notifyListeners();
  }

//3.feeder
  String? _selectedFeeder;
  String? get selectedFeeder => _selectedFeeder;

  List _feeder = ["RTC", "Nakkalagutta", "Ramnagar"];
  List get feeder => _feeder;

  void onListFeederSelected(String? value) {
    _selectedFeeder = value;
    notifyListeners();
  }

  void setSelectedFilter(String title) {
    _selectedFilter = title;
    print("$_selectedFilter: filter selected");
    notifyListeners();
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      }
    }
  }
    bool validateForm() {
      if (_selectedFilter==''||_selectedFilter==null) {
        AlertUtils.showSnackBar(context, "Please select any one filter option", isTrue);
        print("Please select any one filter option");
        return false;
      }
      if (_selectedFilter=="Equipment/Structure search" && equipNoORStructCode.text.isEmpty ) {
        AlertUtils.showSnackBar(
            context, "Please Enter Your Equipment No/Structure Code",
            isTrue);
        return false;
      } else if (_selectedFilter=="Distribution wise" && selectedDistribution==null) {
        AlertUtils.showSnackBar(
            context, "Please select Distribution",
            isTrue);
        return false;
      }else if (_selectedFilter=="Feeder wise" && selectedCircle==null) {
        AlertUtils.showSnackBar(
            context, "Please select Circle",
            isTrue);
        return false;
      }else if ((_selectedFilter=="Feeder wise" &&selectedCircle!=null) && selectedStation==null) {
        AlertUtils.showSnackBar(
            context, "Please select Station",
            isTrue);
        return false;
      }else if (((_selectedFilter=="Feeder wise"&&selectedCircle!=null)&&selectedStation!=null) && selectedFeeder==null) {
        AlertUtils.showSnackBar(
            context, "Please select Feeder",
            isTrue);
        return false;
      }
      return true;
    }
  }