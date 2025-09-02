import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  final bool expands;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.hintStyle,
    this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.height,
    this.expands = false,
    this.enabled,
    this.textInputAction = TextInputAction.unspecified,
    this.obscureText = false,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
        enabled: enabled,
        readOnly: readOnly,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: obscureText ? 1 : null, // obscure texts can't be multi-lined
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: inputFormatters,
        expands: expands,
        decoration: InputDecoration(
          filled: true,
          fillColor: (readOnly || enabled == false)
              ? Colors.grey[200]
              : Colors.transparent,
          hintText: hintText,
          hintStyle: hintStyle,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: null,
        ),
        textInputAction: textInputAction,
        obscureText: obscureText,
        onChanged: onChanged,
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
