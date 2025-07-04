import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/non_kvah_services/viewmodel/rmd_service_list_viewmodel.dart';

class RmdServiceInspectionList extends StatelessWidget {
  static const id = Routes.monthRmdServiceListInspection;
  const RmdServiceInspectionList({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            'RMD exceeded services Inspection',
            style: TextStyle(
                color: Colors.white,
                fontSize: titleSize,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back))),
      body: ChangeNotifierProvider(
        create: (_) =>
            RmdServiceListViewmodel(context: context, args: args),
        child: Consumer<RmdServiceListViewmodel>(
            builder: (context, viewModel, child) {
              return const Text(""); //
            }),
      ),
    );
  }
}
