import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/models/article.dart';
import 'package:news/ui/home_view/news_view/view_model/articles_state.dart';
import 'package:news/ui/home_view/news_view/view_model/articles_view_model.dart';
import 'package:news/ui/home_view/news_view/widget/article_card.dart';
import 'package:news/ui/home_view/news_view/widget/article_details_sheet.dart';
import 'package:news/ui/home_view/news_view/widget/articles_list_footer.dart';
import 'package:news/ui/widget/empty_view.dart';
import 'package:news/ui/widget/error_retry_view.dart';
import 'package:news/ui/widget/fade_in.dart';
import 'package:news/ui/widget/loading_view.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({super.key});

  // Starts loading the next page when the user is this close to the end of the list.
  static const double _loadMoreDistance = 600;

  /// Asks for the next page once the list is scrolled near its end.
  bool _onScroll(BuildContext context, ScrollNotification notification) {
    if (notification.metrics.extentAfter < _loadMoreDistance) {
      context.read<ArticlesViewModel>().loadMore();
    }
    return false;
  }

  /// Opens a sheet where [article] can be read, with a button to open its link.
  void _openArticleDetails(BuildContext context, Article article) {
    final ArticlesViewModel articlesViewModel = context.read<ArticlesViewModel>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => ArticleDetailsSheet(
        article: article,
        onOpenLink: () => articlesViewModel.openArticleLink(article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesViewModel, ArticlesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const FadeIn(
            key: ValueKey('articles-loading'),
            child: LoadingView(),
          );
        }
        final String? failureMsg = state.failureMsg;
        if (failureMsg != null) {
          return FadeIn(
            key: const ValueKey('articles-error'),
            child: ErrorRetryView(
              message: failureMsg,
              onRetry: context.read<ArticlesViewModel>().retry,
            ),
          );
        }
        if (state.articles.isEmpty) {
          return FadeIn(
            key: const ValueKey('articles-empty'),
            child: EmptyView(message: S.of(context).noArticles),
          );
        }
        final int articleCount = state.articles.length;
        return FadeIn(
          key: const ValueKey('articles-content'),
          child: RefreshIndicator(
            color: Theme.of(context).canvasColor,
            onRefresh: context.read<ArticlesViewModel>().refresh,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) => _onScroll(context, notification),
              child: ListView.builder(
                // Lets pull-to-refresh work even when the list is shorter than the screen.
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.hasMorePages ? articleCount + 1 : articleCount,
                itemBuilder: (context, index) {
                  if (index == articleCount) {
                    return ArticlesListFooter(
                      failureMsg: state.loadMoreFailureMsg,
                      onRetry: context.read<ArticlesViewModel>().retryLoadMore,
                    );
                  }
                  final Article article = state.articles[index];
                  return ArticleCard(
                    article: article,
                    onTap: () => _openArticleDetails(context, article),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
