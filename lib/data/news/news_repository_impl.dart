import 'package:injectable/injectable.dart';
import 'package:news/data/news/news_local_data_source.dart';
import 'package:news/data/news/news_remote_data_source.dart';
import 'package:news/domain/repositories/news_repository.dart';
import 'package:news/models/article.dart';
import 'package:news/models/news_response.dart';
import 'package:news/services/connectivity_service.dart';
import 'package:news/utils/app_exceptions.dart';
import 'package:news/utils/arabic_normalizer.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._connectivityService,
  );

  final NewsRemoteDataSource _remoteDataSource;
  final NewsLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;

  /// Maximum number of articles kept in each cache entry.
  static const int _maxCachedArticles = 10;

  /// Fetches the news when online (caching the unfiltered first page), otherwise reads the cache.
  @override
  Future<NewsResponse> getLatestNews({
    required String categoryId,
    required String languageCode,
    String? countryCode,
    String? query,
    String? page,
  }) async {
    // Each category/language/country combination is cached separately.
    final String cacheKey =
        '$categoryId-$languageCode-${countryCode ?? 'all'}';
    final bool isSearch = query != null && query.isNotEmpty;
    if (await _connectivityService.isOnline()) {
      final NewsResponse newsResponse = await _remoteDataSource.getLatestNews(
        categoryId: categoryId,
        languageCode: languageCode,
        countryCode: countryCode,
        query: query,
        page: page,
      );
      if (page == null && !isSearch) {
        await _cacheLatestArticles(cacheKey, newsResponse);
      }
      return newsResponse;
    }
    // Next pages only exist online.
    if (page != null) throw const OfflineException();
    final NewsResponse? cachedNews = _localDataSource.getNews(cacheKey);
    if (cachedNews == null) throw const NoCachedDataException();
    final List<Article> articles = isSearch
        ? _searchArticles(cachedNews.articles, query)
        : cachedNews.articles;
    // No nextPage, so the list doesn't try to load more while offline.
    return NewsResponse(status: cachedNews.status, articles: articles);
  }

  /// Merges [newsResponse] into the cache entry [cacheKey], keeping only the newest unique articles.
  Future<void> _cacheLatestArticles(
    String cacheKey,
    NewsResponse newsResponse,
  ) async {
    NewsResponse? cachedNews;
    try {
      cachedNews = _localDataSource.getNews(cacheKey);
    } catch (_) {
      // An unreadable entry is replaced instead of failing the online request.
      cachedNews = null;
    }
    final List<Article> latestArticles = _latestUniqueArticles([
      ...newsResponse.articles,
      ...?cachedNews?.articles,
    ]);
    await _localDataSource.saveNews(
      cacheKey,
      NewsResponse(
        status: newsResponse.status,
        totalResults: newsResponse.totalResults,
        articles: latestArticles,
        nextPage: newsResponse.nextPage,
      ),
    );
  }

  /// Removes duplicate [articles], sorts them newest first, and keeps the first [_maxCachedArticles].
  List<Article> _latestUniqueArticles(List<Article> articles) {
    final Set<String> seenKeys = {};
    // Earlier articles win, so fresh copies replace older cached ones.
    final List<Article> uniqueArticles = articles.where((article) {
      final String? key = article.articleId ?? article.link ?? article.title;
      return key == null || seenKeys.add(key);
    }).toList();
    uniqueArticles.sort(_compareNewestFirst);
    return uniqueArticles.take(_maxCachedArticles).toList();
  }

  /// Orders articles by publish date, newest first, with undated articles last.
  static int _compareNewestFirst(Article first, Article second) {
    final DateTime? firstDate = first.publishedAt;
    final DateTime? secondDate = second.publishedAt;
    if (firstDate == null && secondDate == null) return 0;
    if (firstDate == null) return 1;
    if (secondDate == null) return -1;
    return secondDate.compareTo(firstDate);
  }

  /// Keeps the cached [articles] whose title or description contains [query],
  /// ignoring case and Arabic diacritics.
  List<Article> _searchArticles(List<Article> articles, String query) {
    final String normalizedQuery = normalizeArabic(query.toLowerCase());
    return articles.where((article) {
      final String text = '${article.title ?? ''} ${article.description ?? ''}';
      return normalizeArabic(text.toLowerCase()).contains(normalizedQuery);
    }).toList();
  }
}
