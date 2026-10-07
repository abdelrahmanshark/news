import 'package:flutter/material.dart';
import 'package:news/utils/app_animations.dart';

/// Swaps icons with a scale and fade; the child needs a changing `ValueKey`.
class AnimatedIconSwitcher extends StatelessWidget {
  const AnimatedIconSwitcher({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppAnimations.iconSwap,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: FadeTransition(opacity: animation, child: child),
      ),
      child: child,
    );
  }
}
