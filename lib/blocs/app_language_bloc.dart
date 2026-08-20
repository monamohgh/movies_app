import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLanguageCubit extends Cubit<Locale> {
  AppLanguageCubit() : super(const Locale('en'));

  void changeLanguage(String languageCode) {
    if (state.languageCode == languageCode) return;
    emit(Locale(languageCode));
  }
}
