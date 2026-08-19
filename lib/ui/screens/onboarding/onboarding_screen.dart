import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/model/onboarding_model.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'widget/movie_grid_animation.dart';
import 'widget/onboarding_content_container.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingModel> _pages = OnboardingModel.onboardingPages;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    if (!mounted) return;
    //todo:go to loginscreen
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.blackColor,
      body: Stack(
        children: [

          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final page = _pages[index];

              if (page.isFirstPage) {
                return const MovieGridAnimation();
              }

              return Image.asset(
                page.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.blackColor,
                  child:  Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.darkBlackColor,
                      size: 50,
                    ),
                  ),
                ),
              );
            },
          ),


          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.blackColor.withOpacity(0.1),
                    AppColors.blackColor.withOpacity(0.85),
                  ],
                ),
              ),
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: OnboardingContentContainer(
              title: _pages[_currentIndex].title,
              description: _pages[_currentIndex].description,
              buttonText: _currentIndex == 0
                  ? 'explore_now'.tr()
                  : (_currentIndex == _pages.length - 1 ? 'finish'.tr() : 'next'.tr()),
              onNextPressed: () {
                if (_currentIndex == _pages.length - 1) {
                  _finishOnboarding();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              onBackPressed: _currentIndex == 0
                  ? null
                  : () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}