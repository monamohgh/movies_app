import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/user_bloc.dart';
import 'package:movies_app/ui/screens/home/tabs/profile/profile_tab.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details_screen.dart';
import 'package:movies_app/ui/screens/onboarding/onboarding_screen.dart';
import 'package:movies_app/ui/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/providers/app_language_provider.dart';
import 'package:movies_app/ui/screens/forget_password/forget_password.dart';
import 'package:movies_app/ui/screens/home/home_screen.dart';
import 'package:movies_app/ui/screens/login/login_screen.dart';
import 'package:movies_app/ui/screens/register/register_screen.dart';
import 'package:movies_app/ui/screens/updateprofile/update_profile.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
      BlocProvider(create: (context) => UserCubit(),///Bloc
      )
    ],
    child: const MyApp()),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppColors.blackColor),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.splashScreenRouteName: (context) => SplashScreen(),
        AppRoutes.onBoardingScreenName: (context) => OnboardingScreen(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
         AppRoutes.movieDetails: (context) => MovieDetailsScreen(),
         AppRoutes.profile:(context) =>ProfileTab(),
         AppRoutes.updateProfileRouteName: (context) =>UpdateProfileScreen(),
        AppRoutes.loginRouteName: (context) => const LoginScreen(),
        AppRoutes.registerRouteName: (context) => const RegisterScreen(),
        AppRoutes.forgetPasswordRouteName: (context) =>const ForgetPasswordScreen(),
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}


