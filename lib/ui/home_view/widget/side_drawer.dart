import 'package:flutter/material.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/ui/home_view/widget/country_selector_field.dart';
import 'package:news/ui/home_view/widget/drawer_item.dart';
import 'package:news/ui/home_view/widget/drop_down_language_menu.dart';
import 'package:news/ui/home_view/widget/drop_down_theme_menu.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ColoredBox(
              color: AppColors.whiteColor,
              child: Center(
                child: Text(strings.appName, style: AppStyles.blackBold24),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ColoredBox(
              color: AppColors.blackColor,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    DrawerItem(
                      icon: Icons.home_outlined,
                      title: strings.goToHome,
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: AppColors.whiteColor, height: 1),
                    const SizedBox(height: 15),
                    DrawerItem(icon: Icons.light, title: strings.theme),
                    const SizedBox(height: 20),
                    const DropDownThemeMenu(),
                    const SizedBox(height: 110),
                    DrawerItem(icon: Icons.language, title: strings.language),
                    const SizedBox(height: 20),
                    const DropDownLanguageMenu(),
                    const SizedBox(height: 110),
                    DrawerItem(icon: Icons.public, title: strings.country),
                    const SizedBox(height: 20),
                    const CountrySelectorField(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
