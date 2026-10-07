import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

/// Drawer-styled dropdown that shows [labels] and reports the picked value.
class DrawerDropDownMenu<T> extends StatelessWidget {
  const DrawerDropDownMenu({
    super.key,
    required this.selectedValue,
    required this.labels,
    required this.onSelected,
  });

  final T selectedValue;

  /// Every selectable value with the text shown for it.
  final Map<T, String> labels;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.whiteColor),
    );
    return DropdownMenu<T>(
      initialSelection: selectedValue,
      onSelected: (newValue) {
        if (newValue == null) return;
        onSelected(newValue);
      },
      dropdownMenuEntries: [
        for (final MapEntry<T, String> option in labels.entries)
          DropdownMenuEntry(
            value: option.key,
            label: option.value,
            labelWidget: Text(option.value, style: AppStyles.whiteBold20),
          ),
      ],
      textStyle: AppStyles.whiteBold20,
      width: double.infinity,
      inputDecorationTheme: InputDecorationThemeData(
        border: border,
        enabledBorder: border,
      ),
      menuStyle: MenuStyle(
        elevation: const WidgetStatePropertyAll<double>(0),
        backgroundColor: const WidgetStatePropertyAll<Color>(
          AppColors.transparentColor,
        ),
        fixedSize: WidgetStatePropertyAll<Size>(
          Size(screenSize.width * 0.65, screenSize.height * 0.15),
        ),
      ),
      trailingIcon: const Icon(
        Icons.arrow_drop_down,
        color: AppColors.whiteColor,
        size: 40,
      ),
      selectedTrailingIcon: const Icon(
        Icons.arrow_drop_up,
        color: AppColors.whiteColor,
        size: 40,
      ),
    );
  }
}
