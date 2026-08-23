import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/providers/app_language_provider.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/widgets/text_form_field_widget.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

import '../../../utils/dialog_utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;

    context.watch<AppLanguageProvider>();

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          localizations.forget_password,
          style: AppStyles.regular16Primary,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: context.height * 0.02),
                /// Forget Password image
                Image.asset(
                  AppAssets.forgetPassword,
                  height: context.height * 0.3,
                  fit: BoxFit.contain,
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
                    if (!_emailRegex.hasMatch(value.trim())) {
                      return localizations.please_enter_valid_email;
                    }
                    return null;
                  },
                ),

                SizedBox(height: context.height * 0.03),

                ElevatedButtonWidget(
                  backgroundColor: AppColors.primaryColor,
                  verticalPadding: 14,
                  //todo: reset password
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //todo: Call reset logic
                      resetPassword(email:_emailController.text);
                    }
                  },
                  child: Text(
                    localizations.verify_email,
                    style: AppStyles.semi20Black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> resetPassword({required String email}) async {
    //todo:show loading
    DialogUtils.showLoading(context: context, loadingText: 'Loading...');
    try {
      //todo:send request to firebase
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      //todo:hide loading
      //mounted is true=>success
      if(mounted)DialogUtils.hideLoading(context: context);
      if(mounted){
        DialogUtils.showMessage(context: context,
          message: 'Reset link has been sent to your email!',
          positiveActionName: 'OK',
          positiveAction: () {
            Navigator.pop(context); // العودة لشاشة تسجيل الدخول بعد النجاح
          },
        );
      }
    }on FirebaseAuthException catch(e){
      //todo:hide loading in error state
      if(mounted)DialogUtils.hideLoading(context: context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      //todo:show error message
      if(mounted){
        DialogUtils.showMessage(context: context, message: errorMessage,positiveActionName: 'OK');
      }
    }catch(e){
      if (mounted) DialogUtils.hideLoading(context: context,);
      if(mounted){      DialogUtils.showMessage(context: context, message: e.toString(),positiveActionName: 'Ok');
      }
    }
  }
}
