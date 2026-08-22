
import 'package:flutter/material.dart';
import 'package:news/utils/app_assets.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLightColor,
      canvasColor: AppColors.primaryDarkColor,
      scaffoldBackgroundColor: AppColors.primaryLightColor,
    extensions: [
      AppImages(
          general: AppAssets.generalDark,
          business: AppAssets.businessDark,
          entertainment: AppAssets.entertainmentDark,
          health: AppAssets.healthDark,
          science: AppAssets.scienceDark,
          sports: AppAssets.sportsDark,
          technology: AppAssets.technologyDark
      ),
    ],
    textTheme: TextTheme(
      headlineLarge: AppStyles.lightMid20,
      headlineMedium: AppStyles.lightBold16,
      bodyMedium: AppStyles.lightBold16,
        bodySmall: AppStyles.bothGrayMed12,
    ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryLightColor,
        iconTheme: IconThemeData(color: AppColors.primaryDarkColor),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primaryDarkColor,
        selectionColor: AppColors.primaryDarkColor,
        selectionHandleColor: AppColors.primaryDarkColor,

      ));
  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDarkColor,
      canvasColor: AppColors.primaryLightColor,
    scaffoldBackgroundColor: AppColors.primaryDarkColor,
    extensions: [
      AppImages(
          general: AppAssets.generalLight,
          business: AppAssets.businessLight,
          entertainment: AppAssets.entertainmentLight,
          health: AppAssets.healthLight,
          science: AppAssets.scienceLight,
          sports: AppAssets.sportsLight,
          technology: AppAssets.technologyLight
      ),
    ],
      textTheme: TextTheme(
        headlineLarge: AppStyles.darkMid20,
        headlineMedium: AppStyles.darkBold16,
        bodyMedium: AppStyles.darkBold16,
        bodySmall: AppStyles.bothGrayMed12,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryDarkColor,
        iconTheme: IconThemeData(color: AppColors.primaryLightColor),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primaryLightColor,
        selectionColor: AppColors.primaryLightColor,
        selectionHandleColor: AppColors.primaryLightColor,

      )
  );
}

class AppImages extends ThemeExtension<AppImages> {

 final String general;
 final String business;
 final String entertainment;
 final String health;
 final String science;
 final String sports;
 final String technology;

  AppImages({
    required this.general,
    required this.business,
    required this.entertainment,
    required this.health,
    required this.science,
    required this.sports,
    required this.technology,
  });

  @override
  AppImages copyWith({
    String? general,
    String? business,
    String? entertainment,
    String? health,
    String? science,
    String? sports,
    String? technology,
  }) {
    return AppImages(
      general: general ?? this.general,
      business: business ?? this.business,
      entertainment: entertainment ?? this.entertainment,
      health: health ?? this.health,
      science: science ?? this.science,
      sports: sports ?? this.sports,
      technology: technology ?? this.technology,
    );
  }

  @override
  AppImages lerp(covariant ThemeExtension<AppImages>? other, double t) {
    // TODO: implement lerp
    return this;
  }
}
