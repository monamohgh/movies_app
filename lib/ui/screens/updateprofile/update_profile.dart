import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/updateprofile/picker_avatar_screen.dart';
import 'package:movies_app/ui/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/widgets/text_form_field_widget.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String currentAvatar;

  const UpdateProfileScreen({
    super.key,
    this.currentName = 'John Safwat',
    this.currentPhone = '01200000000',
    this.currentAvatar = AppAssets.avatar1,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late String selectedAvatar;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.currentAvatar;
    nameController = TextEditingController(text: widget.currentName);
    phoneController = TextEditingController(text: widget.currentPhone);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => PickAvatarScreen(selectedAvatar: selectedAvatar),
      ),
    );

    if (result != null) {
      setState(() {
        selectedAvatar = result;
      });
    }
  }

  void _updateData() {
    Navigator.pop(context, {
      'name': nameController.text,
      'phone': phoneController.text,
      'avatar': selectedAvatar,
    });
  }

  void _deleteAccount() {
    // TODO: Delete account
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
            size: context.width * 0.06,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.pick_avatar,
          style: AppStyles.regular15Primary,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickAvatar,
                  child: Container(
                    width: context.width * 0.25,
                    height: context.width * 0.25,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.asset(selectedAvatar, fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(height: context.height * 0.03),

                TextFormFieldWidget(
                  controller: nameController,
                  textStyle: AppStyles.regular16White,
                  borderColor: AppColors.transparentColor,
                  filled: true,
                  fillColor: AppColors.darkGreyColor,
                  radius: context.width * 0.03,
                  prefixIcon: Icon(Icons.person, color: AppColors.whiteColor),
                ),

                SizedBox(height: context.height * 0.02),

                TextFormFieldWidget(
                  controller: phoneController,
                  textStyle: AppStyles.regular16White,
                  borderColor: AppColors.transparentColor,
                  filled: true,
                  fillColor: AppColors.darkGreyColor,
                  radius: context.width * 0.03,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(Icons.phone, color: AppColors.whiteColor),
                ),

                SizedBox(height: context.height * 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Navigate to reset password
                    },
                    child: Text(
                      AppLocalizations.of(context)!.reset_password,
                      style: AppStyles.regular16White,
                    ),
                  ),
                ),

                SizedBox(height: context.height * 0.2),

                ElevatedButtonWidget(
                  onPressed: _deleteAccount,
                  backgroundColor: AppColors.redColor,
                  verticalPadding: context.height * 0.018,
                  radius: context.width * 0.03,
                  child: Text(
                    AppLocalizations.of(context)!.delete_account,
                    style: AppStyles.regular16White,
                  ),
                ),

                SizedBox(height: context.height * 0.015),

                ElevatedButtonWidget(
                  onPressed: _updateData,
                  backgroundColor: AppColors.primaryColor,
                  verticalPadding: context.height * 0.018,
                  radius: context.width * 0.03,
                  child: Text(
                    AppLocalizations.of(context)!.update_data,
                    style: AppStyles.bold16Black,
                  ),
                ),

                SizedBox(height: context.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}