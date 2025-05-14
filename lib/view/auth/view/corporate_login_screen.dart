import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/auth/viewmodel/auth_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class CorporateLoginScreen extends StatelessWidget {
  static const id = Routes.corporateLoginScreen;
  const CorporateLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthViewmodel(context: context),
      child: Stack(
        children: [
          Image.asset(
            Assets.copLoginBgLogo, // Replace with your image URL or asset
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
            body: SingleChildScrollView(
              child: SafeArea(
                child: Consumer<AuthViewmodel>(
                  builder: (context, viewModel, child) {
                    return Padding(
                      padding: const EdgeInsets.all(doubleSixteen),
                      child: Form(
                        key: viewModel.corporateFormKey,
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
                                      controller: viewModel.userNameController,
                                      labelText: 'Username',
                                      keyboardType: TextInputType.text  ,
                                      prefixIcon: const Icon(Icons.person_rounded),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "User name cannot be left blank";
                                        } else if (value.length < 2) {
                                          return "Please enter valid user name";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: doubleTwenty,
                                    ),
                                    FillTextFormField(
                                      controller: viewModel.userPassController,
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
                                    const SizedBox(height: doubleSixteen),
                                    Center(
                                      child: PrimaryButton(
                                          text: 'login',
                                          onPressed: () {
                                            viewModel.authenticateUser();
                                          }
                                      ),
                                    ),
                                    const SizedBox(height: doubleSixteen),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigation.instance.pushBack();
                                          },
                                          child: const Text(
                                            "Employee Login",
                                            style: TextStyle(
                                              color: CommonColors.colorPrimary,
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
                    );
                  },
                ),
              ),
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
          ),
        ],
      ),
    );
  }
}
