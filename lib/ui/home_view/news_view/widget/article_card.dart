import 'package:flutter/material.dart';
import 'package:news/models/article.dart';
import 'package:news/ui/home_view/news_view/widget/article_image.dart';
import 'package:news/ui/home_view/news_view/widget/article_source_row.dart';
import 'package:news/ui/widget/pressable_scale.dart';
import 'package:news/utils/app_styles.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article, required this.onTap});

  final Article article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final String? description = article.description;
    return PressableScale(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        height: screenHeight * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.canvasColor),
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.25,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ArticleImage(imageUrl: article.imageUrl),
              ),
            ),
            const SizedBox(height: 8),
            // The full text is read in the details sheet, so the card only shows a preview.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    article.title ?? '',
                    style: theme.textTheme.headlineLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Flexible(
                      child: Text(
                        description,
                        style: AppStyles.grayRegular14,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 4),
            ArticleSourceRow(article: article),
          ],
        ),
      ),
    );
  }
}
