import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class GenreWidget extends StatelessWidget {
  final String genre;

  const GenreWidget({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (20 / 430) * context.width,
        vertical: (10 / 932) * context.height,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        genre,
        style: AppStyles.regular14White,
      ),
    );
  }
}