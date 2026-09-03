import 'package:flutter/material.dart';

import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/app_styles.dart';


class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String rating;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Movie Poster Image
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.darkGreyColor,
                  child: Icon(
                    Icons.broken_image,
                    color: AppColors.lightGreyColor,
                  ),
                ),
              ),
            ),
            // Rating Badge
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.blackColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rating,
                      style: AppStyles.regular16White.copyWith(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.star,
                      color: AppColors.primaryColor,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}