import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

class AppTheme {
  // Dark status bar icons on the light theme, light icons on the dark theme.
  static const SystemUiOverlayStyle lightOverlayStyle =
      SystemUiOverlayStyle.dark;
  static const SystemUiOverlayStyle darkOverlayStyle =
      SystemUiOverlayStyle.light;

  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.whiteColor,
    canvasColor: AppColors.blackColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    pageTransitionsTheme: _pageTransitionsTheme(AppColors.whiteColor),
    textTheme: const TextTheme(
      headlineLarge: AppStyles.blackRegular20,
      headlineMedium: AppStyles.blackBold16,
      bodyLarge: AppStyles.blackRegular16,
      bodyMedium: AppStyles.blackBold16,
      bodySmall: AppStyles.grayRegular12,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      titleTextStyle: AppStyles.blackRegular20,
      iconTheme: IconThemeData(color: AppColors.blackColor),
      systemOverlayStyle: lightOverlayStyle,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.blackColor,
      selectionColor: AppColors.blackColor,
      selectionHandleColor: AppColors.blackColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.blackColor,
    canvasColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    pageTransitionsTheme: _pageTransitionsTheme(AppColors.blackColor),
    textTheme: const TextTheme(
      headlineLarge: AppStyles.whiteRegular20,
      headlineMedium: AppStyles.whiteBold16,
      bodyLarge: AppStyles.whiteRegular16,
      bodyMedium: AppStyles.whiteBold16,
      bodySmall: AppStyles.grayRegular12,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blackColor,
      centerTitle: true,
      titleTextStyle: AppStyles.whiteRegular20,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      systemOverlayStyle: darkOverlayStyle,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.whiteColor,
      selectionColor: AppColors.whiteColor,
      selectionHandleColor: AppColors.whiteColor,
    ),
  );

  /// Builds the page transitions; [backgroundColor] stops routes flashing another color.
  static PageTransitionsTheme _pageTransitionsTheme(Color backgroundColor) {
    return PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(
          backgroundColor: backgroundColor,
        ),
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
      },
    );
  }
}
