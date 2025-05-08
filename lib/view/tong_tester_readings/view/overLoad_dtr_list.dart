import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/viewmodel/overload_dtr_list_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class OverLoadDTRList extends StatelessWidget {
  static const id = Routes.overLoadDTRList;

  const OverLoadDTRList({super.key});
 @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Column(
        children: [
          Text(
          "OVER LOAD DTRs LIST",
          style: TextStyle(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w700),
        ),
          Text(
            "Showing I(N)>20Amps",
            style: TextStyle(
                color: Colors.white,
                fontSize: titleSize,
                fontWeight: FontWeight.w700),
          ),
        ]
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => OverloadDtrListViewmodel(context: context),
   child: Consumer<OverloadDtrListViewmodel>(
   builder: (context, viewModel, child) {
   return  Stack(
       children: [
         ListView.builder(
   itemCount: viewModel.overLoadItems.length,
   itemBuilder: (context, index) {
     final data = viewModel.overLoadItems[index];
     return data == null
         ?
     const Center(child: Text("No data found")) :

             GestureDetector(
                 onTap: () {
                   Navigation.instance.navigateTo(Routes.viewDetailedTongTesterReadings,args: data,);
                   print("passing data: $data");
                 },
                 child:
             Container(
         margin: const EdgeInsets.all(10),
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(8),
           // Optional: to give rounded corners
           boxShadow: [
             BoxShadow(
               color: Colors.black.withOpacity(0.1),
               blurRadius: 8,
               offset: const Offset(
                   0, 4),
             ),
           ],
         ),
         padding: const EdgeInsets.only(top: 10),
         child: Column(
           children: [
             Row(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Align(
                         alignment: Alignment.topRight,
                         child: Text(
                           "${data.readingDate} ${data.readingTime}",
                           style: const TextStyle(
                             color: CommonColors.deepBlue,
                           ),
                         ),
                       ),
                       const SizedBox(height: 10),
                       ViewDetailedLcTileWidget(
                           tileKey: "Equipment Code",
                           tileValue: data.equipmentCode),

                       ViewDetailedLcTileWidget(
                           tileKey: "Structure Code",
                           tileValue: data.dtrStructureCode),

                       ViewDetailedLcTileWidget(
                           tileKey: "Section",
                           tileValue:data.sectionCode),

                       _reusableLastRow(data.ir, data.iy, data.ib, data.iNeutral),
                     ],
                   ),
                 ),
                 // IconButton with no space between it and the text
                 IconButton(
                   onPressed: () {
                     // Add your navigation logic here
                     Navigation.instance
                         .navigateTo(Routes.viewDetailedTongTesterReadings, args: data,);
                     print("icon on tap: $data");
                   },
                   icon:
                   const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                   padding:
                   EdgeInsets.zero, // Ensures there is no extra padding
                 ),
               ],
             ),
           ],
         ),
       ),
     );
   }
   ),
         if (viewModel.isLoading)
           Positioned.fill(
             child: Container(
               color: Colors.black.withOpacity(0.0), // Semi-transparent overlay
               child: const Center(
                 child: CircularProgressIndicator(),
               ),
             ),
           ),
     ]
     );
   }
   ),
   ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CommonColors.colorPrimary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () {
          Navigation.instance.navigateTo(Routes.tongTesterReadingsScreen);
        },
        child:  Image.asset(Assets.tongTesterReadings,height: 30,),
      ),
   );
  }

  //reusable last row
  Widget _reusableLastRow(
      double value1, double value2, double value3, double value4) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 4, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "Rph: $value1",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: CommonColors.deepRed,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: const Color(0xffcfcdcd),
          ),
          Expanded(
            child: Text(
              "Yph: $value2",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CommonColors.colorSecondary,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: const Color(0xffcfcdcd),
          ),
          Expanded(
            child: Text(
              "Bph: $value3",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CommonColors.colorPrimary,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: const Color(0xffcfcdcd),
          ),
          Expanded(
            child: Text(
              "N: $value4",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: normalSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}