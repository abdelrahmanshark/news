import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/ui/home_view/view_model/country_search_view_model.dart';
import 'package:news/ui/home_view/widget/country_option_tile.dart';
import 'package:news/ui/view_model/country_view_model.dart';
import 'package:news/ui/widget/custom_text_form_field.dart';
import 'package:news/ui/widget/empty_view.dart';
import 'package:news/ui/widget/fade_in.dart';

/// Bottom sheet listing "All Countries" and every supported country, with a name search.
class CountryPickerSheet extends StatelessWidget {
  const CountryPickerSheet({super.key});

  /// Saves [countryCode] (null for all countries) and closes the sheet.
  void _selectCountry(BuildContext context, String? countryCode) {
    context.read<CountryViewModel>().changeCountry(countryCode);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final S strings = S.of(context);
    final String? selectedCountryCode = context.watch<CountryViewModel>().state;
    // Lifts the sheet above the keyboard while keeping it at most 70% of the screen.
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.7,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                hintText: strings.searchCountry,
                prefixIcon: Icons.search,
                onChanged: context.read<CountrySearchViewModel>().search,
              ),
              const SizedBox(height: 8),
              CountryOptionTile(
                label: strings.allCountries,
                isSelected: selectedCountryCode == null,
                onTap: () => _selectCountry(context, null),
              ),
              Divider(color: theme.canvasColor, height: 1),
              Expanded(
                child: BlocBuilder<CountrySearchViewModel, List<String>>(
                  builder: (context, countryCodes) {
                    if (countryCodes.isEmpty) {
                      return FadeIn(
                        key: const ValueKey('countries-empty'),
                        child: EmptyView(message: strings.noCountriesFound),
                      );
                    }
                    return FadeIn(
                      key: const ValueKey('countries-content'),
                      child: ListView.builder(
                        itemCount: countryCodes.length,
                        itemBuilder: (context, index) {
                          final String countryCode = countryCodes[index];
                          return CountryOptionTile(
                            label: strings.countryName(countryCode),
                            isSelected: countryCode == selectedCountryCode,
                            onTap: () => _selectCountry(context, countryCode),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
