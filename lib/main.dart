import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/apis/api_manger.dart';
import 'package:news/di/di.dart';
import 'package:news/providers/app_theme_provider.dart';
import 'package:news/services/data_base_service.dart';
import 'package:news/ui/home/home_screen.dart';
import 'package:news/ui/news_screen/cubit/my_bloc_observer.dart';
import 'package:news/ui/news_screen/cubit/news_screen_view_model.dart';
import 'package:news/ui/news_screen/news_screen.dart';
import 'package:news/utils/app_const.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/app_themes.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DataBaseService().init();
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
      debugShowCheckedModeBanner: false,
      themeMode:appConst.themeProvider.appTheme ,
      darkTheme:AppThemes.darkTheme ,
      theme: AppThemes.lightTheme,
      initialRoute: AppRoutes.homeScreenRouteName,
      routes: {
        AppRoutes.homeScreenRouteName: (context) => const HomeScreen(),
        AppRoutes.newsScreenRouteName:(context)=>  BlocProvider(
            create: (context) => NewsScreenViewModel(sourceRepository: injectSourceRepository(), newsRepository:injectNewsRepository() ,apiManger: ApiManger.getInstance()),
            child: NewsScreen())

      },
    );
  }
}
