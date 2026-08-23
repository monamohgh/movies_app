import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

import 'app_colors.dart';
class DialogUtils {
  static void showLoading({ required BuildContext context,required String loadingText}){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:(context) {
        return AlertDialog(
          content:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: context.width*.04,
            children: [
              CircularProgressIndicator(
                color: AppColors.blackColor,
              ),
              Text(loadingText,style: AppStyles.bold20Primary  ,)
            ],),
        );
      }, );
  }
  static void hideLoading({required BuildContext context}){
    Navigator.pop(context);
  }
  static void showMessage({required BuildContext context,
    required  String message,String? title='',
    String? positiveActionName,VoidCallback? positiveAction,
    String? negativeActionName,VoidCallback? negativeAction
  }){
    List<Widget>actions=[];
    if(positiveActionName!=null){
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            positiveAction?.call();
            ///call=>execute the function
          },
          child: Text(positiveActionName,style: AppStyles.bold20Primary,)));
    }
    if(negativeActionName!=null){
      actions.add(TextButton(
          onPressed:() {
            Navigator.pop(context);
            negativeAction?.call();
          },
          child: Text(negativeActionName,style: AppStyles.bold20Primary,)));
    }
    showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message,style:AppStyles.bold20Primary,),
          title: Text(title!,style: AppStyles.bold20Primary)  ,
          actions:actions,
        );
      },
    );

  }
}