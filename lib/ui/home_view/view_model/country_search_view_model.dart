import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/utils/api_const.dart';
import 'package:news/utils/arabic_normalizer.dart';

/// Holds the NewsData.io country codes whose names match the country picker search.
class CountrySearchViewModel extends Cubit<List<String>> {
  CountrySearchViewModel() : super(_sortedCountryCodes());

  /// Returns every supported country code, ordered by its name in the current app language.
  static List<String> _sortedCountryCodes() {
    final List<String> countryCodes = List.of(ApiConst.supportedCountryCodes);
    countryCodes.sort(
      (first, second) =>
          S.current.countryName(first).compareTo(S.current.countryName(second)),
    );
    return countryCodes;
  }

  /// Keeps only the countries whose name contains [query], ignoring case and Arabic diacritics.
  void search(String query) {
    final String normalizedQuery = normalizeArabic(query.trim().toLowerCase());
    emit(
      _sortedCountryCodes()
          .where(
            (countryCode) => normalizeArabic(
              S.current.countryName(countryCode).toLowerCase(),
            ).contains(normalizedQuery),
          )
          .toList(),
    );
  }
}
