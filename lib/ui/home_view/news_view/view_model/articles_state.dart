import 'package:news/models/article.dart';

class ArticlesState {
  const ArticlesState({
    this.isLoading = false,
    this.failureMsg,
    this.articles = const [],
    this.nextPage,
    this.isLoadingMore = false,
    this.loadMoreFailureMsg,
  });

  final bool isLoading;
  final String? failureMsg;
  final List<Article> articles;

  /// NewsData.io token of the next page; null when every page is loaded.
  final String? nextPage;
  final bool isLoadingMore;

  /// Error of the last "load more" request, shown under the list.
  final String? loadMoreFailureMsg;

  /// Whether another page can still be loaded.
  bool get hasMorePages => nextPage != null;
}
