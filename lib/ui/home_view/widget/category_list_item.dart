import 'package:flutter/material.dart';
import 'package:news/utils/app_animations.dart';

/// Wraps a category card so it shrinks and fades away while it moves,
/// then grows back in at its new place in the list.
class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    super.key,
    required this.isMoving,
    required this.isArriving,
    required this.child,
  });

  /// Whether the card is shrinking away before it moves.
  final bool isMoving;

  /// Whether the card was just moved here and should grow in.
  final bool isArriving;

  final Widget child;

  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      // Without a begin value, cards start at full size; arriving cards start collapsed.
      tween: Tween<double>(begin: isArriving ? 0 : null, end: isMoving ? 0 : 1),
      duration: AppAnimations.listMove,
      curve: AppAnimations.curve,
      builder: (context, value, child) => ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: value,
          child: Opacity(opacity: value, child: child),
        ),
      ),
      // The spacing is inside the item so it collapses with the card.
      child: Padding(
        padding: const EdgeInsets.only(bottom: _spacing),
        child: child,
      ),
    );
  }
}
