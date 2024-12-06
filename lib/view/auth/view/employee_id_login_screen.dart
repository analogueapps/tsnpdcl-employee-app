import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/const.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
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
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0, // Hide AppBar
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Consumer<AuthViewmodel>(
            builder: (context, viewModel, child) {
              return Padding(
                padding: const EdgeInsets.all(doubleSixteen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      Assets.appLogo,
                      height: doubleHundred,
                      width: doubleHundred,
                    ),
                    Card(
                      color: Colors.white,
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
                                prefixIcon: const Icon(Icons.person_rounded),
                                suffixIcon: null),
                            const SizedBox(
                              height: doubleTwenty,
                            ),
                            FillTextFormField(
                              controller: viewModel.passwordController,
                              labelText: 'Password',
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: const Icon(Icons.lock_rounded),
                              suffixIcon: null,
                              isObscure: isTrue,
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
                                  color: Colors.grey[600]),
                            ),
                            const SizedBox(height: doubleSixteen),
                            Center(
                              child: PrimaryButton(
                                  text: 'auth', onPressed: () {}),
                            ),
                            const SizedBox(height: doubleSixteen),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => CorporateLoginPage()),
                                    // );
                                  },
                                  child: const Text(
                                    "Corporate Login",
                                    style: TextStyle(
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
                                      viewModel.showErrorToast(
                                          "Please enter your employee ID first!");
                                    } else {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => PasswordChangePage(
                                      //       empId: viewModel.empIdController.text,
                                      //     ),
                                      //   ),
                                      // );
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
              );
            },
          ),
        ),
      ),
    );
  }
}

class PasswordChangePage extends StatelessWidget {
  final String empId;

  const PasswordChangePage({required this.empId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Center(
        child: Text("Change password for Employee ID: $empId"),
      ),
    );
  }
}

class CorporateLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Corporate Login"),
      ),
      body: const Center(
        child: Text("Corporate Login Page"),
      ),
    );
  }
}
