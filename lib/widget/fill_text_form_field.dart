import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';


class FillTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
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
    this.inputFormatters,
    required this.labelText,
    this.isObscure = false,
    this.isEnable = true,
    required this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
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
      inputFormatters: widget.inputFormatters,
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
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: CommonColors.colorPrimary
          )
        ),
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
