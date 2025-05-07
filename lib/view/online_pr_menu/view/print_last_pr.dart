import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/viewmodel/print_last_pr_viewmodel.dart';

class PrintLastPrView extends StatelessWidget {
  const PrintLastPrView({super.key});
  static const id = Routes.printLastPR;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
              appBar: AppBar(
                backgroundColor: CommonColors.colorPrimary,
                title: const Text('PRINT LAST PR',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: toolbarTitleSize,
                      fontWeight: FontWeight.w700),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              body: ChangeNotifierProvider(
                create: (_)=>PrintLastPrViewModel(context: context),
                child: Consumer<PrintLastPrViewModel>(
                    builder: (context, viewModel, child) {
                      return viewModel.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          :
                      Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      color: CommonColors.colorPrimary,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: InkWell(
                    child: const Center(child: Text('PRINT LAST PR',style: TextStyle(color: Colors.white),)),
                    onTap: (){
                      // viewModel.fetchLastPrData(context);
                      print("Print last PR");
                    },
                  ),
                ),
              );

          }
      ),
              ),
    );
  }
}