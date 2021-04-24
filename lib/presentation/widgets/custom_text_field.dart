import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final bool autoCorrect;
  final AutovalidateMode autoValidate;
  final bool enabled;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Widget? suffixIcon;

  const CustomTextField(
      {Key? key,
      @required this.label,
      this.autoCorrect = false,
      this.autoValidate = AutovalidateMode.disabled,
      this.enabled = true,
      this.obscureText = false,
      this.readOnly = false,
      this.maxLines,
      this.onChanged,
      this.onTap,
      this.inputFormatters,
      this.controller,
      this.inputType, this.suffixIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        autocorrect: autoCorrect,
        controller: controller,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        autovalidateMode: autoValidate,
        maxLines: obscureText ? 1 : (maxLines ?? 1),
        onChanged: onChanged,
        keyboardType: inputType,
        onTap: onTap,
        readOnly: readOnly,
        enabled: enabled,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
        ),
      ),
    );
  }
}
