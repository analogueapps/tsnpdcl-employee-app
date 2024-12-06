import 'package:flutter/material.dart';

enum AlertType { error, success, warning, info }

class AlertDialogUtils {
  void showAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    required AlertType alertType,
    VoidCallback? onPositivePressed,
    VoidCallback? onNegativePressed,
    String positiveButtonText = 'OK',
    String negativeButtonText = 'Cancel',
    TextAlign messageAlignment = TextAlign.center,
  }) {
    final Color alertColor = _getAlertColor(alertType);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: alertColor.withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text(
            title,
            style: TextStyle(color: alertColor, fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            textAlign: messageAlignment,
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            if (onNegativePressed != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  onNegativePressed();
                },
                child: Text(negativeButtonText),
              ),
            if (onPositivePressed != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: alertColor),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  onPositivePressed();
                },
                child: Text(positiveButtonText),
              ),
          ],
        );
      },
    );
  }

  Color _getAlertColor(AlertType alertType) {
    switch (alertType) {
      case AlertType.error:
        return Colors.red;
      case AlertType.success:
        return Colors.green;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.info:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}
