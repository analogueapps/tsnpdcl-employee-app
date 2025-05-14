import 'package:flutter/cupertino.dart';

class ProcessDialog extends StatelessWidget {
  final String? message;

  const ProcessDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Column(
        children: [
          const SizedBox(height: 16),
          const CupertinoActivityIndicator(radius: 14),
          const SizedBox(height: 16),
          Text(
            message ?? "Loading...",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class ProcessDialogHelper {
  static Future<void> showProcessDialog(
      BuildContext context, {
        String? message,
      }) async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ProcessDialog(message: message),
    );
  }

  static void closeDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
