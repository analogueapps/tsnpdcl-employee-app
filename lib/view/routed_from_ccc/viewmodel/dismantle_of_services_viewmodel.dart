import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class DismantleOfServicesViewmodel extends ChangeNotifier {
  DismantleOfServicesViewmodel({required this.context, required this.args});
  final BuildContext context;
  final  Map<String, dynamic> args;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  TextEditingController uscNo= TextEditingController();
}