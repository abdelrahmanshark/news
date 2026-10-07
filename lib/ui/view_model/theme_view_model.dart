import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/utils/shared_preferences.dart';

class ThemeViewModel extends Cubit<ThemeMode> {
  ThemeViewModel(super.initialThemeMode);

  /// Switches the app theme and saves the choice.
  Future<void> changeTheme(ThemeMode themeMode) async {
    if (state == themeMode) return;
    emit(themeMode);
    await saveThemeMode(themeMode);
  }
}
