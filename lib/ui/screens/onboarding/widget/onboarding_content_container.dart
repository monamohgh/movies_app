import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class OnboardingContentContainer extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onNextPressed;
  final VoidCallback? onBackPressed;

  const OnboardingContentContainer({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onNextPressed,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.05,
        vertical: context.height * 0.03,
      ),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.width * 0.06),
          topRight: Radius.circular(context.width * 0.06),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.bold22White,
          ),

          SizedBox(
            height: context.height * 0.015,
          ),

          Text(
            description,
            textAlign: TextAlign.center,
            style: AppStyles.regular13LightGrey.copyWith(
              height: 1.4,
            ),
          ),

          SizedBox(
            height: context.height * 0.025,
          ),

          SizedBox(
            width: double.infinity,
            height: context.height * 0.06,
            child: ElevatedButton(
              onPressed: onNextPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    context.width * 0.03,
                  ),
                ),
              ),
              child: Text(
                buttonText,
                style: AppStyles.bold16Black,
              ),
            ),
          ),

          if (onBackPressed != null) ...[
            SizedBox(
              height: context.height * 0.0125,
            ),

            SizedBox(
              width: double.infinity,
              height: context.height * 0.06,
              child: OutlinedButton(
                onPressed: onBackPressed,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppColors.primaryColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      context.width * 0.03,
                    ),
                  ),
                ),
                child: Text(
                  'back'.tr(),
                  style: AppStyles.bold16Primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}