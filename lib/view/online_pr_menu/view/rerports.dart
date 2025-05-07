import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/viewmodel/rerports_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class ReportsView extends StatelessWidget {
  static const id = Routes.onlinePRReports;

  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RC REPORT',
          style: TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: CommonColors.colorPrimary,
      ),
      body: ChangeNotifierProvider(
          create: (_) => ReportsViewModel(context: context),
          child:
              Consumer<ReportsViewModel>(builder: (context, viewModel, child) {
            return viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(11),
                    child: SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: Card(
                        elevation: 10,
                        child: Padding(
                            padding: const EdgeInsets.all(21.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'SELECT DATE :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: doubleEleven,
                                  ),
                                  InkWell(
                                    child: Row(
                                      children: [
                                        const Icon(
                                            Icons.calendar_month_outlined),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          viewModel.pickedDate,
                                          style: const TextStyle(
                                              color: Colors.pinkAccent),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      viewModel.PickDateFromDateTimePicker(
                                          context);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 21,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: PrimaryButton(
                                        onPressed: () {
                                          print("GET REPORT");
                                        },
                                        text: 'GET REPORT'),
                                  ),
                                ])),
                      ),
                    ),
                  );
          })),
    );
  }
}
