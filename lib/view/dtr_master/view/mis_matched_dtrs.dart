import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/mis_matched_viewmodel.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/general_routes.dart';
import '../../../utils/global_constants.dart';

class  MisMatchedDtr extends StatelessWidget {
  static const id = Routes.misMatched;
  const MisMatchedDtr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            GlobalConstants.missMatchedDtr,
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
          create: (_) => MisMatchedViewModel(),
          child: Consumer<MisMatchedViewModel>(
              builder: (context, viewModel, child) {
                return const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:  SingleChildScrollView(
                    child:Column( //use ListTitle here
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("12245-GOKULNAGAR-NKG-SS-0048"),
                         Text("100005249", style: TextStyle(color: Colors.grey)),
                         Text("Eq no. should written on DTR only", style: TextStyle(color: Colors.redAccent), textAlign: TextAlign.end,),
                         Divider(),
                      ],

                    ),

                  ),
                );
              }
          ),
        ),
    );
  }
}
