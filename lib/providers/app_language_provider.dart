import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  //todo:data
  String appLanguage = 'en';
  void changeLanguage(String newLanguage) {
    //todo:newLanguage=user select it
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}
