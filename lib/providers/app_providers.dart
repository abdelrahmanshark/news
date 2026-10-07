import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/ui/view_model/country_view_model.dart';
import 'package:news/ui/view_model/language_view_model.dart';
import 'package:news/ui/view_model/theme_view_model.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.initialThemeMode,
    required this.initialLocale,
    required this.initialCountryCode,
    required this.child,
  });

  final ThemeMode initialThemeMode;
  final Locale initialLocale;

  /// Saved news country code; null means all countries.
  final String? initialCountryCode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeViewModel(initialThemeMode)),
        BlocProvider(create: (_) => LanguageViewModel(initialLocale)),
        BlocProvider(create: (_) => CountryViewModel(initialCountryCode)),
      ],
      child: child,
    );
  }
}
