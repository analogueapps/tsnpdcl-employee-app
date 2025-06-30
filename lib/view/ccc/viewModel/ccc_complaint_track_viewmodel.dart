import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/ccc/model/complaint_track_model.dart';

class CccComplaintTrackViewmodel extends ChangeNotifier {
  CccComplaintTrackViewmodel({required this.context, required this.ticketId}) {
    complaintTrack();
  }

  final BuildContext context;
  final String ticketId;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<CCCComplaintTrack> _complaintCount = [];
  List<CCCComplaintTrack> get complaintCount => _complaintCount;

  Future<void> complaintTrack() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ticketId": ticketId,
    };
    var response = await ApiProvider(baseUrl: Apis.CCC_END_POINT_BASE_URL)
        .postApiCall(context, Apis.COMPLAINT_STATUS, payload);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == true) {
            if (response.data['taskSuccess'] == true) {
              final dataListRaw = response.data['dataList'];
              if (dataListRaw != null && dataListRaw.isNotEmpty) {
                List<dynamic> jsonList;
                if (dataListRaw is String) {
                  jsonList = jsonDecode(dataListRaw);
                } else if (dataListRaw is List) {
                  jsonList = dataListRaw;
                } else {
                  jsonList = [];
                }

                final List<CCCComplaintTrack> dataList = jsonList.map((item) {
                  final cccData = item['cccComplaint'];
                  return CCCComplaintTrack.fromJson(cccData);
                }).toList();

                _complaintCount.addAll(dataList);
                print("data added in _complaintCount");
                notifyListeners();
              }
            } else {
              showErrorDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      throw Exception("Exception Occurred while Authenticating");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
