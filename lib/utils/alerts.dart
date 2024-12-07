import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/const.dart';

// Define an enum for message types
enum AlertType { success, info, warning, error, custom }

class AlertUtils {
  static responseToast(BuildContext context, int code) {
    String message = "";

    switch (code) {
      case 200:
        message = "Success";
        break;
      case 201:
        message = "Created";
        break;
      case 204:
        message = "No Content";
        break;
      case 400:
        message = "Bad Request";
        break;
      case 401:
        message = "Unauthorized";
        break;
      case 403:
        message = "Forbidden";
        break;
      case 404:
        message = "Not Found";
        break;
      case 405:
        message = "Method Not Allowed";
        break;
      case 413:
        message = "Payload Too Large";
        break;
      case 500:
        message = "Internal Server Error";
        break;
      case 503:
        message = "Service Unavailable";
        break;
      case 429:
        message = "Too Many Requests";
        break;
      default:
        message = "Unexpected error occurred";
        break;
    }

    AlertUtils.showSnackBar(context, message, true);
  }

  static showSnackBar(BuildContext context, String message, bool isAlert) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_getIcon(AlertType.error), color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: _getColor(AlertType.success),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  static Color? _getColor(AlertType type) {
    switch (type) {
      case AlertType.success:
        return Color(0xffe5f9f1);
      case AlertType.info:
        return Colors.blue.shade400;
      case AlertType.warning:
        return Colors.orange.shade400;
      case AlertType.error:
        return Color(0xfffee7e7);
      case AlertType.custom:
        return Colors.purple.shade400;
    }
  }

  // Map SnackbarType to specific icons
  static IconData _getIcon(AlertType type) {
    switch (type) {
      case AlertType.success:
        return Icons.supervised_user_circle;
      case AlertType.info:
        return Icons.info;
      case AlertType.warning:
        return Icons.warning;
      case AlertType.error:
        return Icons.error;
      case AlertType.custom:
        return Icons.send;
    }
  }

  static printValue(String tag, String message) {
    if (kDebugMode) {
      debugPrint('$tag : $message', wrapWidth: FlutterError.wrapWidth);
    }
  }

  static showProgress(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CupertinoActivityIndicator(
          radius: 20.0,
        ),
      ),
    );
  }


}
