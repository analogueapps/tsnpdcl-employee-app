import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/general_routes.dart';
import '../../../utils/global_constants.dart';
import '../../../utils/navigation_service.dart';
import 'meters_stock.dart';

class LtmtMenu extends StatelessWidget {
  static const id = Routes.ltmtScreen;
  const LtmtMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.ltmtTitle.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
          onPressed:(){
            Navigation.instance.navigateTo(Routes.metersStock);
            },
          child:
          const Text(GlobalConstants.metersStock,style: TextStyle(color: Colors.black)),
          ),
          const Divider(),
          const TextButton(
            onPressed:null,
            child:
                Text(GlobalConstants.metersOM, style: TextStyle(color: Colors.black)),
          ),
          const Divider(),
        ],
      ),
      ),
    );
  }
}
