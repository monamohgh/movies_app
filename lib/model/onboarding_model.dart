  import 'package:flutter/cupertino.dart';
  import 'package:movies_app/utils/app_assets.dart';

  import '../l10n/app_localizations.dart';

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

    static List<OnboardingModel> getOnboardingPages(BuildContext context){
      return [
        OnboardingModel(
          title: AppLocalizations.of(context)!.find_your_next_movie,
          description:  AppLocalizations.of(context)!.get_access_to_huge_library,
          imagePath: AppAssets.onboar1,
          isFirstPage: true,
        ),

        OnboardingModel(
          title:  AppLocalizations.of(context)!.discovers_movies,
          description: AppLocalizations.of(context)!.explore_vast_collection,
          imagePath: AppAssets.onboar2,
        ),

        OnboardingModel(
          title:  AppLocalizations.of(context)!.explore_now,
          description: AppLocalizations.of(context)!.discovers_movies_from_every_genre,
          imagePath: AppAssets.onboar3,
        ),

        OnboardingModel(
          title:  AppLocalizations.of(context)!.create_watchlists,
          description:  AppLocalizations.of(context)!.save_movies_to_your_watchlists,
          imagePath: AppAssets.onboar4,
        ),

        OnboardingModel(
          title:  AppLocalizations.of(context)!.rate_review_learn,
          description:  AppLocalizations.of(context)!.share_your_thoughts,
          imagePath: AppAssets.onboar5,
        ),

        OnboardingModel(
          title:  AppLocalizations.of(context)!.start_watching_now,
          description: '',
          imagePath: AppAssets.onboar6,
        ),
      ];
    }


  }