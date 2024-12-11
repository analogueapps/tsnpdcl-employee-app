import 'package:flutter/material.dart';

class ApptrolsProgressDialog extends StatefulWidget {
  final String? progressText;
  final bool hideText;

  const ApptrolsProgressDialog({
    super.key,
    this.progressText,
    this.hideText = false,
  });

  static void show(BuildContext context, {String? progressText, bool hideText = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ApptrolsProgressDialog(
        progressText: progressText,
        hideText: hideText,
      ),
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  State<ApptrolsProgressDialog> createState() => _ApptrolsProgressDialogState();
}

class _ApptrolsProgressDialogState extends State<ApptrolsProgressDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _colorIndex = 0;
  final List<Color> _progressColors = [
    Colors.deepPurple,
    Colors.yellow,
    Colors.teal,
    Colors.deepOrange,
    Colors.blue,
    Colors.green,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        setState(() {
          _colorIndex = (_colorIndex + 1) % _progressColors.length;
        });
        _controller.forward(from: 0);
      }
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              turns: _controller,
              child: Icon(
                Icons.sync,
                size: 48,
                color: _progressColors[_colorIndex],
              ),
            ),
            const SizedBox(height: 16),
            if (!widget.hideText)
              Text(
                widget.progressText ?? 'Loading...',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
