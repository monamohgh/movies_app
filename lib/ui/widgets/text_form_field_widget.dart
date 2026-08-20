import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

typedef OnChanged = void Function(String)?;
typedef OnValidator = String? Function(String?)?;

class TextFormFieldWidget extends StatelessWidget {
  final double? radius;
  final Color borderColor;
  final bool? filled;
  final Color? fillColor;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextEditingController? controller;
  final OnChanged onChanged;
  final OnValidator validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  const TextFormFieldWidget({
    super.key,
    this.maxLines = 1,
    required this.borderColor,
    this.radius,
    this.filled,
    this.fillColor,
    this.hintText,
    this.labelText,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.cursorColor,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.controller,
  final TextStyle? textStyle;

  TextFormFieldWidget({
    super.key,
    this.maxLines = 1,
    required this.borderColor,
    this.radius,
    this.filled,
    this.fillColor,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.hintStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textStyle
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: controller == null ? initialValue : null,
      cursorColor: cursorColor ?? AppColors.whiteColor,
      cursorErrorColor: cursorColor ?? AppColors.whiteColor,
      style: style ?? TextStyle(color: AppColors.whiteColor),
      decoration: InputDecoration(
        enabledBorder: builtDecorationBorder(
          borderColor: borderColor,
          radius: radius ?? 16,
        ),
        focusedBorder: builtDecorationBorder(
          borderColor: borderColor,
          radius: radius ?? 16,
        ),
        errorBorder: builtDecorationBorder(
          borderColor: AppColors.redColor,
          radius: radius ?? 16,
        ),
        focusedErrorBorder: builtDecorationBorder(
          borderColor: AppColors.redColor,
          radius: radius ?? 16,
        ),
        filled: filled,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }

  OutlineInputBorder builtDecorationBorder({
    required double radius,
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: borderColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: borderColor, width: 2),
    );
  }
}
