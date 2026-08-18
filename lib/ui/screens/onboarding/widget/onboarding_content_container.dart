import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration:  BoxDecoration(
        color:  AppColors.blackColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:  AppColors.whiteColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style:  TextStyle(
              color:  AppColors.lightGreyColor,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onNextPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor:  AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                buttonText,
                style:  TextStyle(
                  color:  AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          if (onBackPressed != null) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: onBackPressed,
                style: OutlinedButton.styleFrom(
                  side:  BorderSide(
                      color:  AppColors.primaryColor
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:  Text(
                  'Back',
                  style: TextStyle(
                    color:AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}