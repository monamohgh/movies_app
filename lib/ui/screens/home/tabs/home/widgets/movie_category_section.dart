import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details_screen.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieCategorySection extends StatelessWidget {
  final String title;
  final List<dynamic> movies;
  final VoidCallback? onSeeMoreTap;

  const MovieCategorySection({
    super.key,
    required this.title,
    required this.movies,
    this.onSeeMoreTap,
  });

  double scaleW(BuildContext context, double w) => (w / 430) * context.width;
  double scaleH(BuildContext context, double h) => (h / 932) * context.height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleW(context, 16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyles.bold20White,
              ),
              GestureDetector(
                onTap: onSeeMoreTap,
                child: Row(
                  children: [
                    Text('See More', style: AppStyles.regular15Primary),
                    SizedBox(width: scaleW(context, 4)),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryColor,
                      size: scaleW(context, 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: scaleH(context, 12)),
        SizedBox(
          height: scaleH(context, 180),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(movieId: movie['id']),
                    ),
                  );
                },
                child: Container(
                  width: scaleW(context, 120),
                  margin: EdgeInsets.only(left: scaleW(context, 16)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(movie['medium_cover_image'] ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleW(context, 6),
                        vertical: scaleH(context, 2),
                      ),
                      margin: EdgeInsets.all(scaleW(context, 6)),
                      decoration: BoxDecoration(
                        color: AppColors.blackColor.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${movie['rating'] ?? 0.0}',
                            style: AppStyles.regular14White,
                          ),
                          Icon(
                            Icons.star,
                            color: AppColors.primaryColor,
                            size: scaleW(context, 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}