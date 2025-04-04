import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/ltmt/viewModel/meterOM_viewModel.dart';

class MetersOm extends StatelessWidget {
  static const id = Routes.meterOM;
  final String? empId; // Add empId as a parameter
  const MetersOm({super.key, this.empId});

  @override
  Widget build(BuildContext context) {
    print("MetersOm build - empId from constructor: $empId");

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = MeterOMViewmodel(context: context);
        print("Provider create - empId: $empId, list empty: ${viewModel.meterStockEntityList1.isEmpty}");
        if (empId != null) {
          print("Initializing with empId: $empId");
          viewModel.selectedEmpID = empId!;
          viewModel.getLoaderLoadMetersStock();
        }
        return viewModel;
      },
      child: Consumer<MeterOMViewmodel>(
        builder: (context, viewModel, child) {
          print("Consumer build - meter list length: ${viewModel.meterStockEntityList1.length}");
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: const Text(
                "Meters O&M",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
              body: Column(
                children: [
                  if (viewModel.isLoading)
                    const Expanded(child: Center(child: CircularProgressIndicator()))
                  else if (viewModel.meterStockEntityList1.isEmpty)
                    const Expanded(child: Center(child: Text("No meter data available")))
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.meterStockEntityList1.length,
                        itemBuilder: (context, index) {
                          final meter = viewModel.meterStockEntityList1[index];
                          return meter == null
                              ? const SizedBox()
                              : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(meter.meterNo?.toString() ?? 'N/A'),
                                Text(
                                  "${meter.make ?? 'N/A'}, ${meter.meterType ?? 'N/A'}, ${meter.meterCapacity ?? 'N/A'}",
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    meter.opDate ?? "N/A",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                                const Divider(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                viewModel.showMeterDialog(context);
              },
              backgroundColor: CommonColors.pink,
              child: const Icon(Icons.search, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

//                final meter = viewModel.meterStockEntityList1[index];

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tsnpdcl_employee/utils/app_constants.dart';
// import 'package:tsnpdcl_employee/utils/common_colors.dart';
// import 'package:tsnpdcl_employee/utils/general_routes.dart';
// import 'package:tsnpdcl_employee/view/ltmt/viewModel/meterOM_viewModel.dart';
//
// class MetersOm extends StatelessWidget {
//   static const id = Routes.meterOM;
//   const MetersOm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // final viewModel = Provider.of<MeterOMViewmodel>(context, listen: false);
//     // final String? empId = ModalRoute.of(context)?.settings.arguments as String?;
//     //
//     // if (empId != null && viewModel.meterStockEntityList1.isEmpty) {
//     //   viewModel.selectedEmpID = empId;
//     //   viewModel.getLoaderLoadMetersStock();
//     // }
//
//     return ChangeNotifierProvider(
//       create: (_) => MeterOMViewmodel(context: context),
//       child: Consumer<MeterOMViewmodel>(
//         builder: (context, viewModel, child) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: CommonColors.colorPrimary,
//               title: const Text(
//                 "Meters O&M",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: toolbarTitleSize,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               iconTheme: const IconThemeData(color: Colors.white),
//             ),
//             body: viewModel.isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : viewModel.meterStockEntityList1.isEmpty
//                 ? const Center(child: Text("No meter data available"))
//                 : ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: viewModel.meterStockEntityList1.length,
//               itemBuilder: (context, index) {
//                 final meter = viewModel.meterStockEntityList1[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           const SizedBox(width: 50),
//                           Text(
//                             "${meter.make ?? 'N/A'}, ${meter.meterType ?? 'N/A'}, ${meter.meterCapacity ?? 'N/A'}",
//                           ),
//                         ],
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           meter.opDate ?? "N/A",
//                           style: const TextStyle(color: Colors.grey),
//                           textAlign: TextAlign.end,
//                         ),
//                       ),
//                       const Divider(),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             floatingActionButton: FloatingActionButton(
//               onPressed: () {
//                 viewModel.showMeterDialog(context);
//               },
//               backgroundColor: CommonColors.pink,
//               child: const Icon(Icons.search, color: Colors.white),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }