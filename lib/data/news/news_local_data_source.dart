import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news/models/news_response.dart';
import 'package:news/utils/hive_boxes.dart';

@lazySingleton
class NewsLocalDataSource {
  /// Returns the news cached under [cacheKey], or null when nothing is cached.
  NewsResponse? getNews(String cacheKey) {
    try {
      final dynamic cachedJson = Hive.box(HiveBoxes.news).get(cacheKey);
      return cachedJson == null ? null : NewsResponse.fromJson(cachedJson);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Caches [newsResponse] under [cacheKey] for offline use.
  Future<void> saveNews(String cacheKey, NewsResponse newsResponse) async {
    try {
      await Hive.box(HiveBoxes.news).put(cacheKey, newsResponse.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
