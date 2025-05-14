import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/all_lc_request_list_viewmodel.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/line_clearance_viewmodel.dart';
import 'package:tsnpdcl_employee/view/line_clearance/viewmodel/lc_master_viewmodel.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/create_firm_viewmodel.dart';
import 'package:tsnpdcl_employee/view/pdms/viewmodel/create_pole_indents_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class CreateFirmScreen extends StatelessWidget {
  static const id = Routes.createFirmScreen;
  final String data;

  const CreateFirmScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateFirmViewmodel(context: context, data: data),
      child: Consumer<CreateFirmViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "Create Supplier".toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(doubleTwenty),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FillTextFormField(
                      controller: viewModel.supplierNameController,
                      labelText: 'Supplier Name',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Supplier name cannot be left blank";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: doubleTwenty,),
                    FillTextFormField(
                      controller: viewModel.firmNameController,
                      labelText: 'Firm Name',
                      keyboardType: TextInputType.text,
                      isReadOnly: data == "new" ? false : true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Firm name cannot be left blank";
                        } if (value.length < 3) {
                          return "Firm name should be minimum 3 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: doubleTwenty,),
                    FillTextFormField(
                      controller: viewModel.phoneController,
                      labelText: 'Phone',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone cannot be left blank";
                        } if (value.length < 10) {
                          return "Phone should be 10 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: doubleTwenty,),
                    FillTextFormField(
                      controller: viewModel.sapVendorNoController,
                      labelText: 'SAP Vendor No',
                      isReadOnly: data == "new" ? false : true,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Sap vendor no cannot be left blank";
                        } if (value.length < 5) {
                          return "Sap vendor no should be 5 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: doubleTwenty,),
                    FillTextFormField(
                      controller: viewModel.emailAddressController,
                      labelText: 'Email Address (Optional)',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: doubleTwenty,),
                    FillTextFormField(
                      controller: viewModel.licenseNoController,
                      labelText: 'License No (Optional)',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: doubleTwenty,),
                    Visibility(
                      visible: data != "new",
                      child: SwitchListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        value: viewModel.isBlackListed, // This should be a `bool` variable from your state
                        onChanged: (value) {
                          // viewModel.isBlackListed = value;
                          // viewModel.notifyListeners();
                          viewModel.showBlackListDialog(value);
                        },
                        title: const Text(
                          'Black List Supplier',
                          style: TextStyle(
                            color: Color(0xFFF44336),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ProzaLibre',
                          ),
                        ),
                        activeColor: const Color(0xFFF44336),
                      ),
                    ),
                    const SizedBox(height: doubleForty,),
                    PrimaryButton(
                        text: data == "new" ? "Create Firm" : "Update Firm",
                        onPressed: () {
                          data == "new" ? viewModel.createFirm() : viewModel.updateFirm();
                        }
                    ),
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
