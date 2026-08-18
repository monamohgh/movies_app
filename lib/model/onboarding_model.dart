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
      title: 'Find Your Next Favorite Movie Here',
      description: 'Get access to a huge library of movies to suit all tastes. You will surely like it.',
      imagePath: AppAssets.onboar1,
      isFirstPage: true,
    ),
    OnboardingModel(
      title: 'Discover Movies',
      description: 'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      imagePath: AppAssets.onboar2,
    ),
    OnboardingModel(
      title: 'Explore All Genres',
      description: 'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      imagePath:AppAssets.onboar3,
    ),
    OnboardingModel(
      title: 'Create Watchlists',
      description: 'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities.',
      imagePath: AppAssets.onboar4,
    ),
    OnboardingModel(
      title: 'Rate, Review, and Learn',
      description: 'Share your thoughts on the movies you have watched. Dive deep into film details and help others discover great movies.',
      imagePath: AppAssets.onboar5,
    ),
    OnboardingModel(
      title: 'Start Watching Now',
      description: '',
      imagePath: AppAssets.onboar6,
    ),
  ];
}