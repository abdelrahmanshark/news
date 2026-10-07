import 'package:flutter/material.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/models/article.dart';
import 'package:news/ui/home_view/news_view/widget/article_image.dart';
import 'package:news/ui/home_view/news_view/widget/article_source_row.dart';
import 'package:news/ui/widget/custom_elevated_button.dart';

/// Draggable bottom sheet showing the whole article, with an "Open the link" button at the end.
class ArticleDetailsSheet extends StatelessWidget {
  const ArticleDetailsSheet({
    super.key,
    required this.article,
    required this.onOpenLink,
  });

  final Article article;
  final VoidCallback onOpenLink;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final String? link = article.link;
    // The full content already starts with the description, so the description is only a fallback.
    final String? body = article.content ?? article.description;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        padding: EdgeInsets.fromLTRB(
          16,
          20,
          16,
          16 + MediaQuery.paddingOf(context).bottom,
        ),
        children: [
          SizedBox(
            height: screenHeight * 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ArticleImage(imageUrl: article.imageUrl),
            ),
          ),
          const SizedBox(height: 12),
          Text(article.title ?? '', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 8),
          ArticleSourceRow(article: article),
          if (body != null) ...[
            const SizedBox(height: 16),
            Text(body, style: theme.textTheme.bodyLarge),
          ],
          if (link != null && link.isNotEmpty) ...[
            const SizedBox(height: 24),
            CustomElevatedButton(
              onPressed: onOpenLink,
              backgroundColor: theme.primaryColor,
              borderColor: theme.canvasColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).openTheLink,
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.open_in_new, color: theme.canvasColor),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
