import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/blocs/movie_details_cubit.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/ui/widgets/cast_card_widget.dart';
import 'package:movies_app/ui/widgets/genre_widget.dart';
import 'package:movies_app/ui/widgets/similar_card_widget.dart';
import 'package:movies_app/ui/widgets/state_values_widget.dart';
import 'package:movies_app/ui/widgets/title_header_widget.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key,  this.movieId=30});

  double scaleW(BuildContext context, double w) => (w / 430) * context.width;
  double scaleH(BuildContext context, double h) => (h / 932) * context.height;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieDetailsCubit(DioManager())..loadMovieDetails(movieId),
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            } else if (state is MovieDetailsErrorState) {
              return Center(
                child: Text(state.message, style: AppStyles.regular16White),
              );
            } else if (state is MovieDetailsSuccessState) {
              final movie = state.movieData;
              final suggestions = state.suggestions;

              final List<String> screenshots = [
                if (movie.largeScreenshot1 != null) movie.largeScreenshot1!,
                if (movie.largeScreenshot2 != null) movie.largeScreenshot2!,
                if (movie.largeScreenshot3 != null) movie.largeScreenshot3!,
              ];

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Poster Header Banner
                    Stack(
                      children: [
                        Image.network(
                          movie.backgroundImageUrl.isNotEmpty
                              ? movie.backgroundImageUrl
                              : movie.largeCoverImage,
                          width: double.infinity,
                          height: scaleH(context, 520),
                          fit: BoxFit.fill,
                        ),
                        Container(
                          width: double.infinity,
                          height: scaleH(context, 520),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.4),
                                AppColors.transparentColor,
                                AppColors.blackColor,
                              ],
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: scaleW(context, 16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: SvgPicture.asset(
                                    AppAssets.arrowBackIcon,
                                    width: scaleW(context, 17),
                                    height: scaleH(context, 29),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<MovieDetailsCubit>()
                                        .toggleBookmark();
                                  },
                                  icon: Icon(
                                    state.isBookmarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: AppColors.whiteColor,
                                    size: scaleW(context, 50),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: scaleH(context, 210),
                          left: 0,
                          right: 0,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.playMovieIcon,
                              width: scaleW(context, 97),
                              height: scaleH(context, 97),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: scaleH(context, 10),
                          left: scaleW(context, 20),
                          right: scaleW(context, 20),
                          child: Column(
                            children: [
                              Text(
                                movie.title,
                                textAlign: TextAlign.center,
                                style: AppStyles.bold24White,
                              ),
                              SizedBox(height: scaleH(context, 6)),
                              Text(
                                '${movie.year}',
                                style: AppStyles.regular16White.copyWith(
                                  color: AppColors.lightGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: scaleH(context, 16)),

                    /// Watch Button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleW(context, 16),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: scaleH(context, 50),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {},
                          child: Text('Watch', style: AppStyles.bold20White),
                        ),
                      ),
                    ),

                    SizedBox(height: scaleH(context, 16)),

                    /// State Values Row
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleW(context, 16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: StateValuesWidget(
                              icon: SvgPicture.asset(
                                AppAssets.favoriteIcon,
                                width: scaleW(context, 30),
                                height: scaleH(context, 28),
                              ),
                              value: '${movie.likeCount}',
                            ),
                          ),
                          SizedBox(width: scaleW(context, 16)),
                          Expanded(
                            child: StateValuesWidget(
                              icon: SvgPicture.asset(
                                AppAssets.clockIcon,
                                width: scaleW(context, 30),
                                height: scaleH(context, 28),
                              ),
                              value: '${movie.runtime}',
                            ),
                          ),
                          SizedBox(width: scaleW(context, 16)),
                          Expanded(
                            child: StateValuesWidget(
                              icon: SvgPicture.asset(
                                AppAssets.starIcon,
                                width: scaleW(context, 30),
                                height: scaleH(context, 28),
                              ),
                              value: movie.rating.toStringAsFixed(1),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: scaleH(context, 24)),

                    /// Screen Shots Section
                    if (screenshots.isNotEmpty) ...[
                      const TitleHeader(title: 'Screen Shots'),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleW(context, 16),
                        ),
                        child: Column(
                          children: screenshots.map((screenshotUrl) {
                            return Container(
                              width: double.infinity,
                              height: scaleH(context, 160),
                              margin: EdgeInsets.only(
                                bottom: scaleH(context, 14),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(screenshotUrl),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: scaleH(context, 16)),
                    ],

                    /// Similar Movies Grid
                    if (suggestions.isNotEmpty) ...[
                      const TitleHeader(title: 'Similar'),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleW(context, 16),
                        ),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.68,
                                crossAxisSpacing: scaleW(context, 14),
                                mainAxisSpacing: scaleH(context, 14),
                              ),
                          itemCount: suggestions.length,
                          itemBuilder: (context, index) {
                            final suggestion = suggestions[index];
                            return SimilarCardWidget(
                              imageUrl: suggestion.mediumCoverImage,
                              rating: suggestion.rating,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: scaleH(context, 24)),
                    ],

                    /// Summary
                    const TitleHeader(title: 'Summary'),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleW(context, 16),
                      ),
                      child: Text(
                        movie.descriptionFull,
                        style: AppStyles.regular16White.copyWith(
                          color: AppColors.lightGreyColor,
                          height: 1.4,
                        ),
                      ),
                    ),

                    SizedBox(height: scaleH(context, 24)),

                    /// Cast
                    if (movie.cast != null && movie.cast!.isNotEmpty) ...[
                      const TitleHeader(title: 'Cast'),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: movie.cast!.length,
                        itemBuilder: (context, index) {
                          return CastCardWidget(actor: movie.cast![index]);
                        },
                      ),
                      SizedBox(height: scaleH(context, 24)),
                    ],

                    /// Genres
                    if (movie.genres.isNotEmpty) ...[
                      const TitleHeader(title: 'Genres'),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleW(context, 16),
                        ),
                        child: Wrap(
                          spacing: scaleW(context, 10),
                          runSpacing: scaleH(context, 10),
                          children: movie.genres
                              .map((genre) => GenreWidget(genre: genre))
                              .toList(),
                        ),
                      ),
                      SizedBox(height: scaleH(context, 32)),
                    ],
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
