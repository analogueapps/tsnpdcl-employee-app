import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/designation_utils.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/status_codes.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/view_detailed_lc_viewmodel.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_request_indent_entity.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/view_detailed_inspection_ticket_viewmodel.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/view_detailed_pole_indent_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_image_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class ViewDetailedInspectionTicketScreen extends StatelessWidget {
  static const id = Routes.viewDetailedInspectionTicketScreen;
  final String data;

  const ViewDetailedInspectionTicketScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ViewDetailedInspectionTicketViewmodel(context: context, data: data),
      child: Consumer<ViewDetailedInspectionTicketViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "View Ticket".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "#${viewModel.inspectionTicketEntity.ticketId}",
                    style: const TextStyle(fontSize: normalSize, color: Colors.grey),
                  ),
                ],
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const ViewDetailedLcHeadWidget(title: "Ticket Details",),
                  ViewDetailedLcTileWidget(tileKey: "Ticket Id", tileValue: checkNull(viewModel.inspectionTicketEntity?.ticketId.toString()), valueColor: CommonColors.colorPrimary,),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Ticket Date", tileValue: formatIsoDateForTicketDetails(checkNull(viewModel.inspectionTicketEntity?.ticketDate))),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Qty For Inspection", tileValue: checkNull(viewModel.inspectionTicketEntity?.qtyForInspection.toString())),
                  const Divider(),
                  const SizedBox(height: doubleTen,),
                ],
              ),
            ),
            bottomNavigationBar: Visibility(
              visible: viewModel.isButtonVisible,
              child: Padding(
                padding: const EdgeInsets.all(doubleTwenty),
                child: PrimaryButton(
                    fullWidth: isTrue,
                    buttonColor: viewModel.buttonColor,
                    text: viewModel.buttonText.toUpperCase(),
                    onPressed: () {
                      if (viewModel.buttonAction != null) {
                        viewModel.buttonAction!();
                      }
                    }
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
