import 'package:flutter/material.dart';
import 'package:movies_app/providers/app_language_provider.dart';
import 'package:movies_app/ui/screens/home/home_screen.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'ui/screens/onboarding/onboarding_screen.dart';
import 'ui/screens/splash/splash_screen.dart';


void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context)=>AppLanguageProvider(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.blackColor,
      ),
     debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreenRouteName,
      routes: {
        AppRoutes.splashScreenRouteName: (context) =>SplashScreen(),
        AppRoutes.onBoardingScreenName: (context) =>OnboardingScreen(),
        // AppRoutes.loginRouteName: (context) =>
        // AppRoutes.registerRouteName: (context) =>
        // AppRoutes.forgetPasswordRouteName: (context) =>
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        // AppRoutes.detailsRouteName: (context) =>
        // AppRoutes.updateProfileRouteName: (context) =>
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}


