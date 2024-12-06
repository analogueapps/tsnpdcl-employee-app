import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/const.dart';


class FillTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final bool isEnable;
  final TextInputType keyboardType;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final VoidCallback? onFieldSubmitted;

  const FillTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    this.isEnable = true,
    required this.keyboardType,
    required this.prefixIcon,
    required this.suffixIcon,
    this.validator,
    this.onChange,
    this.onFieldSubmitted,
  });

  @override
  State<FillTextFormField> createState() => _FillTextFormFieldState();
}

class _FillTextFormFieldState extends State<FillTextFormField> {
  late bool _isObscure;
  late bool _isEnable;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isObscure;
    _isEnable = widget.isEnable;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
      enabled: _isEnable,
      style: const TextStyle(
        fontSize: titleSize,
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w600,
      ),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(fontFamily: appFontFamily),
        hintStyle: const TextStyle(fontFamily: appFontFamily),
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isObscure
            ? IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        )
            : widget.suffixIcon,
      ),
      validator: widget.validator,
      onChanged: widget.onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: widget.onFieldSubmitted != null
          ? (value) => widget.onFieldSubmitted!()
          : null,
    );
  }
}
