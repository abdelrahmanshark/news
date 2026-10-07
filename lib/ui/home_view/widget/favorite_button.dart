import 'package:flutter/material.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/ui/widget/animated_icon_switcher.dart';

/// Heart button that adds a category to favorites or removes it.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.color,
    required this.onPressed,
  });

  final bool isFavorite;
  final Color color;
  final VoidCallback onPressed;

  static const double _iconSize = 32;

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return IconButton(
      onPressed: onPressed,
      iconSize: _iconSize,
      tooltip: isFavorite
          ? strings.removeFromFavorites
          : strings.addToFavorites,
      icon: AnimatedIconSwitcher(
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFavorite),
          color: color,
        ),
      ),
    );
  }
}
