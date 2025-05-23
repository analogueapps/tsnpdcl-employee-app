import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';

class ViewDetailedLcTileWidget extends StatelessWidget {
  final String tileKey;
  final String tileValue;
  final Color? valueColor;

  const ViewDetailedLcTileWidget({
    super.key,
    required this.tileKey,
    required this.tileValue,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Column(
    children: [
      Row(
        children: [
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              tileKey.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            child: Text(
              tileValue,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
    const SizedBox(height: doubleTen),
    ]
    ),
    );
  }
}
