import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/view_saidi_saifi_viewmodel.dart';

class ViewSaidiSaifiScreen extends StatelessWidget {
  static const id = Routes.viewSaidiSaifiScreen;
  const ViewSaidiSaifiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ViewSaidiSaifiViewmodel(),
      child: Consumer<ViewSaidiSaifiViewmodel>(
        builder: (context, viewmodel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.saidiSaifiCalculator.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Select Month
                  const Text("Select Month", style: TextStyle(fontSize: titleSize)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(CommonColors.textFieldColor),
                        shape: WidgetStateProperty.all(
                          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                      ),
                      child: const Text('TAP HERE', style: TextStyle(color: Colors.black)),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
