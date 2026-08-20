import 'package:flutter/cupertino.dart';

class AppLanguageProvider extends ChangeNotifier{
//todo:data
  String appLanguage='ar';
  void changeLanguage(String newLanguage){
    //todo:newLanguage=user select it
    if(appLanguage==newLanguage){
      return;
    }
    appLanguage=newLanguage;
    notifyListeners();
  }
}