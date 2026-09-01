import 'package:flutter/material.dart';
import 'package:news/utils/app_const.dart';
import 'package:news/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../providers/app_theme_provider.dart';
import '../utils/app_colors.dart';

class DropDownThemeMenu extends StatelessWidget {
  const DropDownThemeMenu({super.key});

  @override
  Widget build(BuildContext context) {
   var appConst = AppConst(context);
   var themeProvider = Provider.of<AppThemeProvider>(context);
    return DropdownMenu(
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: ThemeMode.light,
          label: 'Light',
          labelWidget: Text(
            'Light',
            style:  AppStyles.whiteBold20
          ),
        ),
        DropdownMenuEntry(
          value: ThemeMode.dark,
          label: 'Dark',
          labelWidget: Text(
            'Dark',
              style: AppStyles.whiteBold20
          ),
        ),
      ],
      textStyle: AppStyles.whiteBold20,
      width: double.infinity,
      inputDecorationTheme: InputDecorationThemeData(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primaryLightColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primaryLightColor),
        ),
      ),
      menuStyle: MenuStyle(
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        fixedSize: WidgetStatePropertyAll(Size(appConst.width*0.65, appConst.height * .15)),
      ),
      initialSelection: isLight(context) ? ThemeMode.light : ThemeMode.dark,
      onSelected: (newTheme) {
       themeProvider.changeAppTheme(newTheme!);
      },
      trailingIcon: Icon(
        Icons.arrow_drop_down,
        color: AppColors.primaryLightColor,
        size: 40,
      ),
      selectedTrailingIcon: Icon(
        Icons.arrow_drop_up,
        color: AppColors.primaryLightColor,
        size: 40,
      ),
    );
  }

  bool isLight(BuildContext context) {
    return Provider.of<AppThemeProvider>(context,listen: false).appTheme == ThemeMode.light;
  }
}
