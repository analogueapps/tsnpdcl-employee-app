import 'package:flutter/material.dart';


class ViewDetailedLcHeadWidget extends StatelessWidget {
  final String title;

  const ViewDetailedLcHeadWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      color: Colors.grey[200],
      width: double.infinity,
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
