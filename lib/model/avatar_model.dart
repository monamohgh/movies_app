import 'package:movies_app/utils/app_assets.dart';

class AvatarModel {
  final String imagePath;

  AvatarModel({
    required this.imagePath,
  });

  static List<AvatarModel> avatars = [
    AvatarModel(imagePath: AppAssets.avatar1),
    AvatarModel(imagePath: AppAssets.avatar2),
    AvatarModel(imagePath: AppAssets.avatar3),
    AvatarModel(imagePath: AppAssets.avatar4),
    AvatarModel(imagePath: AppAssets.avatar5),
    AvatarModel(imagePath: AppAssets.avatar6),
    AvatarModel(imagePath: AppAssets.avatar7),
    AvatarModel(imagePath: AppAssets.avatar8),
    AvatarModel(imagePath: AppAssets.avatar9),
  ];
}