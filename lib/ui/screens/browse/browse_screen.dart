import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/browse/widgets/categories_list.dart';
import 'package:movies_app/ui/screens/browse/widgets/movie_card.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';


class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  // ===========================================================================
  // TODO (FOR API DEVELOPER):
  // 1. Replace the static lists below with Provider/Cubit Data Models.
  // 2. Fetch categories from backend (e.g. provider.categoriesList).
  // 3. Fetch movies based on selected category ID (e.g. provider.moviesList).
  // ===========================================================================

  // MOCK DATA (Temporary for UI preview - To be replaced by API Data)
  final List<String> dummyCategories = const [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
  ];

  final List<Map<String, String>> dummyMovies = const [
    {
      'image': 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      'rating': '7.7'
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/udDclC23M3qL3232Y9d93gS9d3.jpg',
      'rating': '7.7'
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/rCzpD29L53I9R93m22Y9.jpg',
      'rating': '7.7'
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/5m1O1m2Y33.jpg',
      'rating': '7.7'
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/or06Ga1y3A3O.jpg',
      'rating': '7.7'
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/62P1f242.jpg',
      'rating': '7.7'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        elevation: 0,
        title: Text(
          'Browse',
          style: AppStyles.bold22White,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: context.height * 0.01),

          // -------------------------------------------------------------------
          // CATEGORIES SECTION
          // -------------------------------------------------------------------
          CategoriesList(
            // TODO: Replace 'dummyCategories' with 'provider.categories'
            categories: dummyCategories,
            onCategorySelected: (selectedIndex) {
              // TODO (FOR API DEVELOPER):
              // Call API function to load movies for selected category ID here:
              // provider.getMoviesByCategoryId(categories[selectedIndex].id);
            },
          ),

          SizedBox(height: context.height * 0.02),

          // -------------------------------------------------------------------
          // MOVIES GRID SECTION
          // -------------------------------------------------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // TODO (FOR API DEVELOPER):
              // Wrap GridView with Consumer / BlocBuilder to handle Loading & Error States:
              // if (state is Loading) return CircularProgressIndicator();
              child: GridView.builder(
                // TODO: Replace 'dummyMovies.length' with 'provider.moviesList.length'
                itemCount: dummyMovies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  // TODO: Replace 'dummyMovies[index]' with actual MovieModel from API
                  final movie = dummyMovies[index];

                  return MovieCard(
                    // TODO: Replace with model attributes:
                    // imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    // rating: movie.voteAverage.toString()
                    imageUrl: movie['image']!,
                    rating: movie['rating']!,
                    onTap: () {
                      // TODO: Navigate to Movie Details Screen with selected movie ID
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/size_utils.dart';
import '../manager/browse_provider.dart';
import '../widgets/categories_list.dart';
import '../widgets/movie_card.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        elevation: 0,
        title: Text(
          'Browse',
          style: AppStyles.bold22White,
        ),
      ),
      body: Consumer<BrowseProvider>(
        builder: (context, provider, child) {
          // 1. حالة التحميل للتصنيفات الأولية (Initial Loading)
          if (provider.isCategoriesLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          // 2. حالة وجود خطأ في جلب التصنيفات
          if (provider.categoriesError != null) {
            return Center(
              child: Text(
                provider.categoriesError!,
                style: AppStyles.regular16White,
              ),
            );
          }

          return Column(
            children: [
              SizedBox(height: context.height * 0.01),

              // ---------------------------------------------------------------
              // CATEGORIES LIST (عرض قائمة التصنيفات القادمة من الـ API)
              // ---------------------------------------------------------------
              CategoriesList(
                // تحويل الموديل لأسماء التصنيفات للتصميم
                categories: provider.categories.map((c) => c.name).toList(),
                onCategorySelected: (selectedIndex) {
                  // جلب الأفلام الخاصة بالتصنيف المختار بواسطة الـ ID
                  final categoryId = provider.categories[selectedIndex].id;
                  provider.getMoviesByCategoryId(categoryId);
                },
              ),

              SizedBox(height: context.height * 0.02),

              // ---------------------------------------------------------------
              // MOVIES GRID (عرض الأفلام بناءً على التصنيف المحدد)
              // ---------------------------------------------------------------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Builder(
                    builder: (context) {
                      // أ) حالة تحميل أفلام التصنيف المحدد
                      if (provider.isMoviesLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }

                      // ب) حالة حدوث خطأ أثناء جلب الأفلام
                      if (provider.moviesError != null) {
                        return Center(
                          child: Text(
                            provider.moviesError!,
                            style: AppStyles.regular16White,
                          ),
                        );
                      }

                      // ج) حالة عدم وجود أفلام للتصنيف
                      if (provider.movies.isEmpty) {
                        return Center(
                          child: Text(
                            'No movies found in this category',
                            style: AppStyles.regular16White,
                          ),
                        );
                      }

                      // د) عرض الأفلام القادمة من الـ API بـ GridView
                      return GridView.builder(
                        itemCount: provider.movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.68,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final movie = provider.movies[index];

                          return MovieCard(
                            // إسناد بيانات الـ Model الحقيقية للـ Widget بتاعك
                            imageUrl: movie.posterUrl,
                            rating: movie.rating.toStringAsFixed(1),
                            onTap: () {
                              // التنقل لشاشة تفاصيل الفيلم وتمرير الـ ID
                              // Navigator.pushNamed(context, MovieDetailsScreen.routeName, arguments: movie.id);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
 */