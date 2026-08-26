import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_details_model.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class CastCardWidget extends StatelessWidget {
  final CastMember actor;

  const CastCardWidget({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: (16 / 430) * context.width,
        right: (16 / 430) * context.width,
        bottom: (10 / 932) * context.height,
      ),
      padding: EdgeInsets.all((10 / 430) * context.width),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: actor.urlSmallImage != null
                ? Image.network(
              actor.urlSmallImage!,
              width: (55 / 430) * context.width,
              height: (55 / 932) * context.height,
              fit: BoxFit.cover,
            )
                : Container(
              width: (55 / 430) * context.width,
              height: (55 / 932) * context.height,
              color: Colors.grey,
              child: const Icon(Icons.person),
            ),
          ),
          SizedBox(width: (12 / 430) * context.width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name : ${actor.name}',
                  style: AppStyles.bold20White,
                ),
                SizedBox(height: (4 / 932) * context.height),
                Text(
                  'Character : ${actor.characterName}',
                  style: AppStyles.regular14White.copyWith(
                    color: AppColors.lightGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}