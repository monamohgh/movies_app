import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/blocs/search_cubit.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import '../../../../../utils/data_store.dart';
import '../../../movie_details/movie_details_screen.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.blackColor,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Builder(
                  builder: (context) {
                    return TextSelectionTheme(
                      data: TextSelectionThemeData(
                        selectionHandleColor: AppColors.primaryColor,
                        cursorColor: AppColors.primaryColor,
                      ),
                      child: TextField(
                        style: AppStyles.regular16White,
                        onChanged: (query) {
                          context.read<SearchCubit>().search(query);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.searchIcon,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.darkGreyColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }

                      if (state is SearchInitialState) {
                        return const SizedBox.shrink() ;
                      }

                      if (state is SearchSuccessState) {
                        return _buildMoviesGrid(context, state.movies);
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Reusable grid of movies
  Widget _buildMoviesGrid(BuildContext context, List<dynamic> movies) {
    if (movies.isEmpty) {
      return _buildNotFoundWidget();
    }

    return GridView.builder(
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, i) {
        final movie = movies[i];
        final int movieId = movie['id'] is int
            ? movie['id']
            : int.tryParse(movie['id'].toString()) ?? 0;
        return GestureDetector(
          onTap: () {
            final int movieId = movie['id'] is int
                ? movie['id']
                : int.tryParse(movie['id'].toString()) ?? 0;


            final savedMovie = SavedMovie(
              id: movieId,
              title: movie['title'] ?? '',
              imageUrl: movie['medium_cover_image'] ?? '',
              rating: (movie['rating'] is num) ? (movie['rating'] as num).toDouble() : 0.0,
            );


            MovieDataStore.addToWatchList(savedMovie);


            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movieId: movieId),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              movie['medium_cover_image'] ?? '',
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotFoundWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Film Found',
            style: AppStyles.regular15Primary,
          ),
        ],
      ),
    );
  }
}