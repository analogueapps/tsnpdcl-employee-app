import 'package:flutter/material.dart';

void showGPSPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("GPS Permission Required"),
        content: const Text(
          "You must grant GPS permission to access your location.\n\n"
          "Please click on SETTING and grant required permission.",
        ),
        actions: [
          TextButton(
            child: const Text("CANCEL"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("SETTING"),
            onPressed: () {
              // Handle settings redirection here
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
