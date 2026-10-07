// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `News App`
  String get appName {
    return Intl.message('News App', name: 'appName', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Go to home`
  String get goToHome {
    return Intl.message('Go to home', name: 'goToHome', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `العربية`
  String get arabic {
    return Intl.message('العربية', name: 'arabic', desc: '', args: []);
  }

  /// `Top`
  String get categoryTop {
    return Intl.message('Top', name: 'categoryTop', desc: '', args: []);
  }

  /// `Breaking`
  String get categoryBreaking {
    return Intl.message(
      'Breaking',
      name: 'categoryBreaking',
      desc: '',
      args: [],
    );
  }

  /// `World`
  String get categoryWorld {
    return Intl.message('World', name: 'categoryWorld', desc: '', args: []);
  }

  /// `Domestic`
  String get categoryDomestic {
    return Intl.message(
      'Domestic',
      name: 'categoryDomestic',
      desc: '',
      args: [],
    );
  }

  /// `Politics`
  String get categoryPolitics {
    return Intl.message(
      'Politics',
      name: 'categoryPolitics',
      desc: '',
      args: [],
    );
  }

  /// `Business`
  String get categoryBusiness {
    return Intl.message(
      'Business',
      name: 'categoryBusiness',
      desc: '',
      args: [],
    );
  }

  /// `Technology`
  String get categoryTechnology {
    return Intl.message(
      'Technology',
      name: 'categoryTechnology',
      desc: '',
      args: [],
    );
  }

  /// `Science`
  String get categoryScience {
    return Intl.message('Science', name: 'categoryScience', desc: '', args: []);
  }

  /// `Health`
  String get categoryHealth {
    return Intl.message('Health', name: 'categoryHealth', desc: '', args: []);
  }

  /// `Sports`
  String get categorySports {
    return Intl.message('Sports', name: 'categorySports', desc: '', args: []);
  }

  /// `Entertainment`
  String get categoryEntertainment {
    return Intl.message(
      'Entertainment',
      name: 'categoryEntertainment',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get categoryEducation {
    return Intl.message(
      'Education',
      name: 'categoryEducation',
      desc: '',
      args: [],
    );
  }

  /// `Environment`
  String get categoryEnvironment {
    return Intl.message(
      'Environment',
      name: 'categoryEnvironment',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get categoryFood {
    return Intl.message('Food', name: 'categoryFood', desc: '', args: []);
  }

  /// `Lifestyle`
  String get categoryLifestyle {
    return Intl.message(
      'Lifestyle',
      name: 'categoryLifestyle',
      desc: '',
      args: [],
    );
  }

  /// `Tourism`
  String get categoryTourism {
    return Intl.message('Tourism', name: 'categoryTourism', desc: '', args: []);
  }

  /// `Crime`
  String get categoryCrime {
    return Intl.message('Crime', name: 'categoryCrime', desc: '', args: []);
  }

  /// `Other`
  String get categoryOther {
    return Intl.message('Other', name: 'categoryOther', desc: '', args: []);
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Search categories`
  String get searchCategories {
    return Intl.message(
      'Search categories',
      name: 'searchCategories',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get filterAll {
    return Intl.message('All', name: 'filterAll', desc: '', args: []);
  }

  /// `Favorites`
  String get filterFavorites {
    return Intl.message(
      'Favorites',
      name: 'filterFavorites',
      desc: '',
      args: [],
    );
  }

  /// `No categories found`
  String get noCategoriesFound {
    return Intl.message(
      'No categories found',
      name: 'noCategoriesFound',
      desc: '',
      args: [],
    );
  }

  /// `No favorite categories yet`
  String get noFavoriteCategories {
    return Intl.message(
      'No favorite categories yet',
      name: 'noFavoriteCategories',
      desc: '',
      args: [],
    );
  }

  /// `Add to favorites`
  String get addToFavorites {
    return Intl.message(
      'Add to favorites',
      name: 'addToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Remove from favorites`
  String get removeFromFavorites {
    return Intl.message(
      'Remove from favorites',
      name: 'removeFromFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Search news`
  String get searchNews {
    return Intl.message('Search news', name: 'searchNews', desc: '', args: []);
  }

  /// `By {author}`
  String byAuthor(String author) {
    return Intl.message(
      'By $author',
      name: 'byAuthor',
      desc: '',
      args: [author],
    );
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `{count, plural, =1{1 minute ago} other{{count} minutes ago}}`
  String minutesAgo(int count) {
    return Intl.plural(
      count,
      one: '1 minute ago',
      other: '$count minutes ago',
      name: 'minutesAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 hour ago} other{{count} hours ago}}`
  String hoursAgo(int count) {
    return Intl.plural(
      count,
      one: '1 hour ago',
      other: '$count hours ago',
      name: 'hoursAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 day ago} other{{count} days ago}}`
  String daysAgo(int count) {
    return Intl.plural(
      count,
      one: '1 day ago',
      other: '$count days ago',
      name: 'daysAgo',
      desc: '',
      args: [count],
    );
  }

  /// `No articles published yet`
  String get noArticles {
    return Intl.message(
      'No articles published yet',
      name: 'noArticles',
      desc: '',
      args: [],
    );
  }

  /// `Open the link`
  String get openTheLink {
    return Intl.message(
      'Open the link',
      name: 'openTheLink',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `You are offline and nothing is saved yet.`
  String get offlineNoCache {
    return Intl.message(
      'You are offline and nothing is saved yet.',
      name: 'offlineNoCache',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again.`
  String get checkConnection {
    return Intl.message(
      'Please check your internet connection and try again.',
      name: 'checkConnection',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `All Countries`
  String get allCountries {
    return Intl.message(
      'All Countries',
      name: 'allCountries',
      desc: '',
      args: [],
    );
  }

  /// `Search countries`
  String get searchCountry {
    return Intl.message(
      'Search countries',
      name: 'searchCountry',
      desc: '',
      args: [],
    );
  }

  /// `No countries found`
  String get noCountriesFound {
    return Intl.message(
      'No countries found',
      name: 'noCountriesFound',
      desc: '',
      args: [],
    );
  }

  /// `{code, select, ae {United Arab Emirates} ar {Argentina} at {Austria} au {Australia} be {Belgium} bg {Bulgaria} br {Brazil} ca {Canada} ch {Switzerland} cn {China} co {Colombia} cu {Cuba} cz {Czechia} de {Germany} eg {Egypt} fr {France} gb {United Kingdom} gr {Greece} hk {Hong Kong} hu {Hungary} id {Indonesia} ie {Ireland} il {Israel} in {India} it {Italy} jp {Japan} kr {South Korea} lt {Lithuania} lv {Latvia} ma {Morocco} mx {Mexico} my {Malaysia} ng {Nigeria} nl {Netherlands} no {Norway} nz {New Zealand} ph {Philippines} pl {Poland} pt {Portugal} ro {Romania} rs {Serbia} ru {Russia} sa {Saudi Arabia} se {Sweden} sg {Singapore} si {Slovenia} sk {Slovakia} th {Thailand} tr {Türkiye} tw {Taiwan} ua {Ukraine} us {United States} ve {Venezuela} za {South Africa} other {Other}}`
  String countryName(String code) {
    return Intl.select(
      code,
      {
        'ae': 'United Arab Emirates',
        'ar': 'Argentina',
        'at': 'Austria',
        'au': 'Australia',
        'be': 'Belgium',
        'bg': 'Bulgaria',
        'br': 'Brazil',
        'ca': 'Canada',
        'ch': 'Switzerland',
        'cn': 'China',
        'co': 'Colombia',
        'cu': 'Cuba',
        'cz': 'Czechia',
        'de': 'Germany',
        'eg': 'Egypt',
        'fr': 'France',
        'gb': 'United Kingdom',
        'gr': 'Greece',
        'hk': 'Hong Kong',
        'hu': 'Hungary',
        'id': 'Indonesia',
        'ie': 'Ireland',
        'il': 'Israel',
        'in': 'India',
        'it': 'Italy',
        'jp': 'Japan',
        'kr': 'South Korea',
        'lt': 'Lithuania',
        'lv': 'Latvia',
        'ma': 'Morocco',
        'mx': 'Mexico',
        'my': 'Malaysia',
        'ng': 'Nigeria',
        'nl': 'Netherlands',
        'no': 'Norway',
        'nz': 'New Zealand',
        'ph': 'Philippines',
        'pl': 'Poland',
        'pt': 'Portugal',
        'ro': 'Romania',
        'rs': 'Serbia',
        'ru': 'Russia',
        'sa': 'Saudi Arabia',
        'se': 'Sweden',
        'sg': 'Singapore',
        'si': 'Slovenia',
        'sk': 'Slovakia',
        'th': 'Thailand',
        'tr': 'Türkiye',
        'tw': 'Taiwan',
        'ua': 'Ukraine',
        'us': 'United States',
        've': 'Venezuela',
        'za': 'South Africa',
        'other': 'Other',
      },
      name: 'countryName',
      desc: '',
      args: [code],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
