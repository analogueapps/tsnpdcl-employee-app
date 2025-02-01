import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_dispatch_instructions_entity.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/dispatch_instructions_details_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class DispatchInstructionsDetailsTab extends StatelessWidget {
  final PoleDispatchInstructionsEntity poleDispatchInstructionsEntity;

  const DispatchInstructionsDetailsTab({super.key, required this.poleDispatchInstructionsEntity});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DispatchInstructionsDetailsViewModel(context: context, poleDispatchInstructionsEntity: poleDispatchInstructionsEntity),
      child: Consumer<DispatchInstructionsDetailsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: doubleFive,),
                  ViewDetailedLcTileWidget(tileKey: "Dispatch Inst Id", tileValue: checkNull(viewModel.poleDispatchInstructionsEntity.dispatchInstructionId.toString()), valueColor: CommonColors.colorPrimary,),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "D.I Issued Qty", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.qtyToBeDispatched.toString())),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "D.I Date", tileValue: formatIsoDateForDiDetails(checkNull(viewModel.poleDispatchInstructionsEntity.diDate))),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Dispatch Pending Qty", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.dispatchPendingQty.toString())),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Form-13 Issued Qty", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.form13IssuedQty.toString())),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Form-13 Issued Date", tileValue: formatIsoDateForDiDetails(checkNull(viewModel.poleDispatchInstructionsEntity.form13IssuedDate))),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Section", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.section)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "D.I Status", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.diStatus)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "D.I Issued By", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.employeeMasterEntityByDiAdeEmpId!.empName)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Designation", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.employeeMasterEntityByDiAdeEmpId!.designation)),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(doubleFive),
                    child: PrimaryButton(
                        text: "Download D.I".toUpperCase(),
                        fullWidth: isTrue,
                        onPressed: () {
                          viewModel.downloadDispatchInstructions();
                        }
                    ),
                  ),
                  const ViewDetailedLcHeadWidget(title: "P.O Details"),
                  ViewDetailedLcTileWidget(tileKey: "Purchase Order No", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.polePurchaseOrdersEntityByPurchaseOrderNo!.purchaseOrderNo)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "P.O Description", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.polePurchaseOrdersEntityByPurchaseOrderNo!.poDescription)),
                  const ViewDetailedLcHeadWidget(title: "Firm Details"),
                  ViewDetailedLcTileWidget(tileKey: "Firm Name", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.poleManufacturingFirmEntityByFirmId!.firmName)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Supplier Name", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.poleManufacturingFirmEntityByFirmId!.supplierName)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Contact No", tileValue:  checkNull(viewModel.poleDispatchInstructionsEntity.poleManufacturingFirmEntityByFirmId!.mobileNo)),
                  const SizedBox(height: doubleTen,),
                ],
              ),
            ),
            bottomNavigationBar: Visibility(
              visible: viewModel.poleDispatchInstructionsEntity.form13IssuedQty == null || viewModel.poleDispatchInstructionsEntity.form13IssuedQty == 0,
              child: Padding(
                padding: const EdgeInsets.all(doubleTwenty),
                child: PrimaryButton(
                    text: "Submit Form-13 Issued Qty".toUpperCase(),
                    fullWidth: isTrue,
                    onPressed: () {
                      viewModel.submitForm();
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

