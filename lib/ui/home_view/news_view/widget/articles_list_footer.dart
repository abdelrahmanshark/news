import 'package:flutter/material.dart';
import 'package:news/ui/widget/error_retry_view.dart';
import 'package:news/ui/widget/fade_in.dart';
import 'package:news/ui/widget/loading_view.dart';

/// Last list item: a spinner while the next page loads, or its error with a retry button.
class ArticlesListFooter extends StatelessWidget {
  const ArticlesListFooter({
    super.key,
    required this.failureMsg,
    required this.onRetry,
  });

  final String? failureMsg;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final String? message = failureMsg;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: message == null
          ? const FadeIn(
              key: ValueKey('load-more-loading'),
              child: LoadingView(),
            )
          : FadeIn(
              key: const ValueKey('load-more-error'),
              child: ErrorRetryView(message: message, onRetry: onRetry),
            ),
    );
  }
}
