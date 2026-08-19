import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/utils/app_assets.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;
  final bool isFirstPage;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
    this.isFirstPage = false,
  });

  static List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: 'find_your_next_favorite_movie'.tr(),
      description: 'get_access_to_huge_library'.tr(),
      imagePath: AppAssets.onboar1,
      isFirstPage: true,
    ),

    OnboardingModel(
      title: 'discover_movies'.tr(),
      description: 'explore_vast_collection'.tr(),
      imagePath: AppAssets.onboar2,
    ),

    OnboardingModel(
      title: 'explore_all_genres'.tr(),
      description: 'discover_movies_from_every_genre'.tr(),
      imagePath: AppAssets.onboar3,
    ),

    OnboardingModel(
      title: 'create_watchlists'.tr(),
      description: 'save_movies_to_watchlist'.tr(),
      imagePath: AppAssets.onboar4,
    ),

    OnboardingModel(
      title: 'rate_review_and_learn'.tr(),
      description: 'share_your_thoughts_on_movies'.tr(),
      imagePath: AppAssets.onboar5,
    ),

    OnboardingModel(
      title: 'start_watching_now'.tr(),
      description: '',
      imagePath: AppAssets.onboar6,
    ),
  ];
}