import 'package:news/models/article.dart';

class NewsResponse {
  const NewsResponse({
    this.status,
    this.totalResults,
    this.articles = const [],
    this.nextPage,
    this.code,
    this.message,
  });

  /// Builds a [NewsResponse] from NewsData.io or cached JSON.
  // `dynamic` because Hive returns Map<dynamic, dynamic> instead of Map<String, dynamic>.
  factory NewsResponse.fromJson(dynamic json) {
    // `results` is the article list on success and an error object on failure.
    final dynamic results = json['results'];
    final bool isError = results is Map;
    return NewsResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: results is List
          ? results.map((articleJson) => Article.fromJson(articleJson)).toList()
          : const [],
      nextPage: json['nextPage']?.toString(),
      code: isError ? results['code']?.toString() : null,
      message: isError ? results['message']?.toString() : null,
    );
  }

  final String? status;
  final int? totalResults;
  final List<Article> articles;

  /// Token for the next page; null when there are no more articles.
  final String? nextPage;
  final String? code;
  final String? message;

  /// Converts this response to JSON for caching.
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'results': articles.map((article) => article.toJson()).toList(),
      'nextPage': nextPage,
    };
  }
}
