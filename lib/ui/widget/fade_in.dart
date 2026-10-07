import 'package:flutter/material.dart';
import 'package:news/utils/app_animations.dart';

/// Fades its child in once; give it a new `ValueKey` to replay the fade.
class FadeIn extends StatelessWidget {
  const FadeIn({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: AppAnimations.fast,
      curve: AppAnimations.curve,
      builder: (context, opacity, child) {
        return Opacity(opacity: opacity, child: child);
      },
      child: child,
    );
  }
}
