import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/updateprofile/widget/avatar_picker.dart';
import 'package:movies_app/ui/widgets/elevated_button_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';



class PickAvatarScreen extends StatefulWidget {
  final String selectedAvatar;

  const PickAvatarScreen({
    super.key,
    required this.selectedAvatar,
  });

  @override
  State<PickAvatarScreen> createState() => _PickAvatarScreenState();
}

class _PickAvatarScreenState extends State<PickAvatarScreen> {
  late String selectedAvatar;

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.selectedAvatar;
  }

  void _selectAvatar(String avatar) {
    setState(() {
      selectedAvatar = avatar;
    });
  }

  void _confirmAvatar() {
    Navigator.pop(context, selectedAvatar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
            'Pick Avatar',
            style: AppStyles.regular15Primary
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.05,
        ),
        child: Column(
          children: [
            SizedBox(
              height: context.height * 0.02,
            ),

            Container(
              width: context.width * 0.25,
              height: context.height * 0.12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  selectedAvatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(
              height: context.height * 0.03,
            ),

            AvatarPicker(
              selectedAvatar: selectedAvatar,
              onAvatarSelected: _selectAvatar,
            ),

            const Spacer(),

            ElevatedButtonWidget(
              onPressed: _confirmAvatar,
              backgroundColor: AppColors.primaryColor,
              verticalPadding: context.height * 0.018,
              radius: context.width * 0.03,
              child: Text(
                  'Choose Avatar',
                  style: AppStyles.bold16Black
              ),
            ),

            SizedBox(
              height: context.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}