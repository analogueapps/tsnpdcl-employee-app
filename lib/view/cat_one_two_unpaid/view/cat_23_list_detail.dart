import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/cat_one_two_unpaid/viewmodel/cat_23_abstract_viewmodel.dart';
import 'package:tsnpdcl_employee/view/cat_one_two_unpaid/viewmodel/cat_23_list_detail_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';

class Cat23ListDetail extends StatelessWidget {
  static const id = Routes.catListDetail;
  final String args;
  const Cat23ListDetail({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cat23ListDetailViewmodel(context: context, args: args),
      child: Consumer<Cat23ListDetailViewmodel>(
          builder: (context, viewModel, child) {
            return Scaffold(
                appBar: AppBar(
                  title: const Column(
                    children: [
                       Text(
                        'USCNO: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                       Text(
                        'SCNO: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  backgroundColor: CommonColors.colorPrimary,
                  iconTheme: const IconThemeData(color: Colors.white),

                ),
                body: viewModel.isLoading || args.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Text(""),
                ));
          }),
    );
  }
}
