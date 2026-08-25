import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class StateValuesWidget extends StatelessWidget {
  final Widget icon;
  final String value;

  const StateValuesWidget({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: (16 / 932) * context.height,
        horizontal: (16 / 430) * context.width,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: (16 / 430) * context.width),
          Text(value, style: AppStyles.bold20White),
        ],
      ),
    );
  }
}