import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news/di/injection.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/models/news_category.dart';
import 'package:news/providers/app_providers.dart';
import 'package:news/services/data_base_service.dart';
import 'package:news/ui/home_view/home_view.dart';
import 'package:news/ui/home_view/news_view/news_view.dart';
import 'package:news/ui/splash_view/splash_view.dart';
import 'package:news/ui/view_model/language_view_model.dart';
import 'package:news/ui/view_model/theme_view_model.dart';
import 'package:news/utils/app_bloc_observer.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/app_theme.dart';
import 'package:news/utils/shared_preferences.dart';

/// Boots dependencies, local storage, the saved theme, language and country, then starts the app.
Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  // Keeps the native splash on screen until SplashView removes it.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  configureDependencies();
  if (kDebugMode) Bloc.observer = AppBlocObserver();
  await getIt<DataBaseService>().init();
  final ThemeMode initialThemeMode = await getThemeMode();
  final Locale initialLocale = await getLocale();
  final String? initialCountryCode = await getCountryCode();
  runApp(
    AppProviders(
      initialThemeMode: initialThemeMode,
      initialLocale: initialLocale,
      initialCountryCode: initialCountryCode,
      child: const NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageViewModel, Locale>(
      builder: (context, locale) {
        return BlocBuilder<ThemeViewModel, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              initialRoute: AppRoutes.splashRouteName,
              routes: {
                AppRoutes.splashRouteName: (_) => const SplashView(),
                AppRoutes.homeRouteName: (_) => const HomeView(),
                AppRoutes.newsRouteName: (context) => NewsView(
                  category:
                      ModalRoute.of(context)!.settings.arguments
                          as NewsCategory,
                ),
              },
            );
          },
        );
      },
    );
  }
}
