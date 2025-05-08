import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/ccc/viewModel/ccc_oricb_viewmodel.dart';


class CccOricb extends StatelessWidget {
  static const id = Routes.cccORICB;

  const CccOricb({super.key, required this.status, required this.title});
  final String status;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CccOricbViewmodel(context: context, status: status),
      child: Consumer<CccOricbViewmodel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: CommonColors.colorPrimary,
                title:  Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              body: viewModel.isLoading? Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.0),
                  // Semi-transparent overlay
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ):const Text(""),
            );
          }
      ),
    );
  }
}