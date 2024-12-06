import 'package:flutter/material.dart';

class ProcessDialog extends StatefulWidget {
  final String? message;

  const ProcessDialog({super.key, this.message});

  @override
  State<ProcessDialog> createState() => _ProcessDialogState();
}

class _ProcessDialogState extends State<ProcessDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              widget.message ?? "Loading...",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  /// Close the dialog
  void closeDialog() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

class ProcessDialogHelper {
  static Future<void> showProcessDialog(
      BuildContext context, {
        String? message,
      }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProcessDialog(message: message),
    );
  }

  static void closeDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
