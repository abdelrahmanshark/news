import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/ui/widget/loading_view.dart';
import 'package:news/utils/app_colors.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final String? url = imageUrl;
    if (url == null || url.isEmpty) {
      return const Icon(Icons.error, color: AppColors.grayColor);
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (_, _) => const LoadingView(),
      errorWidget: (_, _, _) =>
          const Icon(Icons.error, color: AppColors.grayColor),
    );
  }
}
