import 'package:flutter/material.dart';
import 'package:news/utils/app_animations.dart';

/// One tappable label inside the "All / Favorites" toggle.
class CategoryFilterOption extends StatelessWidget {
  const CategoryFilterOption({
    super.key,
    required this.label,
    required this.style,
    required this.onTap,
  });

  final String label;
  final TextStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedDefaultTextStyle(
          style: style,
          duration: AppAnimations.fast,
          curve: AppAnimations.curve,
          child: Text(label, maxLines: 1),
        ),
      ),
    );
  }
}
