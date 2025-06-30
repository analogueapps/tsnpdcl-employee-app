import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/daily_nil_report/viewmodel/daily_nil_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class DailyNil extends StatelessWidget {
  static const id = Routes.nilReport;
  const DailyNil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          "NIL Report Submission",
          style: TextStyle(
            color: Colors.white,
            fontSize: toolbarTitleSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
          create: (_) => DailyNilViewmodel(context: context),
          child:
              Consumer<DailyNilViewmodel>(builder: (context, viewModel, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: doubleTen),
                  child: Column(
                    children: [
                      Expanded(
                        child: viewModel.optionList.isEmpty
                            ? const Center(child: Text("No data found"))
                            : ListView.builder(
                                itemCount: viewModel.optionList.length,
                                itemBuilder: (context, index) {
                                  final data = viewModel.optionList[index];
                                  return CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      data.optionName,
                                      style: const TextStyle(
                                        fontSize: normalSize,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: viewModel.isSelected(data.optionId),
                                    onChanged: (value) {
                                      viewModel.selectCheckbox(data.optionId);
                                    },
                                  );
                                },
                              ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          text: "SUBMIT NIL REPORT",
                          onPressed: () {
                            if (viewModel.selectedCheckboxList.isEmpty) {
                              AlertUtils.showSnackBar(
                                context,
                                "Please select at least one parameter and click submit",
                                isTrue,
                              );
                            } else {
                              viewModel.submitNil();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Loading overlay
                if (viewModel.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            );
          })),
    );
  }
}
