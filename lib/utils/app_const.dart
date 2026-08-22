
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_theme_provider.dart';
import 'app_themes.dart';

class AppConst {
  BuildContext context;

  AppConst(this.context);

  ThemeData get theme => Theme.of(context);

  AppImages get image => theme.extension<AppImages>()!;


  TextTheme get textStyle => theme.textTheme;

  AppThemeProvider get themeProvider => Provider.of<AppThemeProvider>(context);

  double get height => MediaQuery.of(context).size.height;

  double get width => MediaQuery.of(context).size.width;

}
