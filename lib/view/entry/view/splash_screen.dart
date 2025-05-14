import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/designation_helper.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/size_config.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';

class SplashScreen extends StatefulWidget {
  static const id = Routes.splashScreen;
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: numThree), onModelReady);
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> onModelReady() async {
    if(SharedPreferenceHelper.getLoginStatus()) {
      //Navigation.instance.pushAndRemoveUntil(Routes.universalDashboardScreen);
      goToMainScreen();
    } else {
      Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);
    }
  }

  void goToMainScreen() {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    final npdclUser = user[0];

    if (npdclUser.wing != null && npdclUser.wing == "accounts") {
      //universalNavi();
    } else if ((npdclUser.wing?.isEmpty ?? true) ||
        (npdclUser.secMasterEntity == null && npdclUser.empType != "om")) {
      // startActivity(new Intent(context, OneTimeRegisterActivity.class));
      // finish();
      // return;
    } else if ((npdclUser.wing?.isEmpty ?? true) ||
        (npdclUser.secMasterEntity == null && npdclUser.empType == "om")) {
      showAlertDialog(context, "if you are O&M staff your Section Officer should add your employee id under your section first! Please ask your section officer to add your employee id.");
    }

    if ((npdclUser.wing ?? '').toLowerCase() == 'operation') {
      final designationCode = npdclUser.designationCode;
      final screenType = designationCodes[designationCode] ?? -1;

      switch (screenType) {
        case SCREEN_FOR_AE:
          Navigation.instance.pushAndRemoveUntil(Routes.naviDashboardScreen);
          break;

        case SCREEN_FOR_ADE_OP:
          Navigation.instance.pushAndRemoveUntil(Routes.adeopNaviScreen);
          break;

        case SCREEN_FOR_OM:
          if ((npdclUser.isSsOp ?? 'N').toUpperCase() == 'Y') {
            // _toolbarTitle = "ADE OPN";
            // universalNavi(meeseva: true, );
          } else {

          }
          break;

        case SCREEN_FOR_DE_OP:
        //Navigator.pushReplacementNamed(context, Routes.deOpNaviActivity);
          break;

        case SCREEN_FOR_SE_OP:
        //Navigator.pushReplacementNamed(context, Routes.seOpNaviActivity);
          break;

        default:
          showCupertinoDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: const Text("Access Error"),
              content: const Text("Sorry, this application is currently not designed for your designation, you will be auto logged out."),
              actions: [
                CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await SharedPreferenceHelper.clearData();
                    Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);

                  },
                ),
                CupertinoDialogAction(
                  child: const Text("EXIT"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await SharedPreferenceHelper.clearData();
                    Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);
                  },
                ),
              ],
            ),
          );
          break;
      }
    } else if ((npdclUser.wing ?? '').toLowerCase() == "dpe") {

    } else if ((npdclUser.wing ?? '').toLowerCase() == "pmm" && npdclUser.designationCode == 102) {
      // _toolbarTitle = GlobalConstants.dashboardName;
      // universalNavi(viewSupplier: true, inspectionTickets: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: SizedBox(
    //       width: size.width * pointSix,
    //       child: SvgPicture.asset(
    //         Assets.appLogo,
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            Assets.splashLogo, // Replace with your image URL or asset
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
          // Center(
          //   child: SizedBox(
          //     width: size.width * pointSix,
          //     child: SvgPicture.asset(
          //       Assets.appLogo,
          //     ),
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: SizedBox(
                  width: size.width * 0.6,
                  child: SvgPicture.asset(
                    Assets.appLogo,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}