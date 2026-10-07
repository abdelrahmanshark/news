import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/utils/shared_preferences.dart';

class LanguageViewModel extends Cubit<Locale> {
  LanguageViewModel(super.initialLocale);

  /// Loads the strings of [locale], switches the app language and saves the choice.
  Future<void> changeLanguage(Locale locale) async {
    if (state == locale) return;
    await S.load(locale);
    emit(locale);
    await saveLocale(locale);
  }
}
