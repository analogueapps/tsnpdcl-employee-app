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
    create: (_) => MeterstockViewmodel(context: context),
    child: Consumer<MeterstockViewmodel>(
    builder: (context, viewModel, child) {
      return SingleChildScrollView(
          child:Column( //use ListTitle here
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children:[
            Checkbox(
              tristate: true, // Example with tristate
              value: viewModel.isBoxChecked,
              onChanged: (bool? newValue) {
                print(newValue);
                // if(newValue==true){
                //   viewModel.isBoxChecked= isFalse;
                // }
                // setState(() {
                // viewModel.isBoxChecked= isFalse;
                // });
              },
            ),
            const  Text("10384209"),
        ]
          ),
          const Text(" L & T,S.Ph ,5-30A"),
          const Text("28/06/2021", style: TextStyle(color: Colors.grey), textAlign: TextAlign.end,),
          const Divider(),
        ],

      ),

      );
    }
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
