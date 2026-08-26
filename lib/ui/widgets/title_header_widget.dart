import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class TitleHeader extends StatelessWidget {
  final String title;

  const TitleHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: (16 / 430) * context.width,
        right: (16 / 430) * context.width,
        bottom: (12 / 932) * context.height,
      ),
      child: Text(title, style: AppStyles.bold20White),
    );
  }
}