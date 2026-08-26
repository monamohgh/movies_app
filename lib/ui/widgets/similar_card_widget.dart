import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class SimilarCardWidget extends StatelessWidget {
  final String imageUrl;
  final double rating;

  const SimilarCardWidget({
    super.key,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: (8 / 932) * context.height,
          left: (8 / 430) * context.width,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: (8 / 430) * context.width,
              vertical: (4 / 932) * context.height,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  rating.toStringAsFixed(1),
                  style: AppStyles.bold20White,
                ),
                SizedBox(width: (4 / 430) * context.width),
                SvgPicture.asset(
                  AppAssets.starIcon,
                  width: (15 / 430) * context.width,
                  height: (15 / 932) * context.height,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}