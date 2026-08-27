import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/blocs/home_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/home/widgets/available_movies_carousel.dart';
import 'package:movies_app/ui/screens/home/tabs/home/widgets/movie_category_section.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/l10n/app_localizations.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  double scaleW(BuildContext context, double w) => (w / 430) * context.width;
  double scaleH(BuildContext context, double h) => (h / 932) * context.height;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => HomeCubit(DioManager())..getHomeData(),
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            } else if (state is HomeErrorState) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(scaleW(context, 20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off_rounded,
                        color: AppColors.primaryColor,
                        size: scaleW(context, 60),
                      ),
                      SizedBox(height: scaleH(context, 16)),
                      Text(
                        state.errorMessage,
                        style: AppStyles.regular16White,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: scaleH(context, 20)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.blackColor,
                        ),
                        onPressed: () {
                          context.read<HomeCubit>().getHomeData();
                        },
                        child: Text('try again', style: AppStyles.bold16Black),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is HomeSuccessState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            AppAssets.onboar6,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppColors.blackColor.withValues(alpha: 0.8),
                                  AppColors.blackColor,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: scaleH(context, 50)),
                            AvailableMoviesCarousel(movies: state.availableMovies),
                            SizedBox(height: scaleH(context, 15)),
                            Image.asset(
                              AppAssets.WatchNow,
                              width: scaleW(context, 250),
                            ),
                            SizedBox(height: scaleH(context, 15)),
                          ],
                        ),
                      ],
                    ),

                    MovieCategorySection(
                      title: localizations.action,
                      movies: state.actionMovies,
                      onSeeMoreTap: () {},
                    ),
                    SizedBox(height: scaleH(context, 20)),

                    if (state.dramaMovies.isNotEmpty) ...[
                      MovieCategorySection(
                        title: localizations.drama,
                        movies: state.dramaMovies,
                        onSeeMoreTap: () {},
                      ),
                      SizedBox(height: scaleH(context, 20)),
                    ],

                    if (state.sciFiMovies.isNotEmpty) ...[
                      MovieCategorySection(
                        title: localizations.sci_fi,
                        movies: state.sciFiMovies,
                        onSeeMoreTap: () {},
                      ),
                      SizedBox(height: scaleH(context, 20)),
                    ],

                    SizedBox(height: scaleH(context, 30)),
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