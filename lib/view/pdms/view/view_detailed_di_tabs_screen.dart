import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_dispatch_instructions_entity.dart';
import 'package:tsnpdcl_employee/view/pdms/view/dispatch_instructions_details_tab.dart';
import 'package:tsnpdcl_employee/view/pdms/view/shipping_details_tab.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewDetailedDiTabsScreen extends StatefulWidget {
  static const id = Routes.viewDetailedDiTabsScreen;
  final String data;

  const ViewDetailedDiTabsScreen({
    super.key,
    required this.data,
  });

  @override
  State<ViewDetailedDiTabsScreen> createState() => _ViewDetailedDiTabsScreenState();
}

class _ViewDetailedDiTabsScreenState extends State<ViewDetailedDiTabsScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;
  late PoleDispatchInstructionsEntity poleDispatchInstructionsEntity;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    poleDispatchInstructionsEntity = PoleDispatchInstructionsEntity.fromJson(jsonDecode(widget.data));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              poleDispatchInstructionsEntity.purchaseOrderNo ?? "N/A",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700
              ),
            ),
            Text(
              checkNull(poleDispatchInstructionsEntity.poleManufacturingFirmEntityByFirmId!.firmName),
              style: const TextStyle(fontSize: normalSize, color: Colors.grey),
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              downloadDispatchInstructions();
            },
            icon: const Icon(Icons.file_download_outlined, color: Colors.white,),
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                  text: 'D.I DETAILS'
              ),
              Tab(
                text: 'SHIPPING',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                DispatchInstructionsDetailsTab(poleDispatchInstructionsEntity: poleDispatchInstructionsEntity,),
                ShippingDetailsTab(poleDispatchInstructionsEntity: poleDispatchInstructionsEntity,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadDispatchInstructions() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Requesting Link...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "diId": poleDispatchInstructionsEntity.dispatchInstructionId,
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.REQUEST_DI_DOWNLOAD_LINK_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['data'] != null) {
                final Uri url = Uri.parse(response.data['data']);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              } else {
                showAlertDialog(context,"Download link generation failed.");
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }
  }
}
