
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_inspection_sheet_entity.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_ht_side_group_controller_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_image_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class DtrHtSideGroupControllerScreen extends StatelessWidget {
  const DtrHtSideGroupControllerScreen({super.key, required this.data, required this.selectedOption});
  final String data;
  final String? selectedOption;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: ChangeNotifierProvider(
       create: (_) {
         final viewModel = DtrHtSideGroupControllerViewmodel();
         viewModel.loadData(data); // 👈 Load data from constructor argument
         return viewModel;
       },
    child:Consumer<DtrHtSideGroupControllerViewmodel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(doubleFive),
              child:_buildGroupSpecificWidgets(viewModel.dtrInspectionSheetEntity, selectedOption),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildGroupSpecificWidgets(DtrInspectionSheetEntity? dtrInspectionSheetEntity, String? optionId) {
  switch (optionId) {
    case "HT_SIDE":
      return Column(children: [
        ViewDetailedLcTileWidget(
            tileKey: "ab s/w available".toUpperCase(),
            tileValue: dtrInspectionSheetEntity?.abSwitchAvailable == "Y"
                ? "Available"
                : "Not Available"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "ab s/w type".toUpperCase(),
            tileValue: dtrInspectionSheetEntity!.abSwitchType),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "ab s/w status".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.abSwitchStatus),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "ab s/w contacts damaged".toUpperCase(),
            tileValue: dtrInspectionSheetEntity!.abContactsDamaged.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "ab s/w bras strips damaged".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.abBrassStripDamaged.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "ab s/w nylon bushes damaged".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.nylonBushDamaged.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "hg fuseset available".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.hG11KvFuseSetAvailable.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "hg fuseset status".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.hG11KvFuseSetAvailable == "Y"
                ? "Ok"
                : "null"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "horns to be replaced".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.hornsToBeReplaced.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "horns gap is not correct".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.gapIsNotCorrect=='N'?"No":"Yes"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "post type ins. \n damaged qty".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.hgFuseSetPostTypeInsulatorsCount.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "ht bushes status".toUpperCase(),
            tileValue:"Ok"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "ht bushes damaged".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.htBushesDamageCount.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "ht bushes rods status".toUpperCase(),
            tileValue:"OK"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "ht bushes rods damage qty".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.htBushRodsDamCount.toString()),
        const Divider(),
        Text("before maintenance image".toUpperCase()),
        ViewDetailedLcImageWidget(imageUrl: checkNull(dtrInspectionSheetEntity.beforeMaintenanceImage)),
      ]);

    case "LT_SIDE":
      return Column(children: [
        ViewDetailedLcTileWidget(
            tileKey: "lt bush status".toUpperCase(),
            tileValue:"Ok"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt bush damage qty".toUpperCase(),
            tileValue:dtrInspectionSheetEntity!.ltBushesDamageCount.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt bush rods status".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.htBushRodsDamCount==0?"Ok":"No"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt brush rods damage qty".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.htBushRodsDamCount.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt bi-metallic available".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.ltBiMetalClampsAvailable=="Y"?"Available":"Not Available"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "BiMetallic clamps status".toUpperCase(),
            tileValue:"Ok"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "Bimetallic clamps damaged".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.ltBiMetalClampsDamCount.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt breaker available".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.ltBreaker=="Y"?"Available":"Not Available"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt breaker status".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.ltBreakerStatus),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt fuse set".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.ltFuseSetAvailable=="Y"?"Available":"Not Available"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt fuse set status".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.ltFuseSetStatus),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt fuse wire".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.ltFuseWire),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt pvc cable".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.ltPvcCable=="Y"?"Available":"Not Available"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "lt pvc cable status".toUpperCase(),
            tileValue:dtrInspectionSheetEntity.ltPvcCableStatus),
      ]);

    case "OIL":
      return Column(children: [
        ViewDetailedLcTileWidget(
            tileKey: "oil level".toUpperCase(),
            tileValue: "Ok"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "oil shortage(its)".toUpperCase(),
            tileValue: dtrInspectionSheetEntity!.oilShortageInLiters.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "oil shortage(its)".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.oilLeakage=="N"?"No":"Yes"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "gaskets damaged".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.gasketsDamaged=="N"?"No":"Yes"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "diaphragm available".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.diaphragmStatus!=null?"Yes":"No"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "diaphragm status".toUpperCase(),
            tileValue: dtrInspectionSheetEntity.diaphragmStatus),
        const Divider(),
      ]);


    case "EARTHING":
      return Column(children: [
        ViewDetailedLcTileWidget(
            tileKey: "Earth Pits".toUpperCase(), tileValue:dtrInspectionSheetEntity!.earthPits.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "earth pipes type".toUpperCase(), tileValue: dtrInspectionSheetEntity.earthPipes),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "earth pipe status".toUpperCase(), tileValue: dtrInspectionSheetEntity.earthPipesStatus),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "earthing status".toUpperCase(), tileValue: dtrInspectionSheetEntity.earthing),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "double earthing".toUpperCase(), tileValue: dtrInspectionSheetEntity.doubleEarthing=="Y"?"Available":"Not Available"),
        const Divider(),
      ]);

    case "LT_NETWORK":
      return Column(children: [
        ViewDetailedLcTileWidget(
            tileKey: "loose lines on dtr".toUpperCase(), tileValue: dtrInspectionSheetEntity!.noOfLooseLinesOnDtr==0?"No":"Yes"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "no of loose lines ".toUpperCase(), tileValue: dtrInspectionSheetEntity.noOfLooseLinesOnDtr.toString()),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "Tree cutting required".toUpperCase(), tileValue: dtrInspectionSheetEntity.treeCuttingRequired==0?"No":"Yes"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "no of tree cutting required".toUpperCase(), tileValue: dtrInspectionSheetEntity.treeCuttingRequired==0?"No":"Yes"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "Other rectifications on lt".toUpperCase(), tileValue: dtrInspectionSheetEntity.otherObservationsByLm),
        const Divider(),
      ]);

    case "LA":
      return Column(children: [
        ViewDetailedLcTileWidget(
            tileKey: "Las available".toUpperCase(), tileValue:dtrInspectionSheetEntity?.lightningArrestors!=null?"Available":"Not Available"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "las status".toUpperCase(), tileValue:dtrInspectionSheetEntity!.lightningArrestors),
        const Divider(),
      ]);

    case "DTR_LOADING":
      return Column(children: [
        ViewDetailedLcTileWidget(
            tileKey: "dtr overloaded".toUpperCase(), tileValue: dtrInspectionSheetEntity!.diaphragmStatus),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "agl load".toUpperCase(), tileValue: "${dtrInspectionSheetEntity?.dtrAglLoadHp}HP"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "domestic & non-domestic".toUpperCase(), tileValue: "${dtrInspectionSheetEntity?.domesticNonDomLoad}KW"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "industrial load".toUpperCase(), tileValue: "${dtrInspectionSheetEntity?.industrialLoadInHp}HP"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "water works load".toUpperCase(), tileValue: "${dtrInspectionSheetEntity?.waterWorksLoadInHp}HP"),
        const Divider(),ViewDetailedLcTileWidget(
            tileKey: "other loads".toUpperCase(), tileValue: "${dtrInspectionSheetEntity?.otherLoadInKw}KW"),
        const Divider(),
      ]);

    case "TONG":
      return Column(children: [
        ViewDetailedLcTileWidget(
            tileKey: "R-phase".toUpperCase(), tileValue: "${dtrInspectionSheetEntity?.rPhaseCurrent}Amps"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "y-phase".toUpperCase(), tileValue: "${dtrInspectionSheetEntity?.yPhaseCurrent}Amps"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "b-phase".toUpperCase(), tileValue: "${dtrInspectionSheetEntity?.bPhaseCurrent}Amps"),
        const Divider(),
        ViewDetailedLcTileWidget(
            tileKey: "Neutral".toUpperCase(), tileValue: "${dtrInspectionSheetEntity?.nPhaseCurrent}Amps"),
        const Divider(),
      ]);
    default:
      return const SizedBox(); // Or show a placeholder or message
  }
}


