import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news/utils/app_animations.dart';

/// Shrinks its child slightly while pressed.
///
/// Uses a raw [Listener] so it never delays or steals the tap.
class PressableScale extends StatefulWidget {
  const PressableScale({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _isPressed = false;
  Offset _pointerDownPosition = Offset.zero;

  /// Updates the pressed flag only when it actually changes.
  void _setPressed(bool isPressed) {
    if (_isPressed == isPressed) return;
    setState(() => _isPressed = isPressed);
  }

  /// Starts the press and remembers where the finger went down.
  void _onPointerDown(PointerDownEvent event) {
    _pointerDownPosition = event.position;
    _setPressed(true);
  }

  /// Releases the press once the finger moves far enough to count as a scroll.
  void _onPointerMove(PointerMoveEvent event) {
    if ((event.position - _pointerDownPosition).distance > kTouchSlop) {
      _setPressed(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _isPressed ? AppAnimations.pressedScale : 1,
        duration: AppAnimations.press,
        curve: AppAnimations.curve,
        child: GestureDetector(
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: widget.child,
        ),
      ),
    );
  }
}
