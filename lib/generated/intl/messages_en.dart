// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(author) => "By ${author}";

  static String m1(code) =>
      "${Intl.select(code, {'ae': 'United Arab Emirates', 'ar': 'Argentina', 'at': 'Austria', 'au': 'Australia', 'be': 'Belgium', 'bg': 'Bulgaria', 'br': 'Brazil', 'ca': 'Canada', 'ch': 'Switzerland', 'cn': 'China', 'co': 'Colombia', 'cu': 'Cuba', 'cz': 'Czechia', 'de': 'Germany', 'eg': 'Egypt', 'fr': 'France', 'gb': 'United Kingdom', 'gr': 'Greece', 'hk': 'Hong Kong', 'hu': 'Hungary', 'id': 'Indonesia', 'ie': 'Ireland', 'il': 'Israel', 'in': 'India', 'it': 'Italy', 'jp': 'Japan', 'kr': 'South Korea', 'lt': 'Lithuania', 'lv': 'Latvia', 'ma': 'Morocco', 'mx': 'Mexico', 'my': 'Malaysia', 'ng': 'Nigeria', 'nl': 'Netherlands', 'no': 'Norway', 'nz': 'New Zealand', 'ph': 'Philippines', 'pl': 'Poland', 'pt': 'Portugal', 'ro': 'Romania', 'rs': 'Serbia', 'ru': 'Russia', 'sa': 'Saudi Arabia', 'se': 'Sweden', 'sg': 'Singapore', 'si': 'Slovenia', 'sk': 'Slovakia', 'th': 'Thailand', 'tr': 'Türkiye', 'tw': 'Taiwan', 'ua': 'Ukraine', 'us': 'United States', 've': 'Venezuela', 'za': 'South Africa', 'other': 'Other'})}";

  static String m2(count) =>
      "${Intl.plural(count, one: '1 day ago', other: '${count} days ago')}";

  static String m3(count) =>
      "${Intl.plural(count, one: '1 hour ago', other: '${count} hours ago')}";

  static String m4(count) =>
      "${Intl.plural(count, one: '1 minute ago', other: '${count} minutes ago')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addToFavorites": MessageLookupByLibrary.simpleMessage("Add to favorites"),
    "allCountries": MessageLookupByLibrary.simpleMessage("All Countries"),
    "appName": MessageLookupByLibrary.simpleMessage("News App"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "byAuthor": m0,
    "categoryBreaking": MessageLookupByLibrary.simpleMessage("Breaking"),
    "categoryBusiness": MessageLookupByLibrary.simpleMessage("Business"),
    "categoryCrime": MessageLookupByLibrary.simpleMessage("Crime"),
    "categoryDomestic": MessageLookupByLibrary.simpleMessage("Domestic"),
    "categoryEducation": MessageLookupByLibrary.simpleMessage("Education"),
    "categoryEntertainment": MessageLookupByLibrary.simpleMessage(
      "Entertainment",
    ),
    "categoryEnvironment": MessageLookupByLibrary.simpleMessage("Environment"),
    "categoryFood": MessageLookupByLibrary.simpleMessage("Food"),
    "categoryHealth": MessageLookupByLibrary.simpleMessage("Health"),
    "categoryLifestyle": MessageLookupByLibrary.simpleMessage("Lifestyle"),
    "categoryOther": MessageLookupByLibrary.simpleMessage("Other"),
    "categoryPolitics": MessageLookupByLibrary.simpleMessage("Politics"),
    "categoryScience": MessageLookupByLibrary.simpleMessage("Science"),
    "categorySports": MessageLookupByLibrary.simpleMessage("Sports"),
    "categoryTechnology": MessageLookupByLibrary.simpleMessage("Technology"),
    "categoryTop": MessageLookupByLibrary.simpleMessage("Top"),
    "categoryTourism": MessageLookupByLibrary.simpleMessage("Tourism"),
    "categoryWorld": MessageLookupByLibrary.simpleMessage("World"),
    "checkConnection": MessageLookupByLibrary.simpleMessage(
      "Please check your internet connection and try again.",
    ),
    "country": MessageLookupByLibrary.simpleMessage("Country"),
    "countryName": m1,
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "daysAgo": m2,
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "filterAll": MessageLookupByLibrary.simpleMessage("All"),
    "filterFavorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "goToHome": MessageLookupByLibrary.simpleMessage("Go to home"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "hoursAgo": m3,
    "justNow": MessageLookupByLibrary.simpleMessage("Just now"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "minutesAgo": m4,
    "noArticles": MessageLookupByLibrary.simpleMessage(
      "No articles published yet",
    ),
    "noCategoriesFound": MessageLookupByLibrary.simpleMessage(
      "No categories found",
    ),
    "noCountriesFound": MessageLookupByLibrary.simpleMessage(
      "No countries found",
    ),
    "noFavoriteCategories": MessageLookupByLibrary.simpleMessage(
      "No favorite categories yet",
    ),
    "offlineNoCache": MessageLookupByLibrary.simpleMessage(
      "You are offline and nothing is saved yet.",
    ),
    "openTheLink": MessageLookupByLibrary.simpleMessage("Open the link"),
    "removeFromFavorites": MessageLookupByLibrary.simpleMessage(
      "Remove from favorites",
    ),
    "searchCategories": MessageLookupByLibrary.simpleMessage(
      "Search categories",
    ),
    "searchCountry": MessageLookupByLibrary.simpleMessage("Search countries"),
    "searchNews": MessageLookupByLibrary.simpleMessage("Search news"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
  };
}
