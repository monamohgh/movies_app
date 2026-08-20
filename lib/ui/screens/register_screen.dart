import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/providers/app_language_provider.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/widgets/text_form_field_widget.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  final List<String> _avatars = [
    AppAssets.avatar1,
    AppAssets.avatar2,
    AppAssets.avatar3,
    AppAssets.avatar4,
    AppAssets.avatar5,
    AppAssets.avatar6,
    AppAssets.avatar7,
    AppAssets.avatar8,
    AppAssets.avatar9,
  ];

  int _selectedAvatarIndex = 0;
  PageController? _pageController;

  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static const double _designWidth = 375.0;
  static const double _designHeight = 812.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_pageController == null) {
      double responsiveItemWidth = 182 * (context.width / _designWidth);
      double viewportFraction = responsiveItemWidth / context.width;

      _pageController = PageController(
        initialPage: _selectedAvatarIndex,
        viewportFraction: viewportFraction,
      );
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    var languageProvider = context.watch<AppLanguageProvider>();
    bool isArabic = languageProvider.appLanguage == 'ar';

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(localizations.register, style: AppStyles.regular16Primary),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
            vertical: context.height * 0.01,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 161 * (context.height / _designHeight),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _avatars.length,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedAvatarIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      bool isSelected = index == _selectedAvatarIndex;
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            _pageController?.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width:
                                (isSelected ? 158 : 86) *
                                (context.width / _designWidth),
                            height:
                                (isSelected ? 161 : 86) *
                                (context.height / _designHeight),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(_avatars[index]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: context.height * 0.01),

                Text('Avatar', style: AppStyles.regular16White),

                SizedBox(height: context.height * 0.02),

                TextFormFieldWidget(
                  controller: _nameController,
                  borderColor: AppColors.darkGreyColor,
                  fillColor: AppColors.darkGreyColor,
                  filled: true,
                  hintText: localizations.name,
                  hintStyle: AppStyles.regular16White,
                  style: AppStyles.regular16White,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(AppAssets.nameIcon),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.please_enter_name;
                    }
                    return null;
                  },
                ),

                SizedBox(height: context.height * 0.015),

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

                SizedBox(height: context.height * 0.015),

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

                SizedBox(height: context.height * 0.015),

                TextFormFieldWidget(
                  controller: _confirmPasswordController,
                  borderColor: AppColors.darkGreyColor,
                  fillColor: AppColors.darkGreyColor,
                  filled: true,
                  obscureText: _isConfirmPasswordObscured,
                  hintText: localizations.confirm_password,
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
                          _isConfirmPasswordObscured =
                              !_isConfirmPasswordObscured;
                        });
                      },
                      icon: Icon(
                        _isConfirmPasswordObscured
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
                    if (value != _passwordController.text) {
                      return localizations.please_enter_password;
                    }
                    return null;
                  },
                ),

                SizedBox(height: context.height * 0.015),

                TextFormFieldWidget(
                  controller: _phoneController,
                  borderColor: AppColors.darkGreyColor,
                  fillColor: AppColors.darkGreyColor,
                  filled: true,
                  hintText: localizations.phone_number,
                  keyboardType: TextInputType.phone,
                  hintStyle: AppStyles.regular16White,
                  style: AppStyles.regular16White,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(AppAssets.phoneIcon),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.please_enter_phone;
                    }
                    return null;
                  },
                ),

                SizedBox(height: context.height * 0.025),

                ElevatedButtonWidget(
                  backgroundColor: AppColors.primaryColor,
                  verticalPadding: 14,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    localizations.create_account,
                    style: AppStyles.regular14White.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20,
                    ),
                  ),
                ),

                SizedBox(height: context.height * 0.015),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizations.already_have_account,
                      style: AppStyles.regular14White,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        localizations.login,
                        style: AppStyles.regular14Primary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.height * 0.015),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: GestureDetector(
                    onTap: () {
                      languageProvider.changeLanguage(isArabic ? 'en' : 'ar');
                    },
                    child: Container(
                      width: 90 * (context.width / _designWidth),
                      height: 40 * (context.height / _designHeight),
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
                              width: 35 * (context.width / _designWidth),
                              height: 35 * (context.height / _designHeight),
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
                                width: 35 * (context.width / _designWidth),
                                height: 35 * (context.height / _designHeight),
                                child: Center(
                                  child: ClipOval(
                                    child: SvgPicture.asset(
                                      AppAssets.usIcon,
                                      width:
                                          25 * (context.width / _designWidth),
                                      height:
                                          25 * (context.height / _designHeight),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 35 * (context.width / _designWidth),
                                height: 35 * (context.height / _designHeight),
                                child: Center(
                                  child: ClipOval(
                                    child: SvgPicture.asset(
                                      AppAssets.egyptIcon,
                                      width:
                                          25 * (context.width / _designWidth),
                                      height:
                                          25 * (context.height / _designHeight),
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
                SizedBox(height: 109 * (context.height / _designHeight)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
