class ApiConst {
  /// NewsData.io key; override at build time with `--dart-define=NEWSDATA_API_KEY=<key>`.
  static const String apiKey = String.fromEnvironment(
    'NEWSDATA_API_KEY',
    defaultValue: 'pub_0290b54033f54c7c9c4f38e6032b8edd',
  );
  static const String apiKeyHeader = 'X-ACCESS-KEY';
  static const String baseUrl = 'newsdata.io';
  static const String latestNewsApi = '/api/1/latest';
  static const String successStatus = 'success';

  /// Longest `q` value the free NewsData.io plan accepts.
  static const int maxQueryLength = 100;

  /// NewsData.io country codes offered in the country picker.
  static const List<String> supportedCountryCodes = [
    'ae', 'ar', 'at', 'au', 'be', 'bg', 'br', 'ca', 'ch', 'cn', 'co', 'cu', //
    'cz', 'de', 'eg', 'fr', 'gb', 'gr', 'hk', 'hu', 'id', 'ie', 'il', 'in', //
    'it', 'jp', 'kr', 'lt', 'lv', 'ma', 'mx', 'my', 'ng', 'nl', 'no', 'nz', //
    'ph', 'pl', 'pt', 'ro', 'rs', 'ru', 'sa', 'se', 'sg', 'si', 'sk', 'th', //
    'tr', 'tw', 'ua', 'us', 've', 'za', //
  ];
}
