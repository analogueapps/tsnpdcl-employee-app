import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
            Icon(isAlert ? Icons.error_outline_rounded : Icons.task_alt_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: isAlert ? Colors.red.shade400 : Colors.green.shade400,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
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
