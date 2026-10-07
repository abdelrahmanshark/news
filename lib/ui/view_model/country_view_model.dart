import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/utils/shared_preferences.dart';

/// Holds the NewsData.io country code used to filter news; null means all countries.
class CountryViewModel extends Cubit<String?> {
  CountryViewModel(super.initialCountryCode);

  /// Switches the news country (null for all countries) and saves the choice.
  Future<void> changeCountry(String? countryCode) async {
    if (state == countryCode) return;
    emit(countryCode);
    await saveCountryCode(countryCode);
  }
}
