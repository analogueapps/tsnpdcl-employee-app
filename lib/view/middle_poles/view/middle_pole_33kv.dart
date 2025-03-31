import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

class MiddlePoles33kv extends StatelessWidget {
  static const id = "MiddlePoles33kv";

  const MiddlePoles33kv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // Distribute space evenly
            children: [
              Text(
                GlobalConstants.newMiddlePoles.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(), // Pushes icons to the right
              IconButton(
                icon: const Icon(Icons.save_outlined),
                color: Colors.white,
                onPressed: () {
                  // Add your save action here
                  print("Save icon pressed");
                },
              ),
              IconButton(
                icon: const Icon(Icons.folder_outlined),
                color: Colors.white,
                onPressed: () {
                  // Add your folder action here
                  print("Folder icon pressed");
                },
              ),
            ],
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            // color: item.cardColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ));
  }
}
