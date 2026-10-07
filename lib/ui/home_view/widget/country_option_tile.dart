import 'package:flutter/material.dart';
import 'package:news/ui/widget/pressable_scale.dart';

/// One selectable row in the country picker, with a check mark when selected.
class CountryOptionTile extends StatelessWidget {
  const CountryOptionTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PressableScale(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        child: Row(
          children: [
            Expanded(child: Text(label, style: theme.textTheme.headlineLarge)),
            if (isSelected) Icon(Icons.check, color: theme.canvasColor),
          ],
        ),
      ),
    );
  }
}
