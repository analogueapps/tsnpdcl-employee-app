import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/auth/viewmodel/auth_viewmodel.dart';
import 'package:tsnpdcl_employee/view/auth/viewmodel/change_pass_viewmodel.dart';
import 'package:tsnpdcl_employee/view/auth/viewmodel/otp_verify_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class OtpVerificationScreen extends StatelessWidget {
  static const id = Routes.otpVerificationScreen;
  final Map<String, dynamic> data;

  const OtpVerificationScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OtpVerifyViewmodel(context: context, data: data),
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
          WillPopScope(
            onWillPop: () async {
              final shouldExit = await showCupertinoDialog<bool>(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Exit without verification?"),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: const Text("Exit"),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              );
              if (shouldExit == true) {
                Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);
              }
              return false;
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                toolbarHeight: 0, // Hide AppBar
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Consumer<OtpVerifyViewmodel>(
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
                                    controller: viewModel.empPhoneController,
                                    labelText: 'Mobile Number',
                                    keyboardType: TextInputType.number,
                                    isReadOnly: isTrue,
                                    prefixIcon: const Icon(Icons.phone),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Phone number cannot be left blank";
                                      } else if (value.length < 10) {
                                        return "Please enter a valid phone number";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: doubleTwenty,
                                  ),
                                  const Text(
                                    'OTP',
                                    style: TextStyle(
                                      fontSize: normalSize,
                                      fontWeight: FontWeight.w500,),
                                    textAlign:
                                    TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: doubleTen,
                                  ),
                                  Pinput(
                                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                    showCursor: isTrue,
                                    length: numSix,
                                    defaultPinTheme: PinTheme(
                                      width: doubleFiftySix,
                                      height: doubleSixtyFour,
                                      decoration: BoxDecoration(
                                        color: CommonColors.textFieldColor,
                                        borderRadius: BorderRadius.circular(doubleTen),
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: titleSize,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      viewModel.otp = value;
                                    },
                                    onCompleted: (value) {
                                      viewModel.otp = value;
                                    },
                                  ),
                                  const SizedBox(height: doubleSixteen),
                                  Visibility(
                                    visible: false,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Flexible(
                                            child: Text(
                                              'Didn\'t receive the OTP ? ',
                                              style: TextStyle(
                                                  fontSize: normalSize,
                                                  fontWeight:
                                                  FontWeight.w500),
                                              textAlign:
                                              TextAlign.center,
                                            ),
                                          ),
                                          viewModel.resendOtp == isTrue
                                              ? GestureDetector(
                                            onTap: () {
                                              //viewModel.resendOtpFromServer(context);
                                            },
                                            child: const Text(
                                              'Resend OTP',
                                              style: TextStyle(
                                                  fontSize: normalSize,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  color: CommonColors
                                                      .colorPrimary),
                                              textAlign:
                                              TextAlign
                                                  .start,
                                            ),
                                          )
                                              : Flexible(child: Text(
                                            'Resend OTP in ${viewModel.secondsRemaining} sec',
                                            style: const TextStyle(
                                                fontSize: normalSize,
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                                color: CommonColors
                                                    .colorPrimary),
                                            textAlign:
                                            TextAlign.start,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: doubleTwenty),
                                  Center(
                                    child: PrimaryButton(
                                        text: 'Verify',
                                        onPressed: () {
                                          viewModel.authenticateEmployee();
                                        }
                                    ),
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
              bottomNavigationBar: Consumer<OtpVerifyViewmodel>(
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
          ),
        ],
      ),
    );
  }
}
