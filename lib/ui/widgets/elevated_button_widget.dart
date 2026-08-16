import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
class ElevatedButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? verticalPadding;
  final double? radius;

  ElevatedButtonWidget({
    required this.child,
    this.onPressed,required this.backgroundColor,this.verticalPadding,
    this.radius,
    this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: verticalPadding??0),
          backgroundColor: backgroundColor??AppColors.transparentColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 16),
              side:BorderSide(
                color:borderColor??AppColors.transparentColor ,
                width: 2,
              )

          ),
        ),
      ),
    );
  }
}