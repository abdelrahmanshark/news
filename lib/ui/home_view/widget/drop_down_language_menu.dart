import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/ui/home_view/widget/drawer_drop_down_menu.dart';
import 'package:news/ui/view_model/language_view_model.dart';

class DropDownLanguageMenu extends StatelessWidget {
  const DropDownLanguageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return DrawerDropDownMenu<Locale>(
      selectedValue: context.watch<LanguageViewModel>().state,
      labels: {
        const Locale('en'): strings.english,
        const Locale('ar'): strings.arabic,
      },
      onSelected: (locale) =>
          context.read<LanguageViewModel>().changeLanguage(locale),
    );
  }
}
