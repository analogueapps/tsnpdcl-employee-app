import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
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
      Navigation.instance.pushAndRemoveUntil(Routes.universalDashboardScreen);
    } else {
      Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);
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
          Center(
            child: SizedBox(
              width: size.width * pointSix,
              child: SvgPicture.asset(
                Assets.appLogo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}