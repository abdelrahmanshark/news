import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.hasPrefixIcon = true,
    this.hasSuffixIcon = false,
    this.prefixIconColor,
    this.suffixIconColor,
    this.validator,
    this.errorStyle,
    this.outlineBorderColor,
    this.obscureText = false,
    this.obscuringCharacter = '.',
    this.padding,
    this.maxLines,
    this.onChanged,
  });

  final String? hintText;
  final TextStyle? hintStyle;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final FormFieldValidator<String>? validator;
  final TextStyle? errorStyle;
  final Color? outlineBorderColor;
  final bool obscureText;
  final String obscuringCharacter;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: outlineBorderColor ?? theme.canvasColor,
        width: 2,
      ),
    );
    return TextFormField(
      maxLines: maxLines,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        contentPadding: padding,
        enabledBorder: border,
        focusedBorder: border,
        hintText: hintText,
        hintStyle: hintStyle ?? theme.textTheme.bodyMedium,
        prefixIcon: hasPrefixIcon
            ? Icon(prefixIcon, color: prefixIconColor ?? theme.canvasColor)
            : null,
        suffixIcon: hasSuffixIcon
            ? Icon(suffixIcon, color: suffixIconColor ?? theme.canvasColor)
            : null,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.redColor, width: 2),
        ),
        errorStyle: errorStyle ?? AppStyles.redRegular16,
      ),
      style: theme.textTheme.bodyMedium,
      validator: validator,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      cursorColor: theme.canvasColor,
      onChanged: onChanged,
    );
  }
}
