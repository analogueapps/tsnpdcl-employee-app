import 'package:flutter/material.dart';

void showGPSPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("GPS Permission Required"),
        content: Text(
          "You must grant GPS permission to access your location.\n\n"
              "Please click on SETTING and grant required permission.",
        ),
        actions: [
          TextButton(
            child: Text("CANCEL"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("SETTING"),
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