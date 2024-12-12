import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';

class AuthViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  // Controllers for Employee login
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController empPassController = TextEditingController();

  // Controllers for Corporate Login
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPassController = TextEditingController();

  // State variables
  bool isChecked = false; // For the checkbox
  bool isLoading = false; // For showing progress indicator

  // Form Keys
  final employeeFormKey = GlobalKey<FormState>(); // For Employee
  final corporateFormKey = GlobalKey<FormState>(); // For Corporate

  // App version
  String appVersion = 'Unknown';

  AuthViewmodel({required this.context,}) {
    _initPackageInfo();
  }

  // Package Info method
  Future<void> _initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //_appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
    appVersion = packageInfo.version;
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }

  // API call simulation
  Future<void> authenticateEmployee() async {
    if (employeeFormKey.currentState!.validate()) {
      employeeFormKey.currentState!.save();
      notifyListeners();
      Navigation.instance.pushAndRemoveUntil(Routes.universalDashboardScreen);
      notifyListeners();
    } else if (empIdController.text.isEmpty && empPassController.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Please enter valid employee ID and password", isTrue);
    } else if (empIdController.text.length < 5) {
      AlertUtils.showSnackBar(context, "Please enter a valid employee ID", isTrue);
    } else if (empPassController.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Password cannot be left blank", isTrue);
    } else {
      AlertUtils.showSnackBar(context, "Check all fields", isTrue);
    }
  }

  // API call simulation
  Future<void> authenticateUser() async {
    if (corporateFormKey.currentState!.validate()) {
      corporateFormKey.currentState!.save();
      notifyListeners();

      notifyListeners();
    } else if (userNameController.text.isEmpty && userPassController.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Please enter valid user name and password", isTrue);
    } else if (userNameController.text.length < 2) {
      AlertUtils.showSnackBar(context, "Please enter a valid user name", isTrue);
    } else if (userPassController.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Password cannot be left blank", isTrue);
    } else {
      AlertUtils.showSnackBar(context, "Check all fields", isTrue);
    }
  }


}
