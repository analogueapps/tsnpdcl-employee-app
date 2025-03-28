import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/saidi_saifi_calculator_viewmodel.dart';

class SaidiSaifiCalculatorScreen extends StatelessWidget {
  static const id = "SaidiSaifiCalculatorScreen";
  const SaidiSaifiCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SaidiSaifiCalculatorViewmodel(),
      child: Consumer<SaidiSaifiCalculatorViewmodel>(
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
          body: Center(child: Text("SaidiSaifiCalculator")),
        );
      }),
    );
  }
}
