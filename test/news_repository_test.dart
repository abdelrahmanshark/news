import 'package:flutter_test/flutter_test.dart';
import 'package:news/data/news/news_local_data_source.dart';
import 'package:news/data/news/news_remote_data_source.dart';
import 'package:news/data/news/news_repository_impl.dart';
import 'package:news/models/article.dart';
import 'package:news/models/news_response.dart';
import 'package:news/services/connectivity_service.dart';
import 'package:news/utils/app_exceptions.dart';

/// Returns a fixed response and remembers the last requested page and query.
class FakeRemoteDataSource extends NewsRemoteDataSource {
  String? lastPage;
  String? lastQuery;
  List<Article> articles = const [
    Article(articleId: 'remote', title: 'Remote news'),
  ];

  @override
  Future<NewsResponse> getLatestNews({
    required String categoryId,
    required String languageCode,
    String? countryCode,
    String? query,
    String? page,
  }) async {
    lastPage = page;
    lastQuery = query;
    return NewsResponse(
      status: 'success',
      articles: articles,
      nextPage: 'next-token',
    );
  }
}

/// Keeps the cache in memory instead of Hive.
class FakeLocalDataSource extends NewsLocalDataSource {
  final Map<String, NewsResponse> cache = {};

  @override
  NewsResponse? getNews(String cacheKey) => cache[cacheKey];

  @override
  Future<void> saveNews(String cacheKey, NewsResponse newsResponse) async {
    cache[cacheKey] = newsResponse;
  }
}

/// Reports a fixed connectivity state.
class FakeConnectivityService extends ConnectivityService {
  FakeConnectivityService({required this.online});

  final bool online;

  @override
  Future<bool> isOnline() async => online;
}

void main() {
  group('NewsResponse.fromJson', () {
    test('reads NewsData.io articles and hides paid-plan placeholders', () {
      final NewsResponse response = NewsResponse.fromJson({
        'status': 'success',
        'totalResults': 2,
        'nextPage': 1791299540049567016,
        'results': [
          {
            'article_id': 'a1',
            'title': 'Title',
            'description': 'Description',
            'content': 'ONLY AVAILABLE IN PAID PLANS',
            'link': 'https://example.com/a1',
            'image_url': 'https://example.com/a1.jpg',
            'source_name': 'Example',
            'creator': ['Jane Doe'],
            'pubDate': '2026-10-06 15:13:00',
          },
          {'article_id': 'a2', 'title': 'Second', 'creator': null},
        ],
      });

      expect(response.status, 'success');
      expect(response.nextPage, '1791299540049567016');
      expect(response.articles, hasLength(2));
      final Article first = response.articles.first;
      expect(first.content, isNull);
      expect(first.description, 'Description');
      expect(first.link, 'https://example.com/a1');
      expect(first.imageUrl, 'https://example.com/a1.jpg');
      expect(first.sourceName, 'Example');
      expect(first.creators, ['Jane Doe']);
      expect(response.articles.last.creators, isEmpty);
    });

    test('reads the NewsData.io error object', () {
      final NewsResponse response = NewsResponse.fromJson({
        'status': 'error',
        'results': {
          'message': 'The size provided is invalid',
          'code': 'UnsupportedFilter',
        },
      });

      expect(response.status, 'error');
      expect(response.articles, isEmpty);
      expect(response.message, 'The size provided is invalid');
      expect(response.code, 'UnsupportedFilter');
    });

    test('survives a cache round trip', () {
      const NewsResponse original = NewsResponse(
        status: 'success',
        articles: [Article(articleId: 'a1', title: 'Title', creators: ['A'])],
        nextPage: 'token',
      );

      final NewsResponse restored = NewsResponse.fromJson(original.toJson());

      expect(restored.nextPage, 'token');
      expect(restored.articles.single.title, 'Title');
      expect(restored.articles.single.creators, ['A']);
    });
  });

  group('NewsRepositoryImpl', () {
    late FakeRemoteDataSource remoteDataSource;
    late FakeLocalDataSource localDataSource;

    setUp(() {
      remoteDataSource = FakeRemoteDataSource();
      localDataSource = FakeLocalDataSource();
    });

    NewsRepositoryImpl repository({required bool online}) {
      return NewsRepositoryImpl(
        remoteDataSource,
        localDataSource,
        FakeConnectivityService(online: online),
      );
    }

    test('caches only the first page without a search', () async {
      final NewsRepositoryImpl onlineRepository = repository(online: true);

      await onlineRepository.getLatestNews(
        categoryId: 'sports',
        languageCode: 'en',
        query: 'cup',
      );
      await onlineRepository.getLatestNews(
        categoryId: 'sports',
        languageCode: 'en',
        page: 'next-token',
      );
      expect(localDataSource.cache, isEmpty);
      expect(remoteDataSource.lastPage, 'next-token');

      await onlineRepository.getLatestNews(
        categoryId: 'sports',
        languageCode: 'en',
        countryCode: 'eg',
      );
      expect(localDataSource.cache.keys, ['sports-en-eg']);
    });

    test('merges new articles into the cache, newest first, max 10', () async {
      // 8 cached articles published on days 1..8.
      localDataSource.cache['top-en-all'] = NewsResponse(
        status: 'success',
        articles: [
          for (int day = 1; day <= 8; day++)
            Article(
              articleId: 'old-$day',
              title: 'Old $day',
              pubDate: '2026-10-0$day 10:00:00',
            ),
        ],
      );
      // 5 fresh articles: 4 new (days 9..12) and an updated copy of 'old-8'.
      remoteDataSource.articles = [
        for (int day = 9; day <= 12; day++)
          Article(
            articleId: 'new-$day',
            title: 'New $day',
            pubDate: '2026-10-${day.toString().padLeft(2, '0')} 10:00:00',
          ),
        const Article(
          articleId: 'old-8',
          title: 'Updated 8',
          pubDate: '2026-10-08 10:00:00',
        ),
      ];

      final NewsResponse response = await repository(online: true)
          .getLatestNews(categoryId: 'top', languageCode: 'en');

      final List<Article> cached = localDataSource.cache['top-en-all']!.articles;
      expect(cached, hasLength(10));
      expect(cached.map((article) => article.articleId), [
        'new-12',
        'new-11',
        'new-10',
        'new-9',
        'old-8',
        'old-7',
        'old-6',
        'old-5',
        'old-4',
        'old-3',
      ]);
      expect(cached[4].title, 'Updated 8');
      // The online result itself is returned unchanged.
      expect(response.articles, hasLength(5));
      expect(response.nextPage, 'next-token');
    });

    test('trims an oversized cache entry on the next update', () async {
      localDataSource.cache['top-en-all'] = NewsResponse(
        articles: [
          for (int minute = 10; minute < 30; minute++)
            Article(
              articleId: 'old-$minute',
              pubDate: '2026-10-01 10:$minute:00',
            ),
        ],
      );
      remoteDataSource.articles = const [];

      await repository(online: true)
          .getLatestNews(categoryId: 'top', languageCode: 'en');

      final List<Article> cached = localDataSource.cache['top-en-all']!.articles;
      expect(cached, hasLength(10));
      expect(cached.first.articleId, 'old-29');
      expect(cached.last.articleId, 'old-20');
    });

    test('offline search filters the cached first page', () async {
      localDataSource.cache['top-ar-all'] = const NewsResponse(
        status: 'success',
        articles: [
          Article(title: 'Football final'),
          Article(title: 'Weather', description: 'Rain in Cairo'),
        ],
        nextPage: 'token',
      );

      final NewsResponse response = await repository(online: false)
          .getLatestNews(categoryId: 'top', languageCode: 'ar', query: 'cairo');

      expect(response.articles.single.title, 'Weather');
      expect(response.nextPage, isNull);
    });

    test('offline without cache or for a next page throws', () async {
      final NewsRepositoryImpl offlineRepository = repository(online: false);

      expect(
        offlineRepository.getLatestNews(categoryId: 'top', languageCode: 'en'),
        throwsA(isA<NoCachedDataException>()),
      );
      expect(
        offlineRepository.getLatestNews(
          categoryId: 'top',
          languageCode: 'en',
          page: 'token',
        ),
        throwsA(isA<OfflineException>()),
      );
    });
  });
}
