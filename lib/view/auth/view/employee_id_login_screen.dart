import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/auth/viewmodel/auth_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class EmployeeIdLoginScreen extends StatelessWidget {
  static const id = Routes.employeeIdLoginScreen;

  const EmployeeIdLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthViewmodel(context: context),
      child: Stack(
        children: [
          Image.asset(
            Assets.loginBgLogo, // Replace with your image URL or asset
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
            body: Consumer<AuthViewmodel>(
              builder: (context, viewModel, child) {
                return Padding(
                  padding: const EdgeInsets.all(doubleSixteen),
                  child: SingleChildScrollView(child:Form(
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
                                  isReadOnly: isFalse,
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
                                  isReadOnly: isFalse,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password cannot be left blank";
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: viewModel.isChecked,
                                      onChanged: (value) {
                                        viewModel.isChecked = value!;
                                        viewModel.notifyListeners();
                                      },
                                    ),
                                    Text(
                                      "FAC LOGIN",
                                      style: TextStyle(
                                          fontSize: normalSize,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red[800]),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Please select 'FAC LOGIN' only if you want to auth into your in charge section!",
                                  style: TextStyle(
                                      fontSize: regularTextSize,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800]),
                                ),
                                const SizedBox(height: doubleSixteen),
                                Center(
                                  child: PrimaryButton(
                                      text: 'login', onPressed: () {
                                    viewModel.authenticateEmployee();
                                  }
                                  ),
                                ),
                                const SizedBox(height: doubleSixteen),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigation.instance.navigateTo(Routes.corporateLoginScreen);
                                      },
                                      child: const Text(
                                        "Corporate Login",
                                        style: TextStyle(
                                          color: CommonColors.colorPrimary,
                                          fontSize: normalSize,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        if (viewModel
                                            .empIdController.text.isEmpty) {
                                          AlertUtils.showSnackBar(context, "Please enter your employee ID first!", isTrue);
                                        } else {
                                          Navigation.instance.navigateTo(Routes.changePasswordScreen, args: viewModel.empIdController.text);
                                        }
                                      },
                                      child: Text(
                                        "Change Password",
                                        style: TextStyle(
                                          color: Colors.red[800],
                                          fontSize: normalSize,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                );
              },
            ),
            bottomNavigationBar: Consumer<AuthViewmodel>(
              builder: (context, viewModel, child) {
                return Padding(
                  padding: const EdgeInsets.all(doubleSixteen),
                  child: Text(
                    viewModel.appVersion != "Unknown" ? "Version : ${viewModel.appVersion}" : "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: regularTextSize,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
