import 'package:flutter/material.dart';
import 'package:news/utils/api_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  static const String themeKey = 'Theme';
  static const String languageKey = 'Language';
  static const String countryKey = 'Country';
  static const String favoriteCategoriesKey = 'FavoriteCategories';
}

const String _lightThemeValue = 'light';
const String _darkThemeValue = 'dark';
const String _defaultLanguageCode = 'en';

/// Reads the saved theme mode, defaulting to light.
Future<ThemeMode> getThemeMode() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final String? theme = preferences.getString(SharedPreferencesKeys.themeKey);
  return theme == _darkThemeValue ? ThemeMode.dark : ThemeMode.light;
}

/// Saves the chosen theme mode.
Future<void> saveThemeMode(ThemeMode themeMode) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString(
    SharedPreferencesKeys.themeKey,
    themeMode == ThemeMode.dark ? _darkThemeValue : _lightThemeValue,
  );
}

/// Reads the saved app locale, defaulting to English.
Future<Locale> getLocale() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final String? languageCode = preferences.getString(
    SharedPreferencesKeys.languageKey,
  );
  return Locale(languageCode ?? _defaultLanguageCode);
}

/// Saves the chosen app locale.
Future<void> saveLocale(Locale locale) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString(
    SharedPreferencesKeys.languageKey,
    locale.languageCode,
  );
}

/// Reads the saved news country code; null means all countries.
Future<String?> getCountryCode() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final String? countryCode = preferences.getString(
    SharedPreferencesKeys.countryKey,
  );
  // Falls back to all countries if the saved code is no longer in the picker list.
  return ApiConst.supportedCountryCodes.contains(countryCode)
      ? countryCode
      : null;
}

/// Saves the chosen news country code, or clears it when [countryCode] is null (all countries).
Future<void> saveCountryCode(String? countryCode) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  if (countryCode == null) {
    await preferences.remove(SharedPreferencesKeys.countryKey);
    return;
  }
  await preferences.setString(SharedPreferencesKeys.countryKey, countryCode);
}

/// Reads the ids of the favorite categories, newest first.
Future<List<String>> getFavoriteCategoryIds() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getStringList(
        SharedPreferencesKeys.favoriteCategoriesKey,
      ) ??
      [];
}

/// Saves the ids of the favorite categories, newest first.
Future<void> saveFavoriteCategoryIds(List<String> categoryIds) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setStringList(
    SharedPreferencesKeys.favoriteCategoriesKey,
    categoryIds,
  );
}
