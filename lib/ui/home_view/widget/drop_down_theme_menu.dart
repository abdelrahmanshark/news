import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/ui/home_view/widget/drawer_drop_down_menu.dart';
import 'package:news/ui/view_model/theme_view_model.dart';

class DropDownThemeMenu extends StatelessWidget {
  const DropDownThemeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return DrawerDropDownMenu<ThemeMode>(
      selectedValue: context.watch<ThemeViewModel>().state,
      labels: {ThemeMode.light: strings.light, ThemeMode.dark: strings.dark},
      onSelected: (themeMode) =>
          context.read<ThemeViewModel>().changeTheme(themeMode),
    );
  }
}
