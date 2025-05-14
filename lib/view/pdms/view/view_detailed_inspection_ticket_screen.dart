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
                  ViewDetailedLcTileWidget(tileKey: "Ticket Id", tileValue: checkNull(viewModel.inspectionTicketEntity.ticketId.toString()), valueColor: CommonColors.colorPrimary,),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Ticket Date", tileValue: formatIsoDateForTicketDetails(checkNull(viewModel.inspectionTicketEntity.ticketDate))),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Qty For Inspection", tileValue: checkNull(viewModel.inspectionTicketEntity.qtyForInspection.toString())),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "P.O NO", tileValue: checkNull(viewModel.inspectionTicketEntity.purchaseOrderNo.toString())),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            "P.O Description".toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: doubleFive,),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.poDescription),
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Financial Year",
                    tileValue: checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.financialYear),
                  ),
                  const Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Pole Type",
                    tileValue: checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.poleType),
                  ),
                  const ViewDetailedLcHeadWidget(title: "Quantity Breakup",),
                  ViewDetailedLcTileWidget(
                    tileKey: "P.O Qty",
                    tileValue: checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.polesQuantity.toString()),
                  ),
                  const Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Balance Qty",
                    tileValue: checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.balanceQuantity.toString()),
                  ),
                  const Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Ready Qty",
                    tileValue: checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.readyQuantity.toString()),
                  ),
                  const Divider(),
                  ViewDetailedLcTileWidget(
                    tileKey: "Ticket Status",
                    tileValue: checkNull(viewModel.inspectionTicketEntity.ticketStatus?.toString()),
                    valueColor: Colors.red,
                  ),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Scheduled Date", tileValue: formatIsoDateForTicketDetailsOnlyDate(checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.insertDate))),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Time Slot", tileValue: formatIsoDateForTicketDetailsOnlyTime(checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.insertDate))),
                  const ViewDetailedLcHeadWidget(title: "Firm Details",),
                  ViewDetailedLcTileWidget(tileKey: "Firm Name", tileValue: checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.poleManufacturingFirmEntityByFirmId?.firmName)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Supplier Name", tileValue: checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.poleManufacturingFirmEntityByFirmId?.supplierName)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Contact No", tileValue: checkNull(viewModel.inspectionTicketEntity.polePurchaseOrdersEntityByPurchaseOrderNo?.poleManufacturingFirmEntityByFirmId?.mobileNo)),
                  const ViewDetailedLcHeadWidget(title: "Inspection Summary",),
                  ViewDetailedLcTileWidget(tileKey: "Tested Quantity", tileValue: checkNull(viewModel.inspectionTicketEntity.testedQuantity.toString())),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Failed Quantity", tileValue: checkNull(viewModel.inspectionTicketEntity.failedQuantity.toString())),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Passed Quantity", tileValue: checkNull(viewModel.inspectionTicketEntity.passedQuantity.toString())),
                  const ViewDetailedLcHeadWidget(title: "Approval Details",),
                  ViewDetailedLcTileWidget(tileKey: "Approved Officer", tileValue: checkNull(viewModel.inspectionTicketEntity.ticketClosedEmpName.toString())),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Officer Designation", tileValue: checkNull(viewModel.inspectionTicketEntity.ticketClosedEmpDes.toString())),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Approved Quantity", tileValue: checkNull(viewModel.inspectionTicketEntity.approvedQuantity.toString())),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Ticket Closed Date", tileValue: checkNull(viewModel.inspectionTicketEntity.closedDate.toString())),
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
