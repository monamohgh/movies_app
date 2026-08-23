import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/providers/app_language_provider.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/widgets/text_form_field_widget.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

import '../../../blocs/user_bloc.dart';
import '../../../firebae_utils.dart';
import '../../../model/my_user.dart';
import '../../../utils/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    var languageProvider = context.watch<AppLanguageProvider>();
    bool isArabic = languageProvider.appLanguage == 'ar';

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
            vertical: context.height * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.height * 0.03),

                Image.asset(
                  AppAssets.movieLogoImage,
                  height: context.height * 0.15,
                  fit: BoxFit.fill,
                ),

                SizedBox(height: context.height * 0.04),

                TextFormFieldWidget(
                  controller: _emailController,
                  borderColor: AppColors.darkGreyColor,
                  fillColor: AppColors.darkGreyColor,
                  filled: true,
                  hintText: localizations.email,
                  keyboardType: TextInputType.emailAddress,
                  hintStyle: AppStyles.regular16White,
                  style: AppStyles.regular16White,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(AppAssets.emailIcon),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.please_enter_email;
                    }
                    final RegExp emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value.trim())) {
                      return localizations.please_enter_valid_email;
                    }
                    return null;
                  },
                ),

                SizedBox(height: context.height * 0.02),

                TextFormFieldWidget(
                  controller: _passwordController,
                  borderColor: AppColors.darkGreyColor,
                  fillColor: AppColors.darkGreyColor,
                  filled: true,
                  obscureText: _isPasswordObscured,
                  hintText: localizations.password,
                  hintStyle: AppStyles.regular16White,
                  style: AppStyles.regular16White,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(AppAssets.passwordIcon),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                      icon: Icon(
                        _isPasswordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.please_enter_password;
                    }
                    return null;
                  },
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.forgetPasswordRouteName,
                      );
                    },
                    child: Text(
                      '${localizations.forget_password}?',
                      style: AppStyles.regular14Primary,
                    ),
                  ),
                ),

                SizedBox(height: context.height * 0.02),

                ElevatedButtonWidget(
                  backgroundColor: AppColors.primaryColor,
                  verticalPadding: 14,
                  onPressed: login,
                  child: Text(
                    localizations.login,
                    style: AppStyles.regular14White.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20,
                    ),
                  ),
                ),

                SizedBox(height: context.height * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${localizations.dont_have_account}?',
                      style: AppStyles.regular14White,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.registerRouteName,
                        );
                      },
                      child: Text(
                        localizations.create_account,
                        style: AppStyles.regular14Primary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.height * 0.02),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryColor,
                        thickness: 1,
                        indent: 40,
                        endIndent: 10,
                      ),
                    ),
                    Text(localizations.or, style: AppStyles.regular14Primary),
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryColor,
                        thickness: 1,
                        indent: 10,
                        endIndent: 40,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.height * 0.025),

                ElevatedButtonWidget(
                  backgroundColor: AppColors.primaryColor,
                  verticalPadding: 12,
                  onPressed: signInWithGoogle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.googleIcon,
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        localizations.login_with_google,
                        style: AppStyles.regular16White.copyWith(
                          color: AppColors.blackColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.height * 0.03),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: GestureDetector(
                    onTap: () {
                      languageProvider.changeLanguage(isArabic ? 'en' : 'ar');
                    },
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.blackColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            alignment: isArabic
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Center(
                                  child: ClipOval(
                                    child: SvgPicture.asset(
                                      AppAssets.usIcon,
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Center(
                                  child: ClipOval(
                                    child: SvgPicture.asset(
                                      AppAssets.egyptIcon,
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void login() async {
    if (_formKey.currentState!.validate() == true) {
      //todo:login
      try {
        //todo:1-show loading
        DialogUtils.showLoading(context: context, loadingText: '${AppLocalizations.of(context)!.loading}....');
        //todo:2-login FirebaseAuth
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        //todo:3-read user from fireStore
        var user = await FirebaseUtils.readUserFromFireStore(
          credential.user?.uid ?? '',
        );
        if (user == null) {
          return;
        }
        //todo:4-save user in bloc
        context.read<UserCubit>().updateUser(user);

        //todo:5-hide loading
        DialogUtils.hideLoading(context: context);
        //todo:6-show message=>success
        DialogUtils.showMessage(
          context: context,
          message: AppLocalizations.of(context)!.login_successfully,
          title:  AppLocalizations.of(context)!.success,
          positiveActionName:  AppLocalizations.of(context)!.ok,
          positiveAction: () {
            Navigator.pushNamed(context, AppRoutes.homeRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo:hide loading
          DialogUtils.hideLoading(context: context);

          //todo:show message=>error
          DialogUtils.showMessage(
            context: context,
            message:
            'The supplied auth credential is incorrect, malformed or has expired.',
            title:  AppLocalizations.of(context)!.error,
            positiveActionName:  AppLocalizations.of(context)!.ok,
          );
        }
      } catch (e) {
        //todo:hide loading
        DialogUtils.hideLoading(context: context);
        //todo:show message=>error
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: AppLocalizations.of(context)!.error,
          positiveActionName:AppLocalizations.of(context)!.ok,
        );
      }
    }
  }
  void signInWithGoogle() async {
    try {
      // 1. إظهار مؤشر التحميل
      DialogUtils.showLoading(context: context, loadingText: '${AppLocalizations.of(context)!.loading}....');
      await GoogleSignIn().signOut();

      // 2. بدء عملية تسجيل الدخول عبر Google
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // إذا أغلق المستخدم النافذة ولم يقتّر إيميل
      if (gUser == null) {
        if (mounted) DialogUtils.hideLoading(context: context);
        return;
      }

      // 3. جلب تفاصيل التوثيق
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // 4. إنشاء الـ Credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // 5. تسجيل الدخول في Firebase
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // 6. قراءة بيانات المستخدم من Firestore
      var user = await FirebaseUtils.readUserFromFireStore(
        userCredential.user?.uid ?? '',
      );

      // إذا كان أول دخول للمستخدم عبر جوجل، ننشئ له سجلاً في Firestore
      if (user == null && userCredential.user != null) {
        var newUser = MyUser(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
          email: userCredential.user!.email ?? '',
        );
        await FirebaseUtils.addUserInFireStore(newUser);
        user = newUser;
      }

      // التأكد من أن الـ Widget ما زالت موجودة قبل استخدام الـ context
      if (!mounted) return;

      // 7. حفظ المستخدم في الـ Cubit
      if (user != null) {
        context.read<UserCubit>().updateUser(user);
      }

      // 8. إخفاء التحميل
      DialogUtils.hideLoading(context: context);

      // 9. الانتقال لشاشة الـ Home
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.homeRouteName, (route) => false);
    } catch (e) {
      if (mounted) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: AppLocalizations.of(context)!.error,
          positiveActionName: AppLocalizations.of(context)!.ok,
        );
      }
    }
  }

}

