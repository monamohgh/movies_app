import 'package:flutter/material.dart';
import 'package:movies_app/model/avatar_model.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class AvatarPicker extends StatelessWidget {
  final String selectedAvatar;
  final ValueChanged<String> onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.025),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(context.width * 0.04),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: AvatarModel.avatars.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: context.width * 0.025,
          mainAxisSpacing: context.height * 0.012,
        ),
        itemBuilder: (context, index) {
          final avatar = AvatarModel.avatars[index];

          final isSelected = avatar.imagePath == selectedAvatar;

          return GestureDetector(
            onTap: () {
              onAvatarSelected(avatar.imagePath);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  context.width * 0.035,
                ),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.transparentColor,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(context.width * 0.01),
                child: Image.asset(
                  avatar.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}