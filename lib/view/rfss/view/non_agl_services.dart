import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class NonAglServices extends StatelessWidget {
  static const id = Routes.nonAglService;
  const NonAglServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.nonAGLService.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: const [
          TextButton(
            onPressed: null,
            child: Text("UPDATE DTR MAKES", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adds spacing around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Select Distribution"), // Ensure it has proper padding
            const SizedBox(height: 20), // Add spacing

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure proper spacing
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: "SEARCH SERVICE",
                    onPressed: () {
                      // viewModel.submitForm();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    text: "SAVE",
                    onPressed: () {
                      // viewModel.submitForm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}
