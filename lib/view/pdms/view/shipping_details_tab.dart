import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_dispatch_instructions_entity.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/shipping_details_viewmodel.dart';

class ShippingDetailsTab extends StatelessWidget {
  final PoleDispatchInstructionsEntity poleDispatchInstructionsEntity;

  const ShippingDetailsTab({super.key, required this.poleDispatchInstructionsEntity});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShippingDetailsViewModel(context: context, poleDispatchInstructionsEntity: poleDispatchInstructionsEntity),
      child: Consumer<ShippingDetailsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: viewModel.poleDispatchInstructionsEntity.poleTransportEntitiesByDispatchInstructionsId!.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.builder(
                itemCount: viewModel.poleDispatchInstructionsEntity.poleTransportEntitiesByDispatchInstructionsId!.length,
                itemBuilder: (context, index) {
                  final item = viewModel.poleDispatchInstructionsEntity.poleTransportEntitiesByDispatchInstructionsId![index];

                  return GestureDetector(
                    onTap: () {
                      Navigation.instance.navigateTo(Routes.viewDetailedTransportScreen, args: jsonEncode(item));
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: doubleFive,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: doubleTen,),
                                      Expanded(
                                        child: Text(
                                          "#${checkNull(item.transportId.toString())} | DI ID#${checkNull(item.dispatchInstructionId.toString())}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                            normalSize,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: doubleTwenty,),
                                      Text(
                                        checkNull(item.vehicleNo),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red,
                                          fontSize: regularTextSize,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: doubleTwo,),
                                  Divider(height: 0.1, color: Colors.grey[200],),
                                  const SizedBox(height: doubleTwo,),
                                  Row(
                                    children: [
                                      const SizedBox(width: doubleTen,),
                                      Text(
                                        "${checkNull(item.driverName)} | ${checkNull(item.driverPhone)}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                          extraRegularSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: doubleFive,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: doubleTen,),
                                      Expanded(
                                        child: Text(
                                          "Dt: ${formatIsoDateForDiShippingDetails(checkNull(item.dispatchDate))}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                            normalSize,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: doubleTwenty,),
                                      Text(
                                        "Qty:${item.transportQty ?? "0"}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: regularTextSize,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigation.instance.navigateTo(Routes.viewDetailedTransportScreen, args: jsonEncode(item));
                                },
                                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14,)
                            )
                          ],
                        ),
                        const SizedBox(height: doubleFive,),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 1,
                        ),
                      ],
                    ),
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
