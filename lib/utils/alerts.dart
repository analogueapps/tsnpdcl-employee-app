import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
            Icon(isAlert ? Icons.error : Icons.check_circle , color: Colors.white), // Your icon here
            const SizedBox(width: 8), // Space between icon and text
            Expanded(
              child: Text(message),
            ),
          ],
        ),
        //backgroundColor: Colors.black87,
        duration: const Duration(seconds: 2),
        backgroundColor: isAlert ? Colors.red[800] : Colors.green[800],
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
