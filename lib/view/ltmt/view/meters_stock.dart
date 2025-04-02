import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/general_routes.dart';
import '../../../utils/global_constants.dart';
import '../viewModel/meterStock_viewModel.dart';

class MetersStock extends StatelessWidget {
  static const id = Routes.metersStock;
  const MetersStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          "Meters Stock",
          style:  TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body:ChangeNotifierProvider(
        create: (_) => MeterStockViewmodel(context: context),
        child: Consumer<MeterStockViewmodel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.meterStockEntityList.isEmpty) {
              return const Center(child: Text("No meter data available"));
            }

            return SingleChildScrollView(
              child:
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.meterStockEntityList.length,
                    itemBuilder: (context, index) {
                      final meter = viewModel.meterStockEntityList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left:15.0, right: 15.0, top:8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.isBoxChecked,
                                  onChanged: (bool? newValue) {
                                    print("newValue $newValue");

                                  },
                                ),
                                Text(meter.meterNo?.toString() ?? "N/A"),
                              ],
                            ),
                            Row(
                                children: [
                                  SizedBox(width: 50,),
                                  Text(
                                      "${meter.make ?? 'N/A'}, ${meter.meterType ?? 'N/A'}, ${meter.meterCapacity ?? 'N/A'}"
                                  ),
                                ]
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child:Text(
                              meter.opDate ?? "N/A",
                              style: const TextStyle(color: Colors.grey),
                              textAlign: TextAlign.end,
                            ),
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  ),
            );
          },
        ),
      ),
        floatingActionButton:FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: CommonColors.pink,
          child: const Icon(Icons.search, color: Colors.white
            ,
          )
          ,
        )
    );
  }
}
