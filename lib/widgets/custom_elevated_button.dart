
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

typedef OnPressed = void Function();

class CustomElevatedButton extends StatelessWidget {
  final OnPressed onPressed;
  final Widget child;
  final Color? backGroundColor;
  final Color? borderColor;

  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backGroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: borderColor ?? theme.primaryColor, width: 2),
        elevation: 0,
        backgroundColor: backGroundColor ?? theme.canvasColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }
}
