import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news/domain/repositories/news_repository.dart';
import 'package:news/models/article.dart';
import 'package:news/models/news_response.dart';
import 'package:news/ui/home_view/news_view/view_model/articles_state.dart';
import 'package:news/utils/api_const.dart';
import 'package:news/utils/network_utils.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class ArticlesViewModel extends Cubit<ArticlesState> {
  // Starts loading because articles are requested as soon as the screen opens.
  ArticlesViewModel(this._newsRepository)
    : super(const ArticlesState(isLoading: true));

  // Waits for a pause in typing so every key press doesn't spend an API credit.
  static const Duration _searchDelay = Duration(milliseconds: 600);

  final NewsRepository _newsRepository;

  // The current filters, reused by search, refresh, retry and load more.
  String _categoryId = '';
  String _languageCode = '';
  String? _countryCode;
  String _query = '';

  // Increases with every first-page request so answers to older requests are ignored.
  int _requestCount = 0;
  Timer? _searchTimer;

  /// Loads the first page of [categoryId] in [languageCode], limited to [countryCode] when given.
  Future<void> loadArticles({
    required String categoryId,
    required String languageCode,
    String? countryCode,
  }) {
    _categoryId = categoryId;
    _languageCode = languageCode;
    _countryCode = countryCode;
    return _loadFirstPage();
  }

  /// Loads the articles matching [query] once the user stops typing.
  void search(String query) {
    _searchTimer?.cancel();
    String trimmedQuery = query.trim();
    if (trimmedQuery.length > ApiConst.maxQueryLength) {
      trimmedQuery = trimmedQuery.substring(0, ApiConst.maxQueryLength);
    }
    if (trimmedQuery == _query) return;
    _searchTimer = Timer(_searchDelay, () {
      _query = trimmedQuery;
      _loadFirstPage();
    });
  }

  /// Reloads the first page while the current articles stay on screen.
  Future<void> refresh() => _loadFirstPage(showLoading: false);

  /// Reloads the first page after a failure.
  Future<void> retry() => _loadFirstPage();

  /// Loads the next page when there is one and nothing else is loading.
  Future<void> loadMore() async {
    if (state.isLoading ||
        state.isLoadingMore ||
        state.loadMoreFailureMsg != null) {
      return;
    }
    await _loadNextPage();
  }

  /// Repeats the "load more" request that failed.
  Future<void> retryLoadMore() => _loadNextPage();

  /// Opens the link of [article] in the external browser.
  Future<void> openArticleLink(Article article) async {
    final String? url = article.link;
    if (url == null || url.isEmpty) return;
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      log(e.toString());
    }
  }

  /// Replaces the list with the first page of the current filters.
  Future<void> _loadFirstPage({bool showLoading = true}) async {
    _requestCount++;
    final int requestNumber = _requestCount;
    if (showLoading) emit(const ArticlesState(isLoading: true));
    try {
      final NewsResponse newsResponse = await _fetchPage(null);
      if (isClosed || requestNumber != _requestCount) return;
      emit(
        ArticlesState(
          articles: newsResponse.articles,
          nextPage: newsResponse.nextPage,
        ),
      );
    } catch (e) {
      if (isClosed || requestNumber != _requestCount) return;
      emit(ArticlesState(failureMsg: NetworkUtils.failureMessageFor(e)));
    }
  }

  /// Appends the next page to the current articles.
  Future<void> _loadNextPage() async {
    final String? nextPage = state.nextPage;
    if (nextPage == null) return;
    final int requestNumber = _requestCount;
    final List<Article> currentArticles = state.articles;
    emit(
      ArticlesState(
        articles: currentArticles,
        nextPage: nextPage,
        isLoadingMore: true,
      ),
    );
    try {
      final NewsResponse newsResponse = await _fetchPage(nextPage);
      if (isClosed || requestNumber != _requestCount) return;
      emit(
        ArticlesState(
          articles: [...currentArticles, ...newsResponse.articles],
          nextPage: newsResponse.nextPage,
        ),
      );
    } catch (e) {
      if (isClosed || requestNumber != _requestCount) return;
      emit(
        ArticlesState(
          articles: currentArticles,
          nextPage: nextPage,
          loadMoreFailureMsg: NetworkUtils.failureMessageFor(e),
        ),
      );
    }
  }

  /// Requests [page] (null for the first page) with the current filters.
  Future<NewsResponse> _fetchPage(String? page) {
    return _newsRepository.getLatestNews(
      categoryId: _categoryId,
      languageCode: _languageCode,
      countryCode: _countryCode,
      query: _query.isEmpty ? null : _query,
      page: page,
    );
  }

  /// Cancels a pending search before the ViewModel is closed.
  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
