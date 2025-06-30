import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/meeseva/model/days_pending_meeseva_abstract.dart';
import 'package:tsnpdcl_employee/view/meeseva/model/load_applications_list.dart';

class ServicesAppListViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final Map<String, dynamic> data;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<LoadApplicationsList> _loadApplicationsList = [];
  List<LoadApplicationsList> get loadApplicationsList => _loadApplicationsList;

  final List<LoadApplicationsList> _filterApplicationsList = [];
  List<LoadApplicationsList> get filterApplicationsList =>
      _filterApplicationsList;

  ServicesAppListViewmodel({required this.context, required this.data}) {
    loadApplications();
  }

  Future<void> loadApplications() async {
    _isLoading = true;
    _loadApplicationsList.clear();
    _filterApplicationsList.clear();
    notifyListeners();

    print(data['lmEmp']);

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "fromDate": "123456",
      "toDate": "12342134",
      "ncflag": data['ncflag'],
      "status": data['s'],
    };

    if (data['sc'] != null) {
      requestData['sc'] = data['sc'];
    }

    final payload = {
      "path": "/api/loadapplications",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = false;
    notifyListeners();
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
                final List<LoadApplicationsList> responseList = jsonList
                    .map((json) => LoadApplicationsList.fromJson(json))
                    .toList();
                _loadApplicationsList.addAll(responseList);
                if (data['filterLm'] != null && data['lmEmp'] != null) {
                  for (var applications in _loadApplicationsList) {
                    if (data['name'] != null) {
                      if (data['name'].toLowerCase() == "ae" ||
                          data['name'].toLowerCase() == "ade/op") {
                        _filterApplicationsList.add(applications);
                      }
                    }

                    if ((applications.aAllotLmEmp != null &&
                            applications.aAllotLmEmp!.empId == data['lmEmp']) ||
                        (applications.fAllotLmEmp != null &&
                            applications.fAllotLmEmp!.empId == data['lmEmp'])) {
                      _filterApplicationsList.add(applications);
                    }
                  }
                } else {
                  _filterApplicationsList.addAll(_loadApplicationsList);
                }
                notifyListeners();
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
}
