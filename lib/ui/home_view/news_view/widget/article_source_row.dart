import 'package:flutter/material.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/models/article.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/utils/time_ago_utils.dart';

/// One line with the article's source and authors, followed by how long ago it was published.
class ArticleSourceRow extends StatelessWidget {
  const ArticleSourceRow({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final String sourceName = article.sourceName ?? '';
    final DateTime? publishedAt = article.publishedAt;
    final String sourceLine = article.creators.isEmpty
        ? sourceName
        : '$sourceName • ${S.of(context).byAuthor(article.creators.join(', '))}';
    return Row(
      children: [
        Expanded(
          child: Text(
            sourceLine,
            style: AppStyles.grayRegular12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (publishedAt != null)
          Text(
            TimeAgoUtils.format(publishedAt),
            style: AppStyles.grayRegular12,
          ),
      ],
    );
  }
}
