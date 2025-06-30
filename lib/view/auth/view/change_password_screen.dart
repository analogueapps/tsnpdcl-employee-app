import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/auth/viewmodel/change_pass_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const id = Routes.changePasswordScreen;
  final String empId;

  const ChangePasswordScreen({
    super.key,
    required this.empId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePassViewmodel(context: context, empId: empId),
      child: Stack(
        children: [
          Image.asset(
            Assets.changePassBgLogo, // Replace with your image URL or asset
            fit: BoxFit.cover, // Makes sure the image covers the entire screen
            width: double.infinity,
            height: double.infinity,
          ),
          Opacity(
            opacity: 0.7, // 70% opacity for the color
            child: Container(
              color: Colors.black, // Choose the color you want for the overlay
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarHeight: 0, // Hide AppBar
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Consumer<ChangePassViewmodel>(
              builder: (context, viewModel, child) {
                return Padding(
                  padding: const EdgeInsets.all(doubleSixteen),
                  child: Form(
                    key: viewModel.employeeFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SvgPicture.asset(
                          Assets.appLogo,
                          height: doubleHundred,
                          width: doubleHundred,
                        ),
                        Card(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(doubleTen),
                          ),
                          elevation: doubleFour,
                          child: Padding(
                            padding: const EdgeInsets.all(doubleSixteen),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: doubleTen,
                                ),
                                FillTextFormField(
                                  controller: viewModel.empIdController,
                                  labelText: 'Employee ID',
                                  keyboardType: TextInputType.number,
                                  isReadOnly: isTrue,
                                  prefixIcon: const Icon(Icons.person_rounded),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Employee id cannot be left blank";
                                    } else if (value.length < 5) {
                                      return "Please enter valid employee Id";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: doubleTwenty,
                                ),
                                FillTextFormField(
                                  controller: viewModel.empPassController,
                                  labelText: 'Password',
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIcon: const Icon(Icons.lock_rounded),
                                  isObscure: isTrue,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password cannot be left blank";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: doubleTwenty,
                                ),
                                FillTextFormField(
                                  controller: viewModel.empConPassController,
                                  labelText: 'Confirm Password',
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIcon: const Icon(Icons.lock_rounded),
                                  isObscure: isTrue,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password cannot be left blank";
                                    } else if (value !=
                                        viewModel.empPassController.text) {
                                      return "Password does not match";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: doubleSixteen),
                                Center(
                                  child: PrimaryButton(
                                      fullWidth: true,
                                      text: 'change password',
                                      onPressed: () {
                                        viewModel.authenticateEmployee();
                                      }),
                                ),
                                const SizedBox(height: doubleSixteen),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: Consumer<ChangePassViewmodel>(
              builder: (context, viewModel, child) {
                return Padding(
                  padding: const EdgeInsets.all(doubleSixteen),
                  child: Text(
                    viewModel.appVersion != "Unknown"
                        ? "Version : ${viewModel.appVersion}"
                        : "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: regularTextSize,
                        fontWeight: FontWeight.w400),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
