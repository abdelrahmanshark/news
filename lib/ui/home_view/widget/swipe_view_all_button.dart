import 'package:flutter/material.dart';
import 'package:news/utils/app_animations.dart';

/// A "View All" pill whose round knob can be swiped across to open the category.
///
/// The knob snaps back when released early and after a completed swipe.
class SwipeViewAllButton extends StatefulWidget {
  const SwipeViewAllButton({
    super.key,
    required this.label,
    required this.labelStyle,
    required this.cardColor,
    required this.contrastColor,
    required this.isKnobAtEnd,
    required this.onSwiped,
  });

  final String label;
  final TextStyle labelStyle;

  /// Color of the card behind the button, used for the arrow.
  final Color cardColor;

  /// Color that stands out on the card, used for the knob and the pill.
  final Color contrastColor;

  /// Whether the knob rests on the end side; it is swiped toward the start.
  final bool isKnobAtEnd;

  final VoidCallback onSwiped;

  @override
  State<SwipeViewAllButton> createState() => _SwipeViewAllButtonState();
}

class _SwipeViewAllButtonState extends State<SwipeViewAllButton>
    with SingleTickerProviderStateMixin {
  static const double _knobSize = 54;
  static const double _labelPadding = 16;
  static const double _labelGap = 10;
  static const double _completeThreshold = 0.7;
  static const double _flingVelocity = 700;

  // 0 = knob at rest, 1 = knob swiped to the other end of the pill.
  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: AppAnimations.fast,
  );

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  /// Distance the knob can travel inside the pill.
  double get _maxTravel => (context.size?.width ?? _knobSize) - _knobSize;

  /// Returns 1 when the knob travels right on screen and -1 when it travels left.
  double get _travelSign {
    final bool isLtr = Directionality.of(context) == TextDirection.ltr;
    return widget.isKnobAtEnd == isLtr ? -1 : 1;
  }

  /// Moves the knob with the finger.
  void _onDragUpdate(DragUpdateDetails details) {
    if (_maxTravel <= 0) return;
    _progress.value += details.delta.dx * _travelSign / _maxTravel;
  }

  /// Opens the category when swiped far or fast enough, otherwise snaps back.
  Future<void> _onDragEnd(DragEndDetails details) async {
    final double velocity = details.velocity.pixelsPerSecond.dx * _travelSign;
    final bool isComplete =
        _progress.value >= _completeThreshold || velocity >= _flingVelocity;
    if (!isComplete) {
      _resetKnob();
      return;
    }
    await _progress.animateTo(1, curve: AppAnimations.curve);
    if (!mounted) return;
    widget.onSwiped();
    _resetKnob();
  }

  /// Slides the knob back to its resting place.
  void _resetKnob() {
    _progress.animateBack(0, curve: AppAnimations.curve);
  }

  @override
  Widget build(BuildContext context) {
    final double restX = widget.isKnobAtEnd ? 1 : -1;
    final Widget label = Flexible(
      child: AnimatedBuilder(
        animation: _progress,
        builder: (context, child) =>
            Opacity(opacity: 1 - _progress.value, child: child),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(widget.label, style: widget.labelStyle, maxLines: 1),
        ),
      ),
    );
    // Ordered for a knob on the end side; reversed when the knob is on the start.
    final List<Widget> pillChildren = [
      const SizedBox(width: _labelPadding),
      label,
      const SizedBox(width: _labelGap),
      const SizedBox.square(dimension: _knobSize),
    ];
    return GestureDetector(
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onHorizontalDragCancel: _resetKnob,
      child: Container(
        decoration: BoxDecoration(
          color: widget.contrastColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(_knobSize),
        ),
        child: Stack(
          children: [
            // Lays out the pill size; the empty box is the knob's resting spot.
            Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.isKnobAtEnd
                  ? pillChildren
                  : pillChildren.reversed.toList(),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _progress,
                builder: (context, child) => Align(
                  // Slides from the resting edge (x = ±1) to the opposite edge.
                  alignment: AlignmentDirectional(
                    restX - 2 * restX * _progress.value,
                    0,
                  ),
                  child: child,
                ),
                child: Container(
                  width: _knobSize,
                  height: _knobSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.contrastColor,
                  ),
                  child: Icon(
                    widget.isKnobAtEnd ? Icons.chevron_left : Icons.chevron_right,
                    color: widget.cardColor,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
