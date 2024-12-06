import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: CommonColors.colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          //elevation: 15.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
