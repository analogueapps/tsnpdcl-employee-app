import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/view_mapped_viewmodels/mapped_dtr_viewmodel.dart';

class MappedDtr extends StatelessWidget {
  static const id = Routes.mappedDtrScreen;
  final List<FeederDisModel> structureData;

  const MappedDtr({super.key, required this.structureData});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MappedDtrViewmodel(context: context),
      child: Consumer<MappedDtrViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: const Text(
                GlobalConstants.viewMappedDTR,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Stack(children: [
              SingleChildScrollView(
                child: structureData.isEmpty
                    ? const Center(child: Text("No data available"))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: structureData.length,
                        itemBuilder: (context, index) {
                          final structure = structureData[index];
                          return GestureDetector(
                            onTap: () {
                              viewModel
                                  .getStructureData(structure.structureCode!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 50),
                                            Text(
                                              structure.structureCode ?? 'N/A',
                                            ),
                                            Text(
                                              "Land Mark: ${structure.landMark ?? 'N/A'}",
                                              style: const TextStyle(
                                                  fontSize: doubleEleven),
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: doubleSixteen,
                                        )
                                      ]),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      structure.createdDate ?? "N/A",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: doubleEleven),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              // if (viewModel.isLoading)
              // Positioned.fill(
              // child:  Container(
              // color: Colors.black.withOpacity(0.3),
              // child: const Center(
              // child: CircularProgressIndicator(color: CommonColors.colorPrimary,),
              // ),
              // ),
              // ),
            ]),
          );
        },
      ),
    );
  }
}
