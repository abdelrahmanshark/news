import 'package:flutter/animation.dart';

class AppAnimations {
  static const Duration press = Duration(milliseconds: 120); // tap feedback
  static const Duration fast = Duration(milliseconds: 220); // state switches
  static const Duration listMove = Duration(milliseconds: 300); // list items
  static const Curve curve = Curves.easeOutCubic; // default curve
  static const double pressedScale = 0.97; // pressed card scale
  static const Duration iconSwap = Duration(milliseconds: 200); // icon swaps
  static const Duration pageJump = Duration(
    milliseconds: 300,
  ); // programmatic scroll jumps
  static const Curve pageJumpCurve = Curves.easeInOut; // scroll jump curve
  static const Duration splashReveal = Duration(
    milliseconds: 1400,
  ); // splash logo intro
  static const Duration splashHold = Duration(
    milliseconds: 600,
  ); // pause before home
}
