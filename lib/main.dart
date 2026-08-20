import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/app_language_bloc.dart';
import 'package:movies_app/ui/screens/forget_password.dart';
import 'package:movies_app/ui/screens/home/home_screen.dart';
import 'package:movies_app/ui/screens/login_screen.dart';
import 'package:movies_app/ui/screens/register_screen.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AppLanguageCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLanguageCubit, Locale>(
      builder: (context, currentLocale) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.blackColor,

          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.loginRouteName,
          routes: {
            // AppRoutes.splashScreenRouteName: (context) => const SplashScreen(),
            // AppRoutes.welcomeScreenRouteName: (context) => const WelcomeScreen(),
            // AppRoutes.onBoardingScreenName: (context) => const OnBoardingScreen(),
             AppRoutes.loginRouteName: (context) => const LoginScreen(),
             AppRoutes.registerRouteName: (context) => const RegisterScreen(),
             AppRoutes.forgetPasswordRouteName: (context) => const ForgetPasswordScreen(),
            AppRoutes.homeRouteName: (context) => const HomeScreen(),
            // AppRoutes.detailsRouteName: (context) => const DetailsScreen(),
            // AppRoutes.updateProfileRouteName: (context) => const UpdateProfileScreen(),
          },
          locale: currentLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}