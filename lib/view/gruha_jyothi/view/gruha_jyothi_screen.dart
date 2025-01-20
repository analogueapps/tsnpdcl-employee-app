import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/consumer_details/viewmodel/consumer_details_viewmodel.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/viewmodel/ctpt_menu_viewmodel.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/viewmodel/dtr_failure_viewmodel.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/viewmodel/dtr_maintenance_viewmodel.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/viewmodel/failure_dtr_inspection_viewmodel.dart';
import 'package:tsnpdcl_employee/view/gruha_jyothi/viewmodel/gruha_jyothi_viewmodel.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/viewmodel/online_pr_menu_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class GruhaJyothiScreen extends StatelessWidget {
  static const id = Routes.gruhaJyothiScreen;
  const GruhaJyothiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "${GlobalConstants.gruhaJyothiTitle} status".toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => GruhaJyothiViewModel(context: context),
        child: Consumer<GruhaJyothiViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(doubleSixteen),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter USCNO'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FillTextFormField(
                      controller: viewModel.uscNoController,
                      labelText: '',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: doubleFive),
                    const Center(
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: titleSize,
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: doubleFive),
                    Text(
                      'Enter Ration no'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FillTextFormField(
                      controller: viewModel.rationNoController,
                      labelText: '',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: doubleTwenty),
                    Visibility(
                      visible: viewModel.gruhaJyothiStatus == null,
                      child: Center(
                        child: PrimaryButton(
                            text: 'Search',
                            onPressed: () {
                              viewModel.fetchDetails();
                            }
                        ),
                      ),
                    ),
                    Visibility(
                      visible: viewModel.gruhaJyothiStatus != null,
                      child: Center(
                        child: PrimaryButton(
                            text: 'Clear',
                            buttonColor: CommonColors.colorSecondary,
                            onPressed: () {
                              viewModel.clearDetails();
                            }
                        ),
                      ),
                    ),
                    const SizedBox(height: doubleTwenty),
                    const Divider(),
                    Visibility(
                      visible: viewModel.gruhaJyothiStatus != null,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Text(
                                "USCNO",
                                style: TextStyle(
                                  fontSize: normalSize,
                                  color: CommonColors.colorPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: doubleFive, bottom: doubleFive),
                                child: Text(
                                  checkNull(viewModel.gruhaJyothiStatus?.uscno),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const TableRow(children: [SizedBox(height: doubleFive,),SizedBox(height: doubleFive,)]),
                          TableRow(
                            children: [
                              const Text(
                                "RATION NO.",
                                style: TextStyle(
                                  fontSize: normalSize,
                                  color: CommonColors.colorPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: doubleFive, bottom: doubleFive),
                                child: Text(
                                  checkNull(viewModel.gruhaJyothiStatus?.rationNo),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const TableRow(children: [SizedBox(height: doubleFive,),SizedBox(height: doubleFive,)]),
                          TableRow(
                            children: [
                              const Text(
                                "AADHAR NO",
                                style: TextStyle(
                                  fontSize: normalSize,
                                  color: CommonColors.colorPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: doubleFive, bottom: doubleFive),
                                child: Text(
                                  checkNull(viewModel.gruhaJyothiStatus?.aadharNo),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const TableRow(children: [SizedBox(height: doubleFive,),SizedBox(height: doubleFive,)]),
                          TableRow(
                            children: [
                              const Text(
                                "MOBILE",
                                style: TextStyle(
                                  fontSize: normalSize,
                                  color: CommonColors.colorPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: doubleFive, bottom: doubleFive),
                                child: Text(
                                  checkNull(viewModel.gruhaJyothiStatus?.mobileNo),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const TableRow(children: [SizedBox(height: doubleFive,),SizedBox(height: doubleFive,)]),
                          TableRow(
                            children: [
                              const Text(
                                "GRUHA JYOTHI STATUS",
                                style: TextStyle(
                                  fontSize: normalSize,
                                  color: CommonColors.colorPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: doubleFive, bottom: doubleFive),
                                child: Text(
                                  checkNull(viewModel.gruhaJyothiStatus?.status),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const TableRow(children: [SizedBox(height: doubleFive,),SizedBox(height: doubleFive,)]),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
