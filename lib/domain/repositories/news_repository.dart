import 'package:news/models/news_response.dart';

abstract class NewsRepository {
  /// Returns one page of the latest news of [categoryId] in [languageCode], limited to
  /// [countryCode] and matching [query] when given, from the API when online or the
  /// cache when offline. [page] is the `nextPage` token of the previous page.
  Future<NewsResponse> getLatestNews({
    required String categoryId,
    required String languageCode,
    String? countryCode,
    String? query,
    String? page,
  });
}
