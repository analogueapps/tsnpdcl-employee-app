import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';

class GlobalAlertDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    String positiveButtonText = 'OK',
    String negativeButtonText = 'Cancel',
    VoidCallback? onPositivePressed,
    VoidCallback? onNegativePressed,
    bool dismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12.0),
          // ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            if (onNegativePressed != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  onNegativePressed();
                },
                child: Text(negativeButtonText),
              ),
            if (onPositivePressed != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: CommonColors.colorPrimary),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  onPositivePressed();
                },
                child: Text(
                  positiveButtonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }
}
