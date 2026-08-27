import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details_screen.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

import '../../../../../../utils/data_store.dart';

class AvailableMoviesCarousel extends StatefulWidget {
  final List<dynamic> movies;

  const AvailableMoviesCarousel({super.key, required this.movies});

  @override
  State<AvailableMoviesCarousel> createState() => _AvailableMoviesCarouselState();
}

class _AvailableMoviesCarouselState extends State<AvailableMoviesCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  double scaleW(BuildContext context, double w) => (w / 430) * context.width;
  double scaleH(BuildContext context, double h) => (h / 932) * context.height;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.58, initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.Available),
        SizedBox(height: scaleH(context, 15)),
        SizedBox(
          height: scaleH(context, 340),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.movies.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              final isSelected = index == _currentIndex;

              return GestureDetector(
                onTap: () {// Add to Watch List
                  MovieDataStore.addToWatchList(
                    SavedMovie(
                      id: movie['id'] ?? 0,
                      title: movie['title'] ?? '',
                      imageUrl: movie['large_cover_image'] ?? movie['medium_cover_image'] ?? '',
                      rating: (movie['rating'] as num?)?.toDouble() ?? 0.0,
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(movieId: movie['id']),
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  margin: EdgeInsets.symmetric(
                    horizontal: scaleW(context, 8),
                    vertical: isSelected ? 0 : scaleH(context, 25),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ]
                        : [],
                    image: DecorationImage(
                      image: NetworkImage(movie['large_cover_image'] ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleW(context, 8),
                        vertical: scaleH(context, 4),
                      ),
                      margin: EdgeInsets.all(scaleW(context, 8)),
                      decoration: BoxDecoration(
                        color: AppColors.blackColor.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${movie['rating'] ?? 0.0}',
                            style: AppStyles.regular15White,
                          ),
                          SizedBox(width: scaleW(context, 4)),
                          Icon(
                            Icons.star,
                            color: AppColors.primaryColor,
                            size: scaleW(context, 16),
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