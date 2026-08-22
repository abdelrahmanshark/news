import 'package:flutter/material.dart';
import 'package:news/providers/app_theme_provider.dart';
import 'package:news/ui/home/home_screen.dart';
import 'package:news/utils/app_const.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/app_themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppThemeProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppConst appConst = AppConst(context);
    return MaterialApp(
      themeMode:appConst.themeProvider.appTheme ,
      darkTheme:AppThemes.darkTheme ,
      theme: AppThemes.lightTheme,
      initialRoute: AppRoutes.homeScreenRouteName,
      routes: {
        AppRoutes.homeScreenRouteName: (context) => const HomeScreen(),
      },
    );
  }
}
