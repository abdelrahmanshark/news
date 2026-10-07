import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news/models/news_response.dart';
import 'package:news/utils/api_const.dart';
import 'package:news/utils/app_exceptions.dart';

/// Decodes the news JSON; runs in a background isolate because the payload is large.
NewsResponse _parseNewsResponse(String responseBody) {
  return NewsResponse.fromJson(jsonDecode(responseBody));
}

@lazySingleton
class NewsRemoteDataSource {
  final http.Client _client = http.Client();

  /// Fetches one page of the latest NewsData.io articles matching the given filters.
  ///
  /// [countryCode] null means all countries, and [page] null means the first page.
  Future<NewsResponse> getLatestNews({
    required String categoryId,
    required String languageCode,
    String? countryCode,
    String? query,
    String? page,
  }) async {
    try {
      final Uri url = Uri.https(ApiConst.baseUrl, ApiConst.latestNewsApi, {
        'language': languageCode,
        'category': categoryId,
        if (countryCode != null) 'country': countryCode,
        if (query != null && query.isNotEmpty) 'q': query,
        if (page != null) 'page': page,
        'removeduplicate': '1',
      });
      final http.Response response = await _client.get(
        url,
        headers: {ApiConst.apiKeyHeader: ApiConst.apiKey},
      );
      // Error answers (4xx/5xx) still carry a JSON body with the reason.
      final NewsResponse newsResponse = await compute(
        _parseNewsResponse,
        response.body,
      );
      if (newsResponse.status != ApiConst.successStatus) {
        throw ApiException(newsResponse.message);
      }
      return newsResponse;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
