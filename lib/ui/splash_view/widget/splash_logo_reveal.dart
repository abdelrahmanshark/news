import 'package:flutter/material.dart';
import 'package:news/utils/app_assets.dart';

/// Plays the staggered fade, slide and scale intro of the splash logo.
class SplashLogoReveal extends StatefulWidget {
  const SplashLogoReveal({
    super.key,
    required this.animation,
    required this.color,
  });

  final Animation<double> animation;
  final Color color;

  @override
  State<SplashLogoReveal> createState() => _SplashLogoRevealState();
}

class _SplashLogoRevealState extends State<SplashLogoReveal> {
  late final CurvedAnimation _fadeCurve;
  late final CurvedAnimation _slideCurve;
  late final CurvedAnimation _scaleCurve;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;

  /// Splits the single splash animation into staggered layers.
  @override
  void initState() {
    super.initState();
    _fadeCurve = CurvedAnimation(
      parent: widget.animation,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    _slideCurve = CurvedAnimation(
      parent: widget.animation,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    );
    _scaleCurve = CurvedAnimation(
      parent: widget.animation,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_slideCurve);
    _scale = Tween<double>(begin: 0.7, end: 1).animate(_scaleCurve);
  }

  /// Releases the curve listeners attached to the parent animation.
  @override
  void dispose() {
    _fadeCurve.dispose();
    _slideCurve.dispose();
    _scaleCurve.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeCurve,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _scale,
          // The asset is a white alpha mask, so `color` tints it per theme.
          child: Image.asset(
            AppAssets.splashLogo,
            width: 88,
            height: 165,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
