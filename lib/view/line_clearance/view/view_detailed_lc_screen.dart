import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/view_detailed_lc_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_image_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';


class ViewDetailedLcScreen extends StatelessWidget {
  static const id = Routes.viewDetailedLcScreen;
  final String lcId;

  const ViewDetailedLcScreen({
    super.key,
    required this.lcId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ViewDetailedLcViewModel(context: context, lcId: lcId),
      child: Consumer<ViewDetailedLcViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "View line clearance".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    "#$lcId",
                    style: const TextStyle(fontSize: normalSize, color: Colors.grey),
                  ),
                ],
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.getDetailedLcView == null
                ? const Center(child: Text("Please try again."),)
                : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: doubleFive,),
                  ViewDetailedLcTileWidget(tileKey: "Lc no", tileValue: checkNull(viewModel.getDetailedLcView!.lcId)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Ss name", tileValue: checkNull(viewModel.getDetailedLcView!.ssName)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Ss code", tileValue: checkNull(viewModel.getDetailedLcView!.ssCode)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Feeder name", tileValue: checkNull(viewModel.getDetailedLcView!.fdrName), valueColor: CommonColors.colorPrimary,),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Feeder code", tileValue: checkNull(viewModel.getDetailedLcView!.fdrCode), valueColor: CommonColors.colorPrimary,),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Voltage", tileValue: checkNull(viewModel.getDetailedLcView!.voltage)),
                  const ViewDetailedLcHeadWidget(title: "Lc requested staff details"),
                  ViewDetailedLcTileWidget(tileKey: "Emp name", tileValue: checkNull(viewModel.getDetailedLcView!.employeeMasterEntityByLcRequestedEmpId!.empName)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Designation", tileValue: checkNull(viewModel.getDetailedLcView!.employeeMasterEntityByLcRequestedEmpId!.designation)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Contact no", tileValue: checkNull(viewModel.getDetailedLcView!.employeeMasterEntityByLcRequestedEmpId!.personalMobileNo)),
                  const ViewDetailedLcHeadWidget(title: "Lc approved by"),
                  Visibility(
                    visible: viewModel.getDetailedLcView!.employeeMasterEntityByLcApprovedEmpId != null,
                    child: Column(
                      children: [
                        ViewDetailedLcTileWidget(tileKey: "Emp name", tileValue: checkNull(viewModel.getDetailedLcView!.employeeMasterEntityByLcApprovedEmpId?.empName),),
                        const Divider(),
                        ViewDetailedLcTileWidget(tileKey: "Designation", tileValue: checkNull(viewModel.getDetailedLcView!.employeeMasterEntityByLcApprovedEmpId?.designation),),
                        const Divider(),
                        ViewDetailedLcTileWidget(tileKey: "Contact no", tileValue: checkNull(viewModel.getDetailedLcView!.employeeMasterEntityByLcApprovedEmpId?.personalMobileNo),),
                        const Divider(),
                      ],
                    ),
                  ),
                  ViewDetailedLcTileWidget(tileKey: "Lc requested date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.requestDate)),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Expected start date", tileValue: checkNull(viewModel.getDetailedLcView!.expLcStartDate),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Expected start time", tileValue: checkNull(viewModel.getDetailedLcView!.expLcStartTime),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Expected end date", tileValue: checkNull(viewModel.getDetailedLcView!.expLcEndDate),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Expected end time", tileValue: checkNull(viewModel.getDetailedLcView!.expLcEndTime),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "${"Expected lc duration".toUpperCase()}(Hrs)", tileValue: checkNull(viewModel.getDetailedLcView!.expLcDuration),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lc purpose", tileValue: checkNull(viewModel.getDetailedLcView!.lcPurpose),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lm remarks", tileValue: checkNull(viewModel.getDetailedLcView!.lmRemarks),),
                  const ViewDetailedLcHeadWidget(title: "Ab switch opened image"),
                  ViewDetailedLcImageWidget(imageUrl: checkNull(viewModel.getDetailedLcView!.lmAbOpenImage),),
                  ViewDetailedLcTileWidget(tileKey: "Lm ab sw open lat", tileValue: checkNull(viewModel.getDetailedLcView!.lmAbOpenLat?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lm ab sw open lon", tileValue: checkNull(viewModel.getDetailedLcView!.lmAbOpenLon?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lm ab sw open date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.lmAbImgDate)),),
                  const ViewDetailedLcHeadWidget(title: "Scada breaker local image"),
                  ViewDetailedLcImageWidget(imageUrl: checkNull(viewModel.getDetailedLcView!.lmLocalImage),),
                  ViewDetailedLcTileWidget(tileKey: "Lm local done lat", tileValue: checkNull(viewModel.getDetailedLcView!.lmLocalOpenLat?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lm local done lon", tileValue: checkNull(viewModel.getDetailedLcView!.lmLocalOpenLon?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lm local done date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.lmLocalImgDate)),),
                  Visibility(
                    visible: viewModel.getDetailedLcView!.employeeMasterEntityByFieldStaffEmployeeId != null,
                    child: Column(
                      children: [
                        const ViewDetailedLcHeadWidget(title: "Field images by"),
                        ViewDetailedLcTileWidget(tileKey: "Emp name", tileValue: checkNull(viewModel.getDetailedLcView!.employeeMasterEntityByFieldStaffEmployeeId?.empName),),
                        const Divider(),
                        ViewDetailedLcTileWidget(tileKey: "Designation", tileValue: checkNull(viewModel.getDetailedLcView!.employeeMasterEntityByFieldStaffEmployeeId?.designation),),
                        const Divider(),
                        ViewDetailedLcTileWidget(tileKey: "Contact no", tileValue: checkNull(viewModel.getDetailedLcView!.employeeMasterEntityByFieldStaffEmployeeId?.personalMobileNo),),
                      ],
                    ),
                  ),
                  const ViewDetailedLcHeadWidget(title: "Local earthing image"),
                  ViewDetailedLcImageWidget(imageUrl: checkNull(viewModel.getDetailedLcView!.localEarthingImage),),
                  ViewDetailedLcTileWidget(tileKey: "Local earthing lat", tileValue: checkNull(viewModel.getDetailedLcView!.localEarthLat?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Local earthing lon", tileValue: checkNull(viewModel.getDetailedLcView!.localEarthLon?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Local earthing date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.localEartImgDate)),),
                  const ViewDetailedLcHeadWidget(title: "Local earthing removed image"),
                  ViewDetailedLcImageWidget(imageUrl: checkNull(viewModel.getDetailedLcView!.localEarthingRemoveImage),),
                  ViewDetailedLcTileWidget(tileKey: "Local earthing removed lat", tileValue: checkNull(viewModel.getDetailedLcView!.localEarthRmvLat?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Local earthing removed lon", tileValue: checkNull(viewModel.getDetailedLcView!.localEarthRmvLon?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Local earthing removed date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.localEarthRemoveImgDate)),),
                  const ViewDetailedLcHeadWidget(title: "Scada breaker remote image"),
                  ViewDetailedLcImageWidget(imageUrl: checkNull(viewModel.getDetailedLcView!.lmRemoteImage),),
                  ViewDetailedLcTileWidget(tileKey: "Lm remote done lat", tileValue: checkNull(viewModel.getDetailedLcView!.lmRemoteOpenLat?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lm remote done lon", tileValue: checkNull(viewModel.getDetailedLcView!.lmRemoteOpenLon?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lm remote done date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.lmRemoteImgDate)),),
                  const ViewDetailedLcHeadWidget(title: "Lm ab close image"),
                  ViewDetailedLcImageWidget(imageUrl: checkNull(viewModel.getDetailedLcView!.lmAbCloseImage),),
                  ViewDetailedLcTileWidget(tileKey: "Lm ab close lat", tileValue: checkNull(viewModel.getDetailedLcView!.lmAbCloseLat?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lm ab close lon", tileValue: checkNull(viewModel.getDetailedLcView!.lmAbCloseLon?.toString()),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lm ab close date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.lmAbClsdImgDate)),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Scada cb open ref", tileValue: checkNull(viewModel.getDetailedLcView!.scadaCbRef),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Scada cb open date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.scadaCbOpenDate)),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Scada cb close date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.scadaCbCloseDate)),),
                  const ViewDetailedLcHeadWidget(title: "Section details"),
                  ViewDetailedLcTileWidget(tileKey: "Section id", tileValue: checkNull(viewModel.getDetailedLcView!.sectionId),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Ae emp id", tileValue: checkNull(viewModel.getDetailedLcView!.aeEmpId),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Ade emp id", tileValue: checkNull(viewModel.getDetailedLcView!.adeEmpId),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lc approved emp id", tileValue: checkNull(viewModel.getDetailedLcView!.lcApprovedEmpId),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Lc approved date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.lcApprovedDate)),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Cb close requested emp id", tileValue: checkNull(viewModel.getDetailedLcView!.cbCloseReqEmpId),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Cb close requested date", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.cbCloseReqDate)),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Status", tileValue: checkNull(viewModel.getDetailedLcView!.status),),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    color: Colors.grey[200],
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "In line field staff list".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: viewModel.getDetailedLcView?.inLineLCStaffEntitiesByLcId != null &&
                        viewModel.getDetailedLcView!.inLineLCStaffEntitiesByLcId!.isNotEmpty,
                    child: Column(
                      children: viewModel.getDetailedLcView!.inLineLCStaffEntitiesByLcId!
                          .map((staffEntity) => Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            color: Colors.grey[200],
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Staff details".toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: doubleFive,),
                          ViewDetailedLcTileWidget(
                            tileKey: "Emp ID",
                            tileValue: checkNull(staffEntity.fieldStaffEmpId),
                          ),
                          const Divider(),
                          ViewDetailedLcTileWidget(
                            tileKey: "Emp Name",
                            tileValue: checkNull(staffEntity.fieldStaffEmpName),
                          ),
                          const Divider(),
                          ViewDetailedLcTileWidget(
                            tileKey: "Designation",
                            tileValue: checkNull(staffEntity.fieldStaffEmpDesignation),
                          ),
                          const SizedBox(height: doubleFive,),
                        ],
                      ))
                          .toList(),

                    ),
                  ),
                  // ViewDetailedLcTileWidget(tileKey: "Emp is", tileValue: checkNull(viewModel.getDetailedLcView!.inLineLCStaffEntitiesByLcId![0].fieldStaffEmpId)),
                  // const Divider(),
                  // ViewDetailedLcTileWidget(tileKey: "Emp name", tileValue: checkNull(viewModel.getDetailedLcView!.inLineLCStaffEntitiesByLcId![0].fieldStaffEmpName)),
                  // const Divider(),
                  // ViewDetailedLcTileWidget(tileKey: "Designation", tileValue: checkNull(viewModel.getDetailedLcView!.inLineLCStaffEntitiesByLcId![0].fieldStaffEmpDesignation)),
                  const ViewDetailedLcHeadWidget(title: "Ss op details"),
                  ViewDetailedLcTileWidget(tileKey: "Cb open date by ss operator", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.ssOpCbOpenDate)),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Cb open ss op name", tileValue: checkNull(viewModel.getDetailedLcView!.ssOpCbOpenEmpName)),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Cb close date by ss operator", tileValue: formatIsoDateForLcDetails(checkNull(viewModel.getDetailedLcView!.ssOpCbCloseDate)),),
                  const Divider(),
                  ViewDetailedLcTileWidget(tileKey: "Cb close ss op name", tileValue: checkNull(viewModel.getDetailedLcView!.ssOpCbCloseEmpName)),
                  const SizedBox(height: doubleTen,),
                ],
              ),

            ),
          );
        },
      ),
    );
  }
}
