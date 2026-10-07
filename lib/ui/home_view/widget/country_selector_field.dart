import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/ui/home_view/view_model/country_search_view_model.dart';
import 'package:news/ui/home_view/widget/country_picker_sheet.dart';
import 'package:news/ui/view_model/country_view_model.dart';
import 'package:news/ui/widget/pressable_scale.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

/// Drawer field showing the selected news country; tapping it opens the searchable picker.
class CountrySelectorField extends StatelessWidget {
  const CountrySelectorField({super.key});

  /// Opens the country picker sheet with a fresh search.
  void _openCountryPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider(
        create: (_) => CountrySearchViewModel(),
        child: const CountryPickerSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    final String? countryCode = context.watch<CountryViewModel>().state;
    return PressableScale(
      onTap: () => _openCountryPicker(context),
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 12, top: 8, bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                countryCode == null
                    ? strings.allCountries
                    : strings.countryName(countryCode),
                style: AppStyles.whiteBold20,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: AppColors.whiteColor,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
